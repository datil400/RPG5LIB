**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5EXCMGR
//  Module  : EXCMGR
//
//  Exception manager
//
//  Author : datil400@gmail.com
//  Date   : June 2021
//
//  Compiling : R5EXCMGRI
//
//  Este mecanismo de gestión de errores se basa en una expresión que lanza
//  una excepción que ha de ser atrapada por un manejador.
//
//  La idea fundamental del manejo de excepciones es que si una función
//  encuentra un problema que no puede resolver lanzará una excepción,
//  esperando que quien la llamó (directa o indirectamente) pueda manejar
//  el problema.
//
//  ¿Cómo se puede codificar un manejador de errores?
//
//    monitor;
//       hacer_algo();
//
//    on-error;
//       r5_catch();
//
//       // aquí el manejador
//    endmon;
//
//  o de esta otra forma:
//
//    callp(e) hacer_algo();
//    if %error();
//       r5_catch();
//
//       // aquí el manejador
//    endif;
//
//  La operación de lanzar (throw) y atrapar (catch) una excepción implica
//  examinar la cadena de llamadas para encontrar un manejador de la
//  excepción.
//
//  Este gestor de excepciones utiliza un mensaje de escape para interrumpir
//  inmediatamente la ejecución del procedimiento que ha lanzado la excepción.
//
//  ¿Cómo se lanza una excepción?
//
//    dcl-s ex like(r5_object_t);
//
//    ex = r5_exception_new('CPF9897': 'QCPFMSG   QSYS': 'Datos de la excepción');
//    r5_throw(ex);
//
//  Este gestor de excepciones se sustenta en dos procedimientos:
//  'send_exception_to_call_level' y 'r5_catch'. Ambos intentan simular en RPG
//  el mismo comportamiento de otros lenguajes de programación como C++ o
//  Java.
//
//  'r5_throw' lanza un mensaje de escape al nivel de llamada anterior a su
//  llamador. El efecto es la interrupción inmediata del procedimiento que lanza
//  la excepción.
//
//  Se dispone de un grupo de procedimientos que también pueden lanzar una
//  excepción:
//
//    r5_check_sql_state
//    r5_assert
//    r5_fail
//    r5_resend_exception
//
//  'r5_catch' atrapa la última excepción lanzada ya sea por este gestor o
//  por el sistema. Debe observase que el menajedor de la excepción siempre
//  deberá utilizarse dentro de un bloque 'on-error' de la sentencia 'monitor'
//  o en el cuerpo de un 'if %error()'.
//
//  Una vez atrapada la excepción podrá consultarse cualquier información
//  relacionada con ésta: id del mensaje, texto del mensaje y datos de
//  sustitución, quién la lanzó, pila de llamadas, etc. Siempre se podrá
//  consultar la última excepción atrapada.
//
//  Además, este gestor de excepciones proporciona otras funciones de
//  utilidad como las relacionadas con el uso de la pila de llamadas.
//
//  Developer
//
//    /COPY RPG5LIB,excmgr_h


ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);


/COPY API,msgh_h
/COPY API,CEEPROC_h
/COPY API,wrkman_h

/COPY RPG5LIB,apierror_h
/COPY RPG5LIB,joblog_h
/COPY RPG5LIB,callstackh
/COPY RPG5LIB,callstke_h
/COPY RPG5LIB,calllevelh
/COPY RPG5LIB,c_lib_h
/COPY R5EXCMGR,excmgrdev
/COPY RPG5LIB,excmgr_h


dcl-c EXCEPTION_MANAGER_ID  'send_exception_to_call_level';
dcl-c CALLING_PROGRAM  -1;

dcl-c DFT_MSG_ID  'CPF9897';
dcl-c FAIL_MSG_ID  'CPF9897';
dcl-c DFT_MSG_FILE  'QCPFMSG   *LIBL';


dcl-ds exception_sender_t qualified template;
   program like(r5_program_name_t);
   module like(r5_module_name_t);
   procedure like(r5_procedure_name_t);
   statements;
      stmt like(r5_statement_t) overlay(statements)
           dim(3);
   stmt_count like(r5_small_t);
end-ds;

/COPY RPG5LIB,pgmsts_h

dcl-ds exception_manager qualified inz;
   exception like(r5_object_t);
   call_stack like(r5_object_t);
   rcv_msg pointer;
   job likeds(r5_qualified_job_t);
   sender likeds(exception_sender_t);
   msg_key like(r5_message_key_t);
