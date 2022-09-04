**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5EXCMGR
//  Module  : RCVM0300
//
//  RCVM0300 format for Receive Program Message (QMHRCVPM) API
//
//  Author : Javier Mora
//  Date   : Junio 2021
//
//  Compiling : R5EXCMGRI
//
//  Comments
//
//    Funciones de utilidad para el manejo de la estructura de datos
//    RCVM0300 de la API 'Recibir mensaje de programa'.

ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);


/COPY API,msgh_h
/COPY RPG5LIB,exceptionh
/COPY R5EXCMGR,excmgrdev


dcl-proc RCVM0300_to_exception export;

   dcl-pi *N pointer;
      rcvm likeds(RCVM0300PM_T);
   end-pi;

   dcl-s ex like(r5_object_t);
   dcl-s data like(TypeBuffer) based(data_ptr);


   data_ptr = RCVM0300_pointer_to_replace_data(rcvm);
   if rcvm.rplDtaOrTxtLenRtn > 0;
      ex = r5_exception_new( rcvm.msgId: rcvm.msgFName + rcvm.msgFlibSpec
                           : %subst(data: 1: rcvm.rplDtaOrTxtLenRtn)
                           );
   else;
      ex = r5_exception_new( rcvm.msgId: rcvm.msgFName + rcvm.msgFlibSpec);
   endif;
   return ex;
end-proc;


dcl-proc RCVM0300_pointer_to_replace_data export;

   dcl-pi *N pointer;
      rcvm likeds(RCVM0300PM_T);
   end-pi;

   dcl-s ptr pointer;

   ptr = %addr(rcvm) + %size(rcvm);
   return ptr;
end-proc;


dcl-proc RCVM0300_pointer_to_message_text export;

   dcl-pi *N pointer;
      rcvm likeds(RCVM0300PM_T);
   end-pi;

   dcl-s ptr pointer;

   ptr = %addr(rcvm) + %size(rcvm)
       + rcvm.rplDtaOrTxtLenRtn;
   return ptr;
end-proc;


dcl-proc RCVM0300_pointer_to_help export;

   dcl-pi *N pointer;
      rcvm likeds(RCVM0300PM_T);
   end-pi;

   dcl-s ptr pointer;

   ptr = %addr(rcvm) + %size(rcvm)
       + rcvm.rplDtaOrTxtLenRtn + rcvm.msgLenRtn;
   return ptr;
end-proc;


dcl-proc RCVM0300_pointer_to_sender export;

   dcl-pi *N pointer;
      rcvm likeds(RCVM0300PM_T);
   end-pi;

   dcl-s ptr pointer;

   ptr = %addr(rcvm) + %size(rcvm)
       + rcvm.rplDtaOrTxtLenRtn + rcvm.msgLenRtn + rcvm.hlpLenRtn;
   return ptr;
end-proc;

