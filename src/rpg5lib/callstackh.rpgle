**FREE

/IF DEFINED(R5_CALL_STACK_H)
/EOF
/ENDIF
/DEFINE R5_CALL_STACK_H

//  Package : RPG5LIB
//  SrvPgm  : R5EXCMGR
//
//  CALLSTACKH
//
//  Call stack
//
//  June 2021
//
//  Use:
//
//  /COPY RPG5LIB,callstackh


/COPY API,wrkman_h
/COPY RPG5LIB,types_h

dcl-pr r5_call_stack_get_from_current_job like(r5_object_t) extproc(*DCLCASE);
   o_skip_entries like(r5_int_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_call_stack_get_from_job like(r5_object_t) extproc(*DCLCASE);
   jidf likeds(JIDF0100_T) const;
   o_skip_entries like(r5_int_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_call_stack_release extproc(*DCLCASE);
   self like(r5_object_t);
end-pr;

dcl-pr r5_call_stack_top like(r5_object_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

dcl-pr r5_call_stack_print extproc(*DCLCASE);
   self like(r5_object_t) value;
   o_print_header_handler pointer(*proc) options(*NOPASS) value;
   o_print_entry_handler pointer(*proc) options(*NOPASS) value;
   o_print_footer_handler pointer(*proc) options(*NOPASS) value;
end-pr;

dcl-pr r5_call_stack_look_for_program_boundary like(r5_int_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
   o_start like(r5_int_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_call_stack_at_entry like(r5_object_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
   pos like(r5_int_t) const;
end-pr;

dcl-pr r5_call_stack_entry_position like(r5_int_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
   entry like(r5_object_t) value;
end-pr;

dcl-pr r5_call_stack_size like(r5_size_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

