**FREE

//  WORDWRAP2
//
//  SQL UDTF for Word Wrap (with line feed)
//
//  Author: datil400@gmail.com
//
//  Compile:
//
//  CRTBNDRPG  PGM(&LIB/WORDWRAP2)
//             SRCFILE(&LIB/QRPGLESRC)
//             DBGVIEW(*SOURCE)
//
//  Register SQL UDTF:
//
//  CREATE OR REPLACE FUNCTION
//    $(SCHEMA).WORD_WRAP
//  (
//    text VARCHAR(8192),
//    width SMALLINT,
//    line_feed_sym VARCHAR(5)
//  )
//  RETURNS TABLE
//  (
//    line_number SMALLINT,
//    line VARCHAR(1024)
//  )
//  LANGUAGE RPGLE
//  PARAMETER STYLE DB2SQL
//  SPECIFIC WORD_WRAP_WITH_LINE_FEED
//  NOT FENCED
//  DETERMINISTIC
//  NO SQL
//  EXTERNAL NAME '$(LIB)/WORDWRAP2'
//  DISALLOW PARALLEL
//  ;


ctl-opt dftactgrp(*NO);
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('RPG5LIB');
//ctl-opt bnddir('RUTINAS/UNITS');

/COPY RPG5LIB,joblog_h
/COPY RPG5LIB,wordwrap_h

//  UDTF call parameter constants

dcl-c SQL_UDTF_FIRST_CALL  -2;
dcl-c SQL_UDTF_OPEN  -1;
dcl-c SQL_UDTF_FETCH  0;
dcl-c SQL_UDTF_CLOSE  1;
dcl-c SQL_UDTF_FINAL_CALL 2;

//  UDF call parameter constants

dcl-c SQL_UDF_FIRST_CALL  -1;
dcl-c SQL_UDF_NORMAL_CALL  0;
dcl-c SQL_UDF_FINAL_CALL 1;

dcl-c SQL_PARM_IS_NULL  -1;
dcl-c SQL_PARM_IS_NOT_NULL  0;

dcl-c SQL_STATE_OK  '00000';
dcl-c SQL_END_OF_TABLE  '02000';
dcl-c SQL_UNEXPECTED_ERROR  '38999';


dcl-s out_text_ptr pointer;
dcl-s out_line varchar(1024) based(out_line_ptr);
dcl-s max_lines int(5);
dcl-s current_line int(5);

// DB2SQL style parameter

dcl-pi udtf_word_wrap extpgm('WORDWRAP2');

   // Input(s)
   text varchar(8192) options(*VARSIZE) const;
   width int(5) const;
   line_feed_sym varchar(5) const;

   // Output(s)
   line_nbr int(5);
   line varchar(1024);

   // Input Null Indicators
   text_null int(5);
   width_null int(5);
   line_feed_sym_null int(5);

   // Output Null Indicators
   line_nbr_null int(5);
   line_null int(5);

   // DB2SQL Style Parameters
   sql_state char(5);
   function_name varchar(517) const;
   specific_name varchar(128) const;
   sql_msg_text varchar(70);
   call_type int(10) const;
end-pi;


sql_state = SQL_STATE_OK;

monitor;
   select;
   when call_type = SQL_UDTF_FIRST_CALL;

   when call_type = SQL_UDTF_OPEN;
      load_wrapped_text();

   when call_type = SQL_UDTF_FETCH;
      next_line();

   when call_type = SQL_UDTF_CLOSE;
      clean_up();

   when call_type = SQL_UDTF_FINAL_CALL;

   endsl;
on-error;
   sql_state = SQL_UNEXPECTED_ERROR;
   sql_msg_text = 'Unexpected error';
endmon;

return;


dcl-proc load_wrapped_text;

   max_lines = 0;
   r5_word_wrap(*NULL: text: width: %paddr(compute_max_lines): line_feed_sym);
   out_text_ptr = %alloc(max_lines * %size(out_line));

   r5_word_wrap(*NULL: text: width: %paddr(store_line): line_feed_sym);

   current_line = 0;
   return;
end-proc;


dcl-proc compute_max_lines;

   dcl-pi *N;
      context like(r5_pointer_t) value;
      line varchar(8192) options(*VARSIZE) const;
      line_nbr like(r5_short_t) const;
      width like(r5_short_t) const;
      is_end_of_paragraph like(r5_boolean_t) const;
      is_end_of_text like(r5_boolean_t) const;
   end-pi;

   max_lines = line_nbr;
   return;
end-proc;


// Stores in an array the text lines

dcl-proc store_line;

   dcl-pi *N;
      context like(r5_pointer_t) value;
      line varchar(8192) options(*VARSIZE) const;
      line_nbr like(r5_short_t) const;
      is_end_of_paragraph like(r5_boolean_t) const;
      is_end_of_text like(r5_boolean_t) const;
   end-pi;

   out_line_ptr = out_text_ptr + (%size(out_line) * (line_nbr - 1));
   out_line = line;
   return;
end-proc;


dcl-proc next_line;

   current_line += 1;
   if current_line > max_lines;
      sql_state = SQL_END_OF_TABLE;
      return;
   endif;

   line_nbr_null = SQL_PARM_IS_NOT_NULL;
   line_null = SQL_PARM_IS_NOT_NULL;

   line_nbr = current_line;
   out_line_ptr = out_text_ptr + (%size(out_line) * (current_line - 1));
   line = out_line;

   return;
end-proc;


dcl-proc clean_up;

   dealloc(N) out_text_ptr;
   return;
end-proc;

