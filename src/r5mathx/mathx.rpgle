**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5MATHX
//  Module  : MATHX
//
//  Mathematical extensions
//
//  Author : datil400@gmail.com
//  Date   : May 2024
//
//  Compiling : R5MATHXI
//
//  Comments
//

ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('RPG5LIB');


/COPY RPG5LIB,joblog_h
/COPY RPG5LIB,excmgr_h
/COPY RPG5LIB,mathx_h


//  Redondea un valor a los decimales indicados.
//
//  Si 'decimals' es positivo, se redondea la parte
//  decimal del valor (derecha de la coma). Si
//  'decimals' es negativo, se redondea la parte
//  entera (a la izquierda de la coma). Un cero
//  redondea la parte entera.
//
//  El redondeo está limitado a 12 decimales y
//  12 enteros.

dcl-proc r5_round export;

   dcl-pi *N like(r5_long_packed_t);
      value like(r5_long_packed_t) const;
      decimals like(r5_small_t) const;
   end-pi;

   dcl-c DEC_LEN %len(value);
   dcl-c DEC_POS %decpos(value);
   dcl-s result like(r5_long_packed_t);
   dcl-s precision packed(63: 12);  // accuracy of 12 decimal places or integers
   dcl-s RP54000 like(r5_object_t);


   if decimals < 0 and %abs(decimals) > %decpos(precision);
      RP54000 = r5_exception_new('RP54000': 'RPG5MSG');
      r5_throw(RP54000);
      return *HIVAL;     // Never runs
   endif;

   // eval(r) resultado = %inth( valor * 10**decim ) / 10**decim;
   //
   // La fórmula anterior no devuelve el resultado correcto en
   // algunos casos, ya sea debido a las reglas de precisión
   // de RPG o por algún cálculo intermedio transformado a 'float'.

   precision = 10**decimals;
   eval(R) result = %dech(value * precision: DEC_LEN - DEC_POS: 0) / precision;
   return  result;
end-proc;


// Resto de una divisón 'euclídea'
//
//  El divisor tiene que ser distinto de cero.
//
//  El resto siempre es positivo.
//
// https://cuadernos.elcartapacio.es/demates/complementos/numeros/la-division-entera/

dcl-proc r5_modulo export;

   dcl-pi *N like(r5_long_packed_t);
      divident like(r5_long_packed_t) const;
      divisor like(r5_long_packed_t)const;
   end-pi;

   dcl-s result like(r5_long_packed_t);

   if divisor >= 0;
      eval(R) result = divident - divisor * r5_floor(divident / divisor);
   else;
      eval(R) result = divident - divisor * r5_ceil(divident / divisor);
   endif;
   return result;
end-proc;


//  Múltiplo superior (para números decimales)
//
//  Redondea 'value' hacia arriba hasta el múltiplo más próximo
//  a 'o_multiplier'.
//
//  'value' no se redondea si ya es un múltipo de 'o_multiplier'.
//
//  Si 'value' y 'o_multiplier' son negativos, el valor se
//  redondea al múltiplo menor (es decir, alejándose del cero).


dcl-proc r5_upper_multiple export;

   dcl-pi *N like(r5_long_packed_t);
      value like(r5_long_packed_t) const;
      o_multiplier like(r5_long_packed_t) options(*NOPASS) const;
   end-pi;

   dcl-s result like(r5_long_packed_t);
   dcl-s multiplier like(o_multiplier) inz(1);


   if %parms() >= %parmnum(o_multiplier);
      multiplier = o_multiplier;
   endif;

   r5_assert( not (multiplier < 0 and value > 0)
            : 'Multiplier alwais positive if value is positive'
            );

   if multiplier = 0;
      return 0;
   endif;

   eval(R) result = value/multiplier;
   result = r5_ceil(result);
   eval(R) result *= multiplier;
   return result;
end-proc;


//  Redondea al entero más próximo mayor o igual
//  que 'value' (redondeo por exceso).

dcl-proc r5_ceil export;

   dcl-pi *N like(r5_long_packed_t);
      value like(r5_long_packed_t) const;
   end-pi;

   dcl-s result like(r5_long_packed_t);

   //result = %int(value);
   result = r5_truncate(value);
   if value > 0 and value > result;
      eval(R) result += 1;
   endif;
   return result;
end-proc;


//  Múltiplo inferior (para números decimales)
//
//  Redondea 'value' hacia abajo hasta el múltiplo más próximo
//  a 'o_multiplier'.
//
//  'value' no se redondea si ya es un múltipo de 'o_multiplier'.
//
//  Si 'value' y 'o_multiplier' son negativos, el valor se
//  redondea al múltiplo superior (es decir, acercándose del cero).

