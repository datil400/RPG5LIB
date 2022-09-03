**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5UTILS
//  Module  : APIERROR
//
//  API error code utilities
//
//  Author : Javier Mora
//  Date   : June 2021
//
//  Compiling : R5UTILSI
//
//  Comments
//
//    Operaciones de inicialización y consulta de la estructura ERRC0100 típica utilizada
//    en la gestión de errores en las llamadas a las APIs del sistema.


ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);


/COPY API,ceeproc_h
/COPY RPG5LIB,c_lib_h
/COPY RPG5LIB,joblog_h
/COPY RPG5LIB,apierror_h


dcl-c ERRC0100_SIZE_ERROR  '%s: El tamaño de ERRC0100 es inferior a 8 bytes.';


dcl-proc r5_api_error_init_for_exception export;

   dcl-pi *N opdesc;
      error likeds(ERRC0100_T) options(*VARSIZE);
   end-pi;

   dcl-s type like(r5_int_t);
   dcl-s length like(r5_int_t);
   dcl-s size like(r5_int_t);


   CEEGSI(%parmnum(error): type: length: size: *OMIT);
   if size < %size(r5_api_bytes_t);
      r5_joblog(ERRC0100_SIZE_ERROR: %proc());
   endif;

   memset(%addr(error): X'00': size);
   return;
end-proc;


dcl-proc r5_api_error_init_for_monitor export;

   dcl-pi *N opdesc;
      error likeds(ERRC0100_T) options(*VARSIZE);
   end-pi;

   dcl-s type like(r5_int_t);
   dcl-s length like(r5_int_t);
   dcl-s size like(r5_int_t);


   CEEGSI(%parmnum(error): type: length: size: *OMIT);
   if size < %size(r5_api_bytes_t);
      r5_joblog(ERRC0100_SIZE_ERROR: %proc());
   endif;

   memset(%addr(error): X'00': size);
   if size >= %size(r5_api_bytes_t);
      error.bytesPrv = size;
   endif;
   return;
end-proc;


dcl-proc r5_api_error_occurred export;

   dcl-pi *N like(r5_boolean_t) opdesc;
      error likeds(ERRC0100_T) options(*VARSIZE) const;
   end-pi;

   dcl-s type like(r5_int_t);
   dcl-s length like(r5_int_t);
   dcl-s size like(r5_int_t);


   CEEGSI(%parmnum(error): type: length: size: *OMIT);
   if size < %size(r5_api_bytes_t);
      r5_joblog(ERRC0100_SIZE_ERROR: %proc());

      return *OFF;
   endif;

   return (error.bytesAvl > 0);
end-proc;

