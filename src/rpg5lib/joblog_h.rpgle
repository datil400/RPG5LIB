**FREE

/IF DEFINED(R5_JOBLOG_H)
/EOF
/ENDIF
/DEFINE R5_JOBLOG_H

//  Package : RPG5LIB
//  SrvPgm  : R5UTILS
//
//  JOBLOG_H
//
//  Job log utilities
//
//  May 2021
//
//  Use:
//
//  /COPY RPG5LIB,joblog_h

/COPY RPG5LIB,types_h

dcl-pr r5_joblog like(r5_int_t) extproc(*DCLCASE);
   msg pointer options(*STRING) value;
   s1 pointer options(*STRING: *NOPASS) value;
   s2 pointer options(*STRING: *NOPASS) value;
   s3 pointer options(*STRING: *NOPASS) value;
   s4 pointer options(*STRING: *NOPASS) value;
   s5 pointer options(*STRING: *NOPASS) value;
   s6 pointer options(*STRING: *NOPASS) value;
   s7 pointer options(*STRING: *NOPASS) value;
   s8 pointer options(*STRING: *NOPASS) value;
end-pr;
