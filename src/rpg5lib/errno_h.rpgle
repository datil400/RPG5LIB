**FREE

/IF DEFINED(R5_ERRNO_H)
/EOF
/ENDIF
/DEFINE R5_ERRNO_H

//  Package : RPG5LIB
//  SrvPgm  : R5UTILS
//
//  ERRNO_H
//
//  C Standard Library error handling.
//
//  June 2021
//
//  Use:
//
//  /COPY RPG5LIB,errno_h

/COPY RPG5LIB,types_h

dcl-s r5_errno_t like(r5_int_t) template;


dcl-pr r5_errno like(r5_errno_t) extproc(*DCLCASE) end-pr;

dcl-pr r5_strerror like(r5_var_string_t) extproc(*DCLCASE);
   errno like(r5_errno_t) value;
end-pr;

dcl-pr r5_errno_to_errc0100 likeds(ERRC0100_T) extproc(*DCLCASE);
   o_errno like(r5_errno_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_errno_to_msg_id like(r5_message_id_t) extproc(*DCLCASE);
   o_errno like(r5_errno_t) options(*NOPASS) const;
end-pr;

