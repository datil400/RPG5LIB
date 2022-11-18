**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5DATTIM
//  Module  : UXTIME
//
//  Unix time functions.
//
//  Author : Javier Mora
//  Date   : November 2022
//
//  Compiling : R5DATTIMI
//
//  Comments
//

ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('RPG5LIB');


/COPY RPG5LIB,r5excmgr_h
/COPY RPG5LIB,apierror_h
/COPY RPG5LIB,errno_h
/COPY RPG5LIB,uxtime_h


dcl-ds struct_tm align qualified template;
   tm_sec int(10);         // seconds after the minute (0-61)
   tm_min int(10);         // minutes after the hour (0-59)
   tm_hour int(10);        // hours since midnight (0-23)
   tm_mday int(10);        // day of the month (1-31)
   tm_mon int(10);         // months since January (0-11)
   tm_year int(10);        // years since 1900
   tm_wday int(10);        // days since Sunday (0-6)
   tm_yday int(10);        // days since January 1 (0-365)
   tm_isdst int(10);       // Daylight Saving Time flag
end-ds;


// UTC unix time in seconds

dcl-pr time like(r5_unix_time_t) extproc(*DCLCASE);
   unix_time like(r5_unix_time_t) options(*OMIT);
end-pr;

// Local time 'struct' tm to unix time in seconds (UTC)

dcl-pr mktime like(r5_unix_time_t) extproc(*DCLCASE);
   tm like(struct_tm);
end-pr;

// UTC unix time to local time 'struct tm'

dcl-pr localtime like(r5_pointer_t) extproc(*DCLCASE);
   unix_time like(r5_unix_time_t) const;
end-pr;

// UTC unix time to UTC 'struct tm'

dcl-pr gmtime like(r5_pointer_t) extproc(*DCLCASE);
   unix_time like(r5_unix_time_t) const;
end-pr;

// Converts UTC unix time to local time character string

dcl-pr ctime like(r5_pointer_t) extproc(*DCLCASE);
   unix_time like(r5_unix_time_t) const;
end-pr;

// Converts 'struct tm' to character string

dcl-pr asctime like(r5_pointer_t) extproc(*DCLCASE);
   time like(struct_tm) const;
end-pr;

// Parse string representation of date/time and converts it
// to 'strct tm'

dcl-pr strptime like(r5_pointer_t) extproc(*DCLCASE);
   buffer like(r5_pointer_t) options(*STRING: *TRIM) value;
   format like(r5_pointer_t) options(*STRING: *TRIM) value;
   tm likeds(struct_tm);
end-pr;

// Convert 'struct tm' date/time to string representation
// controlled by 'format'

dcl-pr strftime like(r5_size_t) extproc(*DCLCASE);
   buffer char(64) options(*VARSIZE);
   size like(r5_int_t) value;
   format like(r5_pointer_t) options(*STRING: *TRIM) value;
   tm likeds(struct_tm);
end-pr;


//  Convierte una marca de fecha y hora local del trabajo
//  en formato Unix UTC.
//
//  No se admiten fechas anteriores a 1970-01-01 (EPOCH).
//
//  Tampoco se maneja correctamente una misma fecha y hora
//  cuando se produce el cambio al/del horario de verano,
//  por ejemplo, en la zona CET de verano a invierno
//  (UTC+2 a UTC+1).

dcl-proc r5_timestamp_to_unix_time export;

   dcl-pi *N like(r5_unix_time_t);
      timestamp like(r5_time_stamp_t) const;
   end-pi;

   dcl-s unix_time like(r5_unix_time_t);
   dcl-s char_timestamp varchar(32);
   dcl-ds tm likeds(struct_tm);
   dcl-s exception like(r5_object_t);


   char_timestamp = %subst(%char(timestamp: *ISO): 1: 19);

   if strptime(char_timestamp: '%Y-%m-%d-%H.%M.%S': tm) = *NULL;
      exception = errno_to_exception(r5_errno());
      r5_throw(exception);
   endif;

   unix_time = mktime(tm);
   if unix_time = -1;
      // No se admiten fechas anteriores a 1970-01-01
      exception = errno_to_exception(r5_errno());
      r5_throw(exception);
   endif;

   return unix_time;
end-proc;


//  Convierte una marca de fecha y hora de Unix (UTC) al
//  timestamp de RPG.
//
//  No se admiten fechas anteriores a 1970-01-01 (EPOCH).

dcl-proc r5_unix_time_to_timestamp export;

   dcl-pi *N like(r5_time_stamp_t);
      unix_time like(r5_unix_time_t) const;
   end-pi;

   dcl-s timestamp like(r5_time_stamp_t);
   dcl-ds tm likeds(struct_tm) based(tm_ptr);
   dcl-s char_timestamp char(32);
   dcl-s exception like(r5_object_t);


   tm_ptr = localtime(unix_time);
   if strftime(char_timestamp: %size(char_timestamp): '%Y-%m-%d-%H.%M.%S.000000': tm) = 0;
      exception = errno_to_exception(r5_errno());
      r5_throw(exception);
   endif;

   timestamp = %timestamp(%str(%addr(char_timestamp)): *ISO);
   return timestamp;
end-proc;


dcl-proc r5_current_utc_unix_time export;

   dcl-pi *N like(r5_unix_time_t) end-pi;

   dcl-s unix_time like(r5_unix_time_t);
   dcl-s exception like(r5_object_t);

   unix_time = time(*OMIT);
   if unix_time = -1;
      exception = errno_to_exception(r5_errno());
      r5_throw(exception);
   endif;

   return unix_time;
end-proc;


// MOVER AL MÓDULO ERRNO EN R5UTILS

dcl-proc errno_to_exception;

   dcl-pi *N like(r5_object_t) extproc(*DCLCASE);
      errcode like(r5_int_t) const;
   end-pi;

   dcl-s ex like(r5_object_t);

   ex = r5_exception_new(errno_to_msg_id(errcode): 'QCPFMSG   *LIBL');

   return ex;
end-proc;


// MOVER AL MÓDULO ERRNO EN R5UTILS

dcl-proc errno_to_msg_id;

   dcl-pi *N like(r5_message_id_t) extproc(*DCLCASE);
      errcode like(r5_int_t) const;
   end-pi;

   dcl-s msg_id like(r5_message_id_t);
   dcl-s id varchar(4);


   id = %trim(%editc((errcode): 'Z'));
   msg_id = 'CPE' + %subst('0000' + id: %len(id) + 1: 4);

   return msg_id;
end-proc;

