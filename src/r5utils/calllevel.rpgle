**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5UTILS
//  Module  : CALLLEVEL
//
//  Call level utilities
//
//  Author : Javier Mora
//  Date   : September 2021
//
//  Compiling : R5UTILSI
//
//  Comments
//
//    Permite consultar los niveles de llamada del trabajo actual sin
//    hacer uso de la API Retrive Call Stack (QWVRCSTK) o de la función
//    de tabla SQL STACK_INFO.


ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);


/COPY API,msgh_h
/COPY API,mih_h

/COPY RPG5LIB,c_lib_h
/COPY RPG5LIB,joblog_h
/COPY R5UTILS,who_am_i_h
/COPY RPG5LIB,calllevelh


//  Busca el procedimiento del programa de usuario que originó la
//  invocación del programa activador mediante:
//
//    - operación de entrada/salida del lenguaje de alto nivel
//    - sentencia SQL incrustada en lenguaje de alto nivel
//    - llamada a DFU
//    - petición SQL desde un cliente (QZDASOINIT). En este caso
//      no es posible conocer el programa llamador.
//
//  'o_start' establece el nivel de llamada de partida para la
//  inspección de la pila de llamadas. El valor cero hace referencia
//  al nivel de llamada previo, es decir, al llamador
//  del llamador de 'trigger_caller'.

dcl-proc r5_trigger_caller export;

   dcl-pi *N;
      lvl likeds(r5_call_level_info_t);
      o_start like(r5_stack_counter_t) options(*NOPASS) const;
   end-pi;

   dcl-c PREVIOUS_TO_THE_CALLER  2;
   dcl-s sc like(o_start);


   if %parms() >= %parmnum(o_start);
      sc = o_start + PREVIOUS_TO_THE_CALLER;
   else;
      sc = PREVIOUS_TO_THE_CALLER;
   endif;

   sc = locate_call_trigger_pgm(lvl: sc);
   sc = locate_trigger_event_origin(lvl: sc);
   return;
end-proc;


//  Localiza el nivel de llamada del programa en QSYS que
//  ha invocado al programa activador.
//
//  Devuelve la posición que ocupa en la pila de llamadas
//  tomando como punto de referencia el nivel de llamada de
//  'r5_trigger_caller'.
//
//  Este procedimiento sólo debería llamarse desde 'r5_trigger_caller'.

dcl-proc locate_call_trigger_pgm;

   dcl-pi *N like(r5_uint_t) extproc(*DCLCASE);
      lvl likeds(r5_call_level_info_t);
      o_start like(r5_stack_counter_t) options(*NOPASS) const;
   end-pi;

   dcl-c THIS_CALL_LEVEL  1;
   dcl-s sc like(o_start);
   dcl-ds inv likeds(r5_invocation_attr_t);
   dcl-ds thread likeds(r5_job_thread_id_t);

   //  Posibles entradas de la pila:
   //    - QSYS/QDBUDR.CALL_TRIGGER_PGM
   //    - QSYS/QDBUDR.QDBUDR
   //    - QSYS/QDBPUT.CALL_TRIGGER_PGM
   //    - QSYS/QDBPUT.QDBPUT
   //    - QRNXIO._QRNX_DB_*  (si llamador es un ILE)

   if %parms() >= %parmnum(o_start);
      sc = o_start + THIS_CALL_LEVEL;
   else;
      sc = THIS_CALL_LEVEL;
   endif;

   callp(e) who_am_i(inv: thread: sc);
   dow not %error();
      if inv.program_library = 'QSYS';
         set_call_level_info(lvl: inv: thread);
         leave;
      endif;
      sc = sc + 1;
      callp(e) who_am_i(inv: thread: sc);
   enddo;
   return sc;
end-proc;


//  Localiza el nivel de llamada del procedimiento de usuario
//  que originó el evento de activación.
//
//  Devuelve la posición que ocupa en la pila de llamadas
//  tomando como punto de referencia el nivel de llamada de
//  'r5_trigger_caller'.
//
//  Este procedimiento sólo debería llamarse desde 'r5_trigger_caller'.

