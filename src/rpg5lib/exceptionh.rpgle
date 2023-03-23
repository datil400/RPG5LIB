**FREE

/IF DEFINED(R5_EXCEPTION_H)
/EOF
/ENDIF
/DEFINE R5_EXCEPTION_H

//  Package : RPG5LIB
//  SrvPgm  : R5EXCMGR
//
//  EXCEPTIONH
//
//  Exception object
//
//  June 2021
//
//  Use:
//
//  /COPY RPG5LIB,exceptionh

/COPY RPG5LIB,types_h
/COPY RPG5LIB,errno_h

dcl-pr r5_exception_new_from_text like(r5_object_t) extproc(*DCLCASE);
   text like(r5_small_varchar_t) options(*TRIM) const;
end-pr;

dcl-pr r5_exception_new_from_errno like(r5_object_t) extproc(*DCLCASE);
   errno like(r5_errno_t) const;
end-pr;

dcl-pr r5_exception_new like(r5_object_t) opdesc extproc(*DCLCASE);
   msg_id like(r5_message_id_t) const;
   msg_file likeds(r5_message_file_t) options(*OMIT: *NOPASS) const;
   msg_data like( r5_message_data_t ) options(*VARSIZE: *NOPASS) const;
end-pr;

dcl-pr r5_exception_delete extproc(*DCLCASE);
   self like(r5_object_t);
end-pr;

dcl-pr r5_exception_message_id  like(r5_message_id_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

dcl-pr r5_exception_message_file likeds(r5_message_file_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

dcl-pr r5_exception_message_data like(r5_message_data_t) rtnparm extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;

dcl-pr r5_exception_message_data_size like(r5_size_t) extproc(*DCLCASE);
   self like(r5_object_t) value;
end-pr;
