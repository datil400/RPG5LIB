**FREE

/IF DEFINED(R5_MATHX_H)
/EOF
/ENDIF
/DEFINE R5_MATHX_H

//  Package : RPG5LIB
//  SrvPgm  : R5MATHX
//
//  MATHX_H
//
//  Mathematical extensions
//
//  July 2024
//
//  Use:
//
//  /COPY RPG5LIB,mathx_h


/COPY RPG5LIB,types_h
/COPY RPG5LIB,math_h


dcl-pr r5_round like(r5_long_packed_t) extproc(*DCLCASE);
   value like(r5_long_packed_t) const;
   decimals like(r5_small_t) const;
end-pr;

dcl-pr r5_truncate like(r5_long_packed_t) extproc(*DCLCASE);
   value like(r5_long_packed_t) const;
   o_decimals like(r5_small_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_ceil like(r5_long_packed_t) extproc(*DCLCASE);
   value like(r5_long_packed_t) const;
end-pr;

dcl-pr r5_floor like(r5_long_packed_t) extproc(*DCLCASE);
   value like(r5_long_packed_t) const;
end-pr;

dcl-pr r5_remainder like(r5_long_packed_t) extproc(*DCLCASE);
   divident like(r5_long_packed_t) const;
   divisor like(r5_long_packed_t) const;
end-pr;

dcl-pr r5_modulo like(r5_long_packed_t) extproc(*DCLCASE);
   divident like(r5_long_packed_t) const;
   divisor like(r5_long_packed_t)const;
end-pr;

dcl-pr r5_upper_multiple like(r5_long_packed_t) extproc(*DCLCASE);
   value like(r5_long_packed_t) const;
   o_multiplier like(r5_long_packed_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_lower_multiple like(r5_long_packed_t) extproc(*DCLCASE);
   value like(r5_long_packed_t) const;
   o_multiplier like(r5_long_packed_t) options(*NOPASS) const;
end-pr;
