**FREE

/IF DEFINED(R5_CALLSTKE_H)
/EOF
/ENDIF
/DEFINE R5_CALLSTKE_H

//  Package : RPG5LIB
//  SrvPgm  : R5EXCMGR
//
//  CALLSTKE_H
//
//  Call stack entry
//
//  June 2021
//
//  Use:
//
//  /COPY RPG5LIB,callstke_h

/COPY RPG5LIB,types_h

dcl-pr r5_call_stack_entry_program_name like(r5_varname_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

dcl-pr r5_call_stack_entry_program_library like(r5_varname_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

dcl-pr r5_call_stack_entry_module_name like(r5_module_name_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

dcl-pr r5_call_stack_entry_module_libray like(r5_varname_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

dcl-pr r5_call_stack_entry_procedure_name like(r5_procedure_name_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

dcl-pr r5_call_stack_entry_statement_id like(r5_statement_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
   number like(r5_int_t) value;
end-pr;

dcl-pr r5_call_stack_entry_count_statements like(r5_int_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;


dcl-pr r5_call_stack_entry_request_level like(r5_int_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;


dcl-pr r5_call_stack_entry_mi_instruction_number like(r5_int_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

dcl-pr r5_call_stack_entry_activation_group_number_long like(r5_ulong_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

dcl-pr r5_call_stack_entry_activation_group_number like(r5_uint_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;


dcl-pr r5_call_stack_entry_activation_group_name like(r5_varname_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;


dcl-pr r5_call_stack_entry_program_asp_number like(r5_int_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;


dcl-pr r5_call_stack_entry_program_asp_name like(r5_varname_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;


dcl-pr r5_call_stack_entry_program_library_asp_number like(r5_int_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;


dcl-pr r5_call_stack_entry_program_library_asp_name like(r5_varname_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

dcl-pr r5_call_stack_entry_is_control_boundary like(r5_boolean_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

dcl-pr r5_call_stack_entry_is_program_boundary like(r5_boolean_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

dcl-pr r5_call_stack_entry_is_program_entry_procedure like(r5_boolean_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

dcl-pr r5_call_stack_entry_is_program like(r5_boolean_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

dcl-pr r5_call_stack_entry_is_service_program like(r5_boolean_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

