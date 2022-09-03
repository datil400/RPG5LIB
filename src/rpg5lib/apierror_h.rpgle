**FREE

/IF DEFINED(R5_APIERROR_H)
/EOF
/ENDIF
/DEFINE R5_APIERROR_H

//  Package : RPG5LIB
//  SrvPgm  : R5UTILS
//
//  APIERROR_H
//
//  API error code utilities
//
//  June 2021
//
//  Use:
//
//  /COPY RPG5LIB,apierror_h

/COPY RPG5LIB,types_h

dcl-pr r5_api_error_init_for_exception opdesc extproc(*DCLCASE);
   error likeds(ERRC0100_T) options(*VARSIZE);
end-pr;

dcl-pr r5_api_error_init_for_monitor opdesc extproc(*DCLCASE);
   error likeds(ERRC0100_T) options(*VARSIZE);
end-pr;

dcl-pr r5_api_error_occurred like(r5_boolean_t) opdesc extproc(*DCLCASE);
   error likeds(ERRC0100_T) options(*VARSIZE) const;
end-pr;