dcl-proc r5_lower_multiple export;

   dcl-pi *N like(r5_long_packed_t);
      value like(r5_long_packed_t) const;
      o_multiplier like(r5_long_packed_t) options(*NOPASS) const;
   end-pi;

   dcl-s result like(r5_long_packed_t);
   dcl-s multiplier like(o_multiplier) inz(1);


   if %parms() >= %parmnum(o_multiplier);
      multiplier = o_multiplier;
   endif;

   r5_assert( not (multiplier < 0 and value > 0)
            : 'Multiplier alwais positive if value is positive'
            );

   if multiplier = 0;
      return 0;
   endif;

   eval(R) result = value/multiplier;
   result = r5_floor(result);
   eval(R) result *= multiplier;
   return result;
end-proc;


//  Redondea al entero más próximo menor o igual
//  que 'value' (redondeo por defecto).

dcl-proc r5_floor export;

   dcl-pi *N like(r5_long_packed_t);
      value like(r5_long_packed_t) const;
   end-pi;

   dcl-s result like(r5_long_packed_t);

   //result = %int(value);
   result = r5_truncate(value: 0);
   if value < 0 and value < result;
      eval(R) result -= 1;
   endif;
   return result;
end-proc;


//  Resto de una divisón 'artimética'
//
//  El divisor tiene que ser distinto de cero.
//
//  El resto toma el signo del dividendo.
//  |resto| < |divisor|
//
//  https://www.victoriglesias.net/la-operacion-modulo-en-teoria-de-numeros-y-como-la-
//    implementan-diferentes-lenguajes/

dcl-proc r5_remainder export;

   dcl-pi *N like(r5_long_packed_t);
      divident like(r5_long_packed_t) const;
      divisor like(r5_long_packed_t) const;
   end-pi;

   dcl-s result like(r5_long_packed_t);

   eval(R) result = divident - divisor * r5_truncate(divident / divisor);
   return result;
end-proc;


//  Elimina la parte fraccionaria de un número para quedarse con
//  su parte entera.

dcl-proc r5_truncate export;

   dcl-pi *N like(r5_long_packed_t);
      value like(r5_long_packed_t) const;
      o_decimals like(r5_small_t) options(*NOPASS) const;
   end-pi;

   dcl-c DEC_LEN %len(value);
   dcl-c DEC_POS %decpos(value);
   dcl-s result like(r5_long_packed_t);
   dcl-s decimals like(o_decimals) inz(0);
   dcl-s precision packed(63: 12);  // accuracy of 12 decimal places or integers
   dcl-s RP54000 like(r5_object_t);


   if %parms() >= %parmnum(o_decimals);
      decimals = o_decimals;
   endif;

   if decimals < 0 and %abs(decimals) > %decpos(precision);
      RP54000 = r5_exception_new('RP54000': 'RPG5MSG');
      r5_throw(RP54000);
      return *HIVAL;     // Never runs
   endif;

   // eval(r) resultado = %int( valor * 10**decim ) / 10**decim;
   //
   // La fórmula anterior no devuelve el resultado correcto en
   // algunos casos, ya sea debido a las reglas de precisión
   // de RPG o por algún cálculo intermedio transformado a 'float'.

   precision = 10**decimals;
   eval(R) result = %dec(value * precision: DEC_LEN - DEC_POS: 0) / precision;
   return  result;
end-proc;


/EOF
// http://puntoflotante.org/

dcl-proc r5_nearly_equal;

    dcl-pi *N like(r5_boolean_t);
       a like(r5_double_t) const;
       b like(r5_double_t) const;
       epsilon like(r5_double_t) const;
    end-pi;

    dcl-s abs_a like(a);
    dcl-s abs_b like(b);
    dcl-s diff like(r5_double_t);

    abs_a = %abs(a);
    abs_b = %abs(b);
    diff = %abs(a - b);

    if a = b;                // Maneja los infinitos
       return *ON;
    elseif (a * b) = 0;      // a o b son cero
       return (diff < (epsilon * epsilon));
    else;                    // Usar el error relativo
       return (diff / (abs_a + abs_b) < epsilon);
    endif;
end-proc;


// Extraer el enésimo decimal. Por ejemplo,
//
//  5.12345 -> el cuarto decimal devolvería 0.0004
//
// Puede ser intersante incluirlo en la bibloteca de funciones
// matemáticas.
//
// También podría ser interesante una función para extraer
// los n primeros decimales.

dcl-proc extract_nth_decimal;

   dcl-pi *N like(r5_long_packed_t);
      value like(r5_long_packed_t) const;
      nth_dec like(r5_int_t) const;
   end-pi;

   dcl-s result like(r5_long_packed_t);
   dcl-s precision like(r5_long_packed_t);

   eval(R) precision = 10 ** (nth_dec - 1);
   eval(R) result = value * precision;
   eval(R) result = (result - %int(result)) / precision;
   return result;
end-proc;