dcl-proc locate_trigger_event_origin;

   dcl-pi *N like(r5_uint_t) extproc(*DCLCASE);
      lvl likeds(r5_call_level_info_t);
      o_start like(r5_stack_counter_t) options(*NOPASS) const;
   end-pi;

   dcl-c THIS_CALL_LEVEL  1;
   dcl-s sc like(o_start);
   dcl-ds inv likeds(r5_invocation_attr_t);
   dcl-ds thread likeds(r5_job_thread_id_t);


   if %parms() >= %parmnum(o_start);
      sc = o_start + THIS_CALL_LEVEL;
   else;
      sc = THIS_CALL_LEVEL;
   endif;

   callp(e) who_am_i(inv: thread: sc);
   dow not %error();
      if inv.program_library <> 'QSYS';
         leave;
      endif;

      sc = sc + 1;
      callp(e) who_am_i(inv: thread: sc);
   enddo;

   if lvl.program_type = X'FF';
      sc = sc - 1;
      who_am_i(inv: thread: sc);
   endif;

   set_call_level_info(lvl: inv: thread);
   return sc;
end-proc;


//  Devuelve información sobre el nivel de llamada actual y que incluye
//  el nombre del procedimiento, la sentencia, el módulo y el programa.
//
//  Este procedimiento es silencioso respecto a posibles errores,
//  no genera excepciones y sólo deja un rastro en las anotaciones
//  del programa.

/IF NOT DEFINED(R5_THIS_WITH_MSG_APIS)

// IMPLEMENTADO CON INSTRUCCIONES DE LA INTERFAZ DE MÁQUINA

dcl-proc r5_this export;

   dcl-pi *N;
      lvl likeds(r5_call_level_info_t);
   end-pi;

   dcl-c CALLER  1;
   dcl-ds inv likeds(r5_invocation_attr_t);
   dcl-ds thread likeds(r5_job_thread_id_t);

   monitor;
      memset(%addr(lvl): X'00': %size(lvl));
      who_am_i(inv: thread: CALLER);
      set_call_level_info(lvl: inv: thread);

   on-error;
      r5_joblog('%s: Error inesperado.': %proc());
      reset_call_level_info(lvl);
   endmon;

   return;
end-proc;

/ELSE

// IMPLEMENTADO CON LAS APIS DE MENSAJES

dcl-proc r5_this export;

   dcl-pi *N;
      lvl likeds(r5_call_level_info_t);
   end-pi;

   dcl-c TEXT_MSG  'Who is before me?';
   dcl-c MSGF  'QCPFMSG   *LIBL';
   dcl-c CALLER  1;

   dcl-s msg_key char(4);
   dcl-ds error likeds(ERRC0100_T);

   dcl-s memSize like(r5_int_t) inz;
   dcl-ds rcvm likeds(RCVM0300PM_T) based(rcvm_ptr);
   dcl-ds sndInf likeds(RCVM0300PM_senderInf_T) based(sndInf_ptr);


   // Envía una 'sonda' al llamador de 'r5_this()'

   r5_api_error_init_for_monitor(error);
   SndPgmMsg( 'CPF9897': MSGF
            : TEXT_MSG: %size(TEXT_MSG)
            : '*INFO'
            : '*': CALLER
            : msg_Key
            : error
            : 1: '*NONE     *NONE': 0
            );
   if not r5_api_error_occurred(error);

      // Recupera y elimina la 'sonda' enviada

      memSize = 2048;
      rcvm_ptr = %alloc(memSize);

      r5_api_error_init_for_monitor(error);
      RcvPgmMsg( rcvm: memSize
               : 'RCVM0300'
               : '*': CALLER
               : '*INFO'
               : msg_key
               : 0
               : '*REMOVE'
               : error
               : 1: '*NONE     *NONE'
               );
   endif;

   if not r5_api_error_occurred(error) and
      rcvm.bytesAvl <= memSize;

      // Obtener la información del destinatario del mensaje
      // del mensaje

      sndInf_ptr = rcvm_ptr + %size(rcvm)
                           + rcvm.rplDtaOrTxtLenRtn
                           + rcvm.msgLenRtn
                           + rcvm.hlpLenRtn;
      lvl.program_type = X'FF';
      lvl.program_name = %trim(sndInf.rcvProgramName);
      lvl.program_library = '*N';
      lvl.module_name = %trim(sndInf.rcvModuleName);
      lvl.module_library = '*N';
      lvl.procedure_name = %trim(sndInf.rcvProcedureName);
      lvl.stmt(1) = %trim(%subst(sndInf.rcvPgmStatementNumbers: 1: 10));
      lvl.stmts_count = 1;
      lvl.job = '*N';     // sndInf.jobName/jobUser/jobNbr siempre se reciben en blanco
      lvl.thread_id = *ALLx'00';
      lvl.hex_thread_id = '*N';

   else;
      r5_joblog('%s: Error inesperado.': %proc());
      reset_call_level_info(lvl);
   endif;

   dealloc(N)  rcvm_ptr;

   return;
