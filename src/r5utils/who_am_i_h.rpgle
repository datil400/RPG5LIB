**FREE

/IF DEFINED(R5_WHO_AM_I_H)
/EOF
/ENDIF
/DEFINE R5_R5_WHO_AM_I_H

//  Package : RPG5LIB
//  SrvPgm  : R5UTILS
//
//  JOBLOG_H
//
//  who_am_i utility.
//
//  September 2021
//
//  Use:
//
//  /COPY RPG5LIB,who_am_i_h


/COPY RPG5LIB,types_h

dcl-c R5_PGMTYPE_NON_BOUND_PROGRAM  x'00';
dcl-c R5_PGMTYPE_BOUND_PROGRAM  x'01';
dcl-c R5_PGMTYPE_BOUND_SERVICE_PROGRAM  x'02';
dcl-c R5_PGMTYPE_JAVA_PROGRAM  x'04';

dcl-ds r5_invocation_attr_t qualified template;
   type char(1);
   program_name like(r5_program_name_t);
   program_library like(r5_varname_t);
   module_name like(r5_module_name_t);
   module_library like(r5_varname_t);
   procedure_name like(r5_procedure_name_t);
   stmts_count like(r5_small_t) inz(%elem(r5_invocation_attr_t.stmt));
   statements;
      stmt like(r5_int_t) dim(4)
           overlay(statements);
end-ds;


dcl-ds r5_job_thread_id_t qualified template;
   job_id likeds(r5_qualified_job_t);
   thread_id char(8);
end-ds;


dcl-pr who_am_i extproc(*DCLCASE);
   attrib likeds(r5_invocation_attr_t);
   thread likeds(r5_job_thread_id_t) options(*OMIT: *NOPASS);
   inv_offset like(r5_int_t) value options(*NOPASS);
end-pr;

