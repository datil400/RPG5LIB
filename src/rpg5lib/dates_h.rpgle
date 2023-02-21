      /IF DEFINED(R5_DATES_H)
      /EOF
      /ENDIF
      /DEFINE R5_DATES_H

     *
     *  Package : RPG5LIB
     *  SrvPgm  : R5DATTIM
     *
     *  DATES_H
     *
     *  Date functions collection.
     *
     *  June 2022
     *
     *  Use:
     *
     *    /COPY RPG5LIB,dates_h
     *

      /COPY RPG5LIB,types_h

     D r5_dec_date_t   S              9P 0 template
     D r5_char_date_t  S             10A   varying template
     D r5_long_char_date_t...
     D                 S             64A   varying template

     D r5_date_format_t...
     D                 S             10A   varying template
     D r5_long_date_format_t...
     D                 S             64A   varying template
     D r5_date_separator_t...
     D                 S              1A   varying template

     D r5_week_t       DS                  qualified template
     D   criteria                    10A   varying
     D   year                              like(r5_short_t)
     D   number                            like(r5_small_t)
     D   begin                             like(r5_date_t)
     D   end                               like(r5_date_t)


     D r5_date_to_dec...
     D                 PR                  like(r5_dec_date_t)
     D                                     extproc('r5_date_to_dec')
     D   date                              like(r5_date_t) const
     D   dec_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

     D r5_dec_to_date...
     D                 PR                  like(r5_date_t)
     D                                     extproc('r5_dec_to_date')
     D   dec_date                          like(r5_dec_date_t) const
     D   dec_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

     D r5_date_to_char...
     D                 PR                  like(r5_char_date_t)
     D                                     extproc('r5_date_to_char')
     D   date                              like(r5_date_t) const
     D   char_format                       like(r5_date_format_t) const
     D                                     options(*TRIM)
     D   o_separator                       like(r5_date_separator_t) const
     D                                     options(*TRIM: *NOPASS)

     D r5_char_to_date...
     D                 PR                  like(r5_date_t)
     D                                     extproc('r5_char_to_date')
     D   char_date                         like(r5_long_char_date_t) const
     D                                     options(*TRIM)
     D   char_format                       like(r5_long_date_format_t) const
     D                                     options(*TRIM)
     D   o_separator                       like(r5_date_separator_t) const
     D                                     options(*TRIM: *NOPASS)

     D r5_decdate_to_char...
     D                 PR                  like(r5_char_date_t)
     D                                     extproc('r5_decdate_to_char')
     D   dec_date                          like(r5_dec_date_t) const
     D   dec_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)
     D   o_char_format...
     D                                     like(r5_date_format_t) const
     D                                     options(*TRIM: *OMIT: *NOPASS)
     D   o_separator                       like(r5_date_separator_t) const
     D                                     options(*TRIM: *NOPASS)

     D r5_chardate_to_dec...
     D                 PR                  like(r5_dec_date_t)
     D                                     extproc('r5_chardate_to_dec')
     D   char_date                         like(r5_long_char_date_t) const
     D                                     options(*TRIM)
     D   char_format                       like(r5_long_date_format_t) const
     D                                     options(*TRIM)
     D   o_separator                       like(r5_date_separator_t) const
     D                                     options(*TRIM: *OMIT: *NOPASS)
     D   o_dec_format                      like(r5_date_format_t) const
     D                                     options(*TRIM: *NOPASS)

     D r5_convert_decdate...
     D                 PR                  like(r5_dec_date_t)
     D                                     extproc('r5_convert_decdate')
     D   dec_date                          like(r5_dec_date_t) const
     D   dec_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)
     D   out_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

     D r5_make_date    PR                  like(r5_date_t)
     D                                     extproc('r5_make_date')
     D   year                         4P 0 const
     D   o_month                      2P 0 options(*NOPASS) const
     D   o_day                        2P 0 options(*NOPASS) const

     D r5_set_year_of_date...
     D                 PR                  like(r5_date_t)
     D                                     extproc('r5_set_year_of_date')
     D   date                              like(r5_date_t) const
     D   year                         4P 0 const

     D r5_set_month_of_date...
     D                 PR                  like(r5_date_t)
     D                                     extproc('r5_set_month_of_date')
     D   date                              like(r5_date_t) const
     D   month                        2P 0 const

     D r5_set_day_of_date...
     D                 PR                  like(r5_date_t)
     D                                     extproc('r5_set_day_of_date')
     D   date                              like(r5_date_t) const
     D   day                          2P 0 const

     D r5_check_dec_date...
     D                 PR                  like(r5_boolean_t)
     D                                     extproc('r5_check_dec_date')
     D   dec_date                          like(r5_dec_date_t) const
     D   dec_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

     D r5_check_char_date...
     D                 PR                  like(r5_boolean_t)
     D                                     extproc('r5_check_char_date')
     D   char_date                         like(r5_long_char_date_t) const
     D   char_format                       like(r5_long_date_format_t) const

     D r5_check_date_format...
     D                 PR                  like(r5_boolean_t)
     D                                     extproc('r5_check_date_format')
     D   format                            like(r5_long_date_format_t) const
     D                                     options(*TRIM)

     D r5_verify_date_format...
     D                 PR                  extproc('r5_verify_date_format')
     D   format                            like(r5_long_date_format_t) const
     D                                     options(*TRIM)

     D r5_check_date_separator...
     D                 PR                  like(r5_boolean_t)
     D                                     extproc('r5_check_date_separator')
     D   separator                         like(r5_date_separator_t) const

     D r5_verify_date_separator...
     D                 PR                  extproc('r5_verify_date_separator')
     D   separator                         like(r5_date_separator_t) const

     D r5_date_to_text...
     D                 PR                  like(r5_long_char_date_t)
     D                                     extproc('r5_date_to_text')
     D   o_date                            like(r5_date_t) const
     D                                     options(*OMIT: *NOPASS)
     D   o_format                          like(r5_long_date_format_t) const
     D                                     options(*TRIM: *NOPASS)

     D r5_day_name     PR                  like(r5_long_char_date_t)
     D                                     extproc('r5_day_name')
     D   date                              like(r5_date_t) const
     D   o_format                          like(r5_long_date_format_t) const
     D                                     options(*TRIM: *NOPASS)

     D r5_month_name   PR                  like(r5_long_char_date_t)
     D                                     extproc('r5_month_name')
     D   date                              like(r5_date_t) const
     D   o_format                          like(r5_long_date_format_t) const
     D                                     options(*TRIM: *NOPASS)

     D r5_date_duration...
     D                 PR
     D                                     extproc('r5_date_duration')
     D   date1                             like(r5_date_t) const
     D   date2                             like(r5_date_t) const
     D   years                             like(r5_short_t)
     D   months                            like(r5_short_t)
     D   weeks                             like(r5_short_t)
     D   days                              like(r5_short_t)

     D r5_begin_of_year...
     D                 PR                  like(r5_date_t)
     D                                     extproc('r5_begin_of_year')
     D   date                              like(r5_date_t) const

     D r5_end_of_year...
     D                 PR                  like(r5_date_t)
     D                                     extproc('r5_end_of_year')
     D   date                              like(r5_date_t) const

     D r5_is_leap_year...
     D                 PR                  like(r5_boolean_t)
     D                                     extproc('r5_is_leap_year')
     D   date                              like(r5_date_t) const

     D r5_day_of_year  PR                  like(r5_short_t)
     D                                     extproc('r5_day_of_year')
     D   date                              like(r5_date_t) const

     D r5_get_week_of_year...
     D                 PR                  extproc('r5_get_week_of_year')
     D   date                              like(r5_date_t) const
     D   week                              likeds(r5_week_t)

     D r5_day_of_week...
     D                 PR                  like(r5_small_t)
     D                                     extproc('r5_day_of_week')
     D   date                              like(r5_date_t) const
     D   o_criteria                        like(r5_varname_t) const
     D                                     options(*TRIM: *NOPASS)

     D r5_begin_of_week...
     D                 PR                  like(r5_date_t)
     D                                     extproc('r5_begin_of_week')
     D   date                              like(r5_date_t) const

     D r5_end_of_week  PR                  like(r5_date_t)
     D                                     extproc('r5_end_of_week')
     D   date                              like(r5_date_t) const

     D r5_begin_of_month...
     D                 PR                  like(r5_date_t)
     D                                     extproc('r5_begin_of_month')
     D   date                              like(r5_date_t) const

     D r5_end_of_month...
     D                 PR                  like(r5_date_t)
     D                                     extproc('r5_end_of_month')
     D   date                              like(r5_date_t) const

     D r5_begin_of_quarter...
     D                 PR                  like(r5_date_t)
     D                                     extproc('r5_begin_of_quarter')
     D   date                              like(r5_date_t) const

     D r5_end_of_quarter...
     D                 PR                  like(r5_date_t)
     D                                     extproc('r5_end_of_quarter')
     D   date                              like(r5_date_t) const

     D r5_quarter      PR                  like(r5_small_t)
     D                                     extproc('r5_quarter')
     D   date                              like(r5_date_t) const