end-proc;

/ENDIF


//  Devuelve información sobre los niveles de llamada previos al actual,
//  que incluye el nombre de procedimiento, sentencia, módulo y programa.
//
//  Este procedimiento es silencioso respecto a posibles errores,
//  no genera excepciones y sólo deja un rastro en las anotaciones
//  del programa.
//
//  'o_target_offset' es el desplazamiento al nivel de llamada de destino
//  que se quiere consultar tomando como referencia al llamador de este
//  procedimiento.
//  Si no se indica su valor es cero y hace referencia al nivel de llamada
//  previo.


/IF NOT DEFINED(R5_CALLER_WITH_MSG_APIS)

// IMPLEMENTADO CON INSTRUCCIONES DE LA INTERFAZ DE MÁQUINA

dcl-proc r5_caller export;

   dcl-pi *N;
      lvl likeds(r5_call_level_info_t);
      o_target_offset like(r5_int_t) options(*NOPASS) const;
   end-pi;

   dcl-c PREVIOUS_TO_THE_CALLER  2;
   dcl-s target_offset like(o_target_offset);
   dcl-ds inv likeds(r5_invocation_attr_t);
   dcl-ds thread likeds(r5_job_thread_id_t);

   if %parms() >= %parmnum(o_target_offset);
      target_offset = o_target_offset;
   else;
      target_offset = 0;
   endif;
   target_offset += PREVIOUS_TO_THE_CALLER;

   monitor;
      memset(%addr(lvl): X'00': %size(lvl));
      who_am_i(inv: thread: target_offset);
      set_call_level_info(lvl: inv: thread);

   on-error;
      r5_joblog('%s: Error inesperado.': %proc());
      reset_call_level_info(lvl);
   endmon;

   return;
end-proc;

/ELSE

// IMPLEMENTADO CON LAS APIS DE MENSAJES

