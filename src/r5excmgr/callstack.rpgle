**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5EXCMGR
//  Module  : CALLSTACK
//
//  Call stack.
//
//  Author : datil400@gmail.com
//  Date   : June 2021
//
//  Compiling : R5EXCMGRI
//
//  Comments
//
//    Representa una instantánea de la pila de llamadas de un determinado trabajo en
//    un momento dado.
//
//  Developer
//
//    Si se extrae este módulo en un programa de servicio a parte hay que acordarse de:
//      - actgrp(*CALLER)
//      - sustituir 'crash_if' por 'r5_assert'
//
//    /COPY RPG5LIB,callstackh


ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);


/COPY RPG5LIB,joblog_h
/COPY RPG5LIB,apierror_h
/COPY RPG5LIB,c_lib_h
/COPY RPG5LIB,callstackh
/COPY RPG5LIB,callstke_h
/COPY R5EXCMGR,excmgrdev


// Número máximo de entradas de la pila de llamadas que
// se pueden inspeccionar

dcl-c MAX_ENTRIES  1024;     // Esta es una limitación importante


dcl-ds call_stack_t align(*FULL) qualified template;
   //class like(call_stack_class_t);
   info pointer;        // CSTK0100_T
   entries pointer;     // dim of call_stack_entry_t
   count int(10);       // ¿size?
   api_format like(TypeApiFormat);
   top like(r5_int_t);
end-ds;


//  'o_skip_entries' indica cuantas entradas deben ignorarse
//  tomando como referencia la entrada más reciente para situar
//  la 'cima' de la pila.

dcl-proc r5_call_stack_get_from_current_job export;

   dcl-pi *N like(r5_object_t);
      o_skip_entries like(r5_int_t) options(*NOPASS) const;
   end-pi;

   dcl-c IGNORE_THIS_ENTRY  1;

   dcl-s self like(r5_object_t);
   dcl-s skip_entries like(o_skip_entries);
   dcl-ds jidf likeds(JIDF0100_T);


   if %parms() >= %parmnum(o_skip_entries);
      skip_entries = o_skip_entries + IGNORE_THIS_ENTRY;
   else;
      skip_entries = IGNORE_THIS_ENTRY;
   endif;

   JIDF0100_set_current_job(jidf);
   self = r5_call_stack_get_from_job(jidf: skip_entries);
   return self;
end-proc;


dcl-proc JIDF0100_set_current_job export;

   dcl-pi *N;
      jidf likeds(JIDF0100_T);
   end-pi;

   jidf = *ALLx'00';
   jidf.jobNam = '*';
   jidf.jobUsr = *BLANKS;
   jidf.jobNbr = *BLANKS;
   jidf.intJobId = *BLANKS;
   jidf.thrInd = 1;
   return;
end-proc;


//  'o_skip_entries' indica cuantas entradas deben ignorarse
//  tomando como referencia la entrada más reciente para situar
//  la 'cima' de la pila.

dcl-proc r5_call_stack_get_from_job export;

   dcl-pi *N like(r5_object_t);
      jidf likeds(JIDF0100_T) const;
      o_skip_entries like(r5_int_t) options(*NOPASS) const;
   end-pi;

   dcl-c IGNORE_ENTRIES 2;
      // r5_call_stack_get_from_job + retrieve_call_stack

   dcl-s skip_entries like(o_skip_entries);
   dcl-s self like(r5_object_t);
   dcl-ds stack likeds(call_stack_t) based(self);
   dcl-ds header0100 likeds(CSTK0100_T) based(header0100_ptr);


   if %parms() >= %parmnum(o_skip_entries);
      skip_entries = o_skip_entries + IGNORE_ENTRIES;
   else;
      skip_entries = IGNORE_ENTRIES;
   endif;

   monitor;
      self = %alloc(%size(call_stack_t));
      memset(self: X'00': %size(call_stack_t));

      header0100_ptr = retrieve_call_stack(jidf);
      stack.info = header0100_ptr;
      stack.count = header0100.nbrEntRtn;
      stack.api_format = 'CSTK0100';

      stack.entries = parse_call_stack(header0100);

      // Se ignoran las 'n' primeras entradas de la pila de llamadas
      stack.top = skip_entries + 1;

   on-error;
      crash(UNEXPECTED_ERROR);
   endmon;

   return self;
