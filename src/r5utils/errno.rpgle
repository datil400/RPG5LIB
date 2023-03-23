**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5UTILS
//  Module  : ERRNO
//
//  C Standard Library error handling.
//
//  Author : Javier Mora
//  Date   : June 2021
//
//  Compiling : R5UTILSI
//
//  Comments
//
//    Funciones relacionadas con la gestión de errores de la biblioteca
//    estándar de C.
//

ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);


/COPY RPG5LIB,c_lib_h
/COPY RPG5LIB,errno_h


// El último código de error generado por la biblioteca de funciones
// estándar del lenguage C

dcl-proc r5_errno export;

   dcl-pi *N like(r5_errno_t) end-pi;

   dcl-pr errno pointer extproc('__errno') end-pr;

   dcl-s result like(r5_int_t) based(errno_ptr);

   errno_ptr = errno();
   return result;
end-proc;


// Descripción del código de error 'errno'

dcl-proc r5_strerror export;

   dcl-pi *N like(r5_var_string_t);
      errno like(r5_errno_t) value;
   end-pi;

   dcl-pr strerror pointer extproc('strerror');
      errno int(10) value;
   end-pr;

   return %trim(%str(strerror(errno)));
end-proc;


//  No se valida 'o_errno'

dcl-proc r5_errno_to_errc0100 export;

   dcl-pi *N likeds(ERRC0100_T);
      o_errno like(r5_errno_t) options(*NOPASS) const;
   end-pi;

   dcl-ds ec likeds(ERRC0100_T);
   dcl-s errno like(o_errno);


   if %parms() >= %parmnum(o_errno);
      errno = o_errno;
   else;
      errno = r5_errno();
   endif;

   memset(%addr(ec): X'00': %size(ec));
   ec.bytesPrv = %size(ec) - %size(ec.msgDta);

   if errno > 0;
      ec.bytesAvl = 16;
      ec.msgid = r5_errno_to_msg_id(errno);
   endif;
   return ec;
end-proc;


//  Un valor de 'o_errno' igual a cero (no hay error) devuelve
//  el id de mensaje a blancos.
//
//  No se valida 'o_errno' ni la existencia del identificador
//  del mensaje.

dcl-proc r5_errno_to_msg_id export;

   dcl-pi *N like(r5_message_id_t);
      o_errno like(r5_errno_t) options(*NOPASS) const;
   end-pi;

   dcl-s msg_id like(r5_message_id_t);
   dcl-s errno like(o_errno);
   dcl-s last_4 char(4);


   if %parms() >= %parmnum(o_errno);
      errno = o_errno;
   else;
      errno = r5_errno();
   endif;

   if errno <= 0 or errno > 9999;
      return *BLANKS;
   endif;

   evalr last_4 = %editc(errno: 'X');
   msg_id = 'CPE' + last_4;
   return msg_id;
end-proc;