dcl-proc r5_caller export;

   dcl-pi *N;
      lvl likeds(r5_call_level_info_t);
      o_target_offset like(r5_int_t) options(*NOPASS) const;
   end-pi;

   dcl-c TEXT_MSG  'Who is before me?';
   dcl-c MSGF  'QCPFMSG   *LIBL';

   dcl-s target_offset like(o_target_offset);

   dcl-s msg_key char(4);
   dcl-ds error likeds(ERRC0100_T);

   dcl-s memSize like(r5_int_t) inz;
   dcl-ds rcvm likeds(RCVM0300PM_T) based(rcvm_ptr);
   dcl-ds sndInf likeds(RCVM0300PM_senderInf_T) based(sndInf_ptr);


   if %parms() >= %parmnum(o_target_offset);
      target_offset = o_target_offset;
   else;
      target_offset = 0;
   endif;

   // Envia una 'sonda' al procedimiento anterior al que ha
   // llamado a 'r5_caller()'

   r5_api_error_init_for_monitor(error);
   SndPgmMsg( 'CPF9897': MSGF
            : TEXT_MSG: %size(TEXT_MSG)
            : '*INFO'
            : '*': 2 + target_offset
            : msg_key
            : error
            : 1: '*NONE     *NONE': 0
            );

   if not r5_api_error_occurred(error);

      // Recupera y elimina la 'sonda' enviada

      memSize = 2048;
      rcvm_ptr = %alloc(memSize);
      r5_api_error_init_for_monitor(error);
      RcvPgmMsg( rcvm: memSize
               : 'RCVM0300'
               : '*': 2 + target_offset
               : '*INFO'
               : msg_key
               : 0
               : '*REMOVE'
               : error
               : 1: '*NONE     *NONE'
               );
   endif;

   if not r5_api_error_occurred(error) and
      rcvm.bytesAvl <= memSize;

      // Obtener la información del destinatario del mensaje

      sndInf_ptr = rcvm_ptr + %Size(rcvm)
                            + rcvm.rplDtaOrTxtLenRtn
                            + rcvm.msgLenRtn
                            + rcvm.hlpLenRtn;
      lvl.program_type = X'FF';
      lvl.program_name = %trim(sndInf.rcvProgramName);
      lvl.program_library = '*N';
      lvl.module_name = %trim(sndInf.rcvModuleName);
      lvl.module_library = '*N';
      lvl.procedure_name = %trim(sndInf.rcvProcedureName);
      lvl.stmt(1) = %trim(%subst(sndInf.rcvPgmStatementNumbers: 1: 10));
      lvl.stmts_count = 1;
      lvl.job = '*N';     // sndInf.jobName/jobUser/jobNbr siempre se reciben en blanco
      lvl.thread_id = *ALLx'00';
      lvl.hex_thread_id = '*N';

   else;
      r5_joblog('%s: Error inesperado.': %proc());
      reset_call_level_info(lvl);
   endif;

   dealloc(N)  rcvm_ptr;

   return;
end-proc;

/ENDIF


dcl-proc set_call_level_info;

   dcl-pi *N extproc(*DCLCASE);
      lvl likeds(r5_call_level_info_t);
      inv likeds(r5_invocation_attr_t);     // const
      thread likeds(r5_job_thread_id_t);    // const
   end-pi;

   dcl-s s int(3);


   memset(%addr(lvl): X'00': %size(lvl));

   lvl.program_type = inv.type;
   lvl.program_name = inv.program_name;
   lvl.program_library = inv.program_library;
   lvl.module_name = inv.module_name;
   lvl.module_library = inv.module_library;
   lvl.procedure_name = inv.procedure_name;
   lvl.stmts_count = inv.stmts_count;
   for s = 1 to lvl.stmts_count;
      lvl.stmt(s) = %trim(%char(inv.stmt(s)));
   endfor;
   lvl.job = thread.job_id;
   lvl.thread_id = thread.thread_id;
   HexToChar(%addr(lvl.char_thread_id): %addr(thread.thread_id): %size(lvl.char_thread_id));

   return;
end-proc;


dcl-proc reset_call_level_info;

   dcl-pi *N extproc(*DCLCASE);
      lvl likeds(r5_call_level_info_t);
   end-pi;


   lvl.program_type = X'FF';
   lvl.program_name = '*N';
   lvl.program_library = '*N';
   lvl.module_name = '*N';
   lvl.module_library = '*N';
   lvl.procedure_name = '*N';
   lvl.stmts_count = 0;
   memset(%addr(lvl.statements): X'00': %size(lvl.statements));
   lvl.job = '*N';
   lvl.thread_id = *ALLx'00';
   lvl.char_thread_id = '*N';
   return;
end-proc;

