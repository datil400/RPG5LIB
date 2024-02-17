**FREE

// R5WW01B
//
// Cómo dividir un texto en líneas de un ancho máximo y con saltos
// entre párrafos.
//
// Octubre 2023
//
// Comentarios:
//
//   Este programa ilustra cómo se puede procesar un texto
//   para conseguir líneas de un ancho máximo sin la necesidad
//   de utilizar estructuras de datos para contener el resultado.
//   Cada línea se trata al mismo tiempo que se obtiene sin
//   necesidad de programar un bucle.
//
//   En este ejemplo se muestra como dividir un texto en párrafos.


ctl-opt dftactgrp(*NO) actgrp(*NEW);
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('RPG5LIB');

/COPY RPG5LIB,joblog_h
/COPY RPG5LIB,wordwrap_h

dcl-c LF  X'25';   // Line feed

dcl-s parrafo1 varchar(4096) inz('-
  El   orden de las reglas no tiene importancia salvo para determinar la prede-
terminada,    es decir, el objetivo que make construirá si no se le especifica -
otro en la línea de órdenes. Esta regla predeterminada es la primera que -
aparece en el makefile si no empieza por un punto. Por lo tanto, se -
escribirá el makefile de forma que la primera regla que se ponga sea la -
encargada de compilar el programa entero, o todos los programas que se -
describan.'
);

dcl-s parrafo2 varchar(4096) inz('-
  Por ejemplo, supongamos que se va a aprovechar parte del editor del ejem-
plo anterior para hacer un programa que nos permita ver el contenido de un -
fichero; sea view el nombre de tal programa. Para que al dar la orden make sin -
parámetros se recompilen los dos programas y no sólo el editor, se pondrá como -
primera regla una cuyo objetivo dependa de los dos. Es costumbre llamar a tal -
regla all («todo», en inglés). Así, la primera regla sería simplemente:'
);

dcl-s texto varchar(4096);


*inLR = *ON;

texto = parrafo1 + LF + parrafo2;

r5_joblog('--- WORD WRAP Ancho = 25 ---');
r5_word_wrap(*NULL: texto: 25: %paddr(mostrar_linea): LF);

return;


dcl-proc mostrar_linea;

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
