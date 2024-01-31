**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5STRING
//  Module  : WORDWRAP
//
//  Word wrap utility.
//
//  Author : datil400@gmail.com
//  Date   : October 2023
//
//  Compiling : R5STRINGI
//
//  Comments
//

ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('RPG5LIB');


/COPY RPG5LIB,exceptionh
/COPY RPG5LIB,excmgr_h
/COPY RPG5LIB,calllevelh
/COPY RPG5LIB,wordwrap_h

dcl-ds rp50100_msgdta_t qualified template;
   width int(10);
end-ds;

dcl-ds rp5ff00_msgdta_t qualified template;
   procedure_name char(256);
   program_name char(10);
   program_library char(10);
end-ds;


//  Divide un texto en l�neas para que se ajusten a un ancho. Cada l�nea
//  contiene palabras completas, salvo que la palabra sea mayor que el
//  ancho indicado. En este caso se divide la palabra (sin tener en cuenta
//  las s�labas) y se se�aliza con un gui�n al final.
//
//  Cada palabra est� delimitada por espacios en blanco. Si entre palabras
//  hay m�s de un espacio en blanco, se convierte en uno solo.
//
//  Adem�s se puede incluir una marca de nueva l�nea para separar el texto
//  en p�rrafos.
//
//  Cada l�nea de texto generada se trata a trav�s de una funci�n de
//  respuesta (callback) que tiene que ajustarse al siguiente prototipo:
//
//    dcl-pr word_wrap_handler;
//       context like(r5_pointer_t) value;
//       line varchar(16382) options(*VARSIZE) const;
//       line_nbr like(r5_short_t) const;
//       width like(r5_short_t) const;
//       is_end_of_paragraph like(r5_boolean_t) const;
//       is_end_of_text like(r5_boolean_t) const;
//    end-pr;
//
//  'context' hace referencia a un espacio de memoria definido por el
//  usuario por si fuera necesario pasar informaci�n al manejador.
//
//  'line' es la siguiente l�nea completa generada a partir del texto.
//
//  'line_nbr' es la numeraci�n de la l�nea.
//
//  'width' es el ancho m�ximo que puede tener la l�nea.
//
//  'is_end_of_paragraph' se activa (*ON) si se ha alcanzado el final
//  de un p�rrafo o del texto completo.
//
//  'is_end_of_text' se activa si se ha alcanzado el final del texto.

