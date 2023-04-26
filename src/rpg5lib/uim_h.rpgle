**FREE

/IF DEFINED(R5_UIM_H)
/EOF
/ENDIF
/DEFINE R5_UIM_H

//  Package : RPG5LIB
//  SrvPgm  : R5TUI
//
//  UIM_H
//
//  User Interface Manager
//
//  March 2023
//
//  Use:
//
//  /COPY RPG5LIB,uim_h


/COPY RPG5LIB,types_h


dcl-pr r5_text_box extproc(*DCLCASE);
   text varchar(8192) options(*VARSIZE) const;
   o_title_id likeds(r5_qualified_msg_id_t) options(*NOPASS) const;
end-pr;


