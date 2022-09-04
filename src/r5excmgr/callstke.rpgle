**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5EXCMGR
//  Module  : CALLSTKE
//
//  Call stack entry.
//
//  Author : Javier Mora
//  Date   : Junio 2021
//
//  Compiling : R5EXCMGRI
//
//  Comments
//
//    Cada una de las entradas que conforman la pila de llamadas de un trabajo.
//
//  Developer
//
//    Si se extrae este módulo en un programa de servicio a parte hay que acordarse de:
//      - actgrp(*CALLER)
//      - sustituir 'crash_if' por 'r5_assert'
//
//    /COPY RPG5LIB,callstke_h

ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);


/COPY API,regex_h
/COPY RPG5LIB,c_lib_h
/COPY RPG5LIB,callstke_h
/COPY R5EXCMGR,excmgrdev


dcl-proc r5_call_stack_entry_program_name export;

   dcl-pi *N like(r5_varname_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   return %trim(entry0100.pgmName);
end-proc;


dcl-proc r5_call_stack_entry_program_library export;

   dcl-pi *N like(r5_varname_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   return %trim(entry0100.pgmLib);
end-proc;


dcl-proc r5_call_stack_entry_module_name export;

   dcl-pi *N like(r5_module_name_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   return %trim(entry0100.module);
end-proc;


dcl-proc r5_call_stack_entry_module_libray export;

   dcl-pi *N like(r5_varname_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   return %trim(entry0100.moduleLib);
end-proc;


dcl-proc r5_call_stack_entry_procedure_name export;

   dcl-pi *N like(r5_procedure_name_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-s procedure like(TypeBuffer) based(proc_ptr);
   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);


   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   if entry0100.procDisp = 0;
      return '';
   endif;

   proc_ptr = entry0100_ptr + entry0100.procDisp;
   return %subst(procedure: 1: entry0100.procLen);
end-proc;


//  El n-ésimo identificador de sentencia

dcl-proc r5_call_stack_entry_statement_id export;

   dcl-pi *N like(r5_statement_t);
      self like(r5_object_t) value;
      number like(r5_int_t) value;
   end-pi;

   dcl-s stmt like(r5_statement_t);
   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);
   dcl-s statements char(1024) based(stmts_ptr);


   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   if entry0100.stmtDisp = 0 or
      number > entry0100.stmtNbr;
      return '';
   endif;

   stmts_ptr = entry0100_ptr + entry0100.stmtDisp;
   stmt = %subst(statements: (number - 1)*10 + 1: 10);
   return %triml(%trim(stmt): '0');
end-proc;


dcl-proc r5_call_stack_entry_count_statements export;

   dcl-pi *N like(r5_int_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   return entry0100.stmtNbr;
end-proc;


dcl-proc r5_call_stack_entry_request_level export;

   dcl-pi *N like(r5_int_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   return entry0100.rqsLvl;
end-proc;


dcl-proc r5_call_stack_entry_mi_instruction_number export;

   dcl-pi *N like(r5_int_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   return entry0100.MIinst;
end-proc;


dcl-proc r5_call_stack_entry_activation_group_number_long export;

   dcl-pi *N like(r5_ulong_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   return entry0100.actGrpNbrLong;
end-proc;


//  Debería utilizarse la versión long

dcl-proc r5_call_stack_entry_activation_group_number export;

   dcl-pi *N like(r5_uint_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   return entry0100.actGrpNbr;
end-proc;


dcl-proc r5_call_stack_entry_activation_group_name export;

   dcl-pi *N like(r5_varname_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   return %trim(entry0100.actGrpNam);
end-proc;


dcl-proc r5_call_stack_entry_program_asp_number export;

   dcl-pi *N like(r5_int_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   return entry0100.pgmAspNbr;
end-proc;


dcl-proc r5_call_stack_entry_program_asp_name export;

   dcl-pi *N like(r5_varname_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   return %trim(entry0100.pgmAspNam);
end-proc;


dcl-proc r5_call_stack_entry_program_library_asp_number export;

   dcl-pi *N like(r5_int_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   return entry0100.pgmAspLibNbr;
end-proc;


dcl-proc r5_call_stack_entry_program_library_asp_name export;

   dcl-pi *N like(r5_varname_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   return %trim(entry0100.pgmAspLib);
end-proc;


dcl-proc r5_call_stack_entry_is_control_boundary export;

   dcl-pi *N like(r5_boolean_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);
   dcl-ds entry0100 likeds(CSTK0100_entry_t) based(entry0100_ptr);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   entry0100_ptr = entry.entry0100_ptr;
   return (entry0100.ctlBdy = '1');
end-proc;


dcl-proc r5_call_stack_entry_is_program_boundary export;

   dcl-pi *N like(r5_boolean_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   return (entry.is_program_boundary);
end-proc;


// PEP examples:
//   _CXX_PEP__Fv
//   _C_pep
//   _CL_PEP
//   _QRNP_PEP_<programa_name>

dcl-proc r5_call_stack_entry_is_program_entry_procedure export;

   dcl-pi *N like(r5_boolean_t);
      self like(r5_object_t) value;
   end-pi;


   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   return is_program_entry_procedure(r5_call_stack_entry_procedure_name(self));
end-proc;


// Si la entrada de la pila de llamadas se corresponde con un objeto *PGM

dcl-proc r5_call_stack_entry_is_program export;

   dcl-pi *N like(r5_boolean_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   return (entry.program_type = '*PGM');
end-proc;


// Si la entrada de la pila de llamadas se corresponde con un objeto *SRVPGM

dcl-proc r5_call_stack_entry_is_service_program export;

   dcl-pi *N like(r5_boolean_t);
      self like(r5_object_t) value;
   end-pi;

   dcl-ds entry likeds(call_stack_entry_t) based(self);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   return (entry.program_type = '*SRVPGM');
end-proc;

