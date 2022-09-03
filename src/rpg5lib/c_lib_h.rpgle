**FREE

/IF DEFINED(R5_C_LIB_H)
/EOF
/ENDIF
/DEFINE R5_C_LIB_H

//  Package : RPG5LIB
//
//  C_LIB_H
//
//  RPG5LIB C library prototypes
//
//  October 2021
//
//  Usage:
//
//  /COPY RPG5LIB,c_lib_h


dcl-pr memset pointer extproc('memset');
   dest pointer value;
   c char(1) value;
   count uns(10) value;
end-pr;

dcl-pr sprintf int(10) extproc('sprintf');
   buffer pointer value;
   format pointer options(*STRING) value;
   *N  pointer options(*STRING: *NOPASS) value;
   *N  pointer options(*STRING: *NOPASS) value;
   *N  pointer options(*STRING: *NOPASS) value;
   *N  pointer options(*STRING: *NOPASS) value;
   *N  pointer options(*STRING: *NOPASS) value;
   *N  pointer options(*STRING: *NOPASS) value;
   *N  pointer options(*STRING: *NOPASS) value;
   *N  pointer options(*STRING: *NOPASS) value;
   *N  pointer options(*STRING: *NOPASS) value;
   *N  pointer options(*STRING: *NOPASS) value;
   *N  pointer options(*STRING: *NOPASS) value;
   *N  pointer options(*STRING: *NOPASS) value;
   *N  pointer options(*STRING: *NOPASS) value;
   *N  pointer options(*STRING: *NOPASS) value;
end-pr;