end-ds;


//  Lanza una excepción e interrumpe la ejecución del procedimiento llamador.
//  Si no se indica 'exception', se vuelve a lanzar la última excepción
//  atrapada.

dcl-proc r5_throw export;

   dcl-pi *N;
      exception like(r5_object_t) options(*NOPASS) value;
   end-pi;

   dcl-c PREVIOUS_CALLER_OF_THE_THROW_CALLER  2;
   dcl-c SKIP_PEP  1;
   dcl-s target like(r5_int_t);
   dcl-ds previous likeds(r5_call_level_info_t);


   monitor;
      target = PREVIOUS_CALLER_OF_THE_THROW_CALLER;

      r5_caller(previous: 1);
      if is_program_entry_procedure(previous.procedure_name);
         target += SKIP_PEP;
      endif;

      if %parms() >= %parmnum(exception);
         send_exception_to_call_level(exception: target);
      else;
         send_exception_to_call_level(exception_manager.exception: target);
      endif;

   on-error;
      crash(UNEXPECTED_ERROR);
   endmon;
   return;
end-proc;


//  Busca la llamada dinámica a programa más cercana y lanza una excepción
//  al nivel de llamada anterior a esa llamada.
//  Si no se indica 'exception', se vuelve a lanzar la última excepción
//  atrapada.

dcl-proc r5_throw_to_calling_program export;

   dcl-pi *N;
      exception like(r5_object_t) options(*NOPASS) value;
   end-pi;


   monitor;
      if %parms() >= %parmnum(exception);
         send_exception_to_call_level(exception: CALLING_PROGRAM);
      else;
         send_exception_to_call_level(exception_manager.exception: CALLING_PROGRAM);
      endif;

   on-error;
      crash(UNEXPECTED_ERROR);
   endmon;
   return;
end-proc;


//  Comprueba el área de comunicaciones SQL (SQLCA) de la última sentencia
//  ejecutada.
//
//  Devuelve *ON si finalizó correctamente la sentencia SQL. En una
//  sentencia SELECT se dá por bueno la lectura parcial de los datos o
//  errores de correlación.
//
//  Devuelve *OFF si no se recuperaron datos en la sentencia SQL. Equivale
//  al '%eof' en una lectura de E/S nativa.
//
//  En cualquier otro caso se lanza una excepción 'SQxaaaa', donde el valor
//  de 'xaaaa' equivale a SQLCOD.

dcl-proc r5_check_sql_state export;

   dcl-pi *N like(r5_boolean_t);
      sqlca likeds(r5_sqlca_t) const;
   end-pi;

   dcl-c CALLER_PROCEDURE  1;
   dcl-s ex like(r5_object_t);


   select;

   // Finalización correcta de la setencia SQL:
   //
   // 00000 = Ejecución satisfactoria y no se produjo ningún tipo de
   //         condición de aviso o de excepción.
   // 01nnn = Se realizó una lectura de datos, pero la sentencia SQL
   //         detectó algún problema de correlación.
   //
   // Esta estrategia tiene como inconveniente que no se
   // detectan los problemas que pudieran 'estropear' los
   // datos recuperados.

   when %subst(sqlca.sqlstate: 1: 2) = '00'
     or %subst(sqlca.sqlstate: 1: 2) = '01';
      return *ON;

   // 02nnn = No hay datos.

   when %subst(sqlca.sqlstate: 1: 2) = '02';
      return  *OFF;

   // >= 03nnn = Error en la ejecución.

   other;
      ex = sqlca_to_exception(sqlca);
      send_exception_to_call_level(ex: CALLER_PROCEDURE);
   endsl;

   return  *OFF;
end-proc;


dcl-proc sqlca_to_exception;

   dcl-pi *N like(r5_object_t) extproc(*DCLCASE);
      sqlca likeds(r5_sqlca_t) const;
   end-pi;

   dcl-s ex like(r5_object_t);
   dcl-s sql_msg_id like(r5_message_id_t);


   sql_msg_id = sqlcode_to_msg_id(sqlca.sqlcode);

   if sqlca.sqlerrml > 0;
      ex = r5_exception_new( sql_msg_id: 'QSQLMSG   *LIBL'
                           : %subst(sqlca.sqlerrmc: 1: sqlca.sqlerrml)
                           );
   else;
      ex = r5_exception_new(sql_msg_id: 'QSQLMSG   *LIBL');
   endif;

   return ex;
end-proc;


