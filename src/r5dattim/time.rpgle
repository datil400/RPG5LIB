      *
      *  Package : RPG5LIB
      *  SrvPgm  : R5DATTIM
      *  Module  : TIME
      *
      *  Time and timestamp functions collection.
      *
      *  Author : Javier Mora
      *  Date:
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

      /COPY RPG5LIB,dates_h
      /COPY RPG5LIB,time_h


     D EPOCH           C                   Z'1970-01-01-00.00.00'

     D VALID_TIME_SEPARATORS...
     D                 C                   ':.,&0'


    /**
     *  Convertir una hora a num�rico decimal.
     *
     *  Formato HHMMSS.
     */

     P r5_time_to_dec  B                   export
     D                 PI                  like(r5_dec_time_t)
     D   time                              like(r5_time_t) const

       return %dec(%char(time: *ISO0): 6: 0);

     P r5_time_to_dec  E


    /**
     *  Convertir un valor n�merico decimal en una hora.
     *
     *  Formato HHMMSS.
     */

     P r5_dec_to_time  B                   export
     D                 PI                  like(r5_time_t)
     D   dec_time                          like(r5_dec_time_t) const

       return %time(%editc(dec_time: 'X'): *ISO0);

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

       time = %time((hours*100 + minutes)*100 + seconds: *ISO);
       return time;

     P r5_make_time    E


    /**
     *  Extrae la fecha de una marca de fecha y hora y la convierte en un
     *  valor num�rico decimal.
     *
     *  'dec_format' define el formato de la fecha nm�rica resultante.
     *  Revisar la documentaci�n de la funci�n 'r5_dec_to_date'.
     *
     *    Formatos v�lidos:
     *      Y=A�o; M=Mes; D=D�a
     *    *DMY; *MDY; *YMD; *DMYY; *MDYY; *YYMD
     *    *ISO; *USA; *EUR
     *    DDMMYY; MMDDYY; YYMMDD; DDMMYYYY; MMDDYYYY; YYYYMMDD
     *
     *  Excepciones:
     *
     *  CEE2518  La especificaci�n de la serie de imagen no es v�lida.
     */

     P r5_timestamp_to_decdate...
     P                 B                   export
     D                 PI                  like(r5_dec_date_t)
     D   timestamp                         like(r5_time_stamp_t) const
     D   dec_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

       return r5_date_to_dec(%date(timestamp): dec_format);

     P r5_timestamp_to_decdate...
     P                 E


    /**
     *  Convierte una fecha en formato num�rico decimal en una marca
     *  de fecha y hora.
     *
     *  'dec_date' es la fecha en formato num�rico. Debe ser v�lida.
     *
     *  'dec_format' define el formato de la fecha 'dec_date'.
     *  Revisar la documentaci�n de la funci�n 'r5_dec_to_date'.
     *
     *    Formatos v�lidos:
     *      Y=A�o; M=Mes; D=D�a
     *    *DMY; *MDY; *YMD; *DMYY; *MDYY; *YYMD
     *    *ISO; *USA; *EUR
     *    DDMMYY; MMDDYY; YYMMDD; DDMMYYYY; MMDDYYYY; YYYYMMDD
     *
     *  Excepciones:
     *
     *  CEE2508  El valor del d�a no es v�lido.
     *  CEE2517  El valor del mes no es v�lido.
     *  CEE2521  El valor del a�o no es v�lido.
     *  CEE2518  La especificaci�n de la serie de imagen no es v�lida.
     */

     P r5_decdate_to_timestamp...
     P                 B                   export
     D                 PI                  like(r5_time_stamp_t)
     D   dec_date                          like(r5_dec_date_t) const
     D   dec_format                        like(r5_date_format_t) const
     D                                     options(*TRIM)

       return %timestamp(r5_dec_to_date(dec_date: dec_format));

     P r5_decdate_to_timestamp...
     P                 E


    /**
     *  Marca de fecha y hora actual con una precisi�n de microsegundos.
     *
     *  Nota: a partir de la versi�n 7.3 (PTF SI73190, SI73189) y la versi�n
     *  7.4 (PTF SI73192, SI73191, SI73193) la funci�n incorporada
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
      // Obtener la hora actual UTC. N�mero de segundos transcurridos
      // desde el 1 de enero de 1970 (EPOCH) y microsegundos desde
      // las 0 horas del d�a actual.

       CEEUTCO(hours: mins: secs: *OMIT);
       gettimeofday(%addr(tv): *NULL);
       micro_ts = EPOCH + %seconds(%int(secs))
                + %seconds(tv.tv_sec) + %mseconds(tv.tv_usec);
       return micro_ts;

     P r5_micro_timestamp...
     P                 E

