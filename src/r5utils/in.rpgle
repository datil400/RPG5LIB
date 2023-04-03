**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5UTILS
//  Module  : IN
//
//  Family of "in" functions.
//
//  Author : datil400@gmail.com
//  Date   : March 2023
//
//  Compiling : R5UTILSI
//
//  Comments
//
//    La implementación de estas funciones está inspirada en la
//    propuesta de Rory Hewit de utilizar la intstrucción de la
//    interfaz de máquina NPMPARMLISTADDR para recorrer la lista
//    de parámetros.
//
//    Implementing an IN-Type Procedure in RPG
//    Sistem iNetwork, December 2011
//
//    Nota: este artículo no se encuentra accesible actualmente.


ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);


/COPY API,ParmList_H
/COPY RPG5LIB,in_h


dcl-proc r5_in_char export;

   dcl-pi *N like(r5_boolean_t) opdesc;
      search like(r5_varchar_t) options(*VARSIZE) const;
      value1 like(r5_varchar_t) options(*VARSIZE) const;
      value2 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
      value3 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
      value4 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
      value5 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
      value6 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
      value7 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
      value8 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
      value9 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
      value10 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
   end-pi;

   dcl-ds parm_list likeds(Npm_ParmList_t) based(parm_list_ptr);
   dcl-ds desc_list likeds(Npm_DescList_t) based (desc_list_ptr);
   dcl-s value like(search) based(value_ptr);
   dcl-s p like(r5_small_t);


   parm_list_ptr = Npm_ParmList_Addr();
   desc_list_ptr = parm_list.desclist;

   // First parmeter is the search argument

   for p = 2 to desc_list.argc;
      value_ptr = parm_list.parm(p);

      if search = value;
         return *ON;
      endif;
   endfor;
   return *OFF;
end-proc;


dcl-proc r5_in_dec export;

   dcl-pi *N like(r5_boolean_t) opdesc;
      search like(r5_long_packed_t) const;
      value1 like(r5_long_packed_t) const;
      value2 like(r5_long_packed_t) options(*NOPASS) const;
      value3 like(r5_long_packed_t) options(*NOPASS) const;
      value4 like(r5_long_packed_t) options(*NOPASS) const;
      value5 like(r5_long_packed_t) options(*NOPASS) const;
      value6 like(r5_long_packed_t) options(*NOPASS) const;
      value7 like(r5_long_packed_t) options(*NOPASS) const;
      value8 like(r5_long_packed_t) options(*NOPASS) const;
      value9 like(r5_long_packed_t) options(*NOPASS) const;
      value10 like(r5_long_packed_t) options(*NOPASS) const;
   end-pi;

   dcl-ds parm_list likeds(Npm_ParmList_t) based(parm_list_ptr);
   dcl-ds desc_list likeds(Npm_DescList_t) based (desc_list_ptr);
   dcl-s value like(search) based(value_ptr);
   dcl-s p like(r5_small_t);


   parm_list_ptr = Npm_ParmList_Addr();
   desc_list_ptr = parm_list.desclist;

   // First parmeter is the search argument

   for p = 2 to desc_list.argc;
      value_ptr = parm_list.parm(p);

      if search = value;
         return *ON;
      endif;
   endfor;
   return *OFF;
end-proc;


dcl-proc r5_in_int export;

   dcl-pi *N like(r5_boolean_t) opdesc;
      search like(r5_long_t) const;
      value1 like(r5_long_t) const;
      value2 like(r5_long_t) options(*NOPASS) const;
      value3 like(r5_long_t) options(*NOPASS) const;
      value4 like(r5_long_t) options(*NOPASS) const;
      value5 like(r5_long_t) options(*NOPASS) const;
      value6 like(r5_long_t) options(*NOPASS) const;
      value7 like(r5_long_t) options(*NOPASS) const;
      value8 like(r5_long_t) options(*NOPASS) const;
      value9 like(r5_long_t) options(*NOPASS) const;
      value10 like(r5_long_t) options(*NOPASS) const;
   end-pi;

   dcl-ds parm_list likeds(Npm_ParmList_t) based(parm_list_ptr);
   dcl-ds desc_list likeds(Npm_DescList_t) based (desc_list_ptr);
   dcl-s value like(search) based(value_ptr);
   dcl-s p like(r5_small_t);


   parm_list_ptr = Npm_ParmList_Addr();
   desc_list_ptr = parm_list.desclist;

   // First parmeter is the search argument

   for p = 2 to desc_list.argc;
      value_ptr = parm_list.parm(p);

      if search = value;
         return *ON;
      endif;
   endfor;
   return *OFF;
end-proc;

//  NOTA:
//
//  ¿Faltaría algún tipo de margen (delta) que permita evaluar como
//  igual dos floats que no sean "exactamente iguales"?

