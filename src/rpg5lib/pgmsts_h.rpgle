**FREE

/IF DEFINED(R5_PGMSTS_H)
/EOF
/ENDIF
/DEFINE R5_PGMSTS_H

//  Package : RPG5LIB
//
//  PGMSTS_H
//
//  Program status data structure (PSDS)
//
//  Febrero 2021
//
//  Use:
//
//  /COPY RPG5LIB,pgmsts_h

dcl-ds r5_pgmsts PSDS qualified noopt;
   module_or_program_name char(10) pos(1);
   status zoned(5: 0) pos(11);
   previous_status zoned(5: 0) pos(16);
   line_or_statement_number char(8) pos(21);
   routine char(8) pos(29);
   parms zoned(3: 0) pos(37);
   exeption_msg_id char(7) pos(40);
   message_area char(30) pos(51);      // Only for internal use by the ILE RPG compiler
   program_library char(10) pos(81);
   exception_data char(80) pos(91);
   rnx9001_exception_id char(4) pos(171);
   file_name char(10) pos(175);
   date_of_job_entry char(8) pos(191);
   century zoned(2: 0) pos(199);
   file_name_8 char(8) pos(201);
   file_status_info char(35) pos(209);
   job char(26) pos(244);              // Qualified job name
   job_name char(10) pos(244);
   job_user char(10) pos(254);
   job_number char(6) pos(264);
   job_number_dec zoned(6: 0) pos(264);
   run_start_date zoned(6: 0) pos(270);          // In UDATE format
   system_date zoned(6: 0) pos(276);             // In UDATE format
   system_time zoned(6: 0) pos(282);             // HHMMSS format
   program_compilation_date char(6) pos(288);    // In UDATE format
   program_compilation_time char(6) pos(294);    // HHMMSS format
   compiler_level char(4) pos(300);
   source_file_name char(10) pos(304);
   source_library_name char(10) pos(314);
   source_file_member char(10) pos(324);
   program_name char(10) pos(334);
   module_name char(10) pos(344);
   source_id int(5) pos(354);
   source_id_for_file_status int(5) pos(356);
   current_user_name char(10) pos(358);
   external_error_code int(10) pos(368);
/IF DEFINED(*V7R3M0)
   xml_elemenents int(20) pos(372);
   internal_job_id char(16) pos(380);            // Since 7.3 TR6
   system_name char(8) pos(396);                 // Since 7.3 TR6
/ENDIF
end-ds;