dcl-proc sqlcode_to_msg_id;

   dcl-pi *N like(r5_message_id_t) extproc(*DCLCASE);
      sqlcode like(r5_sqlca_t.sqlcode) const;
   end-pi;

   dcl-s msg_id like(r5_message_id_t);
   dcl-s id varchar(5);


   id = %trim(%editc(%abs(sqlcode): 'Z'));
   if %len(id) < 5;
      msg_id = 'SQL' + %subst('0000' + id: %len(id) + 1: 4);
   else;
      msg_id = 'SQ' + id;
   endif;

   return msg_id;
end-proc;


//  Comprueba la validez de una aserición y si no se cumple
//  lanza una excepción avisando de la situación y de la
//  posición del programa donde ocurrió.

dcl-proc r5_assert export;

   dcl-pi *N;
      condition like(r5_boolean_t) const;
      o_msg varchar(512) options(*TRIM: *NOPASS) const;
   end-pi;

   dcl-c PREVIOUS_CALLER_OF_THE_ASSERT_CALLER  2;
   dcl-s msg like(o_msg) inz;
   dcl-ds caller likeds(r5_call_level_info_t);
   dcl-s assert_fail like(r5_object_t);


   if condition = *ON;
      return;
   endif;

   if %parms() >= %parmnum(o_msg);
      msg = o_msg;
   else;
      msg = '*N';
   endif;

   monitor;
      r5_caller(caller);

      msg = caller.program_name + '.'
          + caller.module_name + '.'
          + caller.procedure_name
          + ' (' + %trim(caller.stmt(1)) + ')'
          +  ' : '
          + msg
          ;
      assert_fail = r5_exception_new(FAIL_MSG_ID: *OMIT: msg);
      send_exception_to_call_level(assert_fail: PREVIOUS_CALLER_OF_THE_ASSERT_CALLER);

   on-error;
      crash(UNEXPECTED_ERROR);
   endmon;
   return;
end-proc;


dcl-proc r5_fail export;

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

   dcl-c PREVIOUS_CALLER_OF_THE_FAIL_CALLER  2;
   dcl-s msg_data char(512);
   dcl-s size like(r5_int_t);
   dcl-s ex like(r5_object_t);


   monitor;
      size = sprintf(%addr(msg_data): msg: s1: s2: s3: s4: s5: s6: s7: s8: s9: s10);
      ex = r5_exception_new(FAIL_MSG_ID: *OMIT: %str(%addr(msg_data)));
      send_exception_to_call_level(ex: PREVIOUS_CALLER_OF_THE_FAIL_CALLER);

   on-error;
      crash(UNEXPECTED_ERROR);
   endmon;
   return;
end-proc;


//  Envía un mensaje de escape a la cola de mensajes del nivel de llamada
//  especificado.
//
//  'target_entry' identifica el nivel de llamada que recibe el mensaje
//  tomando como punto de partida la invocación de este procedimiento:
//
//    0  Envía el mensaje al nivel de llamada que invoca este procedimiento.
//    1  Envía el mensaje al nivel de llamada anterior del que invoca este
//       procedimiento.
//    n  (cualquier número positivo) Envía el mensaje al enésimo nivel de
//       llamada tomando como referencia la invocación de este procedimiento.

dcl-proc send_exception_to_call_level;

   dcl-pi *N extproc(*DCLCASE);
      exception like(r5_object_t) value;
      target_entry like(int4_t) value;
   end-pi;

   dcl-c THIS_CALL_LEVEL  1;
   dcl-c PREVIOUS  1;

   dcl-s msg_id like(r5_message_id_t);
   dcl-ds msg_file likeds(r5_message_file_t);

   dcl-ds sending_error likeds(ERRC0100_T);
   dcl-ds error likeds(ERRC0100_T);
   dcl-s key char(4);


   crash_if(exception = *NULL: NULL_REFERENCE_ERROR);
   crash_if(target_entry < -1: TARGET_INVOCATION_ERROR);

   save_exception_info(exception);

   select;
   when target_entry = CALLING_PROGRAM;
      target_entry = previous_to_nearest_calling_program();

   when target_entry = -2;
      //target_entry = previous_to_nearest_control_boundary();
   endsl;

   msg_id = r5_exception_message_id(exception);
   msg_file = r5_exception_message_file(exception);

   // Sería conveniente validar el id de mensaje antes de lazar la
   // excepción, bien aquí o cuando se crea la excepción.

   r5_api_error_init_for_monitor(sending_error);
   SndPgmMsg( msg_id: msg_file
            : r5_exception_message_data(exception)
            : r5_exception_message_data_size(exception)
            : '*ESCAPE'
            : '*': THIS_CALL_LEVEL + target_entry
            : exception_manager.msg_key
            : sending_error
            );
   if  r5_api_error_occurred(sending_error);
      r5_joblog( '%s: '
               + 'Error al lanzar el mensaje %s '
               + 'del archivo de mensajes %s '
               + 'de la biblioteca %s.'
               : %proc()
               : %trim(msg_id): %trim(msg_file.name): %trim(msg_file.lib)
               );
      r5_api_error_init_for_exception(error);
      SndPgmMsg( sending_error.msgId
               : DFT_MSG_FILE
               : sending_error.msgDta
               : sending_error.bytesAvl - 16
               : '*ESCAPE'
               : '*CTLBDY': PREVIOUS
               : key
               : error
               );
      return;
   endif;

   return;
