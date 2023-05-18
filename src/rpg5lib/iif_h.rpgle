**FREE

/IF DEFINED(R5_IIF_H)
/EOF
/ENDIF
/DEFINE R5_IIF_H

//  Package : RPG5LIB
//  SrvPgm  : R5UTILS
//
//  IIF_H
//
//  Family of "iif" functions
//
//  April 2022
//
//  Use:
//
//  /COPY RPG5LIB,iif_h


/COPY RPG5LIB,types_h

/DEFINE R5_IIF_INCLUDE_DEPRECATED

dcl-pr r5_iif_char like(r5_small_varchar_t) extproc(*DCLCASE);
   condition like(r5_boolean_t) const;
   value_if_true like(r5_small_varchar_t) const;
   value_if_false like(r5_small_varchar_t) const;
end-pr;

dcl-pr r5_iif_dec like(r5_long_packed_t) extproc(*DCLCASE);
   condition like(r5_boolean_t) const;
   value_if_true like(r5_long_packed_t) const;
   value_if_false like(r5_long_packed_t) const;
end-pr;

dcl-pr r5_iif_int like(r5_long_t) extproc(*DCLCASE);
   condition like(r5_boolean_t) const;
   value_if_true like(r5_long_t) const;
   value_if_false like(r5_long_t) const;
end-pr;

dcl-pr r5_iif_date like(r5_date_t) extproc(*DCLCASE);
   condition like(r5_boolean_t) const;
   value_if_true like(r5_date_t) const;
   value_if_false like(r5_date_t) const;
end-pr;

dcl-pr r5_iif_time like(r5_time_t) extproc(*DCLCASE);
   condition like(r5_boolean_t) const;
   value_if_true like(r5_time_t) const;
   value_if_false like(r5_time_t) const;
end-pr;

dcl-pr r5_iif_timestamp like(r5_time_stamp_t) extproc(*DCLCASE);
   condition like(r5_boolean_t) const;
   value_if_true like(r5_time_stamp_t) const;
   value_if_false like(r5_time_stamp_t) const;
end-pr;



/IF NOT DEFINED(R5_IIF_INCLUDE_DEPRECATED)
/EOF
/ENDIF

// Por compatiblidad con programa de servicio UMISC

dcl-pr iif like(r5_small_varchar_t) extproc('r5_iif_char');
   condition like(r5_boolean_t) const;
   value_if_true like(r5_small_varchar_t) const;
   value_if_false like(r5_small_varchar_t) const;
end-pr;

dcl-pr iif_dec like(r5_long_packed_t) extproc('r5_iif_dec');
   condition like(r5_boolean_t) const;
   value_if_true like(r5_long_packed_t) const;
   value_if_false like(r5_long_packed_t) const;
end-pr;

dcl-pr iif_int like(r5_long_t) extproc('r5_iif_int');
   condition like(r5_boolean_t) const;
   value_if_true like(r5_long_t) const;
   value_if_false like(r5_long_t) const;
end-pr;