end-proc;


// Recupera información de la pila de llamadas mediante la
// API QWVRCSTK

dcl-proc retrieve_call_stack export;

   dcl-pi *N pointer extproc(*DCLCASE);
      jidf likeds(JIDF0100_T) const;
   end-pi;

   dcl-ds header0100 likeds(CSTK0100_T) based(info_ptr);
   dcl-s size_of_stack_info like(r5_int_t);
   dcl-ds error likeds(ERRC0100_T);


   r5_api_error_init_for_exception(error);

   size_of_stack_info = %size(CSTK0100_T);
   info_ptr = %alloc(size_of_stack_info);

   dou header0100.bytesRtn >= header0100.bytesAvl;
      RtvCallStk( header0100
                : size_of_stack_info
                : 'CSTK0100'
                : jidf
                : 'JIDF0100'
                : error
                );
      if size_of_stack_info < header0100.bytesAvl;
         size_of_stack_info = header0100.bytesAvl;
         info_ptr = %realloc(info_ptr: size_of_stack_info);
      endif;
   enddo;

   return info_ptr;
end-proc;


dcl-proc parse_call_stack;

   dcl-pi *N pointer extproc(*DCLCASE);
      header0100 likeds(CSTK0100_T);
   end-pi;

   dcl-ds stack_entry likeds(call_stack_entry_t) dim(MAX_ENTRIES) based(stack_entries_ptr);
   dcl-s entry like(r5_object_t);

   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);
   dcl-s size like(r5_size_t);
   dcl-s e like(r5_int_t);

   dcl-ds set qualified;
      count int(10);
      content dim(512);
         program char(10) overlay(content);
         type char(10) overlay(content: *NEXT);
   end-ds;
   dcl-s i like(r5_int_t);
   dcl-s is_found like(r5_boolean_t);


   size = %size(call_stack_entry_t) * header0100.nbrEntRtn;
   stack_entries_ptr = %alloc(size);
   memset(stack_entries_ptr: X'00': size);

   // Recorrido de la pila desde la entrada más reciente hacia su base
   //
   // Se identifica la dirección de memoria de cada entrada de la pila
   // en el formato CSTK0100 y se registra en un array.

   // Primera entrada de la pila de llamadas
   entry0100_ptr = %addr(header0100) + header0100.offsEntInf;

   for e = 1 to header0100.nbrEntRtn;
      stack_entry(e).entry0100_ptr = entry0100_ptr;

      entry0100_ptr = entry0100_ptr + entry0100.len;
   endfor;

   // Recorrido de la pila desde la entrada más antigua hacia la más
   // reciente.
   //
   // Se identifica cada programa (*PGM) o programa de servicio (*SRVPGM),
   // si la entrada es un punto de entrada o es un límite de programa.

   set.count = 0;

   for e = header0100.nbrEntRtn downto 1;
      entry = %addr(stack_entry(e));
      entry0100_ptr = stack_entry(e).entry0100_ptr;

      stack_entry(e).is_program_entry_procedure =
         r5_call_stack_entry_is_program_entry_procedure(entry);

      i = %lookup(entry0100.pgmName: set.program: 1: set.count);
      if i = 0;
         is_found = *OFF;
         set.count += 1;
         i = set.count;

         set.program(i) = entry0100.pgmName;

         if entry0100.module = *BLANKS
         or stack_entry(e).is_program_entry_procedure;
            set.type(i) = '*PGM';
         else;
            set.type(i) = '*SRVPGM';
         endif;
      else;
         is_found = *ON;
      endif;

      stack_entry(e).program_type = set.type(i);
      if is_found;
         stack_entry(e).is_program_boundary = *OFF;
      else;
         stack_entry(e).is_program_boundary = *ON;
      endif;
   endfor;

   return stack_entries_ptr;
