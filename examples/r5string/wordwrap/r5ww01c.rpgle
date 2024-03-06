**FREE

// R5WW01C
//
// Ilustra cómo se puede utilizar r5_word_wrap para procesar un
// texto libre justificándolo de varias formas.
//
// Octubre 2023


ctl-opt dftactgrp(*NO) actgrp(*NEW);
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('RPG5LIB');

/COPY RPG5LIB,joblog_h
/COPY RPG5LIB,string_h
/COPY RPG5LIB,wordwrap_h

dcl-c LF  X'25';

dcl-s p1 varchar(4096) inz('-
  El   orden de las reglas no tiene importancia salvo para determinar la prede-
terminada,    es decir, el objetivo que make construirá si no se le especifica -
otro en la línea de órdenes. Esta regla predeterminada es la primera que -
aparece en el makefile si no empieza por un punto. Por lo tanto, se -
escribirá el makefile de forma que la primera regla que se ponga sea la -
encargada de compilar el programa entero, o todos los programas que se -
describan.'
);

dcl-s p2 varchar(4096) inz('-
  Por ejemplo, supongamos que se va a aprovechar parte del editor del ejem-
plo anterior para hacer un programa que nos permita ver el contenido de un -
fichero; sea view el nombre de tal programa. Para que al dar la orden make sin -
parámetros se recompilen los dos programas y no sólo el editor, se pondrá como -
primera regla una cuyo objetivo dependa de los dos. Es costumbre llamar a tal -
regla all («todo», en inglés). Así, la primera regla sería simplemente:'
);

dcl-s text varchar(4096);


dcl-pi R5WW01C;
   width packed(5: 0) const;
end-pi;

*inLR = *ON;

text = p1 + LF + p2;

r5_joblog('.');
r5_joblog('WORD WRAP EXAMPLE : WIDTH = %s': %char(width));
r5_joblog('.');
r5_joblog('--- LEFT ALIGN WITHOUT LINE FEED ---');
r5_word_wrap(*NULL: text: width: %paddr(left_align));
r5_joblog('.');
r5_joblog('--- ALIGN WITH LINE FEED ---');
r5_joblog('.');
r5_joblog('--- LEFT ALIGN ---');
r5_word_wrap(*NULL: text: width: %paddr(left_align): LF);
r5_joblog('.');
r5_joblog('--- RIGTH ALIGN ---');
r5_word_wrap(*NULL: text: width: %paddr(right_align): LF);
r5_joblog('.');
r5_joblog('--- CENTER ---');
r5_word_wrap(*NULL: text: width: %paddr(center): LF);
return;


dcl-proc left_align;

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


dcl-proc right_align;

   dcl-pi *N;
      context like(r5_pointer_t) value;
      line varchar(2048) options(*VARSIZE) const;
      line_nbr like(r5_short_t) const;
      width like(r5_short_t) const;
      is_end_of_paragraph like(r5_boolean_t) const;
      is_end_of_text like(r5_boolean_t) const;
   end-pi;

   dcl-s work_line like(line);

   work_line = r5_right(r5_spaces(width) + line: width);
   r5_joblog('%2s : %s': %char(line_nbr): work_line);
   return;
end-proc;


dcl-proc center;

   dcl-pi *N;
      context like(r5_pointer_t) value;
      line varchar(2048) options(*VARSIZE) const;
      line_nbr like(r5_short_t) const;
      width like(r5_short_t) const;
      is_end_of_paragraph like(r5_boolean_t) const;
      is_end_of_text like(r5_boolean_t) const;
   end-pi;

   dcl-s work_line like(line);
   dcl-s s like(r5_int_t);

   s = (width - %len(line)) / 2;
   work_line = r5_spaces(s) + line;
   r5_joblog('%2s : %s': %char(line_nbr): work_line);
   return;
end-proc;
