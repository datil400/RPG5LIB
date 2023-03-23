**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5EXCMGR
//  Module  : UTILITIES
//
//  Exception manager utilities
//
//  Author : datil400@gmail.com
//  Date   : June 2021
//
//  Compiling : R5EXCMGRI
//
//  Comments
//
//    Diversas funciones privadas de utilidad del gestor de excepciones.
//    Sólo para uso exclusivo del programa de servicio R5EXCMGR.

ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);


/COPY API,msgh_h
/COPY API,regex_h

/COPY RPG5LIB,c_lib_h
/COPY RPG5LIB,apierror_h
/COPY RPG5LIB,calllevelh
/COPY R5EXCMGR,excmgrdev


//  Interrumpe la ejecución del procedimiento llamador y deja un
//  mensaje de escape en las anotaciones del trabajo.
//
//  Este programa de servicio tiene definido un grupo de activación
//  con nombre. Este procedimiento permite el envío de un mensaje
//  de escape al nivel de llamada anterior al 'límite de control'
//  sin que se destruya el grupo de activación.
//
//  De uso exclusivo para este programa de servicio.

dcl-proc crash export;

   dcl-pi *N;
      msg pointer options(*STRING) value;
      s1 pointer options(*STRING: *NOPASS) value;
      s2 pointer options(*STRING: *NOPASS) value;
      s3 pointer options(*STRING: *NOPASS) value;
      s4 pointer options(*STRING: *NOPASS) value;
      s5 pointer options(*STRING: *NOPASS) value;
      s6 pointer options(*STRING: *NOPASS) value;
      s7 pointer options(*STRING: *NOPASS) value;
      s8 pointer options(*STRING: *NOPASS) value;
      s9 pointer options(*STRING: *NOPASS) value;
      s10 pointer options(*STRING: *NOPASS) value;
   end-pi;

   dcl-ds caller likeds(r5_call_level_info_t);
   dcl-s size like(r5_int_t);
   dcl-s msg_data char(512);
   dcl-ds error likeds(ERRC0100_T);
   dcl-s key char(4);

   r5_caller(caller);
   size = sprintf(%addr(msg_data)
                 : caller.procedure_name + ': ' + %str(msg)
                 : s1: s2: s3: s4: s5: s6: s7: s8: s9: s10);
   r5_api_error_init_for_exception(error);
   SndPgmMsg( 'CPF9897'
            : 'QCPFMSG   QSYS'
            : %str(%addr(msg_data))
            : size
            : '*ESCAPE'
            : '*CTLBDY': 1
            : key
            : error
            );
   return;
end-proc;


//  Interrumpe la ejecución del procedimiento llamador si se cumple
//  una condición. Además deja un mensaje de escape en las anotaciones
//  del trabajo.
//
//  Este programa de servicio tiene definido un grupo de activación
//  con nombre. Este procedimiento permite el envío de un mensaje
//  de escape al nivel de llamada anterior al 'límite de control'
//  sin que se destruya el grupo de activación.
//
//  De uso exclusivo para este programa de servicio.

dcl-proc crash_if export;

   dcl-pi *N;
      condition like(r5_boolean_t) const;
      msg pointer options(*STRING) value;
      s1 pointer options(*STRING: *NOPASS) value;
      s2 pointer options(*STRING: *NOPASS) value;
      s3 pointer options(*STRING: *NOPASS) value;
      s4 pointer options(*STRING: *NOPASS) value;
      s5 pointer options(*STRING: *NOPASS) value;
      s6 pointer options(*STRING: *NOPASS) value;
      s7 pointer options(*STRING: *NOPASS) value;
      s8 pointer options(*STRING: *NOPASS) value;
      s9 pointer options(*STRING: *NOPASS) value;
      s10 pointer options(*STRING: *NOPASS) value;
   end-pi;

   dcl-ds caller likeds(r5_call_level_info_t);
   dcl-s size like(r5_int_t);
   dcl-s msg_data char(512);
   dcl-ds error likeds(ERRC0100_T);
   dcl-s key char(4);

   if condition = *OFF;
      return;
   endif;

   r5_caller(caller);
   size = sprintf(%addr(msg_data)
                 : caller.procedure_name + ': ' + %str(msg)
                 : s1: s2: s3: s4: s5: s6: s7: s8: s9: s10);
   r5_api_error_init_for_exception(error);
   SndPgmMsg( 'CPF9897'
            : 'QCPFMSG   QSYS'
            : %str(%addr(msg_data))
            : size
            : '*ESCAPE'
            : '*CTLBDY': 1
            : key
            : error
            );
   return;
end-proc;


// PEP examples:
//   _CXX_PEP__Fv
//   _C_pep
//   _CL_PEP
//   _QRNP_PEP_<programa_name>

dcl-proc is_program_entry_procedure export;

   dcl-pi *N like(r5_boolean_t);
      procedure_name like(r5_pointer_t) options(*STRING) value;
   end-pi;

   dcl-c PEP_PATTERN   '_[^_].*_(PEP|pep)(_.+|$)';
   dcl-ds match likeds(regmatch_t);
   dcl-ds regex likeds(regex_t) static;
   dcl-s compiled like(r5_boolean_t) inz(*OFF) static;

   if not compiled;
      regcomp(regex: PEP_PATTERN: REG_EXTENDED + REG_ICASE + REG_NOSUB);
      compiled = *ON;
   endif;

   if regexec(regex: procedure_name: 0: match: 0) = 0;
      return *ON;
   endif;

   return *OFF;
end-proc;


//  Devuelve el valor más pequeño de la lista.
//
//  A partir de versión 7.2 TR6 y 7.3 TR2 existe la función incorporada %min()
//
//  Por compatibilidad con versiones anteriores se mantiene esta función.

dcl-proc min export;

   dcl-pi *N int(20);
      value1 int(20) const;
      value2 int(20) const;
      value3 int(20) options(*NOPASS) const;
      value4 int(20) options(*NOPASS) const;
      value5 int(20) options(*NOPASS) const;
      value6 int(20) options(*NOPASS) const;
      value7 int(20) options(*NOPASS) const;
      value8 int(20) options(*NOPASS) const;
      value9 int(20) options(*NOPASS) const;
      value10 int(20) options(*NOPASS) const;
      value11 int(20) options(*NOPASS) const;
      value12 int(20) options(*NOPASS) const;
      value13 int(20) options(*NOPASS) const;
      value14 int(20) options(*NOPASS) const;
      value15 int(20) options(*NOPASS) const;
   end-pi;

   dcl-s minimum like(value1);


   minimum = value1;

   if minimum > value2;
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
