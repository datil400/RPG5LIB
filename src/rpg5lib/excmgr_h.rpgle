**FREE

/IF DEFINED(R5_EXCMGR_H)
/EOF
/ENDIF
/DEFINE R5_EXCMGR_H

//  Package : RPG5LIB
//  SrvPgm  : R5EXCMGR
//
//  EXCMGR_H
//
//  Exception manager
//
//  June 2021
//
//  Use:
//
//  /COPY RPG5LIB,excmgr_h


/COPY RPG5LIB,types_h
/COPY RPG5LIB,sqlca_h
/COPY RPG5LIB,exceptionh


dcl-s r5_exception_msg_text_t varchar(512) template;
dcl-s r5_exception_msg_help_t varchar(2048) template;
dcl-s r5_exception_sys_job_name_t varchar(28) template;
dcl-s r5_exception_severity_t like(r5_int_t) template;


dcl-pr r5_throw extproc(*DCLCASE);
   exception like(r5_object_t) options(*NOPASS) value;
end-pr;

dcl-pr r5_throw_to_calling_program extproc(*DCLCASE);
   exception like(r5_object_t) options(*NOPASS) value;
end-pr;

dcl-pr r5_check_sql_state like(r5_boolean_t) extproc(*DCLCASE);
   sqlca likeds(r5_sqlca_t) const;
end-pr;

dcl-pr r5_assert extproc(*DCLCASE);
   condition like(r5_boolean_t) const;
   o_msg varchar(512) options(*TRIM: *NOPASS) const;
end-pr;

dcl-pr r5_fail extproc(*DCLCASE);
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
end-pr;

dcl-pr r5_resend_exception extproc(*DCLCASE) end-pr;

dcl-pr r5_catch extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_message_id like(r5_message_id_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_message_file likeds(r5_message_file_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_message_text like(r5_exception_msg_text_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_message_data like(r5_message_data_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_size_of_message_data like(r5_size_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_message_help like(r5_exception_msg_help_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_size_of_message_help like(r5_size_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_job like(r5_qualified_job_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_sys_job_name like(r5_exception_sys_job_name_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_job_name like(r5_varname_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_job_user like(r5_varname_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_job_number like(r5_varname_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_severity like(r5_exception_severity_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_sender_program like(r5_program_name_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_sender_module like(r5_module_name_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_sender_procedure like(r5_procedure_name_t)  extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_count_sender_statements int(3) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_sender_statements varchar(30) extproc(*DCLCASE);
   o_limit like(r5_small_t) options(*NOPASS) value;
end-pr;

dcl-pr r5_exception_manager_date like(r5_date_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_time like(r5_time_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_time_stamp like(r5_time_stamp_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_exception_manager_print_stack_trace extproc(*DCLCASE);
   o_print_header_handler like(r5_proc_pointer_t) options(*NOPASS) value;
   o_print_entry_handler like(r5_proc_pointer_t) options(*NOPASS) value;
   o_print_footer_handler like(r5_proc_pointer_t) options(*NOPASS) value;
end-pr;

dcl-pr r5_exception_manager_print_last_exception extproc(*DCLCASE) end-pr;