end-proc;


dcl-proc save_exception_info;
   dcl-pi *N extproc(*DCLCASE);
      exception like(r5_object_t) value;
   end-pi;

   dcl-c IGNORE_ENTRIES  3;
     // thrower + send_exception_to... + save_exception_info invocatios

   dcl-s stack like(r5_object_t);


   if exception = exception_manager.exception;
      exception_manager.exception = *NULL;    // Evita la limpieza
   endif;

   exception_manager_reset();
   exception_manager.exception = exception;
   stack = r5_call_stack_get_from_current_job(IGNORE_ENTRIES);
   save_sender_from_call_stack(stack);
   exception_manager.call_stack = stack;
   return;
end-proc;


dcl-proc save_sender_from_call_stack;

   dcl-pi *N extproc(*DCLCASE);
      stack like(r5_object_t) value;
   end-pi;

   dcl-s top like(r5_object_t);
   dcl-ds sender likeds(exception_sender_t) based(sender_ptr);

   crash_if(stack = *NULL: NULL_REFERENCE_ERROR);

   top = r5_call_stack_top(stack);
   crash_if(top = *NULL: EMPTY_CALL_STACK_ERROR);

   sender_ptr = %addr(exception_manager.sender);
   sender.program = r5_call_stack_entry_program_name(top);
   sender.module = r5_call_stack_entry_module_name(top);
   sender.procedure = r5_call_stack_entry_procedure_name(top);
   sender.stmt(1) = r5_call_stack_entry_statement_id(top: 1);
   sender.stmt_count = 1;
   return;
end-proc;


dcl-proc previous_to_nearest_calling_program;

   dcl-pi *N like(r5_int_t) extproc(*DCLCASE);
   end-pi;

   dcl-c PREVIOUS  1;
   dcl-s offset like(r5_int_t);

   offset = PREVIOUS + look_for_calling_program();
   return offset;
end-proc;


dcl-proc look_for_calling_program;

   dcl-pi *N like(r5_int_t) extproc(*DCLCASE);
   end-pi;

   dcl-s stack like(r5_object_t);
   dcl-s pos like(r5_int_t);
   dcl-s entry like(r5_object_t);
   dcl-s top like(r5_object_t);
   dcl-s top_pos like(r5_int_t);


   crash_if(exception_manager.call_stack = *NULL: NULL_REFERENCE_ERROR);

   stack = exception_manager.call_stack;

   pos = r5_call_stack_look_for_program_boundary(stack);
   dow pos <> 0;
      entry = r5_call_stack_at_entry(stack: pos);
      if r5_call_stack_entry_is_program(entry);
         leave;
      endif;
      pos = r5_call_stack_look_for_program_boundary(stack: pos + 1);
   enddo;

   top = r5_call_stack_top(stack);
   top_pos = r5_call_stack_entry_position(stack: top);
   return (pos - top_pos + 1);
end-proc;


//  Reenviar el último mensaje de escape recibido junto a los
//  mensajes de diagnóstico.
//
//  Evita el procedimiento de entrada de programa (PEP) si
//  fuera el llamador.
//
//  ¡Ojo! NO significa relanzar una excepción atrapada.

