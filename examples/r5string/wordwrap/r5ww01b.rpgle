**FREE

// R5WW01B
//
// C�mo dividir un texto en l�neas de un ancho m�ximo y con saltos
// entre p�rrafos.
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
//
//   En este ejemplo se muestra como dividir un texto en p�rrafos.


ctl-opt dftactgrp(*NO) actgrp(*NEW);
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('RPG5LIB');

/COPY RPG5LIB,joblog_h
/COPY RPG5LIB,wordwrap_h

dcl-c LF  X'25';   // Line feed

dcl-s parrafo1 varchar(4096) inz('-
  El   orden de las reglas no tiene importancia salvo para determinar la prede-
terminada,    es decir, el objetivo que make construir� si no se le especifica -
otro en la l�nea de �rdenes. Esta regla predeterminada es la primera que -
aparece en el makefile si no empieza por un punto. Por lo tanto, se -
escribir� el makefile de forma que la primera regla que se ponga sea la -
encargada de compilar el programa entero, o todos los programas que se -
describan.'
);

dcl-s parrafo2 varchar(4096) inz('-
  Por ejemplo, supongamos que se va a aprovechar parte del editor del ejem-
plo anterior para hacer un programa que nos permita ver el contenido de un -
fichero; sea view el nombre de tal programa. Para que al dar la orden make sin -
par�metros se recompilen los dos programas y no s�lo el editor, se pondr� como -
primera regla una cuyo objetivo dependa de los dos. Es costumbre llamar a tal -
regla all (�todo�, en ingl�s). As�, la primera regla ser�a simplemente:'
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
