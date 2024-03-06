**FREE

// R5WW02
//
// Cómo justificar un texto usando r5_word_wrap.
//
// Noviembre 2023


ctl-opt dftactgrp(*NO) actgrp(*NEW);
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('RPG5LIB');

/COPY RPG5LIB,joblog_h
/COPY RPG5LIB,string_h
/COPY RPG5LIB,math_h
/COPY RPG5LIB,wordwrap_h

dcl-c LF  X'25';

dcl-s t1 varchar(4096) inz('-
  El   orden de las reglas no tiene importancia salvo para determinar la prede-
terminada,    es decir, el objetivo que make construirá si no se le especifica -
otro en la línea de órdenes. Esta regla predeterminada es la primera que -
aparece en el makefile si no empieza por un punto. Por lo tanto, se -
escribirá el makefile de forma que la primera regla que se ponga sea la -
encargada de compilar el programa entero, o todos los programas que se -
describan.'
);

dcl-s t2 varchar(4096) inz('-
  Por ejemplo, supongamos que se va a aprovechar parte del editor del ejem-
plo anterior para hacer un programa que nos permita ver el contenido de un -
fichero; sea view el nombre de tal programa. Para que al dar la orden make sin -
parámetros se recompilen los dos programas y no sólo el editor, se pondrá como -
primera regla una cuyo objetivo dependa de los dos. Es costumbre llamar a tal -
regla all («todo», en inglés). Así, la primera regla sería simplemente:'
);

dcl-s text varchar(4096);


dcl-pi R5WW02;
   width packed(5: 0) const;
end-pi;

*inLR = *ON;

text = t1 + LF + t2;

r5_joblog('WORD WRAP EXAMPLE : WIDTH = %s': %char(width));
r5_joblog('.');
r5_joblog('--- JUSTIFIED TEXT ---');
r5_word_wrap(*NULL: text: width: %paddr(justify): LF);
return;


// Este algoritmo para justificar texto no es el más eficiente
// pero sirve a efectos pedagógicos.

dcl-proc justify;

   dcl-pi *N;
      context like(r5_pointer_t) value;
      line varchar(2048) options(*VARSIZE) const;
      line_nbr like(r5_short_t) const;
      width like(r5_short_t) const;
      is_end_of_paragraph like(r5_boolean_t) const;
      is_end_of_text like(r5_boolean_t) const;
   end-pi;

   dcl-s work_line like(line);
   dcl-s remaining like(r5_int_t); // Espacios restantes
   dcl-s s like(r5_int_t);
   dcl-s i like(r5_int_t);

   // En este ejemplo una línea no podrá contener más
   // de 50 palabras, para un ajuste máximo de 80
   // caracteres de ancho.

   dcl-c MAX_WORDS_PER_LINE  50;
   dcl-ds words qualified inz;
      nbr_of_words int(3);
      word varchar(80) dim(MAX_WORDS_PER_LINE);
      nbr_of_spaces int(3);
      spaces int(3) dim(MAX_WORDS_PER_LINE);
   end-ds;


   if is_end_of_paragraph;
      r5_joblog('%2s : %s': %char(line_nbr): line);
      return;
   endif;

   words.word = %split(line);
   words.nbr_of_words = %lookup('': words.word) - 1;

   if words.nbr_of_words <= 1;
      r5_joblog('%2s : %s': %char(line_nbr): line);
      return;
   endif;

   words.nbr_of_spaces = words.nbr_of_words - 1;
   %subarr(words.spaces: 1: words.nbr_of_spaces) = 1 + ((width - %len(line)) / words.nbr_of_spaces);

   // Repartir los espacios en blanco restantes para terminar de justificar el texto

   remaining = width - %len(line) - (%xfoot(words.spaces) - words.nbr_of_spaces);
   for s = 1 to remaining;
      i = r5_random_number(words.nbr_of_spaces: 1);
      words.spaces(i) += 1;
   endfor;

   // Preparar la línea justificada

   work_line = '';
   for i = 1 to words.nbr_of_spaces;
      work_line += words.word(i) + r5_spaces(words.spaces(i));
   endfor;
   work_line += words.word(i);

   r5_joblog('%2s : %s': %char(line_nbr): work_line);
   return;
end-proc;


