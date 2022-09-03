**FREE

/IF DEFINED(R5_CALL_LEVEL_H)
/EOF
/ENDIF
/DEFINE R5_CALL_LEVEL_H

//  Package : RPG5LIB
//  SrvPgm  : R5UTILS
//
//  CALLLEVEL_H
//
//  Call level utilities
//
//  September 2021
//
//  Use:
//
//  /COPY RPG5LIB,calllevelh


/COPY RPG5LIB,types_h

dcl-ds r5_call_level_info_t qualified template;
   program_type char(1);
   program_name like(r5_program_name_t);
   program_library like(r5_library_name_t);
   module_name like(r5_module_name_t);
   module_library like(r5_library_name_t);
   procedure_name like(r5_procedure_name_t);
   stmts_count like(r5_small_t);
   statements;
      stmt like(r5_statement_t) dim(3)
           overlay(statements);
   job likeds(r5_qualified_job_t);
   thread_id char(8);
   char_thread_id char(16);
end-ds;

dcl-s r5_stack_counter_t uns(10) template;


dcl-pr r5_this extproc(*DCLCASE);
   lvl likeds(r5_call_level_info_t);
end-pr;

dcl-pr r5_caller extproc(*DCLCASE);
   lvl likeds(r5_call_level_info_t);
   o_target_offset like(r5_int_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_trigger_caller extproc(*DCLCASE);
   lvl likeds(r5_call_level_info_t);
   o_start like(r5_stack_counter_t) options(*NOPASS) const;
end-pr;

