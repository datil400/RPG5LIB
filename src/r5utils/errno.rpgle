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

   dcl-pi *N like(r5_int_t) end-pi;

   dcl-pr errno pointer extproc('__errno') end-pr;

   dcl-s result like(r5_int_t) based(errno_ptr);

   errno_ptr = errno();
   return result;
end-proc;


// Descripción del código de error 'errno'

dcl-proc r5_strerror export;

   dcl-pi *N like(r5_var_string_t);
      errno like(r5_int_t) value;
   end-pi;

   dcl-pr strerror pointer extproc('strerror');
      errno int(10) value;
   end-pr;

   return %trim(%str(strerror(errno)));
end-proc;


dcl-proc r5_errno_to_errc0100 export;

   dcl-pi *N likeds(ERRC0100_T) end-pi;

   dcl-ds ec likeds(ERRC0100_T);
   dcl-s errno like(r5_int_t);


   memset(%addr(ec): X'00': %size(ec));
   ec.bytesPrv = %size(ec) - %size(ec.msgDta);

   errno = r5_errno();
   if errno <> 0;
      ec.bytesAvl = 16;
      ec.msgid = 'CPE' + %char(errno);
   endif;
   return ec;
end-proc;
