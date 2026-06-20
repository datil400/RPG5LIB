      *
      *  Package : RPG5LIB
      *  SrvPgm  : R5DATTIM
      *  Module  : TIME
      *
      *  Time and timestamp functions collection.
      *
      *  Author : datil400@gmail.com
      *  Date: October 2022
      *
      *  Compiling : R5DATTIMI
      *
      *  Comments
      *

     H nomain
     H option(*SRCSTMT: *NODEBUGIO)
     H bnddir('RPG5LIB')

      /COPY API,CEEDATE_H
      /COPY API,StdC_H

      /COPY RPG5LIB,excmgr_h
      /COPY RPG5LIB,dates_h
      /COPY RPG5LIB,time_h


     D EPOCH           C                   Z'1970-01-01-00.00.00'

     D VALID_TIME_SEPARATORS...
     D                 C                   ':.,&0'


    /**
     *  Convertir una hora a numérico decimal.
     *
     *  Formato HHMMSS.
     */

     P r5_time_to_dec  B                   export
     D                 PI                  like(r5_dec_time_t)
     D   time                              like(r5_time_t) const

       return %dec(%char(time: *ISO0): 6: 0);

     P r5_time_to_dec  E


    /**
     *  Convertir un valor númerico decimal en una hora.
     *
     *  Formato HHMMSS.
     */

     P r5_dec_to_time  B                   export
     D                 PI                  like(r5_time_t)
     D   dec_time                          like(r5_dec_time_t) const

     D time            S                   like(r5_time_t)

       monitor;
          time = %time(%editc(dec_time: 'X'): *ISO0);
       on-error;
          r5_resend_exception();
       endmon;
       return time;

     P r5_dec_to_time  E


    /**
     *  Construye una hora indicando las horas, minutos y segundos
     *  por separado.
     */

     P r5_make_time    B                   export
     D                 PI                  like(r5_time_t)
     D   hours                        2P 0 const
     D   o_minutes                    2P 0 options(*NOPASS) const
     D   o_seconds                    2P 0 options(*NOPASS) const

     D time            S                   like(r5_time_t)
     D minutes         S                   like(o_minutes) inz(0)
     D seconds         S                   like(o_seconds) inz(0)

       if %parms() >= %parmnum(o_minutes);
          minutes = o_minutes;
       endif;

       if %parms() >= %parmnum(o_seconds);
          seconds = o_seconds;
       endif;

       monitor;
          time = %time((hours*100 + minutes)*100 + seconds: *ISO);
       on-error;
          r5_resend_exception();
       endmon;
       return time;

     P r5_make_time    E


    /**
     *  Extrae la fecha de una marca de fecha y hora y la convierte en un
     *  valor numérico decimal.
     *
     *  'dec_format' define el formato de la fecha nmérica resultante.
     *  Revisar la documentación de la función 'r5_dec_to_date'.
     *
     *    Formatos válidos:
     *      Y=Año; M=Mes; D=Día
     *    *DMY; *MDY; *YMD; *DMYY; *MDYY; *YYMD
     *    *ISO; *USA; *EUR
     *    DDMMYY; MMDDYY; YYMMDD; DDMMYYYY; MMDDYYYY; YYYYMMDD
     *
     *  Excepciones:
     *
     *  CEE2518  La especificación de la serie de imagen no es válida.
     */

     P r5_timestamp_to_decdate...
     P                 B                   export
     D                 PI                  like(r5_dec_date_t)
     D   timestamp                         like(r5_time_stamp_t) const
     D   dec_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

     D dec_date        S                   like(r5_dec_date_t)

       monitor;
          dec_date = r5_date_to_dec(%date(timestamp): dec_format);
       on-error;
          r5_resend_exception();
       endmon;
       return dec_date;

     P r5_timestamp_to_decdate...
     P                 E


    /**
     *  Convierte una fecha en formato numérico decimal en una marca
     *  de fecha y hora.
     *
     *  'dec_date' es la fecha en formato numérico. Debe ser válida.
     *
     *  'dec_format' define el formato de la fecha 'dec_date'.
     *  Revisar la documentación de la función 'r5_dec_to_date'.
     *
     *    Formatos válidos:
     *      Y=Año; M=Mes; D=Día
     *    *DMY; *MDY; *YMD; *DMYY; *MDYY; *YYMD
     *    *ISO; *USA; *EUR
     *    DDMMYY; MMDDYY; YYMMDD; DDMMYYYY; MMDDYYYY; YYYYMMDD
     *
     *  Excepciones:
     *
     *  CEE2508  El valor del día no es válido.
     *  CEE2517  El valor del mes no es válido.
     *  CEE2521  El valor del año no es válido.
     *  CEE2518  La especificación de la serie de imagen no es válida.
     */

     P r5_decdate_to_timestamp...
     P                 B                   export
     D                 PI                  like(r5_time_stamp_t)
     D   dec_date                          like(r5_dec_date_t) const
     D   dec_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

     D time_stamp      S                   like(r5_time_stamp_t)

       monitor;
          time_stamp = %timestamp(r5_dec_to_date(dec_date: dec_format));
       on-error;
          r5_resend_exception();
       endmon;
       return time_stamp;

     P r5_decdate_to_timestamp...
     P                 E


    /**
     *  Convierte una marca de fecha y hora en una cadena de caracteres.
     *
     *  'char_format' define el formato de la marca de fecha y hora
     *  resultante.
     *
     *    Formatos válidos:
     *       Y=Año; M=Mes; D=Día
     *       HH=Horas; MI=Minutos; SS=Segundos; 999=Milésimas
     *
     *       Cualquier combinación válida según CEESECS. Más información
     *       en:
     *
     *       https://www.ibm.com/docs/en/i/7.6.0?topic=ssw_ibm_i_76/apis/CEEDAYS.html#TBLPICXMP
     *
     * -- NO IMPLEMENTADO --
     *    Los siguientes formatos incluirán separadores por defecto:
     *     *ISO equivale a YYYY-MM-DD-HH.MI.SS.999
     * -- FIN NO IMPLEMENTADO --
     *
     *  Al utilizar las APIs CEE de fecha y hora, la precisión máxima
     *  será de milisegundos.
     *
     *  Excepciones:
     *
     *  CEE2518  La especificación de la serie de imagen no es válida.
     */

     P r5_timestamp_to_char...
     P                 B                   export
     D                 PI                  like(r5_char_timestamp_t)
     D   timestamp                         like(r5_time_stamp_t) const
     D   char_format                       like(r5_timestamp_format_t) const
     D                                     options(*TRIM)

     D result          S                   like(r5_char_timestamp_t)
     D IN_FORMAT       C                   'YYYY-MM-DD-HH.MI.SS.999'

       monitor;
          result = convert_char_time(%char(timestamp): IN_FORMAT: char_format);
       on-error;
          r5_resend_exception();
       endmon;
       return result;

     P r5_timestamp_to_char...
     P                 E


    /**
     *  Convierte una cadena de caracteres que representa una marca de
     *  fecha y hora en el tipo de dato nativo de RPG.
     *
     *  'char_ts' es la cadena de caracteres con la marca de fecha y
     *   hora. Debe ser válida.
     *
     *  'char_format' define el formato de 'char_ts'.
     *
     *    Formatos válidos:
     *       Y=Año; M=Mes; D=Día
     *       HH=Horas; MI=Minutos; SS=Segundos; 999=Milésimas
     *
     *       Cualquier combinación válida según CEESECS. Más información
     *       en:
     *
     *       https://www.ibm.com/docs/en/i/7.6.0?topic=ssw_ibm_i_76/apis/CEEDAYS.html#TBLPICXMP
     *
     * -- NO IMPLEMENTADO --
     *    Los siguientes formatos incluirán separadores por defecto:
     *     *ISO equivale a YYYY-MM-DD-HH.MI.SS.999
     * -- FIN NO IMPLEMENTADO --
     *
     *  Al utilizar las APIs CEE de fecha y hora, la precisión máxima
     *  será de milisegundos.
     *
     *  Excepciones:
     *
     *  CEE2508  El valor del día no es válido.
     *  CEE2517  El valor del mes no es válido.
     *  CEE2521  El valor del año no es válido.
     *  CEE2518  La especificación de la serie de imagen no es válida.
     */

     P r5_char_to_timestamp...
     P                 B                   export
     D                 PI                  like(r5_time_stamp_t)
     D   char_ts                           like(r5_long_char_timestamp_t) const
     D                                     options(*TRIM)
     D   char_format                       like(r5_timestamp_format_t) const
     D                                     options(*TRIM)

     D result          S               Z
     D OUT_FORMAT      C                   'YYYY-MM-DD-HH.MI.SS.999'

       monitor;
          result = %timestamp( convert_char_time( char_ts: char_format
                                                : OUT_FORMAT)
                             : *ISO: 3
                             );
       on-error;
          r5_resend_exception();
       endmon;
       return result;

     P r5_char_to_timestamp...
     P                 E


    /**
     *  Convierte el formato de una marca de fecha y hora almacenada
     *  en un campo alfanumérico.
     *
     *  'char_ts' es la cadena que se quiere transformar a otro
     *  formato. Debe ser una marca de fecha y hora válida.
     *
     *  'char_format' define el formato CEE de la marca de fecha y hora
     *   a convertir.
     *
     *     ACTUALMENTE NO ESTÁ IMPLEMENTADO EL USO DE LA MÁSCARA '*ISO'.
     *
     *  'out_format' define el formato CEE de la marca de fecha y hora
     *  resultante de la conversión.
     */

     P convert_char_time...
     P                 B
     D                 PI                  like(r5_long_char_timestamp_t)
     D   char_ts                           like(r5_long_char_timestamp_t) const
     D                                     options(*TRIM)
     D   char_format                       like(r5_timestamp_format_t) const
     D                                     options(*TRIM)
     D   out_format                        like(r5_timestamp_format_t) const
     D                                     options(*TRIM)

     D result          S            128A
     D seconds         S                   like(r5_double_t)
     D exception       S                   like(r5_object_t)

       if char_format = '' or out_format = '';
          exception = r5_exception_new('CEE2518': 'QCEEMSG');
          r5_throw(exception);
       endif;

       monitor;
          CEESECS(char_ts: char_format: seconds: *OMIT);
          CEEDATM(seconds: out_format: result: *OMIT);
       on-error;
          r5_catch();
          r5_throw();
       endmon;
       return %trim(result);


     P convert_char_time...
     P                 E


    /**
     *  Marca de fecha y hora actual con una precisión de microsegundos.
     *
     *  Nota: a partir de la versión 7.3 (PTF SI73190, SI73189) y la versión
     *  7.4 (PTF SI73192, SI73191, SI73193) la función incorporada
     *  %timestamp() ya incorpora esta funcionalidad.
     *
     *  https://www.ibm.com/support/pages/rpg-cafe-microseconds-timestamp
     */

     P r5_micro_timestamp...
     P                 B                   export
     D                 PI                  like(r5_time_stamp_t)

     D micro_ts        S                   like(r5_time_stamp_t)
     D hours           S             10I 0
     D mins            S             10I 0
     D secs            S              8F
     D tv              DS                  likeds(timeval)

      // Obtener el desplazamiento del horario local respecto UTC en
      // segundos.
      // Obtener la hora actual UTC. Número de segundos transcurridos
      // desde el 1 de enero de 1970 (EPOCH) y microsegundos desde
      // las 0 horas del día actual.

       CEEUTCO(hours: mins: secs: *OMIT);
       gettimeofday(%addr(tv): *NULL);
       micro_ts = EPOCH + %seconds(%int(secs))
                + %seconds(tv.tv_sec) + %mseconds(tv.tv_usec);
       return micro_ts;

     P r5_micro_timestamp...
     P                 E