dcl-proc r5_in_float export;

   dcl-pi *N like(r5_boolean_t) opdesc;
      search like(r5_double_t) const;
      delta like(r5_double_t) const;
      value1 like(r5_double_t) const;
      value2 like(r5_double_t) options(*NOPASS) const;
      value3 like(r5_double_t) options(*NOPASS) const;
      value4 like(r5_double_t) options(*NOPASS) const;
      value5 like(r5_double_t) options(*NOPASS) const;
      value6 like(r5_double_t) options(*NOPASS) const;
      value7 like(r5_double_t) options(*NOPASS) const;
      value8 like(r5_double_t) options(*NOPASS) const;
      value9 like(r5_double_t) options(*NOPASS) const;
      value10 like(r5_double_t) options(*NOPASS) const;
   end-pi;

   dcl-ds parm_list likeds(Npm_ParmList_t) based(parm_list_ptr);
   dcl-ds desc_list likeds(Npm_DescList_t) based (desc_list_ptr);
   dcl-s value like(search) based(value_ptr);
   dcl-s p like(r5_small_t);


   parm_list_ptr = Npm_ParmList_Addr();
   desc_list_ptr = parm_list.desclist;

   // First parmeter is the search argument
   // Second parameter is margin error

   for p = 3 to desc_list.argc;
      value_ptr = parm_list.parm(p);

      if %abs(search - value) <= %abs(delta);
         return *ON;
      endif;
   endfor;
   return *OFF;
end-proc;


dcl-proc r5_in_date export;

   dcl-pi *N like(r5_boolean_t) opdesc;
      search like(r5_date_t) const;
      value1 like(r5_date_t) const;
      value2 like(r5_date_t) options(*NOPASS) const;
      value3 like(r5_date_t) options(*NOPASS) const;
      value4 like(r5_date_t) options(*NOPASS) const;
      value5 like(r5_date_t) options(*NOPASS) const;
      value6 like(r5_date_t) options(*NOPASS) const;
      value7 like(r5_date_t) options(*NOPASS) const;
      value8 like(r5_date_t) options(*NOPASS) const;
      value9 like(r5_date_t) options(*NOPASS) const;
      value10 like(r5_date_t) options(*NOPASS) const;
   end-pi;

   dcl-ds parm_list likeds(Npm_ParmList_t) based(parm_list_ptr);
   dcl-ds desc_list likeds(Npm_DescList_t) based (desc_list_ptr);
   dcl-s value like(search) based(value_ptr);
   dcl-s p like(r5_small_t);


   parm_list_ptr = Npm_ParmList_Addr();
   desc_list_ptr = parm_list.desclist;

   // First parmeter is the search argument

   for p = 2 to desc_list.argc;
      value_ptr = parm_list.parm(p);

      if search = value;
         return *ON;
      endif;
   endfor;
   return *OFF;
end-proc;


dcl-proc r5_in_time export;

   dcl-pi *N like(r5_boolean_t) opdesc;
      search like(r5_time_t) const;
      value1 like(r5_time_t) const;
      value2 like(r5_time_t) options(*NOPASS) const;
      value3 like(r5_time_t) options(*NOPASS) const;
      value4 like(r5_time_t) options(*NOPASS) const;
      value5 like(r5_time_t) options(*NOPASS) const;
      value6 like(r5_time_t) options(*NOPASS) const;
      value7 like(r5_time_t) options(*NOPASS) const;
      value8 like(r5_time_t) options(*NOPASS) const;
      value9 like(r5_time_t) options(*NOPASS) const;
      value10 like(r5_time_t) options(*NOPASS) const;
   end-pi;

   dcl-ds parm_list likeds(Npm_ParmList_t) based(parm_list_ptr);
   dcl-ds desc_list likeds(Npm_DescList_t) based (desc_list_ptr);
   dcl-s value like(search) based(value_ptr);
   dcl-s p like(r5_small_t);


   parm_list_ptr = Npm_ParmList_Addr();
   desc_list_ptr = parm_list.desclist;

   // First parmeter is the search argument

   for p = 2 to desc_list.argc;
      value_ptr = parm_list.parm(p);

      if search = value;
         return *ON;
      endif;
   endfor;
   return *OFF;
end-proc;


//  Time stamp

dcl-proc r5_in_ts export;

   dcl-pi *N like(r5_boolean_t) opdesc;
      search like(r5_time_stamp_t) const;
      value1 like(r5_time_stamp_t) const;
      value2 like(r5_time_stamp_t) options(*NOPASS) const;
      value3 like(r5_time_stamp_t) options(*NOPASS) const;
      value4 like(r5_time_stamp_t) options(*NOPASS) const;
      value5 like(r5_time_stamp_t) options(*NOPASS) const;
      value6 like(r5_time_stamp_t) options(*NOPASS) const;
      value7 like(r5_time_stamp_t) options(*NOPASS) const;
      value8 like(r5_time_stamp_t) options(*NOPASS) const;
      value9 like(r5_time_stamp_t) options(*NOPASS) const;
      value10 like(r5_time_stamp_t) options(*NOPASS) const;
   end-pi;

   dcl-ds parm_list likeds(Npm_ParmList_t) based(parm_list_ptr);
   dcl-ds desc_list likeds(Npm_DescList_t) based (desc_list_ptr);
   dcl-s value like(search) based(value_ptr);
   dcl-s p like(r5_small_t);


   parm_list_ptr = Npm_ParmList_Addr();
   desc_list_ptr = parm_list.desclist;

   // First parmeter is the search argument

   for p = 2 to desc_list.argc;
      value_ptr = parm_list.parm(p);

      if search = value;
         return *ON;
      endif;
   endfor;
   return *OFF;
end-proc;

