**FREE

// R5WW01A
//
// C�mo dividir un texto en l�neas de un ancho m�ximo.
//
// Octubre 2023
//
// Comentarios:
//
//   Este programa ilustra c�mo se puede procesar un texto
//   para conseguir l�neas de un ancho m�ximo sin la necesidad
//   de utilizar estructuras de datos para contener el resultado.
//   Cada l�nea se trata al mismo tiempo que se obtiene sin
//   necesidad de programar un bucle.

ctl-opt dftactgrp(*NO);
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('RPG5LIB');

/COPY RPG5LIB,joblog_h
/COPY RPG5LIB,wordwrap_h


dcl-s p1 varchar(4096) inz('-
  El   orden de las reglas no tiene importancia salvo para determinar la prede-
terminada,    es decir, el objetivo que make construir� si no se le especifica -
otro en la l�nea de �rdenes. Esta regla predeterminada es la primera que -
aparece en el makefile si no empieza por un punto. Por lo tanto, se -
escribir� el makefile de forma que la primera regla que se ponga sea la -
encargada de compilar el programa entero, o todos los programas que se -
describan.'
);

dcl-s p2 varchar(4096) inz('-
  Por ejemplo, supongamos que se va a aprovechar parte del editor del ejem-
plo anterior para hacer un programa que nos permita ver el contenido de un -
fichero; sea view el nombre de tal programa. Para que al dar la orden make sin -
par�metros se recompilen los dos programas y no s�lo el editor, se pondr� como -
primera regla una cuyo objetivo dependa de los dos. Es costumbre llamar a tal -
regla all (�todo�, en ingl�s). As�, la primera regla ser�a simplemente:'
);

dcl-s long_word varchar(4096) inz('012345678901234567890123456789');

dcl-s text varchar(4096);


*inLR = *ON;

r5_joblog('.');
r5_joblog('--- Paragraph #1 | Width = 25 ---');
r5_word_wrap(*NULL: p1 : 25: %paddr(show_line));
r5_joblog('.');
r5_joblog('--- Paragraph #1 | Width = 30 ---');
r5_word_wrap(*NULL: p1 : 30: %paddr(show_line));
r5_joblog('.');
r5_joblog('--- Paragraph #2 | Width = 40 ---');
r5_word_wrap(*NULL: p2 : 40: %paddr(show_line));
r5_joblog('.');
r5_joblog('--- Two paragraphs | Width = 25 ---');
text = p1 + ' ' + p2;
r5_word_wrap(*NULL: text : 25: %paddr(show_line));
r5_joblog('.');
r5_joblog('--- Long word | Ancho = 6 ---');
r5_word_wrap(*NULL: long_word: 6: %paddr(show_line));
return;


dcl-proc show_line;

   dcl-pi *N;
      context like(r5_pointer_t) value;
      line varchar(2048) options(*VARSIZE) const;
      line_nbr like(r5_short_t) const;
      width like(r5_short_t) const;
      is_end_of_paragraph like(r5_boolean_t) const;
      is_end_of_text like(r5_boolean_t) const;
   end-pi;

   r5_joblog('%2s : %s': %char(line_nbr): line);
   return;
end-proc;
