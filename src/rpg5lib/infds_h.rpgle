**FREE

/IF DEFINED(R5_INFDS_H)
/EOF
/ENDIF
/DEFINE R5_INFDS_H

//  Package : RPG5LIB
//
//  INFDS_H
//
//  File information data structure
//
//  Sections:
//
//    File feedback (start = 1; length = 80)
//    Open feedback (start = 81; length = 160)
//    Input/Output feedback (start = 241; length = 126)
//    Device specific feedback (start = 367; length = variable)
//    Get attributes feedback
//
//  Febrero 2021
//
//  More info
//
//  https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_73/rzasd/filinda.htm
//  https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_73/dm/rbal3feedb.htm
//  https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_73/dm/rbal3fedbk.htm
//  https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_73/dm/rbal3ciofa.htm
//  https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_73/dm/rbal3ddiof.htm
//  https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_73/dm/rbal3pddio.htm
//  https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_73/dm/rbal3dbiof.htm
//  https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_73/dm/rbal3getat.htm


// Examples:
//
// /COPY RPG5LIB,INFDS_H
//
// dcl-f PRTFILE printer(132) infds(prt_fb);
// dcl-ds prt_fb likeds(r5_inf_ds_t) noopt;
//
// dcl-f DBFILE disk keyed infds(file_fb);
// dcl-ds file_fb likeds(r5_inf_ds_t) noopt;


// Use 'noopt' keyword for no optimize 'inf_ds_t' data structure

dcl-ds r5_inf_ds_t qualified template;

   // File feedback information

   file_name_8 char(8) pos(1);
   is_open char(1) pos(9);
   is_eof char(1) pos(10);
   status zoned(5: 0) pos(11);
   operation_code char(6) pos(16);
   routine_name_8 char(8) pos(22);
   source_line_or_statement_number char(8) pos(30);
   special_file_error zoned(5: 0) pos(38);
   record_name_8 char(8) pos(38);
   msg_id char(7) pos(46);
   // source_id

   // After POST
   screen_size zoned(4: 0) pos(67);   // rows x columns
   nls_input zoned(2: 0) pos(71);
   nls_output zoned(2: 0) pos(73);
   nls_mode zoned(2: 0) pos(75);

   // Open feedback information (start = 81)

   odp_type char(2) pos(81);
   file_name char(10) pos(83);
   library_name char(10) pos(93);
   spool_file_name char(10) pos(103);
   spool_file_library char(10) pos(113);
   //spool_file_number int(5) pos(123);  // Deprecated
   record_length int(5) pos(125);
   key_length int(5) pos(127);
   member char(10) pos(129);
   type int(5) pos(147);
   spool_file_number int(10) pos(160);
   ccsid int(5) pos(218);

   // I/O feedback information (start = 241)

   write_count uns(10) pos(243);
   read_count uns(10) pos(247);
   write_read_count uns(10) pos(251);
   other_count int(10) pos(255);
   operation char(1) pos(260);
   record_format char(10) pos(261);
   device_class char(2) pos(271);
   program_device_name char(10) pos(273);
   io_record_length int(10) pos(283);


   major_return_code char(2) pos(401);
   minor_return_code char(2) pos(403);

   // Display file open feedback, I/O feedback and device specific feedback

   rows int(5) pos(152);
   columns int(5) pos(154);

   display_flags char(2) pos(367);
   key char(1) pos(369);  // AID byte
   //cursor_location char(2) pos(370);
   cursor_location int(5) pos(370);    // row = cursor_location/256; col = remainder
   actual_data_len int(10) pos(372);
   sfl_rrn int(5) pos(376);
   sfl_lowest_rrn int(5) pos(378);     // NRR del primer registro mostrado
   sfl_num_records int(5) pos(380);
   window_cursor_location char(2) pos(382);     // x'0203' row 2 and col 3

   // Database open feedback and specific device feedback

   number_of_records int(10) pos(156);
   access_type char(2) pos(160);
   duplicate_key char(1) pos(162);     // D=duplicates; U=unique
   is_source_file char(1) pos(163);    // Y=source file

   feedback_size int(10) pos(367);
   jfile_bits int(10) pos(371);
   locked_records int(5) pos(377);
   // ...
   num_keys int(5) pos(387);
   db_key_length int(5) pos(393);
   member_number int(5) pos(395);
   db_rrn int(10) pos(397);       // Relative record number
   key_value char(2000) pos(401);

   // Printer file open feedback and specific device feedback

   overflow int(5) pos(188);
   current_line int(5) pos(367);
   current_page int(10) pos(369);
end-ds;

