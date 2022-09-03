**FREE

/IF DEFINED(R5_TYPES_H)
/EOF
/ENDIF
/DEFINE R5_TYPES_H

//  Package : RPG5LIB
//
//  TYPES_H
//
//  RPG5LIB data types
//
//  Mayo 2021
//
//  Use:
//
//  /COPY RPG5LIB,types_h


/COPY API,StdTyp_H

dcl-s r5_char_t char(1) template;
dcl-s r5_boolean_t ind template;
dcl-s r5_byte_t uns(3) template;
dcl-s r5_small_t int(3) template;
dcl-s r5_usmall_t uns(3) template;
dcl-s r5_short_t int(5) template;
dcl-s r5_ushort_t uns(5) template;
dcl-s r5_int_t int(10) template;
dcl-s r5_uint_t uns(10) template;
dcl-s r5_long_t int(20) template;
dcl-s r5_ulong_t uns(20) template;
dcl-s r5_float_t float(4) template;
dcl-s r5_double_t float(8) template;
dcl-s r5_date_t date template;
dcl-s r5_time_t time template;
dcl-s r5_time_stamp_t timestamp template;

dcl-s r5_small_varchar_t varchar(256) template;
dcl-s r5_short_varchar_t varchar(512) template;
dcl-s r5_varchar_t varchar(1024) template;
dcl-s r5_var_string_t varchar(1024) template;
dcl-s r5_string_t varchar(2048) template;

dcl-s r5_pointer_t pointer template;
dcl-s r5_proc_pointer_t pointer(*PROC) template;

dcl-s r5_packed_t packed(31: 9) template;
dcl-s r5_long_packed_t packed(63: 9) template;

dcl-s r5_object_t pointer template;
dcl-s r5_class_t pointer template;
dcl-s r5_size_t uns(10) template;

dcl-s r5_varname_t like(TypeVarName) template;
dcl-s r5_name_t like(TypeName) template;

dcl-ds r5_qualified_job_t qualified template;
   name like(r5_name_t);
   user like(r5_name_t);
   number  char(6);
end-ds;

dcl-s r5_message_id_t char(7) template;
dcl-ds r5_message_file_t likeds(TypeQualName) template;
dcl-s r5_message_data_t char(2048) template;
dcl-s r5_message_key_t char(4) template;

dcl-s r5_program_name_t varchar(10) template;
dcl-s r5_module_name_t varchar(10) template;
dcl-s r5_library_name_t varchar(10) template;
dcl-s r5_procedure_name_t varchar(256) template;
dcl-s r5_statement_t varchar(10) template;

dcl-ds r5_api_bytes_t qualified template;
   provided like(r5_int_t);
   available like(r5_int_t);
end-ds;
