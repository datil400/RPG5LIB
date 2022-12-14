**FREE

/IF DEFINED( R5_STRING_H )
/EOF
/ENDIF
/DEFINE R5_STRING_H

//  Package : RPG5LIB
//  SrvPgm  : R5STRING
//
//  STRING_H
//
//  String procedures and functions
//
//  March 2021
//
//  Use:
//
//  /COPY RPG5LIB,string_h


/COPY RPG5LIB,types_h


dcl-c R5_STR_TO_UPPER  0;
dcl-c R5_STR_TO_LOWER  1;


dcl-s r5_buffer_t char(65535) template;
dcl-s r5_var_buffer_t varchar(65535) template;


dcl-pr r5_left like(r5_string_t) extproc(*DCLCASE);
   string like(r5_string_t) options(*VARSIZE) const;
   length like(r5_int_t) const;
end-pr;

dcl-pr r5_right like(r5_string_t) extproc(*DCLCASE);
   string like(r5_string_t) options(*VARSIZE) const;
   length like(r5_int_t) const;
end-pr;

dcl-pr r5_mid like(r5_string_t) extproc(*DCLCASE);
   string like(r5_string_t) options(*VARSIZE) const;
   start like(r5_int_t) const;
   o_length like(r5_int_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_convert_case extproc(*DCLCASE);
   in_string like(r5_buffer_t) options(*VARSIZE) const;
   in_str_size like(r5_int_t) const;
   out_string like(r5_buffer_t) options(*VARSIZE);
   out_str_size like(r5_int_t) const;
   o_option like(r5_int_t) options(*NOPASS) const;
   o_ccsid like(r5_int_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_to_upper like(r5_string_t) extproc(*DCLCASE);
   string like(r5_string_t) options(*VARSIZE) const;
   o_ccsid like(r5_int_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_to_lower like(r5_string_t) extproc(*DCLCASE);
   string like(r5_string_t) options(*VARSIZE) const;
   o_ccsid like(r5_int_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_buffer_to_varlen like(r5_var_buffer_t) extproc(*DCLCASE);
   buffer like(r5_buffer_t) options(*VARSIZE) const;
   size like(r5_int_t) const;
end-pr;

dcl-pr r5_varlen_to_buffer extproc(*DCLCASE);
  varlen like(r5_var_buffer_t) options(*VARSIZE) const;
  buffer like(r5_buffer_t) Options(*VARSIZE);
  size like(r5_int_t) const;
end-pr;

dcl-pr r5_char_to_dec like(r5_packed_t) extproc(*DCLCASE);
   string varchar(64) options(*TRIM) value;
   o_mask char(3) options(*NOPASS) value;
end-pr;
