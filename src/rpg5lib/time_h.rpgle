      /IF DEFINED(R5_TIME_H)
      /EOF
      /ENDIF
      /DEFINE R5_TIME_H

     *
     *  Package : RPG5LIB
     *  SrvPgm  : R5DATTIM
     *
     *  TIME_H
     *
     *  Time and timestamp functions collection.
     *
     *  November 2022
     *
     *  Use:
     *
     *    /COPY RPG5LIB,time_h
     *

      /COPY RPG5LIB,types_h
      /COPY RPG5LIB,dates_h


     D r5_dec_time_t   S              6P 0 template
     D r5_char_timestamp_t...
     D                 S             32A   varying template
     D r5_long_char_timestamp_t...
     D                 S             64A   varying template
     D r5_timestamp_format_t...
     D                 S             64A   varying template


     D r5_time_to_dec  PR                  like(r5_dec_time_t)
     D                                     extproc('r5_time_to_dec')
     D   time                              like(r5_time_t) const

     D r5_dec_to_time  PR                  like(r5_time_t)
     D                                     extproc('r5_dec_to_time')
     D   dec_time                          like(r5_dec_time_t) const

     D r5_make_time    PR                  like(r5_time_t)
     D                                     extproc('r5_make_time')
     D   hours                        2P 0 const
     D   o_minutes                    2P 0 options(*NOPASS) const
     D   o_seconds                    2P 0 options(*NOPASS) const

     D r5_micro_timestamp...
     D                 PR                  like(r5_time_stamp_t)
     D                                     extproc('r5_micro_timestamp')

     D r5_timestamp_to_decdate...
     D                 PR                  like(r5_dec_date_t)
     D                                     extproc('r5_timestamp_to_decdate')
     D   timestamp                         like(r5_time_stamp_t) const
     D   dec_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

     D r5_decdate_to_timestamp...
     D                 PR                  like(r5_time_stamp_t)
     D                                     extproc('r5_decdate_to_timestamp')
     D   dec_date                          like(r5_dec_date_t) const
     D   dec_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

     D r5_timestamp_to_char...
     D                 PR                  like(r5_char_timestamp_t)
     D                                     extproc('r5_timestamp_to_char')
     D   timestamp                         like(r5_time_stamp_t) const
     D   char_format                       like(r5_timestamp_format_t) const
     D                                     options(*TRIM)

     D r5_char_to_timestamp...
     D                 PR                  like(r5_time_stamp_t)
     D                                     extproc('r5_char_to_timestamp')
     D   char_ts                           like(r5_long_char_timestamp_t) const
     D                                     options(*TRIM)
     D   char_format                       like(r5_timestamp_format_t) const
     D                                     options(*TRIM)

