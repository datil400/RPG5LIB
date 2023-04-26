**FREE

/IF DEFINED(R5_OBJMAN_H)
/EOF
/ENDIF
/DEFINE R5_OBJMAN_H

//  Package : RPG5LIB
//  SrvPgm  : R5SYS
//
//  OBJMAN_H
//
//  Object management
//
//  April 2023
//
//  Use:
//
//  /COPY RPG5LIB,objman_h


/COPY RPG5LIB,types_h


dcl-pr r5_parse_object_name likeds(r5_qualified_name_t) extproc(*DCLCASE);
   obj_name char(21) const;
end-pr;

dcl-pr r5_check_object like(r5_boolean_t) extproc(*DCLCASE);
   obj_name char(21) const;
   obj_type like(r5_name_t) const;
end-pr;

dcl-pr r5_check_member like(r5_boolean_t) extproc(*DCLCASE);
   obj_name char(21) const;
   o_member like(r5_name_t) options(*NOPASS) const;
   o_use_ovr like(r5_boolean_t) options(*NOPASS) const;
end-pr;

