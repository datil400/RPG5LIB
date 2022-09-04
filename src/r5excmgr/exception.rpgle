**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5EXCMGR
//  Module  : EXCEPTION
//
//  Exception object
//
//  Author : Javier Mora
//  Date   : June 2021
//
//  Compiling : R5EXCMGRI
//
//  Comments
//
//    Aprovecha las descripciones de mensajes del IBM i para implantar el concepto
//    de excepción disponible en otros lenguajes.
//
//  Developer
//
//    /COPY RPG5LIB,exceptionh

ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);

/COPY API,ceeproc_h
/COPY RPG5LIB,c_lib_h
/COPY RPG5LIB,exceptionh
/COPY R5EXCMGR,excmgrdev


dcl-c DFT_MSG_FILE 'QCPFMSG   QSYS';
dcl-c LIBRARY_LIST '*LIBL';


dcl-ds exception_t qualified template;
   //class like(r5_class_t);
   bytes_provided like(r5_int_t);
   msg_id like(r5_message_id_t);
   msg_file likeds(r5_message_file_t);
   ccsid like(r5_int_t);
   offset_to_data like(r5_int_t);
   length_of_data like(r5_int_t);
   // CHAR(*)  Here the message data
end-ds;

dcl-s r5_exception_data_t like(r5_message_data_t) template;


dcl-proc r5_exception_new export;

   dcl-pi *N like(r5_object_t) opdesc;
      msg_id like(r5_message_id_t) const;
      msg_file likeds(r5_message_file_t) options(*OMIT: *NOPASS) const;
      msg_data like(r5_message_data_t) options(*VARSIZE: *NOPASS) const;
   end-pi;

   dcl-ds ex likeds(exception_t) based(self);
   dcl-s ex_data like(r5_exception_data_t) based(ex_data_ptr);

   dcl-s size like(r5_int_t);
   dcl-s msg_data_size like(r5_int_t);
   dcl-s type like(r5_int_t);
   dcl-s len like(r5_int_t);


   if %parms() >= %parmnum(msg_data);
      CEEGSI(%parmnum(msg_data): type: len: msg_data_size: *OMIT);
   else;
      msg_data_size = 0;
   endif;

   size = %size(exception_t) + msg_data_size;
   self = %alloc(size);
   memset(self: X'00': size);

   ex.bytes_provided = size;

   ex.msg_id = msg_id;

   if  %parms() >= %parmnum(msg_file) and %addr(msg_file) <> *NULL;
      ex.msg_file = msg_file;
      if msg_file.lib = *BLANKS;
         ex.msg_file.lib = LIBRARY_LIST;
      endif;
   else;
      ex.msg_file = DFT_MSG_FILE;
   endif;

   if msg_data_size > 0;
      ex.offset_to_data = %size(exception_t);
      ex_data_ptr = self + ex.offset_to_data;
      ex.length_of_data = msg_data_size;
      %subst(ex_data: 1: msg_data_size) = %subst(msg_data: 1: msg_data_size);
   endif;

   return self;
end-proc;


dcl-proc r5_exception_delete export;

   dcl-pi *N;
      self like(r5_object_t);
   end-pi;

   dealloc(N) self;
end-proc;


dcl-proc r5_exception_message_id export;

   dcl-pi *N like(r5_message_id_t);
     self like(r5_object_t) value;
   end-pi;

   dcl-ds ex likeds(exception_t) based(self);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);
   return ex.msg_id;
end-proc;


dcl-proc r5_exception_message_file export;

   dcl-pi *N likeds(r5_message_file_t);
     self like(r5_object_t) value;
   end-pi;

   dcl-ds ex likeds(exception_t) based(self);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);
   return ex.msg_file;
end-proc;


dcl-proc r5_exception_message_data export;

   dcl-pi *N like(r5_message_data_t) rtnparm;
     self like(r5_object_t) value;
   end-pi;

   dcl-ds ex likeds(exception_t) based(self);
   dcl-s ex_data like(r5_exception_data_t) based(ex_data_ptr);


   crash_if(self = *NULL: NULL_REFERENCE_ERROR);

   if ex.length_of_data = 0;
      return '';
   else;
      ex_data_ptr = self + ex.offset_to_data;
      return %subst(ex_data: 1: ex.length_of_data);
   endif;
end-proc;


dcl-proc r5_exception_message_data_size export;

   dcl-pi *N like(r5_size_t);
     self like(r5_object_t) value;
   end-pi;

   dcl-ds ex likeds(exception_t) based(self);

   crash_if(self = *NULL: NULL_REFERENCE_ERROR);
   return ex.length_of_data;
end-proc;

