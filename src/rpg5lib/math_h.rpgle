**FREE

/IF DEFINED(R5_MATH_H)
/EOF
/ENDIF
/DEFINE R5_MATHG_H

//  Package : RPG5LIB
//  SrvPgm  : R5UTILS
//
//  MATH_H
//
//  Mathematical and numeric utilities
//
//  April 2022
//
//  Use:
//
//  /COPY RPG5LIB,math_h

/COPY RPG5LIB,types_h


dcl-pr r5_min like(r5_long_packed_t) extproc(*DCLCASE);
   value1 like(r5_long_packed_t) const;
   value2 like(r5_long_packed_t) const;
   value3 like(r5_long_packed_t) options(*NOPASS) const;
   value4 like(r5_long_packed_t) options(*NOPASS) const;
   value5 like(r5_long_packed_t) options(*NOPASS) const;
   value6 like(r5_long_packed_t) options(*NOPASS) const;
   value7 like(r5_long_packed_t) options(*NOPASS) const;
   value8 like(r5_long_packed_t) options(*NOPASS) const;
   value9 like(r5_long_packed_t) options(*NOPASS) const;
   value10 like(r5_long_packed_t) options(*NOPASS) const;
   value11 like(r5_long_packed_t) options(*NOPASS) const;
   value12 like(r5_long_packed_t) options(*NOPASS) const;
   value13 like(r5_long_packed_t) options(*NOPASS) const;
   value14 like(r5_long_packed_t) options(*NOPASS) const;
   value15 like(r5_long_packed_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_max like(r5_long_packed_t) extproc(*DCLCASE);
   value1 like(r5_long_packed_t) const;
   value2 like(r5_long_packed_t) const;
   value3 like(r5_long_packed_t) options(*NOPASS) const;
   value4 like(r5_long_packed_t) options(*NOPASS) const;
   value5 like(r5_long_packed_t) options(*NOPASS) const;
   value6 like(r5_long_packed_t) options(*NOPASS) const;
   value7 like(r5_long_packed_t) options(*NOPASS) const;
   value8 like(r5_long_packed_t) options(*NOPASS) const;
   value9 like(r5_long_packed_t) options(*NOPASS) const;
   value10 like(r5_long_packed_t) options(*NOPASS) const;
   value11 like(r5_long_packed_t) options(*NOPASS) const;
   value12 like(r5_long_packed_t) options(*NOPASS) const;
   value13 like(r5_long_packed_t) options(*NOPASS) const;
   value14 like(r5_long_packed_t) options(*NOPASS) const;
   value15 like(r5_long_packed_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_random_number like(r5_int_t) extproc(*DCLCASE);
   high_nbr like(r5_int_t) const;
   o_low_nbr like(r5_int_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_cube_root like(r5_double_t) extproc(*DCLCASE);
   value like(r5_double_t) const;
end-pr;