dcl-proc r5_resend_exception export;

   dcl-c PREVIOUS_CALLER_OF_THE_RESEND_CALLER  2;
   dcl-c SKIP_PEP  1;

   dcl-ds error likeds(ERRC0100_T);
   dcl-ds rsnm likeds(RSNM0100_T) inz(*LIKEDS);
   dcl-ds previous likeds(r5_call_level_info_t);
   dcl-s target like(r5_int_t);


   target = PREVIOUS_CALLER_OF_THE_RESEND_CALLER;

   r5_caller(previous: 1);
   if is_program_entry_procedure(previous.procedure_name);
      target += SKIP_PEP;
   endif;

   // (1) Mueve los mensajes de diagnóstico a la entrada de destino.
   // (2) Recoge los mensajes de la cola de mensajes del procedimiento
   // que invocó a 'resend'.

   //  Mover mensajes de diagnóstico
   r5_api_error_init_for_monitor(error);
   MovPgmMsg( *BLANKS
            : '*DIAG     ': 1
            : '*': target    // (1)
            : error
            : 20
            : '*NONE     *NONE     '
            : '*CHAR'
            : *NULL: 1       // (2)
            );
   if r5_api_error_occurred(error);
      crash(UNEXPECTED_ERROR);
   endif;

   //  Reenviar el último mensaje de escape
   r5_api_error_init_for_monitor(error);
   rsnm.callStkEntId = '*';
   rsnm.callStkCnt = target; // (1)
   RsnEscMsg( *BLANKS
            : error
            : rsnm
            : %size(rsnm)
            : 'RSNM0100'
            : *NULL: 1       // (2)
            );
   if r5_api_error_occurred(error);
      crash(UNEXPECTED_ERROR);
   endif;

   return;
end-proc;


//  Atrapar una excepción lanzada.

dcl-proc r5_catch export;

   dcl-c PREVIOUS_CALL_LEVEL  1;

   dcl-s key like(MessageKey_T);
   dcl-ds error likeds(ERRC0100_T);

   dcl-ds rcv_msg likeds(RCVM0300PM_T) based(rcv_ptr);
   dcl-s msginf like(TypeBuffer) based(rcv_ptr);
   dcl-ds sender likeds(RCVM0300PM_senderInf_T) based(sender_ptr);

   dcl-ds api_bytes likeds(r5_api_bytes_t) inz(*LIKEDS);


   monitor;
      r5_api_error_init_for_monitor(error);
      RcvPgmMsg( api_bytes
               : %size(api_bytes)
               : 'RCVM0300'
               : '*'
               : PREVIOUS_CALL_LEVEL
               : '*EXCP'
               : key
               : 0
               : '*SAME'
               : error
               );
      if r5_api_error_occurred(error)
      or api_bytes.available = 0;
         exception_manager_reset();
         crash(UNEXPECTED_ERROR);
         return;
      endif;

      rcv_ptr = %alloc(api_bytes.available);
      RcvPgmMsg( msginf
               : api_bytes.available
               : 'RCVM0300'
               : '*'
               : PREVIOUS_CALL_LEVEL
               : '*EXCP'
               : key
               : 0
               : '*REMOVE'
               : error
               );
      if r5_api_error_occurred(error);
         exception_manager_reset();
         r5_joblog('%s: %s': %proc(): error.msgId);
         crash(UNEXPECTED_ERROR);
         return;
      endif;

      sender_ptr = RCVM0300_pointer_to_sender(rcv_msg);

      // ¿Quién lanzó la excepción atrapada?
      if sender.sndProcedureName = EXCEPTION_MANAGER_ID;
         // Fue el gestor de excepciones
         exception_manager.rcv_msg = rcv_ptr;

      else;
         // Fue cualquier otro mecanismo.
         save_message_info(rcv_msg);
      endif;

      save_job_id();

   on-error;
      exception_manager_reset();
      crash(UNEXPECTED_ERROR);
      return;
   endmon;
   return;
end-proc;


dcl-proc exception_manager_reset;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   r5_exception_delete(exception_manager.exception);
   r5_call_stack_release(exception_manager.call_stack);
   dealloc(N) exception_manager.rcv_msg;
   clear exception_manager;
end-proc;


dcl-proc save_message_info;

   dcl-pi *N extproc(*DCLCASE);
      rcv_msg likeds(RCVM0300PM_T);
   end-pi;

   dcl-c IGNORE_THIS_CALL_LEVEL  1;


   exception_manager_reset();
   exception_manager.exception = RCVM0300_to_exception(rcv_msg);
   exception_manager.call_stack = r5_call_stack_get_from_current_job(IGNORE_THIS_CALL_LEVEL);
   exception_manager.rcv_msg = %addr(rcv_msg);
   save_sender_from_message(rcv_msg);
   return;