dcl-proc r5_word_wrap export;

   dcl-pi *N;
      context like(r5_pointer_t) value;
      text varchar(16382) options(*VARSIZE: *TRIM) const;
      width like(r5_short_t) const;
      line_handler like(r5_proc_pointer_t) value;
      o_line_feed_sym varchar(5) options(*TRIM: *NOPASS) const;
   end-pi;

   dcl-pr process_line_event extproc(line_handler);
      context like(r5_pointer_t) value;
      line varchar(16382) options(*VARSIZE) const;
      line_nbr like(r5_short_t) const;
      width like(r5_short_t) const;
      is_end_of_paragraph like(r5_boolean_t) const;
      is_end_of_text like(r5_boolean_t) const;
   end-pr;

   dcl-c WORD_SEP  ' ';
   dcl-s line_feed_sym like(o_line_feed_sym) inz('');

   dcl-s work_text like(text);
   dcl-s begin like(r5_short_t);
   dcl-s end like(r5_short_t);
   dcl-s word like(text);
   dcl-s separator varchar(1);
   dcl-s word_spacing like(r5_small_t);

   dcl-s exception like(r5_object_t);

   dcl-s line like(text);
   dcl-s line_number like(r5_short_t) inz(0);
   dcl-s is_end_of_paragraph like(r5_boolean_t);
   dcl-s is_end_of_text like(r5_boolean_t);


   if width <= 0;
      exception = R5_INVALID_MAX_WIDTH_EXCEPTION(width);
      r5_throw(exception);
   endif;

   if line_handler = *NULL;
      exception = R5_EXPECTED_CALLBACK_EXCEPTION();
      r5_throw(exception);
   endif;

   if text = '';
      return;
   endif;

   if %parms() >= %parmnum(o_line_feed_sym);
      line_feed_sym = o_line_feed_sym;
   endif;

   // El texto original se adapta para que el algoritmo de
   // procesamiento sea m�s sencillo. Toda palabra estar�
   // delimitada por uno o m�s espacios en blanco antes y
   // despu�s (salvo la primera). Para tratar la �ltima
   // palabra como todas las dem�s se sit�a un espacio en
   // blanco al final del texto a modo de 'centinela'. La
   // marca de 'salto de l�nea' tambi�n se acomoda para que
   // sea tratada como una palabra m�s (aunque sea especial).

   work_text = text;
   if %len(line_feed_sym) > 0;

      // Si se incluyen marcas de 'salto de l�nea' se
      // asegura que al final del texto haya al menos una.

      if %scanr(line_feed_sym: text) <> (%len(text) - %len(line_feed_sym) + 1);
         work_text = text + line_feed_sym;
      endif;

      work_text = %scanrpl( line_feed_sym
                          : WORD_SEP + line_feed_sym + WORD_SEP
                          : work_text
                          );
   else;
      work_text += WORD_SEP;
   endif;

   // El texto convertido (work_text) se recorre palabra a palabra.
   // 'begin' siempre apunta a primer car�cter de la palabra,
   // independientemente de los espacios en blanco que le precedan.
   // 'end' se sit�a siempre en el primer espacio en blanco despu�s
   // de la palabra.
   // (end - begin) = la longitud de la palabra.
   //
   // Si la palabra es m�s larga que el ancho al que se quiera acomodar
   // el texto, se parte hasta el ancho especificado menos un gui�n
   // que se le a�ade al final como indicador de divisi�n de palabra.
   // No se realiza ning�n ajuste a s�labas completas.
   //
   // Cuando se encuenta un s�mbolo de 'nueva l�nea' se corta el texto
   // en ese punto y se comienza en la siguiente.
   //
   // Los espacios en blanco del inicio y final del texto original se
   // eliminan. Las palabras del texto final ir�n separadas por un
   // solo espacio en blanco.

   begin = 0;
   end = 1;
   line = '';

   dow end <= %len(work_text);

      begin = %check(WORD_SEP: work_text: end);
      end = %scan(WORD_SEP: work_text: begin);

      if (end - begin) > width;
         end = begin + width - 1;   // -1 porque se incluye un gui�n
         separator = '-';           // al final de la palabra partida
         word_spacing = 0;
      else;
         separator = WORD_SEP;
         word_spacing = 1;
      endif;

      word = %subst(work_text: begin: (end - begin));

      if %len(line) + %len(word) > width
      or word = line_feed_sym;
         if word = line_feed_sym;
            word = '';
            separator = '';
            is_end_of_paragraph = *ON;
         else;
            is_end_of_paragraph = *OFF;
         endif;
         is_end_of_text = (end = %len(work_text));

         line_number += 1;
         process_line_event( context
                           : %trim(line): line_number: width
                           : is_end_of_paragraph
                           : is_end_of_text
                           );

         line = '';
      endif;

      line += word + separator;

      end += word_spacing;
   enddo;

   if %len(line) > 0;
      line_number += 1;
      process_line_event( context
                        : %trim(line): line_number: width
                        : *ON: *ON
                        );
   endif;

   return;
end-proc;


dcl-proc R5_INVALID_MAX_WIDTH_EXCEPTION;

   dcl-pi *N like(r5_object_t);
      width int(10) const;
   end-pi;

   dcl-s exception like(r5_object_t);
   dcl-ds msgdta likeds(rp50100_msgdta_t);

   msgdta.width = width;
   exception = r5_exception_new('RP50100': 'RPG5MSG': msgdta);
   return exception;
end-proc;


dcl-proc R5_EXPECTED_CALLBACK_EXCEPTION;

   dcl-pi *N like(r5_object_t);
   end-pi;

   dcl-s exception like(r5_object_t);
   dcl-ds msgdta likeds(rp5ff00_msgdta_t);
   dcl-ds caller likeds(r5_call_level_info_t);

   r5_caller(caller);
   msgdta.procedure_name = caller.procedure_name;
   msgdta.program_name = caller.program_name;
   msgdta.program_library = caller.program_library;
   exception = r5_exception_new('RP5FF00': 'RPG5MSG': msgdta);
   return exception;
end-proc;
