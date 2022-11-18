**FREE

/IF DEFINED(R5_UXTIME_H)
/EOF
/ENDIF
/DEFINE R5_UXTIME_H

//  Package : RPG5LIB
//  SrvPgm  : R5DATTIM
//
//  UXTIME_H
//
//  Unix time functions.
//
//  November 2022
//
//  Use:
//
//  /COPY RPG5LIB,uxtime_h

/COPY RPG5LIB,time_h

dcl-s r5_unix_time_t int(10) template;    // time_t UTC

dcl-pr r5_timestamp_to_unix_time like(r5_unix_time_t) extproc(*DCLCASE);
   timestamp like(r5_time_stamp_t) const;
end-pr;

dcl-pr r5_unix_time_to_timestamp like(r5_time_stamp_t) extproc(*DCLCASE);
   unix_time like(r5_unix_time_t) const;
end-pr;

dcl-pr r5_current_utc_unix_time like(r5_unix_time_t) extproc(*DCLCASE) end-pr;