end-proc;


dcl-proc save_sender_from_message;

   dcl-pi *N extproc(*DCLCASE);
      rcv_msg likeds(RCVM0300PM_T);
   end-pi;

   dcl-ds sender_inf likeds(RCVM0300PM_senderInf_T) based(sender_inf_ptr);
   dcl-ds sender likeds(exception_sender_t) based(sender_ptr);
   dcl-s s like(exception_sender_t.stmt_count);


   sender_inf_ptr = RCVM0300_pointer_to_sender(rcv_msg);
   sender_ptr = %addr(exception_manager.sender);

   sender.program = %trimr(sender_inf.sndProgramName);
   sender.module = %trimr(sender_inf.sndModuleName);
   sender.procedure = %trimr(sender_inf.sndProcedureName);
   sender.stmt_count = min(sender_inf.sndNbrOfStatementNumbersAvl: %elem(sender.stmt));
   for s = 1 to sender.stmt_count;
      sender.stmt(s) = %trim(%subst(sender_inf.sndPgmStatementNumbers: (s - 1)*10 + 1: 10));
   endfor;
   return;
end-proc;


dcl-proc save_job_id;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   exception_manager.job.name = r5_pgmsts.job_name;
   exception_manager.job.user = r5_pgmsts.job_user;
   exception_manager.job.number = r5_pgmsts.job_number;
   return;
end-proc;


dcl-proc r5_exception_manager_print_stack_trace export;

   dcl-pi *N;
      o_print_header_handler like(r5_proc_pointer_t) options(*NOPASS) value;
      o_print_entry_handler like(r5_proc_pointer_t) options(*NOPASS) value;
      o_print_footer_handler like(r5_proc_pointer_t) options(*NOPASS) value;
   end-pi;

   dcl-s header_handler like(o_print_header_handler) inz(*NULL);
   dcl-s entry_handler like(o_print_entry_handler) inz(*NULL);
   dcl-s footer_handler like(o_print_footer_handler) inz(*NULL);


   if %parms() >= %parmnum(o_print_header_handler) and %addr(o_print_header_handler) <> *NULL;
      header_handler = o_print_header_handler;
   else;
      header_handler = %paddr(print_stack_trace_header);
   endif;

   if %parms() >= %parmnum(o_print_entry_handler) and %addr(o_print_entry_handler) <> *NULL;
      entry_handler = o_print_entry_handler;
   endif;

   if %parms() >= %parmnum(o_print_footer_handler) and %addr(o_print_footer_handler) <> *NULL;
      footer_handler = o_print_footer_handler;
   endif;

   r5_call_stack_print(exception_manager.call_stack: header_handler: entry_handler: footer_handler);
   return;
end-proc;


dcl-proc print_stack_trace_header;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   r5_exception_manager_print_last_exception();
   r5_joblog('.');
   r5_joblog('Pila de llamadas:');
   r5_joblog('.');
   return;
end-proc;


dcl-proc r5_exception_manager_print_last_exception export;

   r5_joblog('____________________________________________________________');
   r5_joblog('Se produjo una excepción:');
   r5_joblog('.');
   r5_joblog('   Id mensaje : %s': r5_exception_manager_message_id());
   r5_joblog('      Archivo : %s': r5_exception_manager_message_file());
   r5_joblog('        Texto : %s': r5_exception_manager_message_text());
   r5_joblog('        Ayuda : %s': r5_exception_manager_message_help());
   r5_joblog('     Programa : %s': r5_exception_manager_sender_program());
   r5_joblog('       Módulo : %s': r5_exception_manager_sender_module());
   r5_joblog('Procedimiento : %s': r5_exception_manager_sender_procedure());
   r5_joblog('    Sentencia : %s': r5_exception_manager_sender_statements(3));
   r5_joblog(' Fecha y hora : %s': %char(r5_exception_manager_time_stamp()));

   return;
end-proc;


//  A continuación todos los procedimientos que consultan la última
//  excepción atrapada.

dcl-proc r5_exception_manager_message_id export;

   dcl-pi *N like(r5_message_id_t);
   end-pi;

   dcl-ds rcv_msg likeds(RCVM0300PM_T) based(rcv_ptr);


   if exception_manager.rcv_msg = *NULL;
      return '';
   endif;

   rcv_ptr = exception_manager.rcv_msg;
   return rcv_msg.msgId;
end-proc;


