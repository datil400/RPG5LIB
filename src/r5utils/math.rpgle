**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5UTILS
//  Module  : MATH
//
//  Mathematical and numeric utilities
//
//  Author : Javier Mora
//  Date   : April 2022
//
//  Compiling : R5UTILSI
//
//  Comments
//

ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);


/COPY API,ceemath_h
/COPY RPG5LIB,math_h


//  El valor más pequeño de la lista.
//
//  Usar %MIN a partir de 7.2 TR6, 7.3 TR2

dcl-proc r5_min export;

   dcl-pi *N like(r5_long_packed_t);
      value1 like(r5_long_packed_t) const;
      value2 like(r5_long_packed_t) const;
      value3 like(r5_long_packed_t) options(*NOPASS) const;
      value4 like(r5_long_packed_t) options(*NOPASS) const;
      value5 like(r5_long_packed_t) options(*NOPASS) const;
      value6 like(r5_long_packed_t) options(*NOPASS) const;
      value7 like(r5_long_packed_t) options(*NOPASS) const;
      value8 like(r5_long_packed_t) options(*NOPASS) const;
      value9 like(r5_long_packed_t) options(*NOPASS) const;
      value10 like(r5_long_packed_t) options(*NOPASS) const;
      value11 like(r5_long_packed_t) options(*NOPASS) const;
      value12 like(r5_long_packed_t) options(*NOPASS) const;
      value13 like(r5_long_packed_t) options(*NOPASS) const;
      value14 like(r5_long_packed_t) options(*NOPASS) const;
      value15 like(r5_long_packed_t) options(*NOPASS) const;
   end-pi;

   dcl-s minimum like(value1);


   minimum = *HIVAL;
   if %parms() >= 1;
      minimum = value1;
   endif;

   if %parms() >= 2 and minimum > value2;
      minimum = value2;
   endif;

   if %parms() >= 3 and minimum > value3;
      minimum = value3;
   endif;

   if %parms() >= 4 and minimum > value4;
      minimum = value4;
   endif;

   if %parms() >= 5 and minimum > value5;
      minimum = value5;
   endif;

   if %parms() >= 6 and minimum > value6;
      minimum = value6;
   endif;

   if %parms() >= 7 and minimum > value7;
      minimum = value7;
   endif;

   if %parms() >= 8 and minimum > value8;
      minimum = value8;
   endif;

   if %parms() >= 9 and minimum > value9;
      minimum = value9;
   endif;

   if %parms() >= 10 and minimum > value10;
      minimum = value10;
   endif;

   if %parms() >= 11 and minimum > value11;
      minimum = value11;
   endif;

   if %parms() >= 12 and minimum > value12;
      minimum = value12;
   endif;

   if %parms() >= 13 and minimum > value13;
      minimum = value13;
   endif;

   if %parms() >= 14 and minimum > value14;
      minimum = value14;
   endif;

   if %parms() >= 15 and minimum > value15;
      minimum = value15;
   endif;

   return minimum;
end-proc;


//  El valor mayor de la lista.
//
//  Usar %MIN a partir de 7.2 TR6, 7.3 TR2

dcl-proc r5_max export;

   dcl-pi *N like(r5_long_packed_t);
      value1 like(r5_long_packed_t) const;
      value2 like(r5_long_packed_t) const;
      value3 like(r5_long_packed_t) options(*NOPASS) const;
      value4 like(r5_long_packed_t) options(*NOPASS) const;
      value5 like(r5_long_packed_t) options(*NOPASS) const;
      value6 like(r5_long_packed_t) options(*NOPASS) const;
      value7 like(r5_long_packed_t) options(*NOPASS) const;
      value8 like(r5_long_packed_t) options(*NOPASS) const;
      value9 like(r5_long_packed_t) options(*NOPASS) const;
      value10 like(r5_long_packed_t) options(*NOPASS) const;
      value11 like(r5_long_packed_t) options(*NOPASS) const;
      value12 like(r5_long_packed_t) options(*NOPASS) const;
      value13 like(r5_long_packed_t) options(*NOPASS) const;
      value14 like(r5_long_packed_t) options(*NOPASS) const;
      value15 like(r5_long_packed_t) options(*NOPASS) const;
   end-pi;

   dcl-s maximum like(value1);


   maximum = *LOVAL;
   if %parms() >= 1;
      maximum = value1;
   endif;

   if %parms() >= 2 and maximum < value2;
      maximum = value2;
   endif;

   if %parms() >= 3 and maximum < value3;
      maximum = value3;
   endif;

   if %parms() >= 4 and maximum < value4;
      maximum = value4;
   endif;

   if %parms() >= 5 and maximum < value5;
      maximum = value5;
   endif;

   if %parms() >= 6 and maximum < value6;
      maximum = value6;
   endif;

   if %parms() >= 7 and maximum < value7;
      maximum = value7;
   endif;

   if %parms() >= 8 and maximum < value8;
      maximum = value8;
   endif;

   if %parms() >= 9 and maximum < value9;
      maximum = value9;
   endif;

   if %parms() >= 10 and maximum < value10;
      maximum = value10;
   endif;

   if %parms() >= 11 and maximum < value11;
      maximum = value11;
   endif;

   if %parms() >= 12 and maximum < value12;
      maximum = value12;
   endif;

   if  %parms() >= 13 and maximum < value13;
      maximum = value13;
   endif;

   if  %parms() >= 14 and maximum < value14;
      maximum = value14;
   endif;

   if  %parms() >= 15 and maximum < value15;
      maximum = value15;
   endif;

   return maximum;
end-proc;


//  Genera un número aleatorio dentro de un rango
//
//  'high_nbr' es el límite superior.
//  'low_nbr' es el límite inferior. Cero si no se indica.

dcl-proc r5_random_number export;

   dcl-pi *N like(r5_int_t);
      high_nbr like(r5_int_t) const;
      o_low_nbr like(r5_int_t) options(*NOPASS) const;
   end-pi;

   //  'seed' es una semilla utilizada en la generación del número
   //  aleatorio. En la primera llamada su valor es cero y el
   //  generador de números toma la fecha y hora actual para generar
   //  una. La función CEERAN0 actualiza el valor de la semilla
   //  después de cada llamada.
   dcl-s seed int(10) inz(0) static;
   dcl-s rand like(r5_double_t) inz(0);
   dcl-s low_nbr like(o_low_nbr) inz(0);
   dcl-s range like(high_nbr);


   if %parms() >= %parmnum(o_low_nbr);
      low_nbr = o_low_nbr;
   endif;

   range = high_nbr - low_nbr + 1;
   CEERAN0(seed: rand: *OMIT);
   return (%int(rand * range ) + low_nbr);
end-proc;
