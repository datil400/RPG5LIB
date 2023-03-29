**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5UTILS
//  Module  : IIF
//
//  Family of 'iif' functions
//
//  Author : Javier Mora
//  Date   : April 2022
//
//  Compiling : R5UTILSI
//
//  Comments
//
//    La familia de funciones 'iif' devuelven un valor si la
//    condición es cierta u otro si no lo es.


ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt text(*SRCMBRTXT);


/COPY RPG5LIB,iif_h


//  Está especializada en el manejo de valores alfanuméricos.

dcl-proc r5_iif_char export;

   dcl-pi *N like(r5_small_varchar_t);
      condition like(r5_boolean_t) const;
      value_if_true like(r5_small_varchar_t) const;
      value_if_false like(r5_small_varchar_t) const;
   end-pi;

   if condition;
      return value_if_true;
   else;
      return value_if_false;
   endif;
end-proc;


//  Está especializada en el manejo de valores decimales empaquetados.

dcl-proc r5_iif_dec export;

   dcl-pi *N like(r5_long_packed_t);
      condition like(r5_boolean_t) const;
      value_if_true like(r5_long_packed_t) const;
      value_if_false like(r5_long_packed_t) const;
   end-pi;

   if condition;
      return value_if_true;
   else;
      return value_if_false;
   endif;
end-proc;


//  Está especializada en el manejo de valores numéricos enteros.

dcl-proc r5_iif_int export;

   dcl-pi *N like(r5_long_t);
      condition like(r5_boolean_t) const;
      value_if_true like(r5_long_t) const;
      value_if_false like(r5_long_t) const;
   end-pi;

   if condition;
      return value_if_true;
   else;
      return value_if_false;
   endif;
end-proc;


//  Está especializada en el manejo de valores de fechas.

dcl-proc r5_iif_date export;

   dcl-pi *N like(r5_date_t);
      condition like(r5_boolean_t) const;
      value_if_true like(r5_date_t) const;
      value_if_false like(r5_date_t) const;
   end-pi;

   if condition;
      return value_if_true;
   else;
      return value_if_false;
   endif;
end-proc;


//  Está especializada en el manejo de valores de hora.

dcl-proc r5_iif_time export;

   dcl-pi *N like(r5_time_t);
      condition like(r5_boolean_t) const;
      value_if_true like(r5_time_t) const;
      value_if_false like(r5_time_t) const;
   end-pi;

   if condition;
      return value_if_true;
   else;
      return value_if_false;
   endif;
end-proc;


//  Está especializada en el manejo de valores de fecha y hora.

dcl-proc r5_iif_timestamp export;

   dcl-pi *N like(r5_time_stamp_t);
      condition like(r5_boolean_t) const;
      value_if_true like(r5_time_stamp_t) const;
      value_if_false like(r5_time_stamp_t) const;
   end-pi;

   if condition;
      return value_if_true;
   else;
      return value_if_false;
   endif;
end-proc;