dcl-proc r5_exception_manager_message_file export;

   dcl-pi *N likeds(r5_message_file_t);
   end-pi;

   dcl-ds rcv_msg likeds(RCVM0300PM_T) based(rcv_ptr);


   if exception_manager.rcv_msg = *NULL;
      return *BLANKS;
   endif;

   rcv_ptr = exception_manager.rcv_msg;
   return (rcv_msg.msgFName + rcv_msg.msgFlibUsed);
end-proc;


dcl-proc r5_exception_manager_message_text export;

   dcl-pi *N like(r5_exception_msg_text_t);
   end-pi;

   dcl-ds rcv_msg likeds(RCVM0300PM_T) based(rcv_ptr);
   dcl-s text like(TypeBuffer) based(text_ptr);


   if exception_manager.rcv_msg = *NULL;
      return '';
   endif;

   rcv_ptr = exception_manager.rcv_msg;
   if rcv_msg.msgLenRtn = 0;
      return '';
   endif;

   text_ptr = RCVM0300_pointer_to_message_text(rcv_msg);
   return (%subst(text: 1: rcv_msg.msgLenRtn));
end-proc;


//  Es responsabilidad del programa cliente asegurarse que los datos
//  se dejan en una variable o estructura adecuada para el
//  mensaje capturado.

dcl-proc r5_exception_manager_message_data export;

   dcl-pi *N like(r5_message_data_t);
   end-pi;

   dcl-ds rcv_msg likeds(RCVM0300PM_T) based(rcv_ptr);
   dcl-s data like(TypeBuffer) based(data_ptr);


   if exception_manager.rcv_msg = *NULL;
      return '';
   endif;

   rcv_ptr = exception_manager.rcv_msg;
   if rcv_msg.rplDtaOrTxtLenRtn = 0;
      return '';
   endif;

   data_ptr = RCVM0300_pointer_to_replace_data(rcv_msg);
   return (%subst(data: 1: rcv_msg.rplDtaOrTxtLenRtn));
end-proc;


dcl-proc r5_exception_manager_size_of_message_data export;

   dcl-pi *N like(r5_size_t);
   end-pi;

   dcl-ds rcv_msg likeds(RCVM0300PM_T) based(rcv_ptr);


   if exception_manager.rcv_msg = *NULL;
      return 0;
   endif;

   rcv_ptr = exception_manager.rcv_msg;
   return rcv_msg.rplDtaOrTxtLenRtn;
end-proc;


//  En un mensaje se puede incluir un texto de segundo nivel (SECLVL)
//  que lo explica. A este texto lo hemos llamado la ayuda del mensaje.

dcl-proc r5_exception_manager_message_help export;

   dcl-pi *N like(r5_exception_msg_help_t);
   end-pi;

   dcl-ds rcv_msg likeds(RCVM0300PM_T) based(rcv_ptr);
   dcl-s help like(TypeBuffer) based(help_ptr);


   if exception_manager.rcv_msg = *NULL;
      return '';
   endif;

   rcv_ptr = exception_manager.rcv_msg;
   if rcv_msg.hlpLenRtn = 0;
      return '';
   endif;

   help_ptr = RCVM0300_pointer_to_help(rcv_msg);
   return (%subst(help: 1: rcv_msg.hlpLenRtn));
end-proc;


dcl-proc r5_exception_manager_size_of_message_help export;

   dcl-pi *N like(r5_size_t);
   end-pi;

   dcl-ds rcv_msg likeds(RCVM0300PM_T) based(rcv_ptr);


   if exception_manager.rcv_msg = *NULL;
      return 0;
   endif;

   rcv_ptr = exception_manager.rcv_msg;
   return rcv_msg.hlpLenRtn;
end-proc;


//  El trabajo actual en formato:
//    job char(10)
//    user char(10)
//    number char(6)

dcl-proc r5_exception_manager_job export;

   dcl-pi *N like(r5_qualified_job_t);
   end-pi;

   return exception_manager.job;
end-proc;


//  El trabajo actual con el formato
//  'número/usuario/trabajo'.

dcl-proc r5_exception_manager_sys_job_name export;

   dcl-pi *N like(r5_exception_sys_job_name_t);
   end-pi;

   return %trim(exception_manager.job.number) + '/' +
          %trim(exception_manager.job.user)   + '/' +
          %trim(exception_manager.job.name);
end-proc;


dcl-proc r5_exception_manager_job_name export;

   dcl-pi *N like(r5_varname_t);
   end-pi;

   return %trim(exception_manager.job.name);
