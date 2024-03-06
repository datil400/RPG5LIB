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

dcl-s r5_var_buffer32_t varchar(32767);
dcl-s r5_var_buffer64_t varchar(65535);


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

dcl-pr r5_spaces like(r5_var_buffer64_t) rtnparm extproc(*DCLCASE);
   length like(r5_int_t) const;
end-pr;

dcl-pr r5_repeat like(r5_var_buffer64_t) rtnparm extproc(*DCLCASE);
   expr like(r5_long_string_t) options(*VARSIZE) const;
   times like(r5_int_t) const;
end-pr;

dcl-pr r5_left_pad like(r5_long_string_t) rtnparm extproc(*DCLCASE);
   str like(r5_long_string_t) options(*VARSIZE) const;
   length like(r5_short_t) const;
   o_pad varchar(128) options(*NOPASS) const;
end-pr;

dcl-pr r5_right_pad like(r5_long_string_t) rtnparm extproc(*DCLCASE);
   str like(r5_long_string_t) options(*VARSIZE) const;
   length like(r5_short_t) const;
   o_pad varchar(128) options(*NOPASS) const;
end-pr;

dcl-pr r5_center like(r5_short_string_t) extproc(*DCLCASE);
   str like(r5_short_string_t) options(*VARSIZE) const;
   width like(r5_short_t) const;
   o_pad like(r5_char_t) options(*NOPASS) const;
end-pr;

dcl-pr r5_clean_text_simple like(r5_var_buffer64_t) rtnparm extproc(*DCLCASE);
   text like(r5_var_buffer64_t) options(*VARSIZE) const;
   symbols varchar(128) const;
end-pr;

dcl-pr r5_clean_text_extended like(r5_var_buffer64_t) rtnparm extproc(*DCLCASE);
   text like(r5_var_buffer64_t) options(*VARSIZE) const;
   filter_handler like(r5_proc_pointer_t) value;
end-pr;

dcl-pr r5_clean_text like(r5_var_buffer64_t)
   overload(r5_clean_text_simple: r5_clean_text_extended);

