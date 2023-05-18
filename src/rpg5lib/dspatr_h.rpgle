**FREE

/IF DEFINED(R5_DSPATR_H)
/EOF
/ENDIF
/DEFINE R5_DSPATR_H

//  Package : RPG5LIB
//  SrvPgm  : R5TUI
//
//  DSPATR_H
//
//  Display attributes P-field (DSPATR DDS keyword)
//
//  December 2022
//
//  Use:
//
//  /COPY RPG5LIB,dspatr_h


/COPY RPG5LIB,types_h


dcl-c R5_DSPATR_NORMAL  X'20';
dcl-c R5_DSPATR_PROTECTED  X'80';
dcl-c R5_DSPATR_COLUMN_SEPARATOR   X'10';
dcl-c R5_DSPATR_BLINK  X'08';
dcl-c R5_DSPATR_UNDERLINE  X'04';
dcl-c R5_DSPATR_HIGH_INTENSITY  X'02';
dcl-c R5_DSPATR_REVERSE  X'01';
dcl-c R5_DSPATR_NON_DISPLAY  X'07';

dcl-c R5_DSPATR_GREEN  X'20';
dcl-c R5_DSPATR_WHITE  X'22';
dcl-c R5_DSPATR_RED  X'28';
dcl-c R5_DSPATR_TURQUOISE  X'30';
dcl-c R5_DSPATR_YELLOW  X'32';
dcl-c R5_DSPATR_PINK  X'38';
dcl-c R5_DSPATR_BLUE  X'3A';


dcl-s r5_dspatr_t char(1) template;
dcl-s r5_dspatr_color_t char(1) template;


dcl-pr r5_dspatr_set_normal extproc(*DCLCASE);
   atr like(r5_dspatr_t);
end-pr;

dcl-pr r5_dspatr_is_normal like(r5_boolean_t) extproc(*DCLCASE);
   atr like(r5_dspatr_t);
end-pr;

dcl-pr r5_dspatr_set_color extproc(*DCLCASE);
   atr like(r5_dspatr_t);
   color like(r5_dspatr_color_t) value;
end-pr;

dcl-pr r5_dspatr_get_color like(r5_dspatr_color_t) extproc(*DCLCASE);
   atr like(r5_dspatr_t);
end-pr;

dcl-pr r5_dspatr_has_color like(r5_boolean_t) extproc(*DCLCASE);
   atr like(r5_dspatr_t);
end-pr;

dcl-pr r5_dspatr_is_color like(r5_boolean_t) extproc(*DCLCASE);
   atr like(r5_dspatr_t);
   color like(r5_dspatr_color_t) value;
end-pr;

dcl-pr r5_dspatr_set_input_output_field extproc(*DCLCASE);
   atr like(r5_dspatr_t);
end-pr;

dcl-pr r5_dspatr_is_input_output_field like(r5_boolean_t) extproc(*DCLCASE);
   atr like(r5_dspatr_t);
end-pr;

dcl-pr r5_dspatr_set_output_field extproc(*DCLCASE);
   atr like(r5_dspatr_t);
end-pr;

dcl-pr r5_dspatr_is_output_field like(r5_boolean_t) extproc(*DCLCASE);
   atr like(r5_dspatr_t);
end-pr;

dcl-pr r5_dspatr_set_high_intensity extproc(*DCLCASE);
   atr like(r5_dspatr_t);
   hi  like(r5_boolean_t) const;
end-pr;

dcl-pr r5_dspatr_is_high_intensity like(r5_boolean_t) extproc(*DCLCASE);
   atr like(r5_dspatr_t);
end-pr;

dcl-pr r5_dspatr_set_reverse extproc(*DCLCASE);
   atr like(r5_dspatr_t);
   ri  like(r5_boolean_t) const;
end-pr;

dcl-pr r5_dspatr_is_reversed like(r5_boolean_t) extproc(*DCLCASE);
   atr like(r5_dspatr_t);
end-pr;

dcl-pr r5_dspatr_set_column_separators extproc(*DCLCASE);
   atr like(r5_dspatr_t);
   cs  like(r5_boolean_t) const;
end-pr;

dcl-pr r5_dspatr_is_column_separators like(r5_boolean_t) extproc(*DCLCASE);
   atr like(r5_dspatr_t);
end-pr;

dcl-pr r5_dspatr_set_blink extproc(*DCLCASE);
   atr like(r5_dspatr_t);
   bl  like(r5_boolean_t) const;
end-pr;

dcl-pr r5_dspatr_is_blinking like(r5_boolean_t) extproc(*DCLCASE);
   atr like(r5_dspatr_t);
end-pr;

dcl-pr r5_dspatr_set_underline extproc(*DCLCASE);
   atr like(r5_dspatr_t);
   ul  like(r5_boolean_t) const;
end-pr;

dcl-pr r5_dspatr_is_underlined like(r5_boolean_t) extproc(*DCLCASE);
   atr like(r5_dspatr_t);
end-pr;

dcl-pr r5_dspatr_set_non_display extproc(*DCLCASE);
   atr like(r5_dspatr_t);
   nd  like(r5_boolean_t) const;
end-pr;

dcl-pr r5_dspatr_is_non_displayable like(r5_boolean_t) extproc(*DCLCASE);
   atr like(r5_dspatr_t);
end-pr;

dcl-pr r5_dspatr_is_displayable like(r5_boolean_t) extproc(*DCLCASE);
   atr like(r5_dspatr_t);
end-pr;

dcl-pr r5_dspatr_set_protected_field extproc(*DCLCASE);
   atr like(r5_dspatr_t);
   pr  like(r5_boolean_t) const;
end-pr;

dcl-pr r5_dspatr_is_protected_field like(r5_boolean_t) extproc(*DCLCASE);
   atr like(r5_dspatr_t);
end-pr;

dcl-pr r5_dspatr_to_hex char(2) extproc(*DCLCASE);
   atr like(r5_dspatr_t) value;
end-pr;

dcl-pr r5_dspatr_to_bin char(8) extproc(*DCLCASE);
   atr like(r5_dspatr_t) value;
end-pr;

dcl-pr r5_dspatr_debug varchar(20) extproc(*DCLCASE);
   atr like(r5_dspatr_t) value;
end-pr;