end-proc;


dcl-proc r5_exception_manager_job_user export;

   dcl-pi *N like(r5_varname_t);
   end-pi;

   return %trim(exception_manager.job.user);
end-proc;


dcl-proc r5_exception_manager_job_number export;

   dcl-pi *N like(r5_varname_t);
   end-pi;

   return %trim(exception_manager.job.number);
end-proc;


dcl-proc r5_exception_manager_severity export;

   dcl-pi *N like(r5_exception_severity_t);
   end-pi;

   dcl-ds rcv_msg likeds(RCVM0300PM_T) based(rcv_ptr);


   if exception_manager.rcv_msg = *NULL;
      return 0;
   endif;

   rcv_ptr = exception_manager.rcv_msg;
   return rcv_msg.msgSev;
end-proc;


dcl-proc r5_exception_manager_sender_program export;

   dcl-pi *N like(r5_program_name_t);
   end-pi;

   return exception_manager.sender.program;
end-proc;


dcl-proc r5_exception_manager_sender_module export;

   dcl-pi *N like(r5_module_name_t);
   end-pi;

   return exception_manager.sender.module;
end-proc;


dcl-proc r5_exception_manager_sender_procedure export;

   dcl-pi *N like(r5_procedure_name_t);
   end-pi;

   return exception_manager.sender.procedure;
end-proc;


//  El emisor de una excepción puede ser un programa OPM o un
//  procedimiento ILE. En el primer caso, el sistema facilita el
//  número de instrucción desde donde se lanzó la excepción. En el
//  segundo caso puede facilitar hasta tres números de instrucción.

dcl-proc r5_exception_manager_count_sender_statements export;

   dcl-pi *N like(r5_small_t);
   end-pi;

   return exception_manager.sender.stmt_count;
end-proc;


//  Lista los números sentencia desde donde se lanzó la última
//  excepción atrapada.
//
//  'limit' indica el número de sentencias devueltas.

dcl-proc r5_exception_manager_sender_statements export;

   dcl-pi *N varchar(30);
      o_limit like(r5_small_t) options(*NOPASS) value;
   end-pi;

   dcl-s limit like(o_limit);
   dcl-s statements varchar(30);
   dcl-s s like(o_limit);


   if %parms() >= %parmnum(o_limit);
      limit = min(o_limit: exception_manager.sender.stmt_count);
   else;
      limit = exception_manager.sender.stmt_count;
   endif;

   statements = '';
   for s = 1 to limit;
      statements += exception_manager.sender.stmt(s);
      if s < limit;
         statements += ', ';
      endif;
   endfor;
   return statements;
end-proc;


//  Con una precisión de segundos

dcl-proc r5_exception_manager_time_stamp export;

   dcl-pi *N like(r5_time_stamp_t);
   end-pi;

   dcl-s ts like(r5_time_stamp_t);

   ts = %timestamp( %char(r5_exception_manager_date(): *ISO) + '-'
                  + %char(r5_exception_manager_time(): *ISO) + '.000000'
                  : *ISO
                  );
   return ts;
end-proc;


dcl-proc r5_exception_manager_date export;

   dcl-pi *N like(r5_date_t);
   end-pi;

   dcl-s date like(r5_date_t);
   dcl-s default like(date) inz;
   dcl-ds rcv likeds(RCVM0300PM_T) based(rcv_ptr);
   dcl-ds sender likeds(RCVM0300PM_senderInf_T) based(sender_ptr);


   if exception_manager.rcv_msg = *NULL;
      return default;
   endif;

   rcv_ptr = exception_manager.rcv_msg;
   sender_ptr = RCVM0300_pointer_to_sender(rcv);
   date = %date(%dec(sender.date: 7: 0): *CYMD);
   return date;
end-proc;


dcl-proc r5_exception_manager_time export;

   dcl-pi *N like(r5_time_t);
   end-pi;

   dcl-s time like(r5_time_t);
   dcl-s default like(time) inz;
   dcl-ds rcv likeds(RCVM0300PM_T) based(rcv_ptr);
   dcl-ds sender likeds(RCVM0300PM_senderInf_T) based(sender_ptr);


   if exception_manager.rcv_msg = *NULL;
      return default;
   endif;

   rcv_ptr = exception_manager.rcv_msg;
   sender_ptr = RCVM0300_pointer_to_sender(rcv);
   time = %time(sender.time: *HMS0);
   return time;
end-proc;

