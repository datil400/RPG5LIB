      *
      *  Package : RPG5LIB
      *  SrvPgm  : R5DATTIM
      *  Module  : DATES
      *
      *  Date functions collection.
      *
      *  Author : Javier Mora
      *  Date: June 2022
      *
      *  Compiling : R5DATTIMI
      *
      *  Comments
      *

     H nomain
     H option(*SRCSTMT: *NODEBUGIO)
     H bnddir('RPG5LIB')

      /COPY API,CEEDATE_H
      /COPY API,MsgH_H
      /COPY RPG5LIB,r5excmgr_h
      /COPY RPG5LIB,string_h
      /COPY RPG5LIB,dates_h

     *
     * El primer día del calendario Gregoriano fue el 15-10-1582 y
     * fue viernes.
     *
     D FIRST_GREGORIAN_DAY...
     D                 C                   D'1582-10-15'

     D VALID_DATE_SEPARATORS...
     D                 C                   '/-.,&0'
     D VALID_TIME_SEPARATORS...
     D                 C                   ':.,&0'
     D SEPARATOR_MASK  C                   '@'
     D WRONG_DATE_FORMAT...
     D                 C                   'YMD'

    D* ------------------------------------------------------------------
    D* Correlación entre los formatos de fechas utilizados en RPG y
    D* los formatos empleados en los procedimientos ILE CEE*.
    D* ------------------------------------------------------------------
     D rpg_and_cee_date_formats...
     D                 DS
     D                               27A   inz('*MDY    MMDDYY  MM@DD@YY  /')
     D                               27A   inz('*DMY    DDMMYY  DD@MM@YY  /')
     D                               27A   inz('*YMD    YYMMDD  YY@MM@DD  /')
     D                               27A   inz('*MDYY   MMDDYYYYMM@DD@YYYY/')
     D                               27A   inz('*DMYY   DDMMYYYYDD@MM@YYYY/')
     D                               27A   inz('*YYMD   YYYYMMDDYYYY@MM@DD/')
     D                               27A   inz('*ISO    YYYYMMDDYYYY@MM@DD-')
     D                               27A   inz('*USA    MMDDYYYYMM@DD@YYYY/')
     D                               27A   inz('*EUR    DDMMYYYYDD@MM@YYYY.')
     D                               27A   inz('*JUL                       ')
     D                               27A   inz('*LONGJUL                   ')
     D                               27A   inz('*JOBRUN                    ')
     D   formats                           dim(12)
     D                                     overlay(rpg_and_cee_date_formats)
     D     rpg_date_format...
     D                                8A   overlay(formats)
     D     cee_date_format...
     D                                8A   overlay(formats: *NEXT)
     D     cee_date_separator_fmt...
     D                               10A   overlay(formats: *NEXT)
     D     default_date_separator...
     D                                1A   overlay(formats: *NEXT)


    /**
     *  Transforma una fecha en formato numérico en una cadena de caracteres,
     *  incluyendo los separadores de fecha.
     *
     *  'dec_date' es la fecha en formato numérico. Debe ser válida.
     *
     *  'dec_format' define el formato de la fecha 'dec_date'.
     *  Revisar la documentación de la función 'r5_dec_to_date'.
     *
     *  'o_char_format' define el formato que tendrá la fecha como resultado
     *  de la conversión.
     *  Si no se indica, el formato final es el mismo que el de la fecha
     *  numérica. Optativo.
     *
     *    Formatos válidos:
     *       Y=Año; M=Mes; D=Día
     *    Los siguientes formatos incluirán un separador por defecto,
     *    que podrá cambiarse o eliminarse indicándolo al final de la
     *    cadena o en el parámetro 'o_separator':
     *     *DMY; *MDY; *YMD; *DMYY; *MDYY; *YYMD
     *     *ISO; *USA; *EUR
     *
     *    Los siguientes formatos NO INCLUYEN un separador por defecto:
     *     DDMMYY; MMDDYY; YYMMDD; DDMMYYYY; MMDDYYYY; YYYYMMDD
     *
     *    pero pueden especificarse junto al formato o en parámetro
     *    a parte. Por ejemplo:
     *     DD-MM-YY; MM/DD/YY; DD.MM.YYYY;
     *
     *  'o_separator' identifica el separador de la fecha de destino
     *  si no se indica junto al parámetro de formato 'o_char_format'.
     *
     *    Los separadores pemitidos son:
     *      / - . , & 0
     *    El valor '0' significa 'sin separadores'.
     *    Parámetro optativo.
     *
     *  Excepciones:
     *
     *  RP50002  El separador de fecha no es válido.
     *  CEE2518  La especificación de la serie de imagen (el formato) no
     *           es válida.
     */

     P r5_decdate_to_char...
     P                 B                   export
     D                 PI                  like(r5_char_date_t)
     D   dec_date                          like(r5_dec_date_t) const
     D   dec_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)
     D   o_char_format...
     D                                     like(r5_date_format_t) const
     D                                     options(*TRIM: *OMIT: *NOPASS)
     D   o_separator                       like(r5_date_separator_t) const
     D                                     options(*TRIM: *NOPASS)

     D char_date       S                   like(r5_char_date_t)
     D char_format     S                   like(o_char_format)
     D separator       S                   like(o_separator) inz('')
     D date            S                   like(r5_date_t)

       if %parms() >= %parmnum(o_char_format) and
          %addr(o_char_format) <> *NULL;
          char_format = o_char_format;
       else;
          char_format = dec_format;
       endif;

       if %parms() >= %parmnum(o_separator);
          separator = o_separator;
       endif;

       date = r5_dec_to_date(dec_date: dec_format);
       char_date = r5_date_to_char(date: char_format: separator);
       return char_date;

     P r5_decdate_to_char...
     P                 E


    /**
     *  Comprueba si una fecha numérica es correcta.
     *
     *  'dec_format' define el formato de la fecha del valor numérico
     *   que se comprueba.
     *
     *    Formatos válidos:
     *      Y=Año; M=Mes; D=Día
     *    *DMY; *MDY; *YMD; *DMYY; *MDYY; *YYMD
     *    *ISO; *USA; *EUR
     *    DDMMYY; MMDDYY; YYMMDD; DDMMYYYY; MMDDYYYY; YYYYMMDD
     */

     P r5_check_dec_date...
     P                 B                   export
     D                 PI                  like(r5_boolean_t)
     D   dec_date                          like(r5_dec_date_t) const
     D   dec_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

       callp(e) r5_dec_to_date(dec_date: dec_format);
       return (not %error());

     P r5_check_dec_date...
     P                 E


    /**
     *  Convierte un valor numérico decimal en una fecha.
     *
     *  'dec_date' es un valor numérico que representa una fecha en el
     *  formato 'dec_format'. Debe ser una fecha válida.
     *
     *    Formatos válidos:
     *      Y=Año; M=Mes; D=Día
     *    *DMY; *MDY; *YMD; *DMYY; *MDYY; *YYMD
     *    *ISO; *USA; *EUR
     *    DDMMYY; MMDDYY; YYMMDD; DDMMYYYY; MMDDYYYY; YYYYMMDD
     *
     *  El formato de la fecha resultante viene definido por la
     *  variable de tipo fecha de destino.
     *
     *  Excepciones:
     *
     *  CEE2507  Se ha proporcionado datos insuficientes.
     *  CEE2508  El valor del día no es válido.
     *  CEE2517  El valor del mes no es válido.
     *  CEE2521  El valor del año no es válido.
     *  CEE2518  La especificación de la serie de imagen no es válida.
     *  CEE2525  Discrepancia con la imagen de indicación de la hora.
     */

     P r5_dec_to_date...
     P                 B                   export
     D                 PI                  like(r5_date_t)
     D   dec_date                          like(r5_dec_date_t) const
     D   dec_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

     D date            S                   like(r5_date_t)
     D cee_format      S                   like(r5_date_format_t)
     D in_date         S                   like(r5_char_date_t)
     D out_date        S                   like(r5_char_date_t)

       cee_format = find_cee_date_format(dec_format);
       in_date = %editc(dec_date: 'X');
       in_date = r5_right(in_date: %len(cee_format));
       out_date = convert_char_date(in_date: cee_format: 'YYYY-MM-DD');
       date = %date(out_date: *ISO);
       return date;

     P r5_dec_to_date...
     P                 E


    /**
     *  Convierte una fecha en un numérico decimal.
     *
     *  'dec_format' define el formato de la fecha numérica resultante
     *  de la conversión.
     *
     *   Formatos válidos:
     *      Y=Año; M=Mes; D=Día
     *    *DMY; *MDY; *YMD; *DMYY; *MDYY; *YYMD
     *    *ISO; *USA; *EUR
     *    DDMMYY; MMDDYY; YYMMDD; DDMMYYYY; MMDDYYYY; YYYYMMDD
     *
     *  Excepciones:
     *
     *  CEE2518  El formato especificado no es válido.
     *  RNX0105  Una representación de carácter de un valor numérico
     *           es errónea.
     */

     P r5_date_to_dec...
     P                 B                   export
     D                 PI                  like(r5_dec_date_t)
     D   date                              like(r5_date_t) const
     D   dec_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

     D dec_date        S                   like(r5_dec_date_t)
     D dec_date_length...
     D                 C                   %len(dec_date)
     D cee_format      S                   like(r5_date_format_t)
     D in_date         S                   like(r5_char_date_t)
     D out_date        S                   like(r5_char_date_t)

       cee_format = find_cee_date_format(dec_format);
       in_date = %char(date: *ISO);
       out_date = convert_char_date(in_date: 'YYYY-MM-DD': cee_format);
       dec_date = %dec(out_date: dec_date_length: 0);
       return dec_date;

     P r5_date_to_dec...
     P                 E


    /**
     *  Cambia el formato de una fecha almacenada en un campo numérico.
     *
     *  'dec_date' es el valor numérico que se quiere transformar a
     *  otro formato. Debe ser una fecha válida.
     *
     *  'dec_format' define el formato de fecha del valor numérico a
     *  convertir.
     *
     *  'out_format' define el formato de la fecha resultante de la
     *  conversión.
     *
     *    Formatos válidos:
     *      Y=Año; M=Mes; D=Día
     *    *DMY; *MDY; *YMD; *DMYY; *MDYY; *YYMD
     *    *ISO; *USA; *EUR
     *    DDMMYY; MMDDYY; YYMMDD; DDMMYYYY; MMDDYYYY; YYYYMMDD
     */

     P r5_convert_decdate...
     P                 B                   export
     D                 PI                  like(r5_dec_date_t)
     D   dec_date                          like(r5_dec_date_t) const
     D   dec_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)
     D   out_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

     D out_dec_date    S                   like(r5_dec_date_t)
     D out_dec_date_length...
     D                 C                   %len(out_dec_date)
     D out_date        S                   like(r5_char_date_t)
     D out_cee_format  S                   like(out_format)
     D in_date         S              9A   varying
     D in_cee_format   S                   like(dec_format)

       in_cee_format = find_cee_date_format(dec_format);
       out_cee_format = find_cee_date_format(out_format);

       select;
       // La fecha 00-00-00 es incorrecta pero se permite cuando la
       // variable es numérica e indica el valor más pequeño de una
       // fecha.

       when dec_date = 0;
          out_date = '0';

       // Las fechas 99-99-99 son incorrectas pero se permiten cuando
       // la variable es numérica e indican el valor más grande de
       // una fecha.

       when (dec_date = 999999 or dec_date = 99999999) and
            (%len(out_cee_format) = 6 or %len(out_cee_format) = 8);

          if %len(out_cee_format) = 6;
             out_date = '999999';
          else;
             out_date = '99999999';
          endif;

       // Si la fecha a covertir no es un valor especial (ver anteriores)
       // ésta debe ser correcta y se transforma según los criterios
       // indicados por los formatos.

       other;
          in_date = %trim(%editc(dec_date: 'X'));
          in_date = r5_right(in_date: %len(in_cee_format));
          out_date =
                   convert_char_date(in_date: in_cee_format: out_cee_format);
       endsl;

       out_dec_date = %dec(%trim(out_date): out_dec_date_length: 0);
       return  out_dec_date;

     P r5_convert_decdate...
     P                 E


    /**
     *  ¿Buscar un nombre más descriptivo?
     */

     P find_cee_date_format...
     P                 B
     D                 PI                  like(r5_date_format_t)
     D   format                            like(r5_date_format_t) const
     D                                     options(*TRIM)

     D cee_format      S                   like(r5_date_format_t)

       if r5_left(format: 1) = '*';
          cee_format = lookup_cee_date_format(format);
       else;
          cee_format = format;
       endif;
       return cee_format;

     P find_cee_date_format...
     P                 E


    /**
     *  Convierte una fecha en una cadena de caracteres, incluyendo
     *  los separadores de fecha.
     *
     *  'char_format' define el formato de la fecha resultante de la
     *   conversión.
     *
     *    Formatos válidos:
     *       Y=Año; M=Mes; D=Día
     *    Los siguientes formatos incluirán un separador por defecto,
     *    que podrá cambiarse o eliminarse indicándolo al final de la
     *    cadena o en el parámetro 'o_separator':
     *     *DMY; *MDY; *YMD; *DMYY; *MDYY; *YYMD
     *     *ISO; *USA; *EUR
     *
     *    Los siguientes formatos NO INCLUYEN un separador por defecto:
     *     DDMMYY; MMDDYY; YYMMDD; DDMMYYYY; MMDDYYYY; YYYYMMDD
     *
     *    pero pueden especificarse junto al formato o en parámetro
     *    a parte. Por ejemplo:
     *     DD-MM-YY; MM/DD/YY; DD.MM.YYYY;
     *
     *  'o_separator' identifica el separador de fecha si no se incluye
     *  junto al parámetro de formato.
     *
     *    Los separadores permitidos son:
     *      / - . , & 0
     *    El valor '0' significa 'sin separadores'.
     *    Parámetro optativo.
     *
     *  Excepciones:
     *
     *  RP50002  El separador de fecha no es válido.
     *  CEE2518  La especificación de la serie de imagen (el formato) no
     *           es válida.
     */

     P r5_date_to_char...
     P                 B                   export
     D                 PI                  like(r5_char_date_t)
     D   date                              like(r5_date_t) const
     D   char_format                       like(r5_date_format_t) const
     D                                     options(*TRIM)
     D   o_separator                       like(r5_date_separator_t) const
     D                                     options(*TRIM: *NOPASS)

     D out_date        S                   like(r5_char_date_t)
     D separator       S                   like(o_separator)
     D cee_format      S                   like(r5_date_format_t)
     D in_date         S                   like(r5_char_date_t)

       if %parms() >= %parmnum(o_separator);
          separator = o_separator;
       endif;

       r5_verify_date_separator(separator);
       cee_format = parse_date_format(char_format: separator);

       in_date = %char(date: *ISO);
       out_date = convert_char_date(in_date: 'YYYY-MM-DD': cee_format);
       return out_date;

     P r5_date_to_char...
     P                 E


    /**
     *  Transforma una cadena de caracteres que representa una fecha a
     *  una fecha en formato numérico.
     *
     *  'char_date' es la fecha en formato alfanumérico, según indique
     *  el parámetro 'char_format'.
     *
     *    Formatos válidos:
     *       Y=Año; M=Mes; D=Día
     *
     *    Los siguientes formatos incluirán un separador por defecto,
     *    que podrá cambiarse o eliminarse indicándolo al final de la
     *    cadena o en el parámetro 'o_separator':
     *     *DMY; *MDY; *YMD; *DMYY; *MDYY; *YYMD
     *     *ISO; *USA; *EUR
     *
     *    Los siguientes formatos NO INCLUYEN un separador por defecto:
     *     DDMMYY; MMDDYY; YYMMDD; DDMMYYYY; MMDDYYYY; YYYYMMDD
     *
     *    pero pueden especificarse junto al formato o en parámetro
     *    a parte. Por ejemplo:
     *     DD-MM-YY; MM/DD/YY; DD.MM.YYYY;
     *
     *    Podrá utilizarse cualquier otro formato compatible con la
     *    API CEEDAYS.
     *
     *  'o_separator' identifica el separador de la fecha que se convierte
     *  si no se indica junto al parámetro de formato 'o_char_format'.
     *
     *    Los separadores pemitidos son:
     *      / - . , & 0
     *    El valor '0' significa 'sin separadores'.
     *    Parámetro optativo.
     *
     *  'dec_format' define el formato de la fecha como resultado de
     *  la conversión. Revisar la documentación de la función
     *   'r5_dec_to_date'.
     *
     *  Si no se indica, el formato final intentará ajustarse lo más
     *  posible a la fecha original. Si no fuera posible, se lanzará una
     *  excepción.
     *  Parámetro optativo.
     *
     *  Excepciones:
     *
     *  RP52500  El formato de fecha no es válido.
     *  RP52501  No se ha podidio interpretar el formato de entrada
     *           para la fecha de retorno.
     *  RP50002  El separador de fecha no es válido.
     *  CEE2518  La especificación de la serie de imagen (el formato) no
     *           es válida.
     *  CEE2508  El valor del día no es válido.
     *  CEE2517  El valor del mes no es válido.
     *  CEE2525  Discrepancia con la imagen de indicación de la hora.
     *  RNX0112  El valor de Fecha, Hora o Indicación de la hora
     *           no es válido.
     */

     P r5_chardate_to_dec...
     P                 B                   export
     D                 PI                  like(r5_dec_date_t)
     D   char_date                         like(r5_long_char_date_t) const
     D                                     options(*TRIM)
     D   char_format                       like(r5_long_date_format_t) const
     D                                     options(*TRIM)
     D   o_separator                       like(r5_date_separator_t) const
     D                                     options(*TRIM: *OMIT: *NOPASS)
     D   o_dec_format                      like(r5_date_format_t) const
     D                                     options(*TRIM: *NOPASS)

     D dec_date        S                   like(r5_dec_date_t)
     D separator       S                   like(o_separator) inz('')
     D dec_format      S                   like(o_dec_format)
     D date            S                   like(r5_date_t)

       if %parms() >= %parmnum(o_separator) and %addr(o_separator) <> *NULL;
          separator = o_separator;
       endif;

       if %parms() >= %parmnum(o_dec_format);
          dec_format = o_dec_format;
       else;
          dec_format = find_equivalent_date_format(char_format);
       endif;

       date = r5_char_to_date(char_date: char_format: separator);
       dec_date = r5_date_to_dec(date: dec_format);
       return dec_date;

     P r5_chardate_to_dec...
     P                 E


    /**
     *  Busca un formato de fecha básico equivalente al formato
     *  formato de fecha especificado.
     */

     P find_equivalent_date_format...
     P                 B
     D                 PI                  like(r5_date_format_t)
     D   long_format                       like(r5_long_date_format_t) const
     D                                     options(*TRIM)

     D format          S                   like(r5_date_format_t)

       if r5_left(long_format: 1) = '*';
          if r5_check_date_separator(r5_right(long_format: 1));
             // Con separador explícito
             format = r5_left(long_format: %len(long_format) - 1);
          else;
             // El formato NO incluye un separador explícito.
             format = long_format;
          endif;
       else;
          if %len(long_format) <= %size(r5_date_format_t);
             format = clean_string(long_format: VALID_DATE_SEPARATORS);
          else;
             format = '';
          endif;
       endif;

       return format;

     P find_equivalent_date_format...
     P                 E


     P r5_check_date_separator...
     P                 B                   export
     D                 PI                  like(r5_boolean_t)
     D   separator                         like(r5_date_separator_t) const

       if %len(separator) > 0 and
          %check(VALID_DATE_SEPARATORS: separator) > 0;
          return *OFF;
       endif;
       return *ON;

     P r5_check_date_separator...
     P                 E


    /**
     *  Limpia una cadena de caracteres de símbolos extraños.
     *
     *  Cuando esta función esté preparada para publicarse habrá que
     *  trasladarla al módulo 'R5STRING'.
     *
     *  Queda pendiente de revisar el parámetro 'symbols' para
     *  sustituirlo por un puntero a un procedimiento encargado de
     *  inspeccionar cada carácter de la cadena y que decida si hay
     *  que eliminarlo o no.
     *
     *  Revisar el tamaño del parámetro 'str'.
     *
     *  'str' es la cadena de caracters a limpiar.
     *
     *  'symbols' es la lista de símbolos a eliminar de la cadena
     *  de entrada.
     */

     P clean_string    B
     D                 PI           128A   varying
     D   str                        128A   varying const
     D   symbols                    128A   varying const

     D clean           S                   like(str)
     D pos             S                   like(r5_int_t)
     D char            S              1A

       for pos = 1 to %len(str);
          char = r5_mid(str: pos: 1);
          if  %check(symbols: char) > 0;
             clean = clean + char;
          endif;
       endfor;
       return clean;

     P clean_string    E


    /**
     *  Comprueba si una cadena de caracteres es una fecha correcta.
     *
     *  'char_format' define el formato de la fecha que se comprueba.
     *
     *    Para los formatos válidos consultar la documentación de la
     *    función 'r5_char_to_date'.
     */

     P r5_check_char_date...
     P                 B                   export
     D                 PI                  like(r5_boolean_t)
     D   char_date                         like(r5_long_char_date_t) const
     D   char_format                       like(r5_long_date_format_t) const

       callp(e) r5_char_to_date(char_date: char_format);
       return (not %error());

     P r5_check_char_date...
     P                 E


    /**
     *  Convierte una cadena de caracteres en una fecha.
     *
     *  La fecha puede expresarse en diferentes formatos que deberán ser
     *  compatibles con los utilizadas con la API CEEDAYS.
     *
     *  'char_date' es la cadena de caracteres que contiene la fecha a
     *   convertir.
     *
     *  'char_format' define el formato de la fecha a convertir.
     *
     *    Formatos válidos:
     *       Y=Año; M=Mes; D=Día
     *
     *    Los siguientes formatos incluirán un separador por defecto,
     *    que podrá cambiarse o eliminarse indicándolo al final de la
     *    cadena o en el parámetro 'o_separator':
     *     *DMY; *MDY; *YMD; *DMYY; *MDYY; *YYMD
     *     *ISO; *USA; *EUR
     *
     *    Los siguientes formatos NO INCLUYEN un separador por defecto:
     *     DDMMYY; MMDDYY; YYMMDD; DDMMYYYY; MMDDYYYY; YYYYMMDD
     *
     *    pero pueden especificarse junto al formato o en parámetro
     *    a parte. Por ejemplo:
     *     DD-MM-YY; MM/DD/YY; DD.MM.YYYY;
     *
     *    Podrá utilizarse cualquier otro formato compatible con la
     *    API CEEDAYS.
     *
     *  'o_sparator' identifica el separador de fecha si no se incluye
     *  junto al parámetro de formato.
     *
     *    Los separadores permitidos son:
     *      / - . , & 0
     *    El valor '0' significa 'sin separadores'.
     *    Parámetro optativo.
     *
     *  Excepciones:
     *
     *  RP50002  El separador de fecha no es válido.
     *  CEE2518  La especificación de la serie de imagen (el formato) no
     *           es válida.
     *  CEE2508  El valor del día no es válido.
     *  CEE2517  El valor del mes no es válido.
     *  CEE2525  Discrepancia con la imagen de indicación de la hora.
     */

     P r5_char_to_date...
     P                 B                   export
     D                 PI                  like(r5_date_t)
     D   char_date                         like(r5_long_char_date_t) const
     D                                     options(*TRIM)
     D   char_format                       like(r5_long_date_format_t) const
     D                                     options(*TRIM)
     D   o_separator                       like(r5_date_separator_t) const
     D                                     options(*TRIM: *NOPASS)

     D date            S                   like(r5_date_t)
     D separator       S                   like(o_separator)
     D cee_format      S                   like(r5_long_date_format_t)
     D out_date        S                   like(r5_char_date_t)

       if %parms() >= %parmnum(o_separator);
          separator = o_separator;
       endif;

       r5_verify_date_separator(separator);
       cee_format = parse_date_format(char_format: separator);

       out_date = convert_char_date(char_date: cee_format: 'YYYY-MM-DD');
       date = %date(out_date: *ISO);
       return date;

     P r5_char_to_date...
     P                 E


     /**
      *  Si el formato no es correcto deja constancia en las anotaciones del trabajo
      */

     P r5_check_date_format...
     P                 B                   export
     D                 PI                  like(r5_boolean_t)
     D   format                            like(r5_long_date_format_t) const
     D                                     options(*TRIM)

       callp(E) r5_verify_date_format(format);
       return (not %error());

     P r5_check_date_format...
     P                 E


     P r5_verify_date_format...
     P                 B                    export
     D                 PI
     D   format                            like(r5_long_date_format_t) const
     D                                     options(*TRIM)

     D exception       S                   like(r5_object_t)
     D cee_format      S            128A
     D result          S            128A

       cee_format = parse_date_format(format);

       if cee_format = '';
          exception = r5_exception_new('CEE2518': 'QCEEMSG');
          r5_throw(exception);
       endif;

       monitor;
          CEEDATE(1: cee_format: result: *OMIT);
       on-error;
          r5_catch();
          r5_throw();
       endmon;
       return;

     P r5_verify_date_format...
     P                 E


    /**
     *  Analiza el formato de fecha para identificar si incluye separadores
     *  y obtiene un formato CEE equivalente.
     *
     *  ¿Buscar un nombre más apropiado?
     *
     *  Factorizar
     */

     P parse_date_format...
     P                 B
     D                 PI                  like(r5_long_date_format_t)
     D   date_format                       like(r5_long_date_format_t) const
     D                                     options(*TRIM)
     D   o_separator                       like(r5_date_separator_t) const
     D                                     options(*TRIM: *NOPASS)

     D cee_format      S                   like(r5_long_date_format_t)
     D separator       S                   like(o_separator)
     D wSep            S                   like(separator)
     D wDateFmt        S                   like(date_format)

       if %parms() >= %parmnum(o_separator);
          separator = o_separator;
       endif;

       if r5_left(date_format: 1) = '*';
          wSep = r5_right(date_format: 1);
          if %check(VALID_DATE_SEPARATORS: wSep) = 0;
             // El formato incluye separador y tiene prioridad sobre
             // el indicado en el parámetro 'o_separator'.
             separator = wSep;
             wDateFmt = r5_left(date_format: %len(date_format) - 1);
          else;
             // El formato NO incluye separador.
             if %len(separator) = 0;
                separator = lookup_default_date_separator(date_format);
             endif;
             wDateFmt = date_format;
          endif;

          if separator = '0' or separator = '';
             cee_format = lookup_cee_date_format(wDateFmt);
          else;
             cee_format = lookup_cee_date_format_with_separator( wDateFmt
                                                               : separator );
          endif;

       else;
          // Averiguar si el formato de fecha CEE es válido y no
          // tiene separadores.
          //
          // La comprobación la hacemos indirectamente a través de la
          // función 'lookup_rpg_date_format'. Si devuelve algo distinto de
          // blancos, se asume que el formato CEE es correcto.

          if lookup_rpg_date_format(date_format) <> '';
             if %len(separator) = 0;
                cee_format = date_format;
             else;
                cee_format =
                         lookup_cee_date_format_with_separator( date_format
                                                              : separator );
             endif;
          else;
             if not check_cee_date_format_with_separator(date_format);
                //cee_format = WRONG_DATE_FORMAT;
             endif;
             cee_format = date_format;
          endif;
       endif;
       return cee_format;

     P parse_date_format...
     P                 E


    /**
     *  Busca el separador por defecto para un formato de fecha
     *  válido:
     *
     *    *DMY; *MDY; *YMD; *DMYY; *MDYY; *YYMD
     *    *ISO; *USA; *EUR
     *    DDMMYY; MMDDYY; YYMMDD; DDMMYYYY; MMDDYYYY; YYYYMMDD
     */

     P lookup_default_date_separator...
     P                 B
     D                 PI                  like(r5_date_separator_t)
     D   format                            like(r5_date_format_t) const
     D                                     options(*TRIM)

     D separator       S                   like(r5_date_separator_t)
     D i               S                   like(r5_short_t)

       if r5_left(format: 1) = '*';
          i = %lookup(format: rpg_date_format);
       else;
          i = %lookup(format: cee_date_format);
       endif;

       if i > 0;
          separator = %trim(default_date_separator(i));
       else;
          separator = '';
       endif;
       return separator;

     P lookup_default_date_separator...
     P                 E


    /**
     *  Busca el formato de fecha CEE equivalente a un formato de
     *  estilo RPG.
     *
     *  'rpg_format' identifica a un formato de fecha de estilo RPG.
     *  Comienza siempre con un '*'.
     *
     *    Formatos válidos:
     *    *DMY; *MDY; *YMD; *DMYY; *MDYY; *YYMD
     *    *ISO; *USA; *EUR
     *
     *  Un formato CEE vacío indica que no hay equivalencia con
     *  el formato RPG especificado.
     */

     P lookup_cee_date_format...
     P                 B
     D                 PI                  like(r5_date_format_t)
     D   rpg_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

     D cee_format      S                   like(r5_date_format_t)
     D i               S                   like(r5_short_t)

       i = %lookup(rpg_format: rpg_date_format);
       if i > 0;
          cee_format = %trim(cee_date_format(i));
       else;
          cee_format = '';
       endif;
       return cee_format;

     P lookup_cee_date_format...
     P                 E


    /**
     *  Busca el formato de fecha CEE con separadores equivalente a
     *  cualquier formato de fecha válido.
     *
     *  Formatos de fecha válidos:
     *
     *    *DMY; *MDY; *YMD; *DMYY; *MDYY; *YYMD
     *    *ISO; *USA; *EUR
     *    DDMMYY; MMDDYY; YYMMDD; DDMMYYYY; MMDDYYYY; YYYYMMDD
     *
     *  'o_separator' es el separador de fecha. Si se omite, se toma
     *  el separador por defecto en función del formato.
     *
     *  Un formato CEE vacío indica que no no se ha encontrado el
     *  equivalente con separadores.
     *
     *  Excepciones:
     *
     *  RP50002  El separador de fecha no es válido.
     */

     P lookup_cee_date_format_with_separator...
     P                 B
     D                 PI                  like(r5_date_format_t)
     D   format                            like(r5_date_format_t) const
     D                                     options(*TRIM)
     D   o_separator                       like(r5_date_separator_t) const
     D                                     options(*TRIM: *NOPASS)

     D cee_format      S                   like(r5_date_format_t)
     D separator       S                   like(o_separator)
     D i               S                   like(r5_short_t)

       if %parms() >= %parmnum(o_separator);
          separator = o_separator;
       endif;

       r5_verify_date_separator(separator);

       if r5_left(format: 1) = '*';
          i = %lookup(format: rpg_date_format);
       else;
          i = %lookup(format: cee_date_format);
       endif;

       if i > 0;
          cee_format = %trim(cee_date_separator_fmt(i));
          if separator = '';
             separator = %trim(default_date_separator(i));
          endif;
          //if separator = '&';
          //   separator = ' ';
          //endif;
          cee_format = %xlate(SEPARATOR_MASK: separator: cee_format);
       else;
          cee_format = '';
       endif;
       return cee_format;

     P lookup_cee_date_format_with_separator...
     P                 E


     P r5_verify_date_separator...
     P                 B                   export
     D                 PI
     D   separator                         like(r5_date_separator_t) const

     D exception       S                   like(r5_object_t)

       if %len(separator) > 0 and
          %check(VALID_DATE_SEPARATORS: separator) > 0;
          exception = r5_exception_new('RP50002': 'RPG5MSG': separator);
          r5_throw(exception);
       endif;
       return;

     P r5_verify_date_separator...
     P                 E


    /**
     *  Busca el formato de fecha RPG equivalente a un formato del
     *  estilo de las APIs CEE.
     *
     *  'cee_format' identifica a un formato de fecha de estilo de
     *  las APIs ILE CEE.
     *
     *    Formatos válidos:
     *    DDMMYY; MMDDYY; YYMMDD; DDMMYYYY; MMDDYYYY; YYYYMMDD
     *
     *  Un formato RPG vacío indica que no hay equivalencia con
     *  el formato CEE especificado.
     */

     P lookup_rpg_date_format...
     P                 B
     D                 PI                  like(r5_date_format_t)
     D   cee_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

     D rpg_format      S                   like(r5_date_format_t)
     D i               S                   like(r5_short_t)

       i = %lookup(cee_format: cee_date_format);
       if i > 0;
          rpg_format = %trim(rpg_date_format(i));
       else;
          rpg_format = '';
       endif;
       return rpg_format;

     P lookup_rpg_date_format...
     P                 E


    /**
     *  Comprueba si un formato de fecha CEE, con sus separadores
     *  incluidos, es correcto.
     *
     *  Formatos válidos:
     *
     *    DD@MM@YY; MM@DD@YY; YY@MM@DD;
     *    DD@MM@YYYY; MM@DD@YYYY; YYYY@MM@DD
     *
     *    el símbolo '@' debe sustituirse por un
     *    separador válido.
     */

     P check_cee_date_format_with_separator...
     P                 B
     D                 PI                  like(r5_boolean_t)
     D   cee_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

     D format          S                   like(cee_format)
     D separator       S                   like(r5_date_separator_t)
     D sep_pos         S                   like(r5_short_t)
     D i               S                   like(r5_short_t)

       // Averigua si el formato de fecha incluye el separador y si
       // éste es válido.
       // Se toma el primero encontrado y todos los demás deben ser
       // iguales.

       sep_pos = %check('DMY': cee_format);
       if not (sep_pos > 2);
          return  *OFF;
       endif;

       separator = r5_mid(cee_format: sep_pos: 1);
       if %check(VALID_DATE_SEPARATORS: separator) > 0;
          return  *OFF;
       endif;

       format = %xlate(separator: SEPARATOR_MASK: cee_format);

       i = %lookup(format: cee_date_separator_fmt);
       if i = 0 or cee_date_separator_fmt(i) = *BLANKS;
          return *OFF;
       endif;

       return *ON;

     P check_cee_date_format_with_separator...
     P                 E


    /**
     *  Transforma una fecha en una representación de texto.
     *  Ejemplo: 2022-05-19 --> 19 de Mayo de 2022
     *
     *  Si se omite 'o_date' se toma la fecha del sistema.
     *
     *  'o_format' define el formato de la frase según la API CEEDATE
     *  (optativo).
     */

     P r5_date_to_text...
     P                 B                   export
     D                 PI                  like(r5_long_char_date_t)
     D   o_date                            like(r5_date_t) const
     D                                     options(*OMIT: *NOPASS)
     D   o_format                          like(r5_long_date_format_t) const
     D                                     options(*TRIM: *NOPASS)

     D date            S                   like(o_date) inz(*SYS)
     D* El formato podría depender del idioma:
     D* Anglosajón
     D*format          S                   iike(o_format)
     D*                                    inz('Wwwwwwwwwz, Mmmmmmmmmz ZD, YYYY'
     D*                                    )
     D* Latino
     D format          S                   like(o_format)
     D                                     inz('ZD de Mmmmmmmmmz de YYYY')

       if %parms() >= %parmnum(o_date) and %addr(o_date) <> *NULL;
          date = o_date;
       endif;

       if  %parms() >= %parmnum(o_format);
          format = o_format;
       endif;

       return convert_char_date(%char(date: *ISO): 'YYYY-MM-DD': format);

     P r5_date_to_text...
     P                 E


    /**
     *  Nombre del día de la fecha indicada.
     *
     *  'o_format' define el formato que tendrá el nombre del
     *  día según la API CEEDATE (optativo).
     */

     P r5_day_name     B                   export
     D                 PI                  like(r5_long_char_date_t)
     D   date                              like(r5_date_t) const
     D   o_format                          like(r5_long_date_format_t) const
     D                                     options(*TRIM: *NOPASS)

     D format          S                   like(o_format)
     D                                     inz('Wwwwwwwwwwwwwwwwwwwz')

       if %parms() >= %parmnum(o_format);
          format = o_format;
       endif;

       return convert_char_date(%char(date: *ISO): 'YYYY-MM-DD': format);

     P r5_day_name     E


    /**
     *  Nombre del mes de la fecha indicada.
     *
     *  'o_format' define el formato del nombre del mes según
     *  la API CEEDATE (optativo).
     */

     P r5_month_name   B                   export
     D                 PI                  like(r5_long_char_date_t)
     D   date                              like(r5_date_t) const
     D   o_format                          like(r5_long_date_format_t) const
     D                                     options(*TRIM: *NOPASS)

     D format          S                   like(o_format)
     D                                     inz( 'Mmmmmmmmmmmmmmmmmmmz' )

       if %parms() >= %parmnum(o_format);
          format = o_format;
       endif;

       return convert_char_date(%char(date: *ISO): 'YYYY-MM-DD': format);

     P r5_month_name   E


    /**
     *  Convierte el formato de una fecha almacenada en un campo
     *  alfanumérico.
     *
     *  'char_date' es la cadena que se quiere transformar a otro
     *  formato. Debe ser una fecha válida.
     *
     *  'char_format' define el formato CEE de la fecha a convertir.
     *
     *  'out_format' define el formato CEE de la fecha resultante de
     *  la conversión.
     */

     P convert_char_date...
     P                 B                   export
     D                 PI                  like(r5_long_char_date_t)
     D   char_date                         like(r5_long_char_date_t) const
     D                                     options(*TRIM)
     D   char_format                       like(r5_long_date_format_t) const
     D                                     options(*TRIM)
     D   out_format                        like(r5_long_date_format_t) const
     D                                     options(*TRIM)

     D result          S            128A
     D days            S                   like(r5_int_t)
     D exception       S                   like(r5_object_t)

       if char_format = '' or out_format = '';
          exception = r5_exception_new('CEE2518': 'QCEEMSG');
          r5_throw(exception);
       endif;

       monitor;
          CEEDAYS(char_date: char_format: days: *OMIT);
          CEEDATE(days: out_format: result: *OMIT);
       on-error;
          r5_catch();
          r5_throw();
       endmon;
       return %trim(result);

     P convert_char_date...
     P                 E


    /**
     *  Permite cambiar el año de la fecha indicada.
     *
     *  Excepciones:
     *
     *  RNX0112  El valor de Fecha, Hora o Indicación de la hora no es
     *           válido.
     *  MCH1210  El valor receptor es demasiado pequeño para contener
     *           el resultado.
     */

     P r5_set_year_of_date...
     P                 B                   export
     D                 PI                  like(r5_date_t)
     D   date                              like(r5_date_t) const
     D   year                         4P 0 const

     D month           S                   like(r5_short_t)
     D day             S                   like(r5_short_t)

       month = %subdt(date: *MONTHS);
       day   = %subdt(date: *DAYS);

       return r5_make_date(year: month: day);

     P r5_set_year_of_date...
     P                 E


    /**
     *  Permite cambiar el mes de la fecha indicada.
     *
     *  Excepciones:
     *
     *  RNX0112  El valor de Fecha, Hora o Indicación de la hora no es
     *           válido.
     *  MCH1210  El valor receptor es demasiado pequeño para contener
     *           el resultado.
     */

     P r5_set_month_of_date...
     P                 B                   export
     D                 PI                  like(r5_date_t)
     D   date                              like(r5_date_t) const
     D   month                        2P 0 const

     D year            S                   like(r5_short_t)
     D day             S                   like(r5_short_t)

       year = %subdt(date: *YEARS);
       day  = %subdt(date: *DAYS);

       return r5_make_date(year: month: day);

     P r5_set_month_of_date...
     P                 E


    /**
     *  Permite cambiar el dia de la fecha indicada.
     *
     *  Excepciones:
     *
     *  RNX0112  El valor de Fecha, Hora o Indicación de la hora no es
     *           válido.
     *  MCH1210  El valor receptor es demasiado pequeño para contener
     *           el resultado.
     */

     P r5_set_day_of_date...
     P                 B                   export
     D                 PI                  like(r5_date_t)
     D   date                              like(r5_date_t) const
     D   day                          2P 0 const

     D year            S                   like(r5_short_t)
     D month           S                   like(r5_short_t)

       year  = %subdt(date: *YEARS);
       month = %subdt(date: *MONTHS);

       return r5_make_date(year: month: day);

     P r5_set_day_of_date...
     P                 E


    /**
     *  Obtiene información relacionada con el número de semana según el
     *  estándar ISO 8601.
     */

     P r5_get_week_of_year...
     P                 B                   export
     D                 PI
     D   date                              like(r5_date_t) const
     D   week                              likeds(r5_week_t)

     D year            S                   like(r5_short_t)
     D d1w1            S                   like(r5_date_t)
     D d1w1_ny         S                   like(r5_date_t)
     D week_number     S                   like(r5_small_t)

       // La primera semana del año contiene el 4 de enero

       year = %subdt(date: *YEARS);
       d1w1 = first_day_of_week_one(year);
       if date < d1w1;
          year = year - 1;
          d1w1 = first_day_of_week_one(year);
       else;
          d1w1_ny = first_day_of_week_one(year + 1);
          if date >= d1w1_ny;
             year = year + 1;
             d1w1 = d1w1_ny;
          endif;
       endif;

       week_number = %div(%abs(%diff(date: d1w1: *DAYS)): 7) + 1;

       week.criteria = '*ISO';
       week.year = year;
       week.number = week_number;
       week.begin = r5_begin_of_week(date);
       week.end = r5_end_of_week(date);
       return;

     P r5_get_week_of_year...
     P                 E


    /**
     *  El primer día de la semana 1 según norma ISO 8601
     */

     P first_day_of_week_one...
     P                 B
     D                 PI                  like(r5_date_t)
     D   year                              like(r5_short_t) const

     D day_one         S                   like(r5_date_t)
     D january_one     S                   like(r5_date_t)
     D offset          S                   like(r5_short_t)

       january_one = r5_make_date(year: 1: 1);
       offset = %rem(11 - r5_day_of_week(january_one): 7) - 3;
       day_one = january_one + %days(offset);
       return day_one;

     P first_day_of_week_one...
     P                 E


    /**
     *  Construye una fecha indicando el año, mes y día por separado.
     *
     *  Excepciones:
     *
     *  RNX0112  El valor de Fecha, Hora o Indicación de la hora
     *           no es válido.
     */

     P r5_make_date    B                   export
     D                 PI                  like(r5_date_t)
     D   year                         4P 0 const
     D   o_month                      2P 0 options(*NOPASS) const
     D   o_day                        2P 0 options(*NOPASS) const

     D date            S                   like(r5_date_t)
     D month           S                   like(o_month) inz(1)
     D day             S                   like(o_day) inz(1)

       if %parms() >= %parmnum(o_month);
          month = o_month;
       endif;

       if %parms() >= %parmnum(o_day);
          day = o_day;
       endif;

       date = %date((year*100 + month)*100 + day: *ISO);
       return date;

     P r5_make_date    E


    /**
     *  El primer día de la semana de la fecha indicada.
     *
     *  Según la norma ISO 8601: el lunes es el primer día de la semana.
     */

     P r5_begin_of_week...
     P                 B                   export
     D                 PI                  like(r5_date_t)
     D   date                              like(r5_date_t) const

       return date - %days(r5_day_of_week(date) - 1);

     P r5_begin_of_week...
     P                 E


    /**
     *  El último día de la semana de la fecha indicada.
     *
     *  Según la norma ISO 8601: el domingo es el último día de la semana.
     */

     P r5_end_of_week  B                   export
     D                 PI                  like(r5_date_t)
     D   date                              like(r5_date_t) const

       return date + %days(7 - r5_day_of_week(date));

     P r5_end_of_week  E


    /**
     *  Por defecto norma ISO 8601:
     *  1=Lunes, 2=Martes, ... , 6=Sábado, 7=Domingo
     *
     *  'o_criteria' indica el criterio de cálculo del día
     *  de la semana. Por ejemplo, *ISO o *USA.  [SIN IMPLEMENTAR]
     */

     P r5_day_of_week...
     P                 B                   export
     D                 PI                  like(r5_small_t)
     D   date                              like(r5_date_t) const
     D   o_criteria                        like(r5_varname_t) const
     D                                     options(*TRIM: *NOPASS)

     D day_of_week     S                   like(r5_small_t)
     D criteria        S                   like(o_criteria) inz('*ISO')
     D*   *ISO, *USA, *EUR

       if %parms() >= %parmnum(o_criteria);
          r5_fail('WEEK_CRITERIA NOT IMPLEMENTED');
          criteria = o_criteria;
       endif;

       //verify_week_criteria(criteria);

       day_of_week = day_of_week_iso(date);
       return day_of_week;

     P r5_day_of_week...
     P                 E


    /**
     *  Según norma ISO 8601:
     *  1=Lunes, 2=Martes, ... , 6=Sábado, 7=Domingo
     */

     P day_of_week_iso...
     P                 B
     D                 PI                  like(r5_small_t)
     D   date                              like(r5_date_t) const

     D day_of_week     S                   like(r5_small_t)
     D reference       S                   like(r5_date_t)

      // Inicialmente se fija la fecha de referencia a un lunes
      // conocido, de este modo el día 1 se corresponderá con el
      // lunes y el 7 con el domingo.

       reference = FIRST_GREGORIAN_DAY + %days(3);

       day_of_week = %rem(%diff(date: reference: *DAYS): 7) + 1;

       if  day_of_week <= 0;
          day_of_week += 7;
       endif;
       return day_of_week;

     P day_of_week_iso...
     P                 E


    /**
     *  Según USA:
     *  0=Domingo, 1=Lunes, 2=Martes, ... , 6=Sábado
     */

     P day_of_week_usa...
     P                 B
     D                 PI                  like(r5_small_t)
     D   date                              like(r5_date_t) const

       r5_fail('DAY OF WEEK USA NOT IMPLEMENTED');
       return 0;

     P day_of_week_usa...
     P                 E


    /**
     *  Según EUR:
     */

     P day_of_week_eur...
     P                 B
     D                 PI                  like(r5_small_t)
     D   date                              like(r5_date_t) const

       r5_fail('DAY OF WEEK EUR NOT IMPLEMENTED');
       return 0;

     P day_of_week_eur...
     P                 E


    /**
     *  Calcula el tiempo transcurrido entre dos fechas desglosando
     *  el resultado en años, meses, semanas y días.
     *
     *  Los años, meses, semanas y días transcurridos siempre serán
     *  positivos.
     */

     P r5_date_duration...
     P                 B                   export
     D                 PI
     D   date1                             like(r5_date_t) const
     D   date2                             like(r5_date_t) const
     D   years                             like(r5_short_t)
     D   months                            like(r5_short_t)
     D   weeks                             like(r5_short_t)
     D   days                              like(r5_short_t)

     D higher_date     S                   like(r5_date_t)
     D lower_date      S                   like(r5_date_t)


       // Este procedimiento utiliza una 'singularidad' de la
       // aritmética de fechas de RPG que asegura la precisión
       // de los resultados.
       //
       // Se quiere calcular los meses transcurridos entre el
       // 31-10-2013 y el 30-11-2013:
       //
       //   %diff( D'2013-11-30': D'2013-10-31': *MONTHS ) = 0
       //
       // El resultado debería ser '1 mes' pero el programa
       // devuelve '0 meses'. Este comportamiento es debido a que:
       //
       //   D'2013-10-31' + %months(1) = D'2013-11-30'
       //
       // y
       //
       //   D'2013-10-30' + %months(1) = D'2013-11-30'
       //
       // Curiosamente, de la suma de un mes a dos fechas distintas
       // se obtiene como resultado el mismo día.
       //
       // Sin embargo:
       //
       //   D'2013-11-30' - %months(1) = D'2013-10-30'
       //
       // El cálculo de las 'duraciones' se realiza en tres fases:
       //
       //   1.a. Se calcula el tiempo transcurrido en años.
       //   1.b. Se restan los años de la fecha mayor.
       //   2.a. Se calculan los meses transcurridos entre la nueva
       //        fecha y la menor.
       //   2.b. Se restan los meses de la fecha mayor.
       //   3.   Se calculan los días transcurridos entre la nueva
       //        fecha y la menor.
       //
       // El truco está en restar siempre el 'tiempo transcurrido'
       // de la fecha más alta (o reciente). Si se suma el cálculo
       // a la fecha más antigua, pueden producirse pérdidas de
       // días.


       if date1 > date2;
          higher_date = date1;
          lower_date = date2;
       else;
          higher_date = date2;
          lower_date = date1;
       endif;

       years = %diff(higher_date: lower_date: *YEARS);
       higher_date -= %years(years);
       months = %diff(higher_date: lower_date: *MONTHS);
       higher_date -= %months(months);
       weeks = %div(%diff(higher_date: lower_date: *DAYS): 7);
       days = %rem(%diff(higher_date: lower_date: *DAYS): 7);
       return;

     P r5_date_duration...
     P                 E


    /**
     *  El número de días que han transcurrido del año.
     *
     *  Es equivalente a los días julianos.
     */

     P r5_day_of_year  B                   export
     D                 PI                  like(r5_short_t)
     D   date                              like(r5_date_t) const

       return %diff(date: r5_begin_of_year(date): *DAYS) + 1;

     P r5_day_of_year  E



    /**
     *  El primer día del año de la fecha indicada.
     */

     P r5_begin_of_year...
     P                 B                   export
     D                 PI                  like(r5_date_t)
     D   date                              like(r5_date_t) const

       return %date(%editc(%subdt(date: *YEARS: 4): 'X') + '-01-01': *ISO);

     P r5_begin_of_year...
     P                 E


    /**
     *  El último día del año de la fecha indicada.
     */

     P r5_end_of_year...
     P                 B                   export
     D                 PI                  like(r5_date_t)
     D   date                              like(r5_date_t) const

       return %date(%editc(%subdt(date: *YEARS: 4): 'X') + '-12-31': *ISO);

     P r5_end_of_year...
     P                 E


    /**
     *  Comprueba si es bisiesto el año de la fecha indicada.
     */

     P r5_is_leap_year...
     P                 B                   export
     D                 PI                  like(r5_boolean_t)
     D   date                              like(r5_date_t) const

     D year            S                   like(r5_int_t)

       year = %subdt(date: *YEARS);

       if %rem(year: 100) = 0;
          return (%rem(year: 400) = 0);
       else;
          return (%rem(year: 4) = 0);
       endif;
       return *OFF;

     P r5_is_leap_year...
     P                 E


    /**
     *  El último día del mes de la fecha indicada.
     */

     P r5_end_of_month...
     P                 B                   export
     D                 PI                  like(r5_date_t)
     D   date                              like(r5_date_t) const

       return r5_begin_of_month(date) + %months(1) - %days(1);

     P r5_end_of_month...
     P                 E


    /**
     *  El primer día del mes de la fecha indicada.
     */

     P r5_begin_of_month...
     P                 B                   export
     D                 PI                  like(r5_date_t)
     D   date                              like(r5_date_t) const

       return date - %days(%subdt(date: *DAYS) - 1);

     P r5_begin_of_month...
     P                 E


    /**
     *  El número de trimestre de la fecha indicada.
     */

     P r5_quarter      B                   export
     D                 PI                  like(r5_small_t)
     D   date                              like(r5_date_t) const

       return %subdt(r5_end_of_quarter(date): *MONTHS) / 3;

     P r5_quarter      E


    /**
     *  El último día del trimestre de la fecha indicada.
     */

     P r5_end_of_quarter...
     P                 B                   export
     D                 PI                  like(r5_date_t)
     D   date                              like(r5_date_t) const

       return r5_begin_of_quarter(date) + %months(3) - %days(1);

     P r5_end_of_quarter...
     P                 E


    /**
     *  El primer día del trimestre de la fecha indicada.
     */

     P r5_begin_of_quarter...
     P                 B                   export
     D                 PI                  like(r5_date_t)
     D   date                              like(r5_date_t) const

       return r5_begin_of_month(date) -
              %months(%rem(%subdt(date: *MONTHS) - 1: 3));

     P r5_begin_of_quarter...
     P                 E

