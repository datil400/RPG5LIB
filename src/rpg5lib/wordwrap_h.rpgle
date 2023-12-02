**FREE

/IF DEFINED( R5_WORDWRAP_H )
/EOF
/ENDIF
/DEFINE R5_WORDWRAP_H

//  Package : RPG5LIB
//  SrvPgm  : R5STRING
//
//  WORDWRAP_H
//
//  Word wrap utility
//
//  October 2023
//
//  Use:
//
//  /COPY RPG5LIB,wordwrap_h


/COPY RPG5LIB,types_h


//  Callback procedure prototype for handler parameter:
//
//    dcl-pr handler;
//       context like(r5_pointer_t) value;
//       line varchar(16382) options(*VARSIZE) const;
//       line_nbr like(r5_short_t) const;
//       width like(r5_short_t) const;
//       is_end_of_paragraph like(r5_boolean_t) const;
//       is_end_of_text like(r5_boolean_t) const;
//    end-pr;

dcl-pr r5_word_wrap extproc(*DCLCASE);
   context like(r5_pointer_t) value;
   text varchar(16382) options(*VARSIZE: *TRIM) const;
   width like(r5_short_t) const;
   handler like(r5_proc_pointer_t) value;
   o_break_sep varchar(5) options(*TRIM: *NOPASS) const;
end-pr;

