-- SQL WORD_WRAP FUNCTION EXAMPLE

SET PATH $(SCHEMA);

SELECT
  line_number, line
FROM (
  VALUES ( 'El   orden de las reglas no tiene importancia ' ||
           'salvo para  determinar  la predeterminada, es ' ||
           'decir, el objetivo que  make construirá si no ' ||
           'se le especifica otro en la línea de órdenes. ' ||
           'Esta regla  predeterminada es la  primera que ' ||
           'aparece en el makefile  si no empieza  por un ' ||
           'punto.&N ' ||
           'Por  lo tanto, se  escribirá el  makefile  de ' ||
           'forma que  la primera regla  que se ponga sea ' ||
           'la encargada  de compilar el programa entero, ' ||
           'o todos los programas que se describan.'
         )
) AS TEXT (text),
  TABLE(WORD_WRAP (text, 40, '&N')) AS WW
;


SELECT
  line_number, line
FROM (
  VALUES ( 'El   orden de las reglas no tiene importancia ' ||
           'salvo para  determinar  la predeterminada, es ' ||
           'decir, el objetivo que  make construirá si no ' ||
           'se le especifica otro en la línea de órdenes. ' ||
           'Esta regla  predeterminada es la  primera que ' ||
           'aparece en el makefile  si no empieza  por un ' ||
           'punto.'
         ),
         ( 'Por  lo tanto, se  escribirá el  makefile  de ' ||
           'forma que  la primera regla  que se ponga sea ' ||
           'la encargada  de compilar el programa entero, ' ||
           'o todos los programas que se describan.'
         )
) AS TEXT (text),
  TABLE(WORD_WRAP (text, 40)) AS WW
;

SELECT
  line_number, line
FROM (
  VALUES ('012345678901234567890123456789')
) AS TEXT (text),
  TABLE(WORD_WRAP (text, 6, '')) AS WW
;


SELECT
  line_number, line
FROM (
  VALUES ('012345678901234567890123456789')
) AS TEXT (text),
  TABLE(WORD_WRAP (text, NULL, NULL)) AS WW
;
