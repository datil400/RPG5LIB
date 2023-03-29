**FREE

/IF DEFINED(R5_IIF_H)
/EOF
/ENDIF
/DEFINE R5_IIF_H

//  Package : RPG5LIB
//  SrvPgm  : R5UTILS
//
//  IN_H
//
//  Family of "in" functions.
//
//  March 2023
//
//  Use:
//
//  /COPY RPG5LIB,in_h


/COPY RPG5LIB,types_h

dcl-pr r5_in_char like(r5_boolean_t) extproc(*DCLCASE) opdesc;
   search like(r5_varchar_t) options(*VARSIZE) const;
   value1 like(r5_varchar_t) options(*VARSIZE) const;
   value2 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
   value3 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
   value4 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
   value5 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
   value6 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
   value7 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
   value8 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
   value9 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
   value10 like(r5_varchar_t) options(*VARSIZE: *NOPASS) const;
end-pr;

dcl-pr r5_in_dec like(r5_boolean_t) extproc(*DCLCASE) opdesc;
   search like(r5_long_packed_t) const;
   value1 like(r5_long_packed_t) const;
   value2 like(r5_long_packed_t) options(*NOPASS) const;
   value3 like(r5_long_packed_t) options(*NOPASS) const;
   value4 like(r5_long_packed_t) options(*NOPASS) const;
   value5 like(r5_long_packed_t) options(*NOPASS) const;
   value6 like(r5_long_packed_t) options(*NOPASS) const;
   value7 like(r5_long_packed_t) options(*NOPASS) const;
   value8 like(r5_long_packed_t) options(*NOPASS) const;
   value9 like(r5_long_packed_t) options(*NOPASS) const;
   value10 like(r5_long_packed_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_in_int like(r5_boolean_t) extproc(*DCLCASE) opdesc;
   search like(r5_long_t) const;
   value1 like(r5_long_t) const;
   value2 like(r5_long_t) options(*NOPASS) const;
   value3 like(r5_long_t) options(*NOPASS) const;
   value4 like(r5_long_t) options(*NOPASS) const;
   value5 like(r5_long_t) options(*NOPASS) const;
   value6 like(r5_long_t) options(*NOPASS) const;
   value7 like(r5_long_t) options(*NOPASS) const;
   value8 like(r5_long_t) options(*NOPASS) const;
   value9 like(r5_long_t) options(*NOPASS) const;
   value10 like(r5_long_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_in_float like(r5_boolean_t) extproc(*DCLCASE) opdesc;
   search like(r5_double_t) const;
   delta like(r5_double_t) const;
   value1 like(r5_double_t) const;
   value2 like(r5_double_t) options(*NOPASS) const;
   value3 like(r5_double_t) options(*NOPASS) const;
   value4 like(r5_double_t) options(*NOPASS) const;
   value5 like(r5_double_t) options(*NOPASS) const;
   value6 like(r5_double_t) options(*NOPASS) const;
   value7 like(r5_double_t) options(*NOPASS) const;
   value8 like(r5_double_t) options(*NOPASS) const;
   value9 like(r5_double_t) options(*NOPASS) const;
   value10 like(r5_double_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_in_date like(r5_boolean_t) extproc(*DCLCASE) opdesc;
   search like(r5_date_t) const;
   value1 like(r5_date_t) const;
   value2 like(r5_date_t) options(*NOPASS) const;
   value3 like(r5_date_t) options(*NOPASS) const;
   value4 like(r5_date_t) options(*NOPASS) const;
   value5 like(r5_date_t) options(*NOPASS) const;
   value6 like(r5_date_t) options(*NOPASS) const;
   value7 like(r5_date_t) options(*NOPASS) const;
   value8 like(r5_date_t) options(*NOPASS) const;
   value9 like(r5_date_t) options(*NOPASS) const;
   value10 like(r5_date_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_in_time like(r5_boolean_t) extproc(*DCLCASE) opdesc;
   search like(r5_time_t) const;
   value1 like(r5_time_t) const;
   value2 like(r5_time_t) options(*NOPASS) const;
   value3 like(r5_time_t) options(*NOPASS) const;
   value4 like(r5_time_t) options(*NOPASS) const;
   value5 like(r5_time_t) options(*NOPASS) const;
   value6 like(r5_time_t) options(*NOPASS) const;
   value7 like(r5_time_t) options(*NOPASS) const;
   value8 like(r5_time_t) options(*NOPASS) const;
   value9 like(r5_time_t) options(*NOPASS) const;
   value10 like(r5_time_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_in_ts like(r5_boolean_t) extproc(*DCLCASE) opdesc;
   search like(r5_time_stamp_t) const;
   value1 like(r5_time_stamp_t) const;
   value2 like(r5_time_stamp_t) options(*NOPASS) const;
   value3 like(r5_time_stamp_t) options(*NOPASS) const;
   value4 like(r5_time_stamp_t) options(*NOPASS) const;
   value5 like(r5_time_stamp_t) options(*NOPASS) const;
   value6 like(r5_time_stamp_t) options(*NOPASS) const;
   value7 like(r5_time_stamp_t) options(*NOPASS) const;
   value8 like(r5_time_stamp_t) options(*NOPASS) const;
   value9 like(r5_time_stamp_t) options(*NOPASS) const;
   value10 like(r5_time_stamp_t) options(*NOPASS) const;
end-pr;

/IF DEFINED(*V7R3M0)
// 7.3 RPG runtime PTF SI71535, RPG compiler PTF SI71534
// 7.4 RPG runtime PTF SI71537, RPG compiler PTF SI71536
// 7.4 TGTRLS(V7R3M0) PTF SI71538

dcl-pr r5_in like(r5_boolean_t)
             overload( r5_in_char
                     : r5_in_dec
                     : r5_in_int
                     : r5_in_float
                     : r5_in_date
                     : r5_in_time
                     : r5_in_ts
                     );
/ENDIF