end-proc;


dcl-proc r5_call_stack_release export;

   dcl-pi *N;
      self like(r5_object_t);
   end-pi;

   dcl-ds stack likeds(call_stack_t) based(self);

   if self = *NULL;
      return;
   endif;

   dealloc stack.info;
   dealloc stack.entries;
   dealloc(N) self;
   return;
end-proc;


//  Señala la entrada situada en la cima de la pila, que no tiene porqué
//  ser la entrada más reciente.

dcl-proc r5_call_stack_top export;

   dcl-pi *N like(r5_object_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds stack likeds(call_stack_t) based(self);
   dcl-ds stack_entry likeds(call_stack_entry_t) dim(MAX_ENTRIES) based(stack_entry_ptr);


   crash_if(self = *NULL: NULL_REFERENCE_ERROR);
   crash_if(stack.entries = *NULL: NOT_PARSED_CALL_STACK_ERROR);
   crash_if(stack.top <= 0: UNDEFINED_TOP_OF_CALL_STACK_ERROR);

   stack_entry_ptr = stack.entries;
   return %addr(stack_entry(stack.top));
end-proc;


//  ¿Se ha recuperado toda la información de la pila de
//  llamadas?

dcl-proc r5_call_stack_is_information_correct export;

   dcl-pi *N like(r5_boolean_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds stack likeds(call_stack_t) based(self);
   dcl-ds info likeds(CSTK0100_T) based(info_ptr);


   crash_if(self = *NULL: NULL_REFERENCE_ERROR);
   crash_if(stack.info = *NULL: MISSING_CALL_STACK_ERROR);

   info_ptr = stack.info;
   return (info.infSts = ' ');
end-proc;


//  ¿La información de la pila no se ha podido recuperar
//  o es incompleta?

dcl-proc r5_call_stack_is_information_incorrect export;

   dcl-pi *N like(r5_boolean_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds stack likeds(call_stack_t) based(self);
   dcl-ds info likeds(CSTK0100_T) based(info_ptr);


   crash_if(self = *NULL: NULL_REFERENCE_ERROR);
   crash_if(stack.info = *NULL: MISSING_CALL_STACK_ERROR);

   info_ptr = stack.info;
   return not (info.infSts = ' ');
end-proc;


//  ¿Está incompleta la información sobre las entradas de la pila?
//  La pila podría contener entradas con información incompleta que
//  no se ha podido recuperar.

dcl-proc r5_call_stack_is_information_incomplete export;

   dcl-pi *N like(r5_boolean_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds stack likeds(call_stack_t) based(self);
   dcl-ds info likeds(CSTK0100_T) based(info_ptr);


   crash_if(self = *NULL: NULL_REFERENCE_ERROR);
   crash_if(stack.info = *NULL: MISSING_CALL_STACK_ERROR);

   info_ptr = stack.info;
   return (info.infSts = 'I');
end-proc;


// ¿Tiene la pila al menos una entrada?

dcl-proc r5_call_stack_has_entries export;

   dcl-pi *N like(r5_boolean_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds stack likeds(call_stack_t) based(self);
   dcl-ds info likeds(CSTK0100_T) based(info_ptr);


   crash_if(self = *NULL: NULL_REFERENCE_ERROR);
   crash_if(stack.info = *NULL: MISSING_CALL_STACK_ERROR);

   info_ptr = stack.info;
   return not (info.infSts = 'N');
end-proc;


//  Lista la pila de llamadas de la última excepción atrapada.
//
//  o_print_header_handler
//
//  Puntero al procedimiento manejador encargado de de mostrar una cabecera
//  antes de listar cada una de las entradas de la pila de llamadas.
//
//  El procedimiento debe cumplir con el siguiente prototipo:
//
//    D print_header    PR
//    D   stack                             like(r5_object_t) value
//
//  o_print_entry_handler
//
//  Puntero al procedimiento manejador encargado de de mostrar cada entrada de
//  la pila de llamadas.
//
//  El procedimiento debe cumplir con el siguiente prototipo:
//
//    D print_entry     PR
//    D   stack                             like(r5_object_t) value
//    D   entry                             like(r5_object_t) value
//
//  o_print_footer_handler
//
//  Puntero al procedimiento manejador encargado de de mostrar el pié o texto
//  final a la lista de la pila de llamadas.
//
//  El procedimiento debe cumplir con el siguiente prototipo:
//
//    D print_footer    PR
//    D   stack                             like(r5_object_t) value

dcl-proc r5_call_stack_print export;

   dcl-pi *N;
      self like(r5_object_t) value;
      o_print_header_handler pointer(*proc) options(*NOPASS) value;
      o_print_entry_handler pointer(*proc) options(*NOPASS) value;
      o_print_footer_handler pointer(*proc) options(*NOPASS) value;
   end-pi;

   dcl-s print_header_handler like(o_print_header_handler);
   dcl-s print_entry_handler like(o_print_entry_handler);
   dcl-s print_footer_handler like(o_print_footer_handler);

   dcl-pr print_header_event extproc(print_header_handler);
      stack like(r5_object_t) value;
   end-pr;

   dcl-pr print_entry_event extproc(print_entry_handler);
      stack like(r5_object_t) value;
      entry like(r5_object_t) value;
   end-pr;

   dcl-pr print_footer_event extproc(print_footer_handler);
      stack like(r5_object_t) value;
   end-pr;

   dcl-ds stack likeds(call_stack_t) based(self);
   dcl-ds stack_entry likeds(call_stack_entry_t) dim(MAX_ENTRIES) based(stack_entry_ptr);
   dcl-s e like(r5_int_t);


   crash_if(self = *NULL: NULL_REFERENCE_ERROR);
   crash_if(stack.entries = *NULL: NOT_PARSED_CALL_STACK_ERROR);

   if stack.count <= 0;
      r5_jobLog('%s: La información de la pila de llamadas no '
               + 'está disponible.': %proc());
      return;
   endif;

   if %parms() >= %parmnum(o_print_header_handler) and
      o_print_header_handler <> *NULL;
      print_header_handler = o_print_header_handler;
   else;
      print_header_handler = %paddr(print_stack_header);
   endif;

   if %parms() >= %parmnum(o_print_entry_handler) and
      o_print_entry_handler <> *NULL;
      print_entry_handler = o_print_entry_handler;
   else;
      print_entry_handler = %paddr(print_stack_entry);
   endif;

   if %parms() >= %parmnum(o_print_footer_handler) and
      o_print_footer_handler <> *NULL;
      print_footer_handler = o_print_footer_handler;
   else;
      print_footer_handler = *NULL;
   endif;

   monitor;
      stack_entry_ptr = stack.entries;

      print_header_event(self);

      for e = stack.top to stack.count;
         print_entry_event(self: %addr(stack_entry(e)));
      endfor;

      if print_footer_handler <> *NULL;
         print_footer_event(self);
      endif;

   on-error;
      crash(UNEXPECTED_ERROR);
   endmon;
   return;
end-proc;


//  Manejador por defecto del evento 'print_header' del
//  procedimiento 'r5_call_stack_print'.
//
//  Escribe en las anotaciones del trabajo la cabecera de la
//  pila de llamadas.

dcl-proc print_stack_header;

   dcl-pi *N extproc(*DCLCASE);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds stack likeds(call_stack_t) based(self);

   r5_joblog('.');
   r5_joblog('Stack trace:');
   r5_joblog('.');
   return;
end-proc;


//  Manejador por defecto del evento 'print_entry' del
//  procedimiento 'r5_call_stack_print'.
//
//  Escribe en las anotaciones del trabajo una entrada de la
//  pila de llamadas.
//
//  Este procedimiento se llamada por cada entrada de la pila.

dcl-proc print_stack_entry;

   dcl-pi *N extproc(*DCLCASE);
      self like(r5_object_t) value;
      entry like(r5_object_t) value;
   end-pi;

   dcl-c TAB '   ';

   dcl-ds stack likeds(call_stack_t) based(self);

   dcl-s procedure like(r5_procedure_name_t);
   dcl-s module like(r5_module_name_t);
   dcl-s program like(r5_program_name_t);
   dcl-s stmt like(r5_statement_t);
   dcl-s trace varchar(128);

   program = r5_call_stack_entry_program_name(entry);
   module = r5_call_stack_entry_module_name(entry);
   procedure = r5_call_stack_entry_procedure_name(entry);
   stmt = r5_call_stack_entry_statement_id(entry: 1);

   trace = program;

   if module <> '';
      trace = trace + '.' + module;
   endif;

   if procedure <> '';
      trace = trace + '.' + procedure;
   endif;

   if stmt <> '';
     trace = trace + ' (' + stmt + ')';
   endif;

   r5_joblog(TAB + trace);
   return;
end-proc;


dcl-proc print_stack_footer;

   dcl-pi *N extproc(*DCLCASE);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds stack likeds(call_stack_t) based(self);

   return;
end-proc;


//  Localiza el límite de programa más cercano y se identifica
//  con la posición que ocupa la entrada en la pila de llamadas,
//  tomando como referencia (valor 1) la entrada más reciente.

//  Este procedimiento identifica esencialmente la entrada más antigua
//  de la pila de llamadas que inició una secuencia de llamadas, y cada
//  llamada en esta secuencia involucró al mismo objeto de programa.
//  La secuencia de llamadas podría implicar llamadas recursivas al
//  mismo programa o, en el caso de ILE, llamadas a diferentes
//  procedimientos del mismo programa ILE o programa de servicio ILE.

dcl-proc r5_call_stack_look_for_program_boundary export;

   dcl-pi *N like(r5_int_t);
      self like(r5_object_t) value;
      o_start like(r5_int_t) options(*NOPASS) const;
   end-pi;

   dcl-s e like(r5_int_t);
   dcl-ds stack likeds(call_stack_t) based(self);
   dcl-s start like(o_start);
   dcl-s entry like(r5_object_t);


   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   if %parms() >= %parmnum(o_start);
      start = o_start;
   else;
      start = stack.top;
   endif;

   for e = start to stack.count - 1;
      entry = r5_call_stack_at_entry(self: e);

      if r5_call_stack_entry_is_program_boundary(entry);
         return e;
      endif;
   endfor;

   return 0;
end-proc;


dcl-proc r5_call_stack_at_entry export;

   dcl-pi *N like(r5_object_t);
      self like(r5_object_t) value;
      pos like(r5_int_t) const;
   end-pi;

   dcl-ds stack likeds(call_stack_t) based(self);
   dcl-ds stack_entry likeds(call_stack_entry_t) dim(MAX_ENTRIES) based(stack.entries);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   return %addr(stack_entry(pos));
end-proc;


dcl-proc r5_call_stack_entry_position export;

   dcl-pi *N like(r5_int_t);
      self like(r5_object_t) value;
      entry like(r5_object_t) value;
   end-pi;

   dcl-s pos like(r5_int_t);
   dcl-ds stack likeds(call_stack_t) based(self);
   dcl-s dif like(r5_int_t);
   dcl-s rem like(r5_int_t);


   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   dif = entry - stack.entries;
   pos = %div(dif: %size(call_stack_entry_t)) + 1;
   rem = %rem(dif: %size(call_stack_entry_t));

   crash_if(rem <> 0: INVALID_CALL_STACK_ENTRY_ERROR);

   return pos;
end-proc;


dcl-proc r5_call_stack_size export;

   dcl-pi *N like(r5_size_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds stack likeds(call_stack_t) based(self);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   return stack.count;
end-proc;

