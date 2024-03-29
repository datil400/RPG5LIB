     /**
      * This file is part of i5/OS Programmer's Toolkit.
      *
      * Copyright (C) 2010, 2011  Junlei Li.
      *
      * i5/OS Programmer's Toolkit is free software: you can redistribute it and/or modify
      * it under the terms of the GNU General Public License as published by
      * the Free Software Foundation, either version 3 of the License, or
      * (at your option) any later version.
      *
      * i5/OS Programmer's Toolkit is distributed in the hope that it will be useful,
      * but WITHOUT ANY WARRANTY; without even the implied warranty of
      * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      * GNU General Public License for more details.
      *
      * You should have received a copy of the GNU General Public License
      * along with i5/OS Programmer's Toolkit.  If not, see <http://www.gnu.org/licenses/>.
      */

     /**
      * @file mih52.rpgleinc
      *
      * Header of system builtins for ILE RPG provided by the
      * open-source project i5/OS Programmer's Toolkit.
      * For details please refer to the project's web site,
      * http://i5toolkit.sourceforge.net/
      *
      * @attention This header is for i5/OS Release 5 Version 2.
      * @attention Will be replaced by a symbolic link to mih.rpgleinc
      */

      /if not defined(i5toolkit_rpg_mih52)
      /define i5toolkit_rpg_mih52

     /* computation instructions */

     /**
      * @BIF _CMPSWP1 (Compare and Swap (CMPSW))
      */
     d cmpswp1         pr            10i 0 extproc('_CMPSWP1')
     d     cmp_op1                    1a
     d     cmp_op2                    1a
     d     swap_op                    1a   value
      * Perform storage synchronization or not
      *  0 = (Default) Storage synchronization is performed both
      *      before and after a successful store of the swap operand.
      *  1 = No storage synchronization is performed.
     d     cntl                      10i 0 options(*nopass)
     d                                     value

     /**
      * @BIF _CMPSWP2 (Compare and Swap (CMPSWP))
      */
     d cmpswp2         pr            10i 0 extproc('_CMPSWP2')
     d     cmp_op1                    2a
     d     cmp_op2                    2a
     d     swap_op                    2a   value
     d     cntl                      10i 0 options(*nopass)
     d                                     value

     /**
      * @BIF _CMPSWP4 (Compare and Swap (CMPSWP))
      */
     d cmpswp4         pr            10i 0 extproc('_CMPSWP4')
     d     cmp_op1                    4a
     d     cmp_op2                    4a
     d     swap_op                    4a   value
     d     cntl                      10i 0 options(*nopass)
     d                                     value

     /**
      * @BIF _CMPSWP8 (Compare and Swap (CMPSWP))
      */
     d cmpswp8         pr            10i 0 extproc('_CMPSWP8')
     d     cmp_op1                    8a
     d     cmp_op2                    8a
     d     swap_op                    8a   value
     d     cntl                      10i 0 options(*nopass)
     d                                     value

     /**
      * CPRDATA template
      */
     d cprdata_tmpl_t  ds                  qualified
     d                                     based(dummy_ptr)
     d     source_len                10i 0
     d     target_len                10i 0
     d     returned_target_len...
     d                               10i 0
     d     algorithm                  5i 0
     d                               18a
     d     source                      *
     d     target                      *

     /* length of cprdata_tmpl_t */
     d CPRDATA_TMPL_LENGTH...
     d                 c                   64

     /**
      * @BIF _CPRDATA (Compress Data (CPRDATA))
      */
     d cprdata         pr                  extproc('_CPRDATA')
     d    tmpl                         *   value

     /* DCPDATA template */
     d dcpdata_tmpl_t  ds                  qualified
     d                                     based(dummy_ptr)
     d                                4a
     d     result_len                10i 0
     d     returned_result_len...
     d                               10i 0
     d                               20a
     d     source                      *
     d     target                      *

     /* length of dcpdata_tmpl_t */
     d DCPDATA_TMPL_LENGTH...
     d                 c                   64

     /**
      * @BIF _DCPDATA (Decompress Data (DCPDATA))
      */
     d dcpdata         pr                  extproc('_DCPDATA')
     d    tmpl                         *   value

     /**
      * @BIF _TSTBTS (Test Bit in String (TSTBTS))
      *
      * @return 1 if bit is set, otherwise 0.
      */
     d tstbts          pr            10i 0 extproc('_TSTBTS')
     d     str                         *   value
     d     offset                    10u 0 value

     /**
      * @BIF _CLRBTS (Clear Bit in String (CLRBTS))
      */
     d clrbts          pr                  extproc('_CLRBTS')
     d     str                         *   value
     d     offset                    10u 0 value

     /**
      * @BIF _SETBTS (Set Bit in String (SETBTS))
      */
     d setbts          pr                  extproc('_SETBTS')
     d     str                         *   value
     d     offset                    10u 0 value

     /**
      * @BIF _CVTEFN (Convert External Form to Numeric Value (CVTEFN))
      */
     d cvtefn          pr                  extproc('_CVTEFN')
     d     receiver                    *   value
     d     rcv_attr                   7a
     d     source                      *   value
     d     src_length                10u 0
     d     mask                       3a

     /* data structure used as CPYECLAP's operand 3 */
     d cpyeclap_pad_t  ds                  qualified
     d     single_byte_pad_value...
     d                                1a
     d     double_byte_pad_value...
     d                                2a

     /**
      * @BIF _CPYECLAP (Copy Extended Characters Left-Adjusted With Pad (CPYECLAP))
      */
     d cpyeclap        pr                  extproc('_CPYECLAP')
     d     receiver                    *
     d     source                      *
     d     pad                             likeds(cpyeclap_pad_t)

     /**
      * @BIF _LBCPYNV (Copy Numeric Value (CPYNV))
      */
     d lbcpynv         pr                  extproc('_LBCPYNV')
     d     receiver                    *   value
     d     receiver_attr...
     d                                7a
     d     source                      *   value
     d     source_attr...
     d                                7a

     /**
      * @BIF _LBCPYNVR (Copy Numeric Value (CPYNV))
      *
      * @remark _LBCPYNVR copy numeric value and round the result half adjusted.
      */
     d lbcpynvr        pr                  extproc('_LBCPYNVR')
     d     receiver                    *   value
     d     receiver_attr...
     d                                7a
     d     source                      *   value
     d     source_attr...
     d                                7a

     /* end -- computation instructions */

     /* bound program calculation builtins */

     /**
      * @BIF _ACOS (Arc Cosine (ACOS))
      */
     d acos            pr             8f   extproc('_ACOS')
     d     x                          8f   value

     /**
      * @BIF _ANDCSTR (And Complemented String (ANDCSTR))
      */
     d andcstr         pr                  extproc('_ANDCSTR')
     d     receiver                   1a   options(*varsize)
     d     str1                       1a   options(*varsize)
     d     str2                       1a   options(*varsize)
     d     length                    10u 0 value

     /**
      * @BIF _ANDCSTR (AND String (ANDSTR))
      */
     d andstr          pr                  extproc('_ANDSTR')
     d     receiver                   1a   options(*varsize)
     d     str1                       1a   options(*varsize)
     d     str2                       1a   options(*varsize)
     d     length                    10u 0 value

     /**
      * @BIF _ASIN (Arc Sine (ASIN))
      */
     d asin            pr             8f   extproc('_ASIN')
     d     x                          8f   value

     /**
      * @BIF _ATAN (Arc Tangent (ATAN))
      */
     d atan            pr             8f   extproc('_ATAN')
     d     x                          8f   value

     /**
      * @BIF _ATANH (Arc Tangent Hyperbolic (ATANH))
      */
     d atanh           pr             8f   extproc('_ATANH')
     d     x                          8f   value

     /**
      * @BIF _STRLENNULL (Compute Length of Null-Terminated String (STRLENNULL))
      */
     d strlennull      pr            10u 0 extproc('__strlen')
     d     str                        1a   options(*varsize)

     /**
      * @BIF _STRCMPNULL (Compare Null-Terminated Strings (STRCMPNULL))
      */
     d strcmpnull      pr            10i 0 extproc('__strcmp')
     d     str1                       1a   options(*varsize)
     d     str2                       1a   options(*varsize)

     /**
      * @BIF _STRNCMPNULL (Compare Null-Terminated Strings Constrained (SRNCMPNULL))
      */
     d strncmpnull     pr            10i 0 extproc('_STRNCMPNULL')
     d     str1                       1a   options(*varsize)
     d     str2                       1a   options(*varsize)
     d     length                    10u 0 value

     /**
      * @BIF _CMPTOPAD (Compare To Pad (CMPTOPAD))
      */
     d cmptopad        pr            10i 0 extproc('_CMPTOPAD')
     d     str                        1a   options(*varsize)
     d     pad                        1a   value
     d     length                    10u 0 value

     /**
      * @BIF _COMSTR (Complement String (COMSTR))
      */
     d comstr          pr                  extproc('_COMSTR')
     d     receiver                   1a   options(*varsize)
     d     source                     1a   options(*varsize)
     d     length                    10u 0 value

     /**
      * @BIF _COS (Cosine (COS))
      */
     d cos             pr             8f   extproc('_COS')
     d     x                          8f   value

     /**
      * @BIF _COSH (Cosine Hyperbolic (COSH))
      */
     d cosh            pr             8f   extproc('_COSH')
     d     x                          8f   value

     /**
      * @BIF _COT (Cotangent (COT))
      */
     d cot             pr             8f   extproc('_COT')
     d     x                          8f   value

     /**
      * @BIF _CPYBYTES (Copy Bytes (CPYBYTES))
      */
     d cpybytes        pr                  extproc('_CPYBYTES')
     d     target                      *   value
     d     source                      *   value
     d     length                    10u 0 value

     /**
      * @BIF _CPYBO (Copy Bytes Overlapping (CPYBO))
      */
     d cpybo           pr                  extproc('_CPYBO')
     d     target                      *   value
     d     source                      *   value
     d     length                    10u 0 value

     /**
      * @BIF _STRCPYNULL (Copy Null-Terminated String (STRCPYNULL))
      */
     d strcpynull      pr              *   extproc('__strcpy')
     d     target                     1a   options(*varsize)
     d     source                     1a   options(*varsize)

     /**
      * @BIF _STRNCPYNULL (Copy Null-Terminated String Constrained (STRNCPYNULL))
      */
     d strncpynull     pr              *   extproc('_STRNCPYNULL')
     d     target                     1a   options(*varsize)
     d     source                     1a   options(*varsize)
     d     length                    10u 0 value

     /**
      * @BIF _STRNCPYNULLPAD (Copy Null-Terminated String Constrained, Null Padded (STRNCPYNULLPAD))
      */
     d strncpynullpad  pr              *   extproc('_STRNCPYNULLPAD')
     d     target                     1a   options(*varsize)
     d     source                     1a   options(*varsize)
     d     length                    10u 0 value

     /**
      * @BIF _EEXP (Exponential Function of E (EEXP))
      */
     d exp             pr             8f   extproc('_EEXP')
     d     x                          8f   value

     /**
      * @BIF _FINDBYTE (Find Byte (FINDBYTE))
      */
     d findbyte        pr              *   extproc('_FINDBYTE')
     d     source                      *   value
     d     to_search                  1a   value

     /**
      * @BIF _MEMCHR (Find Character Constrained (MEMCHR))
      */
     d memchr          pr              *   extproc('_MEMCHR')
     d     source                      *   value
     d     to_search                  1a   value
     d     length                    10u 0 value

     /**
      * @BIF _STRCHRNULL (Find Character in Null-Terminated String (STRCHRNULL))
      */
     d strchrnull      pr              *   extproc('_STRCHRNULL')
     d     source                      *   value
     d     to_search                  1a   value

     /**
      * @BIF _LN (Logarithm Base E (Natural Logarithm) (LN))
      */
     d log             pr             8f   extproc('_LN')
     d     x                          8f   value

     /**
      * @BIF _MEMCMP (Memory Compare (MEMCMP))
      */
     d memcmp          pr            10i 0 extproc('__memcmp')
     d     addr1                       *   value
     d     addr2                       *   value
     d     length                    10u 0 value

     /**
      * @BIF _MEMCPY (Memory Copy (MEMCPY))
      */
     d memcpy          pr              *   extproc('__memcpy')
     d     target                      *   value
     d     source                      *   value
     d     length                    10u 0 value

     /**
      * @BIF _MEMMOVE (Memory Move (MEMMOVE))
      */
     d memmove         pr              *   extproc('_MEMMOVE')
     d     target                      *   value
     d     source                      *   value
     d     length                    10u 0 value

     /**
      * @BIF _ORSTR (OR String (ORSTR))
      */
     d orstr           pr                  extproc('_ORSTR')
     d     receiver                   1a   options(*varsize)
     d     str1                       1a   options(*varsize)
     d     str2                       1a   options(*varsize)
     d     length                    10u 0 value

     /**
      * @BIF _POWER (X To The Y Power (POWER))
      */
     d power           pr             8f   extproc('_POWER')
     d     x                          8f   value
     d     x                          8f   value

     /**
      * @BIF _PROPB (Propagate Byte (PROPB))
      */
     d propb           pr              *   extproc('__memset')
     d     target                      *   value
     d     src_byte                   1a   value
     d     length                    10u 0 value

     /**
      * @BIF _RETCA (Retrieve Computational Attributes (RETCA))
      *
      * @remark the selector operand can be either a ubin(4) or an
      *         char(1). Note that only the rightmost byte of it is used.
      */
     d retca           pr            10u 0 extproc('_RETCA')
     d     selector                   1a   value

     /**
      * @BIF _SETCA (Set Computational Attributes (SETCA))
      */
     d setca           pr                  extproc('_SETCA')
     d     new_ca                    10u 0 value
     d     selector                   1a   value

     /**
      * @BIF _SCANX (Scan Extended (SCANX))
      */
     d scanx           pr            10i 0 extproc('_SCANX')
     d     base_...
     d       locator                   *
     d     controls                    *   value
     d     options                    4a   value

     /**
      * @BIF _SIN (Sine (SIN))
      */
     d sin             pr             8f   extproc('_SIN')
     d     x                          8f   value

     /**
      * @BIF _SINH (Sine Hyperbolic (SINH))
      */
     d sinh            pr             8f   extproc('_SINH')
     d     x                          8f   value

     /**
      * @BIF _TAN (Tangent (TAN))
      */
     d tan             pr             8f   extproc('_TAN')
     d     x                          8f   value

     /**
      * @BIF _TANH (Tangent Hyperbolic (TANH))
      */
     d tanh            pr             8f   extproc('_TANH')
     d     x                          8f   value

     /**
      * @BIF _TESTRPL (Test and Replace Bytes (TESTRPL))
      */
     d testrpl         pr                  extproc('_TESTRPL')
     d     source                      *   value
     d     src_len                   10u 0 value
     d     cmp_str                     *   value
     d     rpl_str                     *   value
     d     other_len                 10u 0 value

     /**
      * @BIF _TESTSUBSET (Test Subset (TESTSUBSET))
      */
     d testsubset      pr            10u 0 extproc('_TESTSUBSET')
     d     src1                        *   value
     d     src2                        *   value
     d     length                    10u 0 value

     /**
      * @BIF _XLATEB (Translate Bytes (XLATEB))
      */
     d xlateb          pr                  extproc('_XLATEB')
     d     source                      *   value
     d     table                       *   value
     d     length                    10u 0 value

     /**
      * @BIF _XLATEB1 (Translate Bytes One Byte at a Time (XLATEB1))
      */
     d xlateb1         pr                  extproc('_XLATEB1')
     d     receiver                    *   value
     d     source                      *   value
     d     table                       *   value
     d     length                    10u 0 value

     /**
      * @BIF _XORSTR (XOR (Exclusive Or) String (XORSTR))
      */
     d xorstr          pr                  extproc('_XORSTR')
     d     receiver                   1a   options(*varsize)
     d     str1                       1a   options(*varsize)
     d     str2                       1a   options(*varsize)
     d     length                    10u 0 value

     /* end -- bound program calculation builtins */

     /* date/time/timestamp */

     /* SAA DDAT without era table and calenday table */
     d saa_ddat1_t     ds            36    qualified
     d                                     based(dummy_ptr)
     d                                5u 0
     d     fmt_code                   5u 0
     d     date_sep                   1a
     d     time_sep                   1a
      * timezone definitions
     d     hour_time_zone...
     d                                5u 0
     d     minute_time_zone...
     d                                5u 0
      * duration definitions
     d     month_def                  5u 0
     d     year_def                   5u 0
      * century definitions
     d     current_century...
     d                               10u 0
     d     century_division...
     d                               10u 0
     d     calendar_table_offset...
     d                               10u 0
     d                                6a
     d saa_ddat1_len   c                   36

     /* SAA DDAT with era table and calenday table */
     d saa_ddat2_t     ds           116    qualified
     d                                     based(dummy_ptr)
     d                                5u 0
     d     fmt_code                   5u 0
     d     date_sep                   1a
     d     time_sep                   1a
      * timezone definitions
     d     hour_time_zone...
     d                                5u 0
     d     minute_time_zone...
     d                                5u 0
      * duration definitions
     d     month_def                  5u 0
     d     year_def                   5u 0
      * century definitions
     d     current_century...
     d                               10u 0
     d     century_division...
     d                               10u 0
     d     calendar_table_offset...
     d                               10u 0
     d                                6a
      * era table. SAA DDAT has only one era table
     d     era_table_elements...
     d                                5u 0
     d     era_origin_date...
     d                               10u 0
     d     era_name...
     d                               32a
     d                               12a
      * calendar table
     d     calendar_table_elements...
     d                                5u 0
     d     gregorian_effective_date...
     d                               10u 0
     d     gregorain_calendar_type...
     d                                5u 0
     d                               10a
     d     null_effective_date...
     d                               10u 0
     d     null_calendar_type...
     d                                5u 0
     d                               10a
     d saa_ddat2_len   c                   116
     d saa_ddat2_caltbl_offset...
     d                 c                   82
     d saa_origine_date...
     d                 c                   1721426
     d saa_era_name    c                   'AD, anno Domini'
     d gregorian_end_date...
     d                 c                   5373485
     d null_calendar_type...
     d                 c                   x'0000'
     d gregorian_calendar_type...
     d                 c                   x'0001'
     d julian_calendar_type...
     d                 c                   x'0002'

     /*
      * compute-duration instruction template for
      * instruction CDD, CTD, and CTSD.
      */
     d dt_compute_duration_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     tmpl_size                 10u 0
     d     op1_ddat_index...
     d                                5u 0
     d     op2_ddat_index...
     d                                5u 0
     d     op3_ddat_index...
     d                                5u 0
     d                                2a
     d     op2_length                 5u 0
     d     op3_length                 5u 0
     d                               26a
      * DDAT list
     d     ddat_list_len...
     d                               10u 0
     d     ddats                      5u 0
     d                               10a
      * DDAT offsets of type ubin(4)
     d     ddat_offsets...
     d                               10u 0 dim(256)
      * DDATs
     d datetime_ddat_list_offset...
     d                 c                   42

     /**
      * @BIF _CDD (Compute Date Duration (CDD))
      */
     d cdd             pr                  extproc('_CDD')
      * address of a pkd(8,0) scalar
     d     date_duration...
     d                                 *   value
      * address of end-date
     d     date1                       *   value
      * address of begin-date
     d     date2                       *   value
      * instruction template
     d     inst_tmpl                       likeds(
     d                                       dt_compute_duration_tmpl_t)

     /**
      * @BIF _CTD (Compute Time Duration (CTD))
      */
     d ctd             pr                  extproc('_CTD')
      * address of a pkd(8,0) scalar
     d     time_duration...
     d                                 *   value
      * address of end-time
     d     time1                       *   value
      * address of begin-time
     d     time2                       *   value
      * instruction template
     d     inst_tmpl                       likeds(
     d                                       dt_compute_duration_tmpl_t)

     /* materialization template of UTC TOD clock for MATTODAT */
     d mattodat_utc_clock_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d                                8a
     d     time_of_day...
     d                                8a
     d     timezone_offset...
     d                               10i 0
     d                                4a
     d mattodat_utc_clock_len...
     d                 c                   32

     /* end -- date/time/timestamp */

     /* pointer resolution */

     /**
      * @BIF _CMPPTRA (Compare Pointer for Object Addressability (CMPPTRA))
      */
     d cmpptra         pr            10i 0 extproc('_CMPPTRA')
     d     ptr_op1                     *   value
     d     ptr_op2                     *   value

     /**
      * @BIF _CMPPTRA (Compare Pointer for Object Addressability (CMPPTRA))
      *
      * @remark When @var ptr_op1 and @var ptr_op2 are pointers other
      *         than space pointers, use this prototype instead of
      *         cmpptra(). When pointer data objects other than space
      *         poniters are passed by value, the RPG compiler does
      *         NOT passed them correctly. The same compromise is used
      *         on the CMPPTRT, SETSPFP, TESTPTR
      */
     d rpg_cmpptra     pr            10i 0 extproc('_CMPPTRA')
     d     ptr_op1                     *   value procptr
     d     ptr_op2                     *   value procptr

     /**
      * @BIF _CMPPTRT (Compare Pointer Type (CMPPTRT))
      *
      * @remark Use this prototype when @var ptr is a space pointer.
      */
     d cmpptrt         pr            10i 0 extproc('_CMPPTRT')
     d     ptr_type                   1a   value
     d     ptr                         *   value

     /**
      * @BIF _CMPPTRT (Compare Pointer Type (CMPPTRT))
      *
      * @remark Use this prototype when @var ptr is NOT a space pointer!
      */
     d rpg_cmpptrt     pr            10i 0 extproc('_CMPPTRT')
     d     ptr_type                   1a   value
     d     ptr                         *   value procptr

     /**
      * @BIF _CPYBWP (Copy Bytes with Pointers (CPYBWP))
      */
     d cpybwp          pr                  extproc('_CPYBWP')
     d     receiver                    *   value
     d     source                      *   value
     d     length                    10u 0 value

     /* Materialization template for MATPTR */
     d matptr_tmpl_t   ds                  qualified
     d     bytes_in                  10i 0                                      bytes provided
     d     bytes_out                 10i 0                                      bytes available
     d     ptr_type                   1a                                        returned pointer typ

     /* length of SYSPTR information */
     d matptr_sysptr_info_length...
     d                 c                   80

     /* Materialization template for MATPTR when materializing a SYSPTR */
     d matptr_sysptr_info_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0                                      bytes provided
     d     bytes_out                 10i 0                                      bytes available
     d     ptr_type                   1a                                        returned pointer typ
     d     ctx_type                   2a                                        context type
     d     ctx_name                  30a                                        context name
     d     obj_type                   2a                                        object type
     d     obj_name                  30a                                        object name
     d     ptr_auth                   2a                                        PTR authorization
     d     ptr_target                 2a                                        PTR target info

     /* length of SPCPTR information */
     d matptr_spcptr_info_length...
     d                 c                   96

     /* SPCPTR info structure */
     d matptr_spcptr_info_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0                                      bytes provided
     d     bytes_out                 10i 0                                      bytes available
     d     ptr_type                   1a                                        returned pointer typ
     d     ctx_type                   2a                                        context type
     d     ctx_name                  30a                                        context name
     d     obj_type                   2a                                        object type
     d     obj_name                  30a                                        object name
     d     offset                    10i 0                                      offset into space
     d     ptr_target                 2a                                        PTR target info
     d                                1a                                        reserved
     d     ext_offset                 8a                                        teraspace offest

     d matptr_dtaptr_info_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0                                      bytes provided
     d     bytes_out                 10i 0                                      bytes available
     d     ptr_type                   1a                                        returned pointer typ
     d     dta_type                   1a                                        scalar type
     d     dta_length                 5u 0                                      scalar length
     d                                4a                                        reserved
     d     ctx_type                   2a
     d     ctx_name                  30a
     d     obj_type                   2a
     d     obj_name                  30a
     d     offset                    10i 0
     /* DTAPTR attributes */
     d matptr_dtaptr_info_length...
     d                 c                   84

     /* PROCPTR info structure */
     d matptr_procptr_info_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0                                      bytes provided
     d     bytes_out                 10i 0                                      bytes available
     d     ptr_type                   1a                                        returned pointer typ
     d     ptr_status                 1a                                        pointer status
     d                                6a                                        reserved
     d     mod_num                   10u 0                                      module number
     d     proc_num                  10u 0                                      procedure number
     d     act_mark                  10u 0                                      activation mark
     d     ag_mark                   10u 0                                      activation group mar
     d     pgm                         *                                        containing program
     d     process                     *                                        containing process
     d     act_mark2                  8a                                        8-bytes activation m
     d     ag_mark2                   8a                                        8-bytes activation g
     /* length of PROCPTR information */
     d matptr_procptr_info_length...
     d                 c                   80

     /* label pointer attributes */
     d matptr_lblptr_info_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0                                      bytes provided
     d     bytes_out                 10i 0                                      bytes available
     d     ptr_type                   1a                                        returned pointer typ
     d     ptr_status                 1a                                        pointer status
     d                                6a                                        reserved
     d     mod_num                   10u 0                                      module number
     d     proc_num                  10u 0                                      procedure number
     d     num_stmt                  10u 0                                      number of stmt IDs
     d     int_id                     4a                                        internal ID
     d     pgm                         *                                        containing program
     d     stmts                     10u 0 dim(1)                               statement IDs
     d min_lblptr_info_len...
     d                 c                   52

     /* synchronization pointer attributes */
     d matptr_synptr_info_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0                                      bytes provided
     d     bytes_out                 10i 0                                      bytes available
     d     ptr_type                   1a                                        returned pointer typ
     d     ptr_status                 1a                                        pointer status
     d     syn_obj_type...
     d                                2a                                        synchronization obje
     d                                1a
     d min_synptr_info_len...
     d                 c                   13

     /* suspend pointer attributes */
     d matptr_suspend_info_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0                                      bytes provided
     d     bytes_out                 10i 0                                      bytes available
     d     ptr_type                   1a                                        returned pointer typ
     d     ptr_status                 1a                                        pointer status
     d                                6a
     d     module_num                10u 0                                      module number
     d     proc_num                  10u 0                                      procecure number
     d     num_stmts                 10u 0                                      number of statement
     d     internal_id...
     d                                4a                                        internal identifier
     d     containing_pgm...
     d                                 *                                        containing program
      * array of statement IDs, of type Ubin(4).

     d min_suspend_info_len...
     d                 c                   48

     /**
      * @BIF _MATPTR (Materialize Pointer (MATPTR))
      */
     d matptr          pr                  extproc('_MATPTR')
     d     receiver                        likeds(matptr_tmpl_t)
     d     ptr                         *

     /**
      * @BIF _MATPTRL (Materialize Pointer Locations (MATPTRL))
      */
     d matptrl         pr                  extproc('_MATPTRL')
     d     receiver_ptr...
     d                                 *   value
     d     source                      *   value
     d     length                    10i 0

     /* Materialization template for MATPTRIF. */
     d matptrif_tmpl_t...
     d                 ds                  qualified

     /**
      * Materialization template for MATPTRIF when materializing a
      * system pointer or a space pointer.
      */
     d matptrif_sypspp_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d                                7a
      *
      * Pointer type.
      * hex 01 = System pointer
      * hex 02 = Space pointer
      * hex 03 = Suspend pointer
      *
     d     ptr_type                   1a
      * ASP number
     d     asp_num                    5u 0

     /**
      * Materialization template for MATPTRIF when materializing a
      * suspend pointer.
      */
     d matptrif_susptr_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d                                7a
      *
      * Pointer type.
      * hex 01 = System pointer
      * hex 02 = Space pointer
      * hex 03 = Suspend pointer
      *
     d     ptr_type                   1a
      *
      * Pointer description. matptrif_susptr_desc_t for a suspend
      * pointer or matptrif_sypspp_desc_t for a system pointer or a
      * space pointer.
      *
     d                                1a
      *
      * hex 00 = Non-bound program
      * hex 01 = Bound program
      * hex 02 = Bound service program
      * hex 04 = Java program
      *
     d     pgm_type                   1a
     d     pgm_ccsid                  5u 0
     d     pgm_name                  30a
     d     pgm_ctx                   30a
     d                                4a
     d     mod_name                  30a
      * module qualification
     d     mod_qual                  30a
     d                                4a
     d     proc_dict_id...
     d                               10i 0
      * this field is for input
     d     proc_name_length_in...
     d                               10i 0
     d     proc_name_length_out...
     d                               10i 0
      * this field is for input
     d     proc_name_ptr...
     d                                 *
     d                                8a
      * this field is for input
     d     stmt_ids_in...
     d                               10i 0
     d     stmt_ids_out...
     d                               10i 0
      * this field is for input
     d     stmt_ids_ptr...
     d                                 *

     /**
      * @BIF _MATPTRIF (Materialize Pointer Information (MATPTRIF))
      *
      * MATPTRIF can be used to retrieve ASP number of a system pointer
      * or space pointer. Addtionally, it can return detailed attributes of
      * a suspend pointer.
      */
     d matptrif        pr                  extproc('_MATPTRIF')
     d     receiver                        likeds(matptrif_tmpl_t)
     d     ptr                         *
     d     selection                  4a

     /**
      * @BIF _RSLVDP1 (Resolve Data Pointer (RSLVDP))
      */
     d rslvdp1         pr                  extproc('_RSLVDP1')
     d     dta_ptr                     *

     /**
      * @BIF _RSLVDP2 (Resolve Data Pointer (RSLVDP))
      */
     d rslvdp2         pr                  extproc('_RSLVDP2')
     d     dta_ptr                     *
     d     obj_name                  32a

     /**
      * @BIF _RSLVDP3 (Resolve Data Pointer (RSLVDP))
      */
     d rslvdp3         pr                  extproc('_RSLVDP3')
     d     dta_ptr                     *
     d     obj_name                  32a
     d     pgm_ptr                     *

     d rslvsp_tmpl     ds                  qualified
     d     obj_type                   2a
     d     obj_name                  30a
     d     auth                       2a   inz(x'0000')

     /**
      * @BIF _RSLVSP2 (Resolve System Pointer (RSLVSP))
      */
     d rslvsp2         pr                  extproc('_RSLVSP2')
     d     obj                         *
     d     opt                       34a

     /**
      * @BIF _RSLVSP4 (Resolve System Pointer (RSLVSP))
      */
     d rslvsp4         pr                  extproc('_RSLVSP4')
     d     obj                         *
     d     opt                       34a
     d     ctx                         *

     /**
      * @BIF _TESTPTR (Test Pointer (TESTPTR))
      *
      * @remark Use testptr instead of rpg_testptr when @var is a space pointer.
      */
     d testptr         pr            10i 0 extproc('_TESTPTR')
     d     ptr                         *   value
     d     type                       1a   value

     /**
      * @BIF _TESTPTR (Test Pointer (TESTPTR))
      *
      * @remark Use rpg_testptr instead of testptr when @var is a procedure pointer.
      */
     d rpg_testptr     pr            10i 0 extproc('_TESTPTR')
     d     ptr                         *   value procptr
     d     type                       1a   value

     /**
      * @BIF _SETSPPFP (Set Space Pointer from Pointer (SETSPPFP))
      * @attention this prototype does NOT work with a SYSPTR
      *            unless src_ptr is declared as a procptr?!
      * @todo      why?
      */
     d setsppfp        pr              *   extproc('_SETSPPFP')
     d     src_ptr                     *   value procptr

     /**
      * @BIF _SETSPFP (Set System Pointer from Pointer (SETSPFP))
      *
      * @remark Use this prototype when @var src_ptr is a space pointer!
      */
     d setspfp         pr              *   extproc('_SETSPFP')
     d     src_ptr                     *   value

     /**
      * @BIF _SETSPFP (Set System Pointer from Pointer (SETSPFP))
      *
      * @remark Use this prototype when @var src_ptr is NOT a space pointer!
      */
     d rpg_setspfp     pr              *   extproc('_SETSPFP')
     d     src_ptr                     *   value procptr

     /* end -- pointer resolution */

     /* space addressing */

     /**
      * @BIF _SETDP (Set Data Pointer (SETDP))
      */
     d setdp           pr              *   extproc('_SETDP')
     d     addr                        *   value
     d     attr                       7a   value

     /**
      * @BIF _SETDPADR (Set Data Pointer Addressability (SETDPADR))
      */
     d setdpadr        pr              *   extproc('_SETDPADR')
     d     dtaptr                      *   value
     d     addr                        *   value

     /* end -- space addressing */

     /* space management */

     /**
      * CRTS template
      *
      * @remark obj_type, object type/subtype, must be hex 19EF
      */
     d crts_tmpl_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     obj_type                   2a
     d     obj_name                  30a
     /*
      * create option, char(4)
      * bit 0, existence attribute, 0=temporary, 1=permanent
      * bit 1, length attribute, 0=fixed-length, 1=variable-length
      * bit 2, Initial context,
      *        0=Addressability is not inserted into context
      *        1=Addressability is inserted into context
      * bit 3, access group,
      *        0=Do not create as member of access group
      *        1=Create as member of access group
      * bit 4-5, reserved(binary 0)
      * bit 6, public authority specified, 0=no, 1=yes
      *        for a temporary space object, default pub-auth is *ALL;
      *        for a permanent space object, default pub-auth is *NONE.
      * bit 7, initial owner specified, 0=no, 1=yes
      *        a temporary space object does not have an owner
      * bit 8-11, reserved(binary 0)
      * bit 12, set public authority in operand 1, 0=no, 1=yes
      * bit 13, initialize space, 0=yes, 1=no
      * bit 14, automatically expand space, 0=no, 1=yes
      * bit 15-16, hardware storage protetion level
      *        00=reference and modify allowed for user state programs
      *        01=only reference allowed for user state programs
      *        10=invalid(yield template value invalid exception, hex 3801)
      *        11=no reference or modify allowed for user state programs
      * bit 17, process temporary space accounting
      *        0=the temporary space will be tracked to the creating process
      *        1=the temporary space will not be tracked to the creating process
      * bit 18-20, reserved(binary 0)
      * bit 21, always enforce hardware storage protection of space
      *        0=enforce hardware storage protection of this space
      *          only when hardware storage protection is being enforced
      *          for all storage.
      *        1=always enforce hardware storage protection of this space.
      * bit 22-31, reserved(binary 0)
      */
     d     crt_opt                    4a
     d                                2a
      * to specify the system ASP, use x'0000'
     d     asp_num                    2a
     d     spc_size                  10i 0
     d     init_val                   1a
     /*
      * performance class
      *
      * bit 0, space alignment; ignored if bit 3 is set to 1
      *   0=The space associated with the object is allocated to allow
      *     proper alignment of pointers at 16-byte alignments within the
      *     space. If the size of space field is zero, this value must be
      *     specified.
      *   1=The space associated with the object is allocated to allow proper
      *     alignment of pointers at 16-byte alignments within the space as
      *     well as to allow proper alignment of input/output buffers at
      *     512-byte alignments within the space.
      * bit 1, clear(or bring?) the space into main memory during creating
      *   0=Only a minimum amount (up to 4K) of the space will be in main
      *     storage upon completion of the instruction.
      *   1=Most of the space, with some limits enforced by the machine, will
      *     be in main storage upon completion of the instruction.
      * bit 2, Spread the space object among storage devices, 0=no, 1=yes
      * bit 3, Machine chooses space alignment
      *   0=the space alignment indicated by bit 0 is performed
      *   1=The machine will choose the space alignment most beneficial to
      *     performance, which may reduce maximum space capacity. When
      *     this value is specified, the space alignment field is
      *     ignored, but the alignment chosen will be a multiple of
      *     512. The maximum capacity for a space object for which the
      *     machine has chosen the alignment is returned by option Hex
      *     0003 of MATMDATA. The maximum space capacity for a
      *     particular space object is returned by MATS.
      * bit 4, Reserved (binary 0)
      * bit 5, Main storage pool selection,
      *   0=Process default main storage pool is used for object.
      *   1=Machine default main storage pool is used for object.
      * bit 6, Transient storage pool selection,
      *   0=Default main storage pool (process default or machine
      *     default as specified for main storage pool selection) is
      *     used for object.
      *   1=transient storage pool is used for object.
      * bit 7, Obsolete, This field is no longer used and will be ignored.
      * bit 8-15, Unit number
      * bit 16-23, reserved (binary 0)
      * bit 24-31, expanded transfer size advisory. specifies the
      *            desired number of pages to be transferred between
      *            main store and auxiliary storage for implicit
      *            access state changes. This value is only an
      *            advisory; the machine may use a value of its choice
      *            for performing access state changes under some
      *            circumstances. For example, the machine may limit
      *            the transfer size to a smaller value than is
      *            specified. A value of zero is an explicit
      *            indication that the machine should use the machine
      *            default storage transfer size for this object.
      */
     d     perf_cls                   4a
     d                                1a
     d     pub_auth                   2a
      * offset to template extension
     d     ext_offset                10i 0
      * context
     d     ctx                         *
      * access group
     d     acc_grp                     *

     /* template extension of CRTS */
     d crts_tmpl_ext_t...
     d                 ds                  qualified
     d     usrprf                      *
     d     max_spc_size_needed...
     d                               10i 0
      * hex 0000, domain is choosed by the machine
      * hex 0001, user domain
      * hex 8000, system domain
     d     domain                     2a
     d                               42a

     /**
      * @BIF _CRTS (Create Space (CRTS))
      */
     d crts            pr                  extproc('_CRTS')
     d     spcobj                      *
     d     crt_tmpl                    *   value

     /**
      * @BIF _DESS (Destroy Space (DESS))
      */
     d dess            pr                  extproc('_DESS')
     d     spcobj                      *

     /* Materialization template for MATS */
     d mats_tmpl_t     ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     obj                       32a
     d     obj_type                   2a   overlay(obj)
     d     obj_name                  30a   overlay(obj:3)
      *
      * Object creation options
      *
      * Bit 0, existence attribute.
      *   0 = Temporary
      *   1 = Permanent
      * Bit 1, space attribute
      *   0 = Fixed-length
      *   1 = Variable-length
      * Bit 2, Context
      *   0 = Addressability not in context
      *   1 = Addressability in context
      * Bit 3, Access group
      *   0 = Not member of access group
      *   1 = Member of access group
      * Bits 4-12, Reserved (binary 0)
      * Bit 14, Automatically extend space
      *   0 = No
      *   1 = Yes
      * Bits 15-16, Hardware storage protection level
      *   00 = Reference and modify allowed for user state programs
      *   01 = Only reference allowed for user state programs
      *   10 = Invalid (undefined)
      *   11 = No reference or modify allowed for user state programs
      * Bits 17-20, Reserved (binary 0)
      * Bit 21, Always enforce hardware storage protection of this space
      *   0 = Enforce hardware storage protection of this space only
      *       when hardware storage protection is enforced for all
      *       storage.
      *   1 = Enforce hardware storage protection of this space at all times.
      * Bits 22-31, Reserved (binary 0)
      *
     d     crt_option                 4a
     d                                2a
     d     asp_num                    5u 0
     d     spc_size                  10i 0
     d     init_val                   1a
      *
      * Performance class
      *
      * Bit 0, Space alignment
      *   0 = The space associated with the object is allocated to
      *       allow proper alignment of pointers at 16-byte alignments
      *       within the space.
      *   1 = The space associated with the object is allocated to
      *       allow proper alignment of pointers at 16-byte alignments
      *       within the space as well as to allow proper alignment of
      *       input/output buffers at 512-byte alignments within the
      *       space.
      *       @remark Ignore the value of this field when the machine
      *       chooses space alignment field has a value of 1.
      * Bit 1, Reserved (binary 0)
      * Bit 2, Spread the space object
      *   0 = The space object may be on one storage device.
      *   1 = The space object may be spread across multiple storage devices.
      * Bit 3, Machine chooses space alignment
      *   0 = The space alignment indicated by the space alignment field is in effect.
      *   1 = The machine chose the space alignment most beneficial to
      *       performance, which may have reduced maximum space
      *       capacity. The alignment chosen is a multiple of
      *       512. Check the maximum size of space field value. Ignore
      *       the value of the space alignment field.
      * Bit 4, Reserved (binary 0)
      * Bit 5, Main storage pool selection
      *   0 = Process default main storage pool is used for object.
      *   1 = Machine default main storage pool is used for object.
      * Bit 6, Transient storage pool selection
      *   0 = Default main storage pool (process default or machine
      *       default as specified for main storage pool selection) is
      *       used for object.
      *   1 = Transient storage pool is used for object.
      * Bit 7, Obsolete
      * Bits 8-15, Unit number
      * Bits 16-23, Reserved (binary 0)
      * Bits 24-31, Expanded transfer size advisory
      *
     d     perf_cls                   4a
     d     unit_num                   1a   overlay(perf_cls:2)
     d     expanded_transfer_size_advisory...
     d                                1a   overlay(perf_cls:4)
     d                                7a
      * context
     d     ctx                         *
      * access group
     d     ag                          *
     d                               16a
     d     max_spc_size...
     d                               10i 0

     /**
      * @BIF _MATS (Materialize Space Attributes (MATS))
      */
     d mats            pr                  extproc('_MATS')
     d     tmpl                            likeds(mats_tmpl_t)
     d     spc                         *

     /**
      * @BIF _MODS1 (Modify Space Attributes (MODS))
      */
     d mods1           pr                  extproc('_MODS1')
     d     spc                         *
     d     spc_size                   5i 0

     /* Modification template for MODS */
     d mods_tmpl_t     ds                  qualified
     d     selection                  4a
     d     attr                       4a
      *
      * Maximum size of secondary associated space
      *
      * @remark This field is ignored when create secondary associated
      * space is 0.
      *
     d     max_2nd_spc_size...
     d                               10i 0
     d     spc_size                  10i 0
     d     init_val                   1a
     d     perf_cls                   4a
     d                                1a
      *
      * Secondary associated space number
      *
      * @remark If the thread execution state is user state, this
      * field must be 0. Otherwise an invalid space modification (hex
      * 3602) exception is signaled. This restriction applies at all
      * system security levels.
      *
     d     num_2nd_spc...
     d                                5u 0
     d                                4a

     /**
      * @BIF _MODS2 (Modify Space Attributes (MODS))
      */
     d mods2           pr                  extproc('_MODS2')
     d     spc                         *
     d     tmpl                            likeds(mods_tmpl_t)

     /* end -- space management */

     /* program management */

     /* Materialization template for MATPG */
     d matpg_tmpl_t    ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     pgm_id                    32a
     d       pgm_type                 2a   overlay(pgm_id)
     d       pgm_name                30a   overlay(pgm_id:3)
      * Program creation options
     d     crt_opt                    4a
     d                                4a
     d     spc_size                  10i 0
     d     spc_init_val...
     d                                1a
      * Performance class
     d     perf_cls                   4a
     d                                7a
      * Context
     d     ctx                         *
      * Access group
     d     ag                          *
      * Program attributes
     d     pgm_attr                   2a
      * Code generation options
     d     gen_opt                    1a
      * Observation attributes
     d     obsv_attr                  1a
      * Size of static storage
     d     ss_size                   10u 0
      * Size of automatic storage
     d     as_size                   10u 0
      * Number of instructions (1)
     d     num_inst1                  5u 0
      *
      * Number of ODV entries (1)
      *
      * For version number = hex 0000, this field indicates the number
      * of instructions. For version number = hex 0001, this field is
      * reserved (binary 0).
      *
     d     num_odv1                   5i 0
     d     inst_stream_offset...
     d                               10i 0
     d     odv_offset                10i 0
     d     oes_offset                10i 0
      * Length of breakpoint offset mapping table entry
     d     bom_ent_len...
     d                               10i 0
      * Length of breakpoint offset mapping table component
     d     bom_len                   10i 0
     d     bom_offset                10i 0
      * length of symbol table entry
     d     symtbl_ent_len...
     d                               10i 0
     d     symtbl_len                10i 0
     d     symtbl_offset...
     d                               10i 0
      *
      * Offset (in bytes) from beginning of template to the
      * object mapping table (OMT) component
      *
     d     omt_offset                10i 0
     d     num_inst2                 10i 0
     d     num_odv2                  10i 0
      *
      * Template extension
      *
      * @remark This extension exists only when the template extension
      *         existence bit (bit 10 of @var pgm_attr) is 1.
      *
     d     ext_pgm_attr...
     d                                4a
      *
      * Language version, release, and modification level
      *
      * Bits 0-3. Reserved
      * Bits 4-7. Version
      * Bits 8-11. Release
      * Bits 12-15. Mod level
      *
     d     lang_vrm                   2a
      *
      * BOM table flags
      *
      * Bit 0. Use new BOM table format
      *  0 = old BOM format
      *  1 = new BOM format
      * Bit 1-7. User data5A
      *
     d     bom_flags                  1a
     d     user_data5B...
     d                                7a
      *
      * Version, release, and modification level this program
      * is being created for.
      *
     d     pgm_vrm                    2a
      *
      * Data required for machine retranslation
      *
      * Bit 0. All data required for machine retranslation is present
      *   0 = No
      *   1 = Yes
      * Bits 1-7. Reserved (binary 0)
      *
     d     data_required_for_machine_retranslation...
     d                                1a
      * Reserved (binary 0)
     d                               47a
      *
      * Program data
      *    Instruction stream component
      *    ODV component
      *    OES component
      * BOM table
      * Symbol table
      * Object mapping table
      *

     /**
      * Layout of the symbol table component.
      */
     d symbol_table_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
      * Number of hash buckets
     d     num_buckets...
     d                               10i 0
      *
      * Hash bucket
      *
      * Each hash bucket contains an offset to the first symbol table
      * base segment entry of the chain. This offset is from the
      * beginning of the symbol table. The end of the chain has a -1
      * value.
      *
      * @remark Maximum of 1000 hash buckets.
      *
     d     buckets                   10i 0 dim(1000)

     /**
      * Symbol table base segment
      */
     d symtbl_base_t...
     d                 ds                  qualified
      * -1 if it's the end of the chain
     d     next_entry_offset...
     d                               10i 0
      * ODT index or MI instruction number
     d     num                        5i 0
      *
      * Bit 0. Instruction or ODT number
      *  0 = MI instruction number
      *  1 = ODT number
      * Bit 1. Symbol origin
      *  0 = Compiler generated
      *  1 = Source program
      * Bit 2. Array specification
      *  0 = Row major
      *  1 = Column major
      * Bit 3. Format segment present
      *  0 = No
      *  1 = Yes
      * Bit 4. Array segment present
      *  0 = No
      *  1 = Yes
      * Bit 5. Extension segment present
      *  0 = No
      *  1 = Yes
      * Bits 6-7. Reserved (binary 0)
      *
     d     flag                       1a
      * Length of symbol
     d     len                        1a
      * symbol
     d     name                      16a

     /**
      * Symbol table format segment
      */
     d symtbl_format_t...
     d                 ds            20    qualified
      * Format program name
     d     fmt_pgm_name...
     d                               10a
      * Format code
     d     fmt_code                   4a
      * Locator variable ODT#
     d     loc_var_odt...
     d                                5u 0
      * Descriptor variable ODT#
     d     desc_var_odt...
     d                                5u 0
      * Reserved (binary 0)
     d                                2a

     /**
      * Symbol table array segment
      *  - Number of array dimensions           Bin(2)
      *  - Indexes (1 per array dimension)      [*] Char(8)
      *    - Lower index                        Bin(4)
      *    - upper index                        Bin(4)
      */

     /**
      * Symbol table extended segment
      */
     d symtbl_ex_t     ds            26    qualified
      * Extended segment length
     d     seg_len                    5u 0
      * Structure level
     d     ds_level                   2a
      *
      * Data representation
      *  hex 00 = See ODT
      *  hex 01 = Binary
      *  hex 02 = Zoned
      *  hex 03 = Bit string
      *
     d     dta_rep                    1a
      * Number of total digits
     d     total_digits...
     d                                5i 0
      * Number of fractional digits
     d     fractional_digits...
     d                                5i 0
      *
      * Sign of number
      *  hex 00 = Leading embedded
      *  hex 01 = Leading separated
      *  hex 02 = Trailing separate
      *
     d     sign                       1a
      * Offset to base segment entry of parent. The end of the chain has a -1 value.
     d     offset_to_base_segment_entry_of_parent...
     d                               10i 0
      * Offset to base segment entry of synonym. The end of the chain has a -1 value.
     d     offset_to_base_segment_entry_of_synonym...
     d                               10i 0
      *
      * Bit 0. Object is a HLL pointer
      * Bit 1. Array segment is in multi-dimensioned array format
      * Bits 2-7. Reserved (binary 0)
      *
     d     flag                       1a
      * Reserved (binary 0)
     d                                7a

     /**
      * Old format BOM table entry
      */
     d bom_entry0_t    ds            12    qualified
      *
      * Bit 0. Format flag
      *   0 = HLL statement number is in character format
      *   1 = HLL statement number is in numeric format
      *
     d     mi_inst                    5u 0
     d     hll_stmt_name...
     d                               10a
     d     hll_stmt_num...
     d                                5i 0 overlay(
     d                                       hll_stmt_name:1)

     /**
      * New format BOM table entry
      */
     d bom_entry1_t    ds            13    qualified
     d     mi_inst                    5u 0
      *
      * Bit 0. Format flag
      *   0 = HLL statement number is in character format
      *   1 = HLL statement number is in numeric format
      *
     d     fmt_flag                   1a
     d     hll_stmt_name...
     d                               10a
     d     hll_stmt_num...
     d                                5i 0 overlay(
     d                                       hll_stmt_name:1)

     /**
      * ODV entry
      */
     d odv_entry_t     ds             4    qualified
     d     hi                         2a
     d     lo                         2a
     d     oes_offset                 5u 0 overlay(lo)
      * scalar length
     d     scalar_len                 2a   overlay(lo)
      * MI instruction number
     d     inst_num                   5u 0 overlay(lo)

     /**
      * OMT entry
      */
     d omt_entry_t     ds             6    qualified
      *
      * addressability type
      *  hex 00 = Base addressability is from the start of the static
      *           storage. e.g. def(static-var)
      *  hex 01 = Base addressability is from the start of the
      *           automatic storage area. e.g. def(auto-var)
      *  hex 02 = Base addressability is from the start of the storage
      *           area addressed by a space pointer. e.g. bas(spp-ptr)
      *  hex 03 = Base addressability is from the start of the storage
      *           area of a parameter.  e.g. bas(parm-var)
      *  hex 04 = Base addressability is from the start of the storage
      *           area addressed by the space pointer found in the
      *           process communication object attribute of the
      *           process associated with the thread executing the
      *           program. aka. baspco
      *  hex FF = Base addressability not provided. The object is
      *           contained in machine storage areas to which
      *           addressability cannot be given, or a parameter has
      *           addressability to an object that is in the storage
      *           of another program.
      *
     d     addr_type                  1a
      *
      * Offset from base. For types hex 00, hex 01, hex 02, hex 03,
      * and hex 04, this is a 3-byte logical binary value representing
      * the offset to the object from the base addressability. For
      * type hex FF, the value is binary 0.
      *
     d     offset                     3a
      *
      * Base addressability. For types hex 02 and hex 03, this is a
      * 2-byte binary field containing the number of the OMT entry for
      * the space pointer or a parameter that provides base
      * addressability for this object. For types hex 00, hex 01, hex
      * 04 and hex FF, the value is binary 0.
      *
     d     basee                      5u 0

     /**
      * @BIF _MATPG (Materialize Program (MATPG))
      *
      * @attention This instruction does not process teraspace addresses ...
      */
     d matpg           pr                  extproc('_MATPG')
     d     receiver                        likeds(matpg_tmpl_t)
     d     pgm                         *

     /**
      * @BIF _MATPGMNM (Materialize Program Name (MATPGMNM))
      */
     d matpgmnm        pr                  extproc('_MATPGMNM')
     d     rcv_tmpl                        likeds(matpgmnm_tmpl_t)

     d matpgmnm_tmpl_t...
     d                 ds            80    qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     format                    10i 0
     d                                4a
     d     ctx_type                   2a
     d     ctx_name                  30a
     d     bpgm_type                  2a
     d     bpgm_name                 30a
     d matpgmnm_tmpl_len...
     d                 c                   80

     /* end -- program management */

     /* program execution */

     /* bound program activation definition template */
     d actbpgm_dfn_t   ds            32    qualified
     d     agp_mark                  10u 0
     d     act_mark                  10u 0
     d                                7a
     d     indicator                  1a
     d                               16a

     /**
      * @BIF _ACTBPGM (Activate Bound Program (ACTBPGM))
      */
     d actbpgm         pr                  extproc('_ACTBPGM')
     d     act_dfn                         likeds(actbpgm_dfn_t)
     d     pgm                         *

     /**
      * @BIF _MATACTEX (Materialize Activation Export (MATACTEX))
      */
     d matactex        pr                  extproc('_MATACTEX')
     d     act_mark                  10u 0 value
      * 1=by export ID, 2=by name
     d     ind_type                  10u 0 value
      * export ID, start from 1
     d     number                    10u 0 value
     d     name                        *   value
      * returned procedure pointer
     d     proc_ptr                    *   procptr
      * 0=item not found
      * 1=procedure export
      * 2=data export
      * 3=inaccessible data export
     d     ext_type                  10u 0

     /**
      * @BIF _ACTPG (Activate Program (ACTPG))
      */
     d actpg           pr                  extproc('_ACTPG')
     d     ssf                         *
     d     pgm                         *

     /**
      * @BIF _DEACTPG1 (Deactivate Program (DEACTPG))
      */
     d deactpg1        pr                  extproc('_DEACTPG1')
     d     pgm                         *

     /**
      * @BIF _DEACTPG2 (Deactivate Program (DEACTPG))
      *
      * @remark _DEACTPG2 deactivate the activation entry of the
      *         calling program itself.
      */
     d deactpg2        pr                  extproc('_DEACTPG2')

     /**
      * @BIF _INVP (Invocation Pointer (INVP))
      */
     d invp            pr              *   extproc('_INVP')
      * relative invocation number; now must be 0
     d     relative_invocation_number...
     d                               10u 0 value

     /* basic attribute of a activation group */
     d agp_basic_attr_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d                                8a
     d     root_pgm                    *
     d                               16a
      * Storage address recycling key
     d     stg_addr_rcc_key...
     d                                 *
     d     agp_name                  30a
     d                                2a
     d     agp_mark                   4a
     d                                4a
     d     heap_cnt                  10u 0
     d     act_cnt                   10u 0
     d     stat_atg_size...
     d                               10u 0
     d                                4a
     d     agp_attr                   1a
      * Process access group (PAG) membership advisory attributes
     d     pag_adv                    1a
     d                                6a
     d     long_agp_mark...
     d                                8a

     /* list of heap ids of a activation group */
     d agp_heap_id_list_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d                                8a
     d     heap_id                   10i 0 dim(1)

     /* list of program activation entries */
     d agp_acte_list_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d                                8a
     d     act_ent                    4a   dim(1)

     /**
      * @BIF _MATAGPAT (Materialize Activation Group Attributes (MATAGPAT))
      */
     d matagpat        pr                  extproc('_MATAGPAT')
     d     receiver                    *   value
     d     agp_mark                   4a
     d     attr_sel                   1a

     /* basic activation attributes */
     d act_basic_attr_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d                                8a
     d     pgm                         *
     d     act_mark                  10u 0
     d     agp_mark                  10u 0
     d     inv_cnt                   10u 0
     d     ssf_cnt                   10u 0
     d     pgm_type                   1a
     d     act_attr                   1a
     d     tgt_agp                    1a
     d                                1a
      * dependent activation count
     d     dep_act_cnt...
     d                               10u 0
     d     long_act_mark...
     d                                8a
     d     long_agp_mark...
     d                                8a

     /* SSF list entry */
     d ssf_liste_t...
     d                 ds                  qualified
     d     ssf_ptr                     *
     d     ssf_size                  10u 0
     d                               12a

     /* SSF list of an program activation entry */
     d act_ssf_list_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d                                8a
     d     ssf_ent                         likeds(ssf_liste_t)
     d                                     dim(1)

     /* dependent activation entries of an program activation entry */
     d act_dep_acte_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d                                8a
     d     dep_act                    4a   dim(1)

     /**
      * @BIF _MATACTAT (Materialize Activation Attributes (MATACTAT))
      */
     d matactat        pr                  extproc('_MATACTAT')
     d     receiver                    *   value
     d     act_mark                  10u 0
     d     attr_sel                   1a

     /**
      * @BIF _MODASA (Modify Automatic Storage Allocation (MODASA))
      *
      * @remark Note that unlike MI instruction MODASA, builtin
      *         _MODASA cannot be used to truncate ASF.
      */
     d modasa          pr              *   extproc('_MODASA')
     d     mod_size                  10u 0 value

     /**
      * @BIF _NPMPARMLISTADDR (NPM Procedure Parameter List Address (NPM_PARMLIST_ADDR))
      *
      * @return space pointer to a npm_plist_t structure
      */
     d npm_plist       pr              *   extproc('_NPMPARMLISTADDR')

     d npm_plist_t     ds                  qualified based(dummy_ptr)
     d     parm_desc_...
     d       list                      *
     d     mch_wrk_...
     d       ara                     16a
     d     argvs                       *   dim(400)

     d parm_desc_...
     d       list_t    ds                  qualified based(dummy_ptr)
     d     argc                      10i 0

     /**
      * MATINVE, materialize invocation entry.
      *
      * @todo MCH4227!
      * The reason code is 8 and the operation code of the current instruction is X'00000061'.
      * When opcode is hex 61??
      *
      * @remark ���������� IBM!
      */
     d*matinve         pr                  extproc('_MATINVE')
     d*    receiver                        likeds(matinve_dummy_t)
     d*    option                    10u 0 value

     d*matinve_dummy_t...
     d*                ds                  qualified

     /* invocation identification structure */
     d invocation_id_t...
     d                 ds                  qualified
     d     src_inv_offset...
     d                               10i 0
     d     org_inv_offset...
     d                               10i 0
     d     inv_range                 10i 0
     d                                4a
     d     inv_ptr                     *
     d                               16a

     /**
      * @BIF _MATINVAT2 (Materialize Invocation Attributes (MATINVAT))
      */
     d matinvat2       pr                  extproc('_MATINVAT2')
     d     receiver                        likeds(matinvat_tmpl_t)
     d     invocation_id...
     d                                     likeds(invocation_id_t)
     d     selection                       likeds(matinvat_selection_t)

     /* Materialization template of MATINVAT. */
     d matinvat_tmpl_t...
     d                 ds                  qualified

     /**
      * @BIF _MATINVAT (Materialize Invocation Attributes (MATINVAT))
      */
     d matinvat        pr                  extproc('_MATINVAT1')
     d     receiver                        likeds(matinvat_tmpl_t)
     d     selection                       likeds(matinvat_selection_t)

     /* attribute selection template for MATINVAT */
     d matinvat_selection_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     num_attr                  10i 0
     d     flag1                      1a
     d                                3a
     d     ind_offset                10i 0
     d     ind_length                10i 0
     d     attr_id                   10i 0
     d     flag2                      1a
     d                                3a
     d     rcv_offset                10i 0
     d     rcv_length                10i 0

     /* length of DS matinvat_selection_t */
     d matinvat_selection_length...
     d                 c                   32

     /* receiver template when materializing ASF pointer; option 2 */
     d matinvat_asf_receiver_t...
     d                 ds                  qualified
     d     asf_ptr                     *

     /* Materialization template of MATINVAT when a pointer is returned. */
     d matinvat_ptr_t...
     d                 ds                  qualified
     d     ptr                         *

     /* receiver template when materializing AG mark; option 14 */
     d matinvat_agp_mark_t...
     d                 ds            16    qualified
     d     agp_mark                  10u 0

     /* activation template for RINZSTAT */
     d rinzstat_tmpl_t...
     d                 ds                  qualified
     d     pgm                         *
     d     agp_mark                  10u 0

     /* activation template for RINZSTAT */
     d rinzstat_tmpl2_t...
     d                 ds                  qualified
     d     pgm                         *
     d     agp_mark                  20u 0
     d                                8a

     /**
      * @BIF _RINZSTAT (Reinitialize Static Storage (RINZSTAT))
      */
     d rinzstat        pr                  extproc('_RINZSTAT')
     d     activation_tmpl...
     d                                     likeds(rinzstat_tmpl_t)

     /**
      * @BIF _RINZSTAT2 (Reinitialize Static Storage (RINZSTAT))
      */
     d rinzstat2       pr                  extproc('_RINZSTAT2')
     d     activation_tmpl...
     d                                     likeds(rinzstat_tmpl2_t)

     /**
      * @BIF _OPM_PARM_CNT (OPM Parameter Count (OPM_PARM_CNT))
      * @todo has not been tested.
      */
     d opm_parm_cnt    pr            10u 0 extproc('_OPM_PARM_CNT')

     /**
      * @BIF _OPM_PARM_ADDR (OPM Parameter Address (OPM_PARM_ADDR))
      * @todo has not been tested.
      */
     d opm_parm_addr   pr              *   extproc('_OPM_PARM_ADDR')
     d     ind                       10u 0 value

     /* Materialization template for MATINVS */
     d matinvs_tmpl_t  ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     entries                   10i 0
      *
      * Fields annotated with a plus sign (+) are not
      * materailized when working with a process rather other the
      * current process.
      *
      * (+)
     d     thd_marker_cnt...
     d                               10i 0
      * offset = 16
      *
      * Call stack (invocation) entries in array of char(128)
      *

     /* Minimal length of matinvs_tmpl_t. */
     d min_matinvs_tmpl_length...
     d                 c                   16

     /* Invocation entries materialized by MATINVS */
     d invocation_entry_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d                               32a
     d     pgm                         *
     d     inv_num                    5i 0
      *
      * Invocation mechanism.
      *
      * hex 01 = Call external
      * hex 02 = Transfer control
      * hex 03 = Event handler
      * hex 04 = External exception handler (for non-bound program)
      * hex 05 = Initial program in process problem state
      * hex 06 = Initial program in process initiation state
      * hex 07 = Initial program in process initiation state
      * hex 08 = Invocation exit (for non-bound program)
      * hex 09 = Return or return/XCTL trap handler
      * hex 0A = Call program
      * hex 0B = Cancel handler (bound program only)
      * hex 0C = Exception handler (bound program only)
      * hex 0D = Call bound procedure/call with procedure pointer
      * hex 0E = Process Default Exception Handler
      *
     d     inv_method                 1a
      *
      * Invocation type.
      *
      * hex 01 = Non-Bound Program
      * hex 02 = Bound Program Entry Procedure (PEP)
      * hex 03 = Bound Program Procedure
      *
     d     inv_type                   1a
      * (+)
     d     inv_mark                  10i 0
     d     inst_id                   10i 0
      * (+)
     d     agp_mark                  10i 0
     d     suspend_ptr...
     d                                 *
     d                               48a

     /* Length of DS invocation_entry_t */
     d invocation_entry_length...
     d                 c                   128

     /**
      * @BIF _MATINVS1 (Materialize Invocation Stack (MATINVS))
      *
      * @remark _MATINVS1 accept a PCS ptr as its second operand and
      *          meterialize the call stack of the initial thread of
      *          another process
      */
     d matinvs1        pr                  extproc('_MATINVS1')
     d     receiver                        likeds(matinvs_tmpl_t)
     d     pcs                         *

     /**
      * @BIF _MATINVS2 (Materialize Invocation Stack (MATINVS))
      *
      * @remark _MATINVS2 materialize the call stack of current thread.
      */
     d matinvs2        pr                  extproc('_MATINVS2')
     d     receiver                        likeds(matinvs_tmpl_t)

     /**
      * Selection template for MATINV.
      */
     d matinv_selection_t...
     d                 ds                  qualified
      *
      * Control information.
      * Bit 0 (+).
      *   Template extension.
      *   0 = Template extension is not present.
      *   1 = Template extension is present.
      *
      * Bits 1-15.
      *   Invocation number
      *
     d     inv_num                    5i 0
     d     offset_parms...
     d                               10i 0
     d     parm_odv_num...
     d                                5u 0
     d     offset_exception_descs...
     d                               10i 0
     d     excpd_odv_num...
     d                                5u 0
      *
      * template extension
      *
     d     offset_mchspcs...
     d                               10i 0
     d     mchspc_num...
     d                                5u 0
     d                                8a

     /* Materialization template for MATINVS */
     d matinv_tmpl_t   ds

     /**
      * Materialization template for MATINVS when target
      * invocation is for a bound program procedure.
      */
     d matinv_npm_tmpl_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
      *
      * Object ID
      *
     d     obj_type                   2a
     d     obj_name                  30a
     d     trace_spec                 2a

     /* Length of matinv_npm_tmpl_t. */
     d matinv_npm_tmpl_length...
     d                 c                   42

     /**
      * Materialization template for MATINVS when target
      * invocation is for a non-bound program procedure.
      */
     d matinv_opm_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
      *
      * Object ID
      *
     d     obj_type                   2a
     d     obj_name                  30a
     d     trace_spec                 2a
      *
      * Fields only for non-bound program invocations.
      *
     d     inst_num                   5u 0
     d     offset_parm_data...
     d                               10i 0
     d     offset_excd_data...
     d                               10i 0
     d     offset_mchspc_data...
     d                               10i 0
      *
      * Array of space pointer machine objects (
      * matinv_mchspc_t).
      *
      * Array of SPCPTRs of parameters.
      *
      * Array of exception descriptions (matinv_expd_t).
      *

     /* Minimal length of matinv_opm_tmpl_t. */
     d min_matinv_opm_tmpl_length...
     d                 c                   56

     /* matinv_mchspc_t */
     d matinv_mchspc_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d                               15a
      *
      * Pointer value indicator.
      *   00 = Addressability value is not valid.
      *   01 = Addressability value is valid.
      *
     d     ptr_ind                    1a
     d     mchspc_ptr                  *

     /**
      * Exception description materialized by MATINVS
      */
     d matinv_expd_t   ds                  qualified
     d                                     based(dummy_ptr)
      *
      * Control flags.
      * Bits 0-2, Exception handling action
      *   000 = Ignore occurrence of exception and continue processing.
      *   001 = Disabled exception description.
      *   002 = Continue search for an exception description by
      *         resignaling the exception to the immediately preceding
      *         invocation.
      *   003 = Defer handling.
      *   004 = Pass control to the specified exception handler.
      *
      * Bits 3-15, reserved (binary 0).
      *
     d     control_flag...
     d                                2a
     d     cmp_value_len...
     d                                5i 0
     d     cmp_value                 32a

     /**
      * @BIF _MATINV (Materialize Invocation (MATINV))
      */
     d matinv          pr                  extproc('_MATINV')
     d     receiver                        likeds(matinv_tmpl_t)
     d     selection                       likeds(matinv_selection_t)

     /**
      * Search criterion structure for FNDRINVN.
      */
     d fndrinvn_criterion_t...
     d                 ds                  qualified
     d                                8a
     d     search_type...
     d                               10i 0
     d     option                     1a
     d                                3a
     d     search_arg                16a

     /**
      * Search range structure for FNCRINVN.
      */
     d fndrinvn_search_range_t...
     d                 ds                  qualified
     d     start_inv_offset...
     d                               10i 0
     d                               10i 0
     d     inv_range                 10i 0
     d                                4a
     d     start_invp                  *
     d                               16a

     /**
      * @BIF _FNDRINVN1 (Find Relative Invocation Number (FNDRINVN))
      *
      * @remark _FNDRINVN1 does NOT accept search-range operand.
      */
     d fndrinvn1       pr                  extproc('_FNDRINVN1')
     d     relative_inv_num...
     d                               10i 0
     d*    range                           likeds(fndrinvn_search_range_t)
     d     criterion                       likeds(fndrinvn_criterion_t)

     /**
      * @BIF _FNDRINVN2 (Find Relative Invocation Number (FNDRINVN))
      *
      * @remark _FNDRINVN2 accept search-range operand as its second operand
      */
     d fndrinvn2       pr                  extproc('_FNDRINVN2')
     d     relative_inv_num...
     d                               10i 0
     d     range                           likeds(fndrinvn_search_range_t)
     d     criterion                       likeds(fndrinvn_criterion_t)

     /* end -- program execution */

     /* heap management */

     /**
      * @BIF _ALCHSS (Allocate Activation Group-Based Heap Space Storage (ALCHSS))
      */
     d alchss          pr              *   extproc('_ALCHSS')
     d     heap_id                   10i 0 value
     d     size                      10i 0 value

     /**
      * @BIF _FREHSS (Free Activation Group-Based Heap Space Storage (FREHSS))
      */
     d frehss          pr                  extproc('_FREHSS')
     d     ptr                         *   value

     /* CRTHS template */
     d crths_tmpl_len  c                   96
     d crths_tmpl_t    ds            96    qualified
     d                                     based(dummy_ptr)
     d                                8a
     d     max_alloc                 10u 0
     d     min_bdry                  10u 0
     d     crt_size                  10u 0
     d     ext_size                  10u 0
     d     domain                     5i 0
     d     crt_option                 6a
     d                               64a

     /**
      * @BIF _CRTHS (Create Activation Group-Based Heap Space (CRTHS))
      */
     d crths           pr                  extproc('_CRTHS')
     d     heap_id                   10i 0
     d     crt_tmpl                        likeds(crths_tmpl_t)

     /**
      * @BIF _MATHSAT (Materialize Activation Group-Based Heap Space Attributes (MATHSAT))
      */
     d mathsat         pr                  extproc('_MATHSAT')
     d     tmpl                        *   value
     d     head_id_tmpl...
     d                                 *   value
     d     selection                  1a

     /* MATHSAT template */
     d mathsat_tmpl_len...
     d                 c                   128
     d mathsat_tmpl_t  ds           128    qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     max_alloc                 10u 0
     d     min_bdry                  10u 0
     d     crt_size                  10u 0
     d     ext_size                  10u 0
     d     domain                     5i 0
     d     crt_option                 6a
     d                               64a
     d     cur_out_alc...
     d                               10u 0
     d     num_realc                 10u 0
     d     num_free                  10u 0
     d     num_alc                   10u 0
     d     max_out_alc...
     d                               10u 0
     d     stg_unit_size...
     d                               10u 0
     d     num_marks                 10u 0
     d     num_ext                   10u 0

     /* MATHSAT's heap id template */
     d heap_id_t       ds            16    qualified
     d    agp_mark                   10u 0
     d    heap_id                    10u 0

     /**
      * @BIF _SETHSSMK (Set Activation Group-Based Heap Space Storage Mark (SETHSSMK))
      */
     d sethssmk        pr                  extproc('_SETHSSMK')
     d     mark                        *
     d     heap_id                   10i 0

     /**
      * @BIF _FREHSSMK (Free Activation Group-Based Heap Space Storage From Mark (FREHSSMK))
      */
     d frehssmk        pr                  extproc('_FREHSSMK')
     d     mark                        *

     /**
      * @BIF _DESHS (Destroy Activation Group-Based Heap Space (DESHS))
      */
     d deshs           pr                  extproc('_DESHS')
     d     heap_id                   10i 0

     /* end -- heap management */

     /* independent index */

     /* template of CRTINX */
     d crtinx_tmpl_t   ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     obj_type                   2a
     d     obj_name                  30a
      * creation option
     d     crt_opt                    4a
      * recovery option
     d     rcvy_opt                   4a
     d     spc_size                  10i 0
     d     init_spc_val...
     d                                1a
      * performance class
     d     perf_cls                   4a
     d                                3a
      * extension offset
     d     ext_offset                10i 0
     d     ctx                         *
     d     acc_grp                     *
     d     inx_attr                   1a
      * argument length
     d     arg_len                    5i 0
      * key length
     d     key_len                    5i 0
      * longer template
     d                               12a
      * template version, must be hex 00
     d     tmpl_ver                   1a
      * index format,
      *   0=maximum object size of 4G bytes
      *   1=maximum object size of 1T bytes
     d     inx_fmt                    1a
     d                               61a

      * template extension of CRTINX
     d crtinx_tmpl_ext_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     usrprf                      *
     d                                4a
      * domain assigned to created object
      *   hex 0000=the domain will be choosed by the machine
      *   hex 0001=user domain
     d     obj_domain                 2a
     d                               42a

     /* template of MATINXAT */
     d matinxat_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     obj_type                   2a
     d     obj_name                  30a
      * creation option
     d     crt_opt                    4a
      * recovery option
     d     rcvy_opt                   4a
     d     spc_size                  10i 0
     d     init_spc_val...
     d                                1a
      * performance class
     d     perf_cls                   4a
     d                                3a
      * extension offset
     d     ext_offset                10i 0
     d     ctx                         *
     d     acc_grp                     *
     d     inx_attr                   1a
      * argument length
     d     arg_len                    5i 0
      * key length
     d     key_len                    5i 0
      * index statistics
     d     entries_inserted...
     d                               10u 0
     d     entries_removed...
     d                               10u 0
     d     find_operations...
     d                               10u 0

     /**
      * @BIF _CRTINX (Create Independent Index (CRTINX))
      */
     d crtinx          pr                  extproc('_CRTINX')
     d     index                       *
     d     tmpl                        *   value
     d

     /**
      * @BIF _DESINX (Destroy Independent Index (DESINX))
      */
     d desinx          pr                  extproc('_DESINX')
     d     index                       *

     /**
      * @BIF _MATINXAT (Materialize Independent Index Attributes (MATINXAT))
      */
     d matinxat        pr                  extproc('_MATINXAT')
     d     attr                        *   value
     d     index                       *

     /* option list structure used by INSINXEN and FNDINXEN */
     d inx_option_list_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     rule_opt                   2a
     d     arg_len                    5u 0
     d     arg_offset                 5i 0
     d     occ_cnt                    5i 0
     d     rtn_cnt                    5i 0
      * offset 10
      * returned index entries: entry length 5u0, offset 5i0

     d inx_entry_length_offset_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     length                     5u 0
     d     offset                     5i 0

     /**
      * @BIF _INSINXEN (Insert Independent Index Entry (INSINXEN))
      */
     d insinxen        pr                  extproc('_INSINXEN')
     d     index                       *
     d     argument                    *   value
     d     opt_list                    *   value

     /**
      * @BIF _FNDINXEN (Find Independent Index Entry (FNDINXEN))
      */
     d fndinxen        pr                  extproc('_FNDINXEN')
     d     receiver                    *   value
     d     index                       *
     d     opt_list                    *   value
     d     argument                    *   value

     /**
      * @BIF _RMVINXEN1 (Remove Independent Index Entry (RMVINXEN))
      */
     d rmvinxen        pr                  extproc('_RMVINXEN1')
     d     receiver                    *   value
     d     index                       *
     d     opt_list                    *   value
     d     argument                    *   value

     /* template of MODINX */
     d modinx_tmpl_t   ds                  qualified
      * bit 1, immediate update
      *   0=do not modify
      *   1=modify
      * bit 2, index coherency tracking
      *   0=do not modify
      *   1=modify
     d     mod_sel                    1a
      * bit 1, immediate update
      *   0=no immediate update
      *   1=immediate update
      * bit 2, index coherency tracking
      *   0=do not track index coherency
      *   1=track index coherency
     d     new_attr                   1a
     d     reserved                   2a

     /**
      * @BIF _MODINX (Modify Independent Index (MODINX))
      */
     d modinx          pr                  extproc('_MODINX')
     d     index                       *
     d     opt                         *   value

     /* end -- independen index */

     /* queue management */

     /* message prefix used by instruction ENQ */
     d enq_prefix_t    ds                  qualified
     d     msg_len                   10i 0
      * for keyed queue objects
     d     msg_key                  256a

     /**
      * @BIF _ENQ (Enqueue (ENQ))
      */
     d enq             pr                  extproc('_ENQ')
     d     queue                       *
     d     msg_prefix                  *   value
     d     msg                         *   value

     /* message prefix used by instruction DEQ */
     d deq_prefix_t    ds                  qualified
     d     deq_time                   8a
     d     time_out                   8a
     d     msg_len                   10i 0
     d     state_flag                 1a
      * for keyed queue objects; input key, output key
     d     msg_keys                 512a

     /**
      * @BIF _DEQI (Dequeue from a queue object without waiting (DEQ))
      */
     d deqi            pr            10i 0 extproc('_DEQI')
     d     msg_prefix                  *   value
     d     msg                         *   value
     d     queue                       *

     /**
      * @BIF _DEQWAIT (Dequeue from or wait on a queue object (DEQ))
      */
     d deqwait         pr                  extproc('_DEQWAIT')
     d     msg_prefix                  *   value
     d     msg                         *   value
     d     queue                       *

     /* end -- queue management */

     /* object lock management */

     /**
      * lock request template with extension.
      *
      * @remark This template is also used by _LOCKSL2 and _UNLOCKSL2,
      *         _LOCKTSL, and _UNLOCKTSL.  When used by _LOCKSL2,
      *         ext_opt is not used and should be set to binary
      *         0. When used by _UNLOCKSL2, time_out, lock_opt, and
      *         ext_opt are not used and should be set to binary 0.
      */
     d lock_request_tmpl_ext_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     num_requests...
     d                               10i 0
     d     offset_lock_state...
     d                                5i 0
      *
      * @remark 20u 0 is more convenient to operate with in RPG
      *         in contrast with 8a.
      *
     d     time_out                  20u 0
     /*
      * @remark Bits in lock_opt parameter have different meaning when
      *         used to invoke _LOCK, _UNLOCK, _LOCKSL2, _UNLOCKSL2,
      *         _LOCKTSL, or _UNLOCKTSL.  Refer to MI documentation in
      *         i5/OS Information Cenetr for details.
      */
     d     lock_opt                   2a
     d     lock_type                  1a   overlay(lock_opt:1)
     d     lock_scope                 1a   overlay(lock_opt:2)
      *
      * 16-byte lock object template extension.
      * @remark this 16-byte extension exists only when
      *         bit 7 of lock_opt is set to 1.
      *
      * Bit 0, Modify thread event mask option.
      *   0 = Do not modify thread event mask.
      *   1 = Modify thread event mask
      *
      * Bits 1-7, Reserved (binary 0).
      *
     d     ext_opt                    1a
     d     new_thread_event_mask...
     d                                5u 0
     d     previous_thread_event_mask...
     d                                5u 0
      * Reserved (binary 0)
     d                               11a
     /*
      * Offset by now: 16 or 32 (if template extension exists).
      *
      * objects-to-lock: array of system pointers
      */

     /*
      * Lock state selections, array of char(1);
      * repeated for each pointer in the template.
      *   Bits 0-4, Requested lock state.
      *     Bit 0. LSRD lock.
      *     Bit 1. LSRO lock.
      *     Bit 2. LSUP lock.
      *     Bit 3. LEAR lock.
      *     Bit 4. LENR lock.
      *
      *   Bits 5-6, Reserved (binary 0).
      *
      *   Bit 7, Entry active indicator.
      *     0 = Entry not active - This entry is not used.
      *     1 = Entry active - Obtain this lock.
      */

     /**
      * lock request template WITHOUT extension.
      *
      * @remark This template can also be used by _UNLOCK.
      */
     d lock_request_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     num_requests...
     d                               10i 0
     d     offset_lock_state...
     d                                5i 0
     d     time_out                  20u 0
     d     lock_opt                   2a
     d     lock_type                  1a   overlay(lock_opt:1)
     d     lock_scope                 1a   overlay(lock_opt:2)
      *
      * objects-to-lock: array of system pointers.
      *
      * Lock state selections: array of char(1).
      *

     /* minimal length of lock request template, WITHOUT extension */
     d min_lock_request_tmpl_length...
     d                 c                   16

     /* minimal length of lock request template, WITH extension */
     d min_lock_request_tmpl_length_ext...
     d                 c                   32

     /**
      * @BIF _LOCK (Lock Object (LOCK))
      */
     d lockobj         pr                  extproc('_LOCK')
     d     lock_request...
     d                                     likeds(lock_request_tmpl_t)

     /**
      * @BIF _UNLOCK (Unlock Object (UNLOCK))
      */
     d unlockobj       pr                  extproc('_UNLOCK')
     d     unlock_request...
     d                                     likeds(lock_request_tmpl_t)

     /**
      * @BIF _LOCKSL1 (Lock Space Location (LOCKSL))
      *
      * @remark _LOCKSL1 locks one space location.
      */
     d locksl1         pr                  extproc('_LOCKSL1')
     d     space_location...
     d                                 *
     d     request                    1a

     /**
      * @BIF _LOCKSL2 (Lock Space Location (LOCKSL))
      *
      * @param lock_request, pointer to DS lock_request_tmpl_ext_t.
      * @remark _LOCKSL2 accepts address of spcptr rather than a
      *         spcptr to instruction template as what _LOCKSL1
      *         behaves.  So it's necessary to pass a pointer to
      *         pointer to it.  This also applies to _UNLOCKSL2,
      *         _LOCKTSL, and _UNLCKTSL.
      */
     d locksl2         pr                  extproc('_LOCKSL2')
     d     lock_request...
     d                                     likeds(
     d                                       lock_request_tmpl_ext_t)

     /**
      * @BIF _UNLOCKSL1 (Unlock Space Location (UNLOCKSL))
      *
      * @remark _UNLOCKSL1 unlocks one space location.
      */
     d unlocksl1       pr                  extproc('_UNLOCKSL1')
     d     space_location...
     d                                 *
     d     request                    1a

     /**
      * @BIF _UNLOCKSL2 (Unlock Space Location (UNLOCKSL))
      *
      * @param lock_request, pointer to DS lock_request_tmpl_ext_t.
      */
     d unlocksl2       pr                  extproc('_UNLOCKSL2')
     d     lock_request...
     d                                 *

     /**
      * @BIF _LOCKTSL (Lock Teraspace Storage Location (LOCKTSL))
      */
     d locktsl         pr                  extproc('_LOCKTSL')
     d     lock_request...
     d                                 *

     /**
      * @BIF _UNLCKTSL (Unlock Teraspace Storage Location (UNLCKTSL))
      */
     d unlcktsl        pr                  extproc('_UNLCKTSL')
     d     lock_request...
     d                                 *

     /**
      * Materailization template of _MATAOL.
      */
     d mataol_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     cur_lock_state...
     d                                1a
     d                                3a
     d     num_lockd                  5i 0
     d                                2a

     /**
      * Offset from the start of mataol_tmpl_t to lock description
      * templates.
      */
     d mataol_lockd_offset...
     d                 c                   16

     /* Length of lock-description of MATAOL */
     d mataol_lockd_length...
     d                 c                   32

     /**
      * Lock description structure.
      */
     d mataol_lock_desc_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     lock_holder...
     d                                 *
     d     lock_type                  1a
     d     lock_status...
     d                                1a
     d     lock_status_2...
     d                                1a
     d                                1a
     d     unopend_thread_handle...
     d                               10u 0
     d     thread_id                  8a

     /**
      * @BIF _MATAOL (Materialize Allocated Object Locks (MATAOL))
      */
     d mataol          pr                  extproc('_MATAOL')
     d     receiver                        likeds(mataol_tmpl_t)
     d     syp_or_spp                  *

     /**
      * Materailization template of _MATOBJLK.
      */
     d matobjlk_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     cur_lock_state...
     d                                1a
     d                                3a
     d     num_lockd                  5i 0
     d                                2a

     /**
      * Offset from the start of matobjlk_tmpl_t to lock description
      * templates.
      */
     d matobjlk_lockd_offset...
     d                 c                   16

     /* Length of lock-description of MATOBJLK */
     d matobjlk_lockd_length...
     d                 c                   32

     /**
      * Lock description structure.
      */
     d matobjlk_lock_desc_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     lock_holder...
     d                                 *
     d     lock_type                  1a
     d     lock_status...
     d                                1a
     d     lock_status_2...
     d                                1a
     d                                1a
     d     unopend_thread_handle...
     d                               10u 0
     d     thread_id                  8a

     /**
      * @BIF _MATOBJLK (Materialize Object Locks (MATOBJLK))
      *
      * @remark The key difference between MATAOL and MATOBJLK is that
      *         MATAOL only materializes locks already allocated on a
      *         lockable object, while MATOBJLK also materializes
      *         locks being requested to allocate on a lockable
      *         object, either synchronously or asynchronously.
      */
     d matobjlk        pr                  extproc('_MATOBJLK')
     d     receiver                        likeds(matobjlk_tmpl_t)
     d     syp_or_spp                  *

     /* Materialization template of MATPRLK. */
     d matprlk_tmpl_t  ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     num_lockd                  5i 0
     d     expanded_num_lockd...
     d                               10i 0
     d                                2a

     /* Lock description template of MATPRLK. */
     d matprlk_lock_desc_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     syp_or_spp                  *
     d     lock_type                  1a
     d     process_lock_status...
     d                                1a
     d     lock_info                  1a
     d                                1a
     d     unopened_thread_handle...
     d                               10u 0
     d     thread_id                  8a

     /**
      * Offset from the start of matprlk_tmpl_t to
      * lock description templates.
      */
     d matprlk_lockd_offset...
     d                 c                   16

     /**
      * Length of lock description template for MATPRLK.
      */
     d matprlk_lockd_length...
     d                 c                   32

     /**
      * @BIF _MATPRLK1 (Materialize Process Locks (MATPRLK))
      */
     d matprlk1        pr                  extproc('_MATPRLK1')
     d     receiver                        likeds(matprlk_tmpl_t)

     /**
      * @BIF _MATPRLK2 (Materialize Process Locks (MATPRLK))
      *
      * _MARPRLK2 accept a system pointer to a PCS object
      * as its second operand.
      */
     d matprlk2        pr                  extproc('_MATPRLK2')
     d     receiver                        likeds(matprlk_tmpl_t)
     d     pcs                         *

     /* Materialization template of MATSELLK. */
     d matsellk_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     cur_lock_states...
     d                                1a
     d                                3a
     d     num_lockd                  5i 0
      *
      * Return format.
      * @remark This is an output field!
      *   Bits 0-3, reserved (Binary 0).
      *   Bit 4, if expanded results are returned (this flag is set to
      *          binary 1) 2-byte lock descriptions are returned;
      *          otherwise 32-byte lock descriptions are returned.
      *   Bit 5, do not return locks held by a transaction.
      *   Bit 6, do not return locks held by a process.
      *   Bit 7, do not return locks held or waited on by a thread.
      *
     d     return_fmt                 1a
     d                                1a

     /* Lock description template of MATSELLK. */
     d matsellk_lock_desc_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     lock_type                  1a
     d     lock_status...
     d                                1a
     d                               14a
     d                                1a
     d     suspend_ptr...
     d                                 *

     /**
      * Offset from the start of matsellk_tmpl_t to
      * lock description templates.
      */
     d matsellk_lockd_offset...
     d                 c                   16

     /**
      * Lengths of lock description template for MATSELLK.
      */
     d matsellk_lockd_length...
     d                 c                   2
     d matsellk_lockd_length_exp...
     d                 c                   32

     /**
      * @BIF _MATSELLK (Materialize Materialize Selected Locks (MATSELLK))
      *
      * @remark In contrast with MATAOL, who materializes locks
      *         currently allocated on a designated lockable object,
      *         the locks materialized by MATSELLK are the thread
      *         scoped locks held by the current thread and the
      *         process scoped locks held by the process containing
      *         the current thread.
      */
     d matsellk        pr                  extproc('_MATSELLK')
     d     receiver                        likeds(matsellk_tmpl_t)
     d     syp_or_spp                  *

     /**
      * Process selection template of MATPRECL.
      */
     d matprecl_process_tmpl_t...
     d                 ds                  qualified
     d     pcs                         *
      *
      * Lock selection
      *
      * Bit 0: Materialize held locks
      *   0 = Do not materialize
      *   1 = Materialize
      *
      * Bit 1: Materialize locks waited for
      *   0 = Do not materialize
      *   1 = Materialize
      *
      * Bits 2-7: Reserved
      *
     d     lock_sel                   1a
      *
      * Template options
      *
      * Bit 0: Format of number of locks
      *   0 = Use Bin(4) for number of locks
      *   1 = Use Bin(2) for number of locks
      *
      * Bits 1-7: Reserved
      *
     d     format_opt                 1a
     d                               14a

     /* Materialization template of MATPRECL. */
     d mat_record_lock_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     nums                       8a
     d     locks_held_4...
     d                               10i 0 overlay(nums:1)
     d     lcoks_waited_4...
     d                               10i 0 overlay(nums:5)
     d     locks_held_2...
     d                                5i 0 overlay(nums:1)
     d     lcoks_waited_2...
     d                                5i 0 overlay(nums:3)
      *
      * Locks held descriptions.
      * Repeated number of lock held descriptions times.
      *
      * Lock waited for descriptions.
      * Repeated number of lock waited for descriptions times.
      *

     /* Minimal length of materialization template of MATPRECL and MATDRECL. */
     d min_reclock_tmpl_length...
     d                 c                   16

     /* Length of a record lock description */
     d record_lockd_length...
     d                 c                   32

     /* Lock description for record locks. */
     d record_lock_desc_t...
     d                 ds                  qualified
      *
      * When returned by instruction MATPRECL, obj
      * refers to a data space object (hex 0B90). When returned
      * by instruction MATDRECL, obj refers to a PCS object (hex 1AEF).
      *
     d     obj                         *
      * Relative record number
     d     rrn                       10u 0
      *
      * Lock state or lock state requested.
      *
      * Hex 30 = DLWK (Database lock weak) lock state.
      * Hex C0 = DLRD (Database lock read) lock state.
      * Hex F8 = DLUP (Database lock update) lock state.
      *
     d     lock_state                 1a
      *
      * Lock holder/waiter information
      *
      * Bit 0: Lock scope object type.
      * 0 = Process control space.
      * 1 = Transaction control structure.
      *
      * Bit 1: Lock scope.
      * 0 = Lock is scoped to the lock scope object type.
      * 1 = Lock is scoped to the thread.
      *
      * Bits 2-7: Reserved (binary 0).
      *
     d     lock_info                  1a
     d     thread_id                  8a

     /**
      * @BIF _MATPRECL (Materialize Process Record Locks (MATPRECL))
      */
     d matprecl        pr                  extproc('_MATPRECL')
     d     receiver                        likeds(mat_record_lock_tmpl_t)
     d     process                         likeds(
     d                                       matprecl_process_tmpl_t)

     /**
      * Process selection template of MATDRECL.
      */
     d matdrecl_record_tmpl_t...
     d                 ds                  qualified
      * System pointer to target data space
     d     dds                         *
      *
      * The record number is a relative record number within that data
      * space. If the record number is zero then all locks on the
      * specified data space will be materialized.
      *
     d     rrn                       10i 0
     d                                4a
      *
      * Lock selection
      *
      * Bit 0: Materialize data space locks held
      *   0 = Do not materialize
      *   1 = Materialize
      *
      * Bit 1: Materialize data space locks waited for
      *   0 = Do not materialize
      *   1 = Materialize
      *
      * Bits 2-7: Reserved
      *
     d     lock_sel                   1a
      *
      * Template options
      *
      * Bit 0: Format of number of locks
      *   0 = Use Bin(4) for number of locks
      *   1 = Use Bin(2) for number of locks
      *
      * Bits 1-7: Reserved
      *
     d     format_opt                 1a
     d                               14a

     /**
      * @BIF _MATDRECL (Materialize Data Space Record Locks (MATDRECL))
      */
     d matdrecl        pr                  extproc('_MATDRECL')
     d     receiver                        likeds(mat_record_lock_tmpl_t)
     d     dds                             likeds(
     d                                       matdrecl_record_tmpl_t)

     /**
      * @BIF _XFRLOCK (Transfer Object Lock (XFRLOCK))
      */
     d xfrlock         pr                  extproc('_XFRLOCK')
     d     pcs                         *
     d     lock_request...
     d                                     likeds(lock_request_tmpl_t)

     /* end -- object lock management */

     /* mutex management */
     d mutex_t         ds                  qualified
      * synchronization pointer
     d     syn_ptr                     *
     d     name                      16a

     /* CRTMTX template */
     d crtmtx_option_t...
     d                 ds                  qualified
     d                                1a
     d     name_opt                   1a
     d     keep_valid_opt...
     d                                1a
     d     recursive_opt...
     d                                1a
     d                               28a

     /**
      * @BIF _CRTMTX (Create Pointer-Based Mutex (CRTMTX))
      *
      * @return 0 if the mutex is created; otherwise an error number.
      */
     d crtmtx          pr            10i 0 extproc('_CRTMTX')
     d     mtx                             likeds(mutex_t)
     d     crt_opt                     *   value

     /**
      * @BIF _DESMTX (Destroy Pointer-Based Mutex (DESMTX))
      *
      * @return 0 if the mutex is created; otherwise an error number.
      */
     d desmtx          pr            10i 0 extproc('_DESMTX')
     d     mtx                             likeds(mutex_t)
     d     des_opt                     *   value

     /* LOCKMTX template */
     d lockmtx_tmpl_t...
     d                 ds                  qualified
     /* hex 00 = wait infinitely
      * hex 01 = wait for the mutex for the specified amount of
      *          time. If the mutex still cannot be obtained, the
      *          EAGAIN error number is returned.
      * hex 02 = return immmediately with an EBUSY error number.
      */
     d     timeout_opt...
     d                                1a
     /*
      * bit 1, wait time-out format
      *   0 = time-out is specified in seconds/microseconds
      *   1 = time-out is a 8-byte system clock value
      *
      * bit 2, MPL control during wait
      *   0 = remain in the current MPL set
      *   1 = do not remain in the current MPL set
      *
      * bit 3, asynchronous signals processing option
      *   0 = do not allow asynchronous signal processing during mutex wait
      *   1 = allow asynchronous signal processing during mutex wait
      *
      * bit 4, wait type
      *   0 = normal wait
      *   1 = restrict wait
      *
      * @remark The wait type option is used by kernel-mode programs
      *         or procedures to specify what type of wait to
      *         perform. The wait type field is ignored when the
      *         thread execution mode is not kernel-mode.
      */
     d     lock_opt                   1a
     d                                6a
     d     timeout                    8a

     /**
      * @BIF _LOCKMTX (Lock Pointer-Based Mutex (LOCKMTX))
      */
     d lockmtx         pr            10i 0 extproc('_LOCKMTX')
     d     mtx                             likeds(mutex_t)
     d     request                     *   value

     d MATPRMTX_OPT_RETURN_MTX_REPLICAS...
     d                 c                   x'80000000'
     d MATPRMTX_OPT_MAT_MULT_THD...
     d                 c                   x'40000000'
     d MATPRMTX_OPT_RETURN_EXT_MTX_INFO...
     d                 c                   x'20000000'
     d MATPRMTX_OPT_MAT_ONLY_WAITERS...
     d                 c                   x'08000000'

     /**
      * Materialization template for MATPRMTX.
      *
      * @remark For matprmtx_entry_1_t and matprmtx_entry_2_t
      */
     d matprmtx_tmpl_a_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
      * Number of mutex lock entries
     d     num_entries...
     d                               10i 0
     d                                4a
      * materialized entries

     /**
      * Materialization template for MATPRMTX.
      *
      * @remark For matprmtx_entry_3_t and matprmtx_entry_4_t
      */
     d matprmtx_tmpl_b_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
      * Number of threads in process
     d     threads                   10u 0
      * Number of thread mutex descriptors
     d     descs                     10u 0
      * materialized entries

     /**
      * Entries returned by MATPRMTX when:
      *  - materialize threads option is set to materialize only specified thread
      *  - mutex attributes option is set to do not return additional mutex attributes
      */
     d matprmtx_entry_1_t...
     d                 ds                  qualified
     d     mtx_ptr                     *
      *
      * Mutex state being described
      *   Hex 00 = The mutex is held by the thread
      *   Hex 01 = The thread is waiting to acquire the mutex
      *
     d     mtx_sts                    1a
     d                               15a

     /**
      * Entries returned by MATPRMTX when:
      *  - materialize threads option is set to materialize only specified thread
      *  - mutex attributes option is set to return additional mutex attributes
      */
     d matprmtx_entry_2_t...
     d                 ds                  qualified
     d     mtx_ptr                     *
     d     mtx_sts                    1a
     d                               15a
     d     mtx_name                  16a
      * Holder process ID
     d     holder_prc_id...
     d                               30a
     d                                2a
      * Mutex holder thread ID
     d     holder_thd_id...
     d                                8a
      * Mutex holder unique thread value
     d     holder_thd_unique_val...
     d                                8a
     d     waiters                   10i 0
     d                               12a

     /**
      * Entries returned by MATPRMTX when:
      *  - materialize threads option is set to materialize multiple
      *    threads in specified thread's process
      *  - mutex attributes option is set to do not return additional
      *    mutex attributes
      */
     d matprmtx_entry_3_t...
     d                 ds                  qualified
      * Identified thread ID
     d     thd_id                     8a
      * Number of descriptors for identified thread
     d     descs                     10u 0
      * Descriptor entry number for identified thread
     d     desc_num                  10u 0
     d     mtx                         *
      *
      * Mutex state being described
      *  Hex 00 = The mutex is held by the thread
      *  Hex 01 = The thread is waiting to acquire the mutex
      *
     d     mtx_sts                    1a
     d                               15a

     /**
      * Entries returned by MATPRMTX when:
      *  - materialize threads option is set to materialize multiple
      *    threads in specified thread's process
      *  - mutex attributes option is set to return additional
      *    mutex attributes
      */
     d matprmtx_entry_4_t...
     d                 ds                  qualified
      * Identified thread ID
     d     thd_id                     8a
      * Number of descriptors for identified thread
     d     descs                     10u 0
      * Descriptor entry number for identified thread
     d     desc_num                  10u 0
     d     mtx                         *
      *
      * Mutex state being described
      *  Hex 00 = The mutex is held by the thread
      *  Hex 01 = The thread is waiting to acquire the mutex
      *
     d     mtx_sts                    1a
     d                               15a
     d     mtx_name                  16a
      * Holder process ID
     d     holder_prc_id...
     d                               30a
     d                                2a
      * Mutex holder thread ID
     d     holder_thd_id...
     d                                8a
      * Mutex holder unique thread value
     d     holder_thd_unique_val...
     d                                8a
     d     waiters                   10i 0
     d                               12a

     d matprmtx_tmpl_t...
     d                 ds                  qualified

     /**
      * @BIF _MATPRMTX (Materialize Process Mutex (MATPRMTX))
      */
     d matprmtx        pr                  extproc('_MATPRMTX')
     d     receiver                        likeds(matprmtx_tmpl_t)
     d     pcs                         *
     d     opt                       10u 0

     /**
      * @BIF _UNLKMTX (Unlock Pointer-Based Mutex (UNLKMTX))
      */
     d unlkmtx         pr            10i 0 extproc('_UNLKMTX')
     d     mtx                             likeds(mutex_t)

     /**
      * @BIF _MATMTX (Materialize Mutex (MATMTX))
      */
     d matmtx          pr                  extproc('_MATMTX')
     d     reciever                    *   value
     d     mtx                             likeds(mutex_t)
     d     opt                         *   value

     /* basic mutex attribute template */
     d mutex_basic_attr_t...
     d                 ds            80    qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d                                4a
     d     num_waiters...
     d                               10i 0
     d     name                      16a
     d     owner_process_id...
     d                               30a
     d                               18a

     /* basic mutex attribute template */
     d mutex_basic_attr2_t...
     d                 ds            80    qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d                                4a
     d     num_waiters...
     d                               10i 0
     d     name                      16a
     d     owner_process_id...
     d                               30a
     d                                2a
     d     owner_thread_id...
     d                                8a
     d     owner_thread_unique_value...
     d                                8a

     /* basic mutex attribute template */
     d mutex_basic_attr3_t...
     d                 ds           240    qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d                                4a
     d     num_waiters...
     d                               10i 0
     d     name                      16a
     d     owner_process_id...
     d                               30a
     d                                2a
     d     owner_thread_id...
     d                                8a
     d     owner_thread_unique_value...
     d                                8a
     d     last_locker_process_id...
     d                               30a
     d                                2a
     d     last_locker_thread_id...
     d                                8a
     d     last_locker_thread_unique_value...
     d                                8a
     d     last_unlocker_process_id...
     d                               30a
     d                                2a
     d     last_unlocker_thread_id...
     d                                8a
     d     last_unlocker_thread_unique_value...
     d                                8a
      * 00 = recursive attempls to lock this mutex will not
      *      be permitted
      * 01 = recursive attempls to lock this mutex will be permitted
      *      by the same thread has already locked the MTX
     d     recursive_flag...
     d                                1a
     d     keep_valid_flag...
     d                                1a
      * 00 = holding thread has not terminated
      * 01 = holding thread has terminated
     d     pending_flag...
     d                                1a
     d                               13a
     d     lock_count                20u 0
      * first 8 characters of the name of the program module
      * that created the mutex
     d     creator                    8a
     d     original_mutex...
     d                                 *
     d                               16a

     /* mutex waiter structure */
     d mutex_waiter_t  ds            48    qualified
     d     process_id                30a
     d                               18a

     /* mutex waiter structure */
     d mutex_waiter2_t...
     d                 ds            48    qualified
     d     process_id                30a
     d                                2a
     d     thread_id                  8a
     d     thread_unique_value...
     d                                8a

     /* standard materialization template of MATMTX */
     d matmtx_std_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     basic_attr                      likeds(mutex_basic_attr_t)
     d     waiters                         likeds(mutex_waiter_t)
     d                                     dim(1024)

     /* format 0 extended materialization template of MATMTX */
     d matmtx_ext0_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     basic_attr                      likeds(mutex_basic_attr2_t)
     d     waiters                         likeds(mutex_waiter2_t)
     d                                     dim(1024)

     /* format 1 extended materialization template of MATMTX */
     d matmtx_ext1_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     basic_attr                      likeds(mutex_basic_attr3_t)
     d     waiters                         likeds(mutex_waiter2_t)
     d                                     dim(1024)

     /* end -- mutex management */

     /* context management */

     /**
      * Symbolic object identification
      *
      * This form of 32-byte object ID is used by MI instructions to
      * represent the name of a MI object symbolicly.
      */
     d sym_object_id_t...
     d                 ds                  qualified
      * object type code, for example x'0A02' for a *USRQ object
     d     type                       2a
     d     type_code                  1a   overlay(type)
     d     subtype_code...
     d                                1a   overlay(type:2)
     d     name                      30a

     /**
      * Context object entry returned by MATCTX with
      * matctx_option_t.sel_flag x'03', x'07', or x'0B'.
      */
     d context_entry_full_t...
     d                 ds                  qualified
     d     objid                           likeds(sym_object_id_t)
     d     ptr                         *

     /**
      * Materialization options for MATCTX.
      *
      * @remark When materializing object entries in a context, bits 6-7 determine the format of the
      *   - Bit 6 = 1, bit 7 = 1: object entries are returned as an array of DSs of type context_ent
      *   - Bit 6 = 1, bit 7 = 0: object entries are returned as an array of system pointers.
      *   - Bit 6 = 0, bit 7 = 1: object entries are returned as an array of DSs of type sym_object_
      */
     d matctx_option_t...
     d                 ds            46    qualified
      *
      * Information requirements (1 = materialize).
      *   Bits 0-3, reserved (binary 0)
      *   Bit 4, materialize extended context attribute
      *   Bit 5, validation
      *     0 = Validate system pointers
      *     1 = No validation
      *   Bit 6, materialize system pointers to objects reside in target context
      *   Bit 7, materialize symbolic identification of objects reside in target context
      *
     d     sel_flag                   1a                                        selection flag
     d     sel_criteria...
     d                                1a                                        selection criteria
     d     name_len                   5i 0                                      selection name lengt
     d     obj_type                   1a                                        object type code
     d     obj_subtype...
     d                                1a                                        object sub-type code
     d     name                      30a                                        object name
     d     timestamp...
     d                                8a                                        selection timestamp
     d     asp_num                    2a                                        indepedent ASP numbe

     /* length of MATCTX option structure */
     d matctx_option_length...
     d                 c                   46

     /* Receiver template for MATCTX. */
     d matctx_receiver_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0                                      bytes provided
     d     bytes_out                 10i 0                                      bytes available
     d     ctx_type                   2a                                        context type/sub-typ
     d     ctx_name                  30a                                        context name
     d     ctx_opt                    4a                                        context options
     d     rcvy_opt                   4a                                        recovery options
     d     spc_size                  10i 0                                      space size
     d     spc_init_val...
     d                                1a                                        initial value of spa
     d     perf_cls                   4a                                        performance class
     d                               23a                                        reserved
     d     acc_grp                     *                                        access group
      * selected context entries

     /* Receiver template for MATCTX with extension. */
     d matctx_receiver_ext_t...
     d                 ds                  qualified
     d     base                            likeds(matctx_receiver_t)
     d     ext_attr                   1a
     d                                7a
     d     cur_time                   8a
      * selected context entries

      * @deprecated Calculate the size of receiver template by BIF %size()
     d matctx_offset1...
     d                 c                   96

     /**
      * @BIF _MATCTX1 (Materialize Context (MATCTX))
      *
      * @example test/t031.rpgle
      */
     d matctx1         pr                  extproc('_MATCTX1')
     d     receiver                        likeds(matctx_receiver_t)
     d     option                    46a

     /**
      * @BIF _MATCTX2 (Materialize Context (MATCTX)).
      *
      * Different from _MATCTX1, _MATCTX2 accepts an additional ctx
      * operand which is a system pointer to the context object whose
      * attributes and/or object entries is to be materialized.
      *
      * @example test/t129.rpgle
      */
     d matctx2         pr                  extproc('_MATCTX2')
     d     receiver                        likeds(matctx_receiver_t)
     d     ctx                         *
     d     option                          likeds(matctx_option_t)

     /**
      * Sytem state wrapper for MATCTX -- the QusMaterializeContext API
      *
      * QusMaterializeContext materialize object entries in a specific context, in either user domai
      *
      * @remark exported by SRVPGM QUSMIAPI.
      *
      * @attention Different from MATCTX, ctx parameter is passed by value
      *
      * @example test/t130.rpgle
      */
     d QusMaterializeContext...
     d                 pr                  extproc('QusMaterializeContext')
     d     receiver                        likeds(matctx_receiver_t)
     d     ctx                         *   value procptr
     d     option                          likeds(matctx_option_t)

     /* end -- context management */

     /* authorization management */

     /* Materialized authorization info of MATAU */
     d matau_tmpl_t    ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
      *
      * Private authorization (1 = authorized)
      *   Bit 0  = Object control
      *   Bit 1  = Object management
      *   Bit 2  = Authorized pointer
      *   Bit 3  = Space authority
      *   Bit 4  = Retrieve
      *   Bit 5  = Insert
      *   Bit 6  = Delete
      *   Bit 7  = Update
      *   Bit 8  = Ownership (1 = yes)
      *   Bit 9  = Excluded
      *   Bit 10 = Authority list management
      *   Bit 11 = Execute
      *   Bit 12 = Alter
      *   Bit 13 = Reference
      *   Bit 14-15, reserved (binary 0)
      *
     d     private_auth...
     d                                2a
     d     public_auth...
     d                                2a
      *
      * Private authorization source
      *   0 =  Authority to object
      *   1 =  Authority to authority list
      *   2 =  Authority to object via primary group
      *   3 =  Authority to authority list via primary group
      *
     d     pri_auth_source...
     d                                5u 0
      *
      * Public authorization source
      *   0 =  Authority to object
      *   1 =  Authority to authority list
      *
     d     pub_auth_source...
     d                                5u 0

     /* Materialize option of MATAU */
     d matau_option_t  ds                  qualified
      *
      * Bit 0, ignore all object special authority.
      *   0 = No
      *   1 = Yes
      *
     d     flag                       2a
     d                               14a
     d     usrprf                      *

     /**
      * @BIF _MATAU1 (Materialize Authority (MATAU))
      *
      * Materialize public and private authority of a permanent MI object.
      */
     d matau1          pr                  extproc('_MATAU1')
     d     receiver                        likeds(matau_tmpl_t)
     d     object                      *
      * System pointer to a *USRPRF object or a matau_option_t DS.
     d     usrprf_or_option...
     d                                 *

     /**
      * @BIF _MATAU2 (Materialize Authority (MATAU))
      *
      * Materialize public authority of a permanent MI object.
      *
      * @remark _MATAU2 does not accept a user profile operand.
      */
     d matau2          pr                  extproc('_MATAU2')
     d     receiver                        likeds(matau_tmpl_t)
     d     object                      *

     /* Materialization option of MATAL */
     d matal_option_t  ds                  qualified
      *
      * Control flag.
      *
      * hex 12 = Materialize count of entries matching the criteria
      * hex 22 = Materialize identification of entries matching
      *          the criteria and return information using
      *          short description format
      * hex 32 = Materialize identification of entries matching
      *          the criteria and return information using long
      *          description format
      *
     d     flag                       1a
      *
      * Selection criteria.
      *
      * hex 00 = All authority list or authority list extension entries
      * hex 01 = Select by object type code.
      * hex 02 = Select by object type code and subtype code.
      *
     d     criteria                   1a
     d                                2a
     d     type_code                  1a
     d     subtype_code...
     d                                1a
     d                               30a

     /* Materialization template of MATAL */
     d matal_tmpl_t    ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
      * *AUTL
     d     obj_type                   2a
     d     obj_name                  30a
     d     crt_option                 4a
     d                                4a
     d     spc_size                  10i 0
     d     init_spc_value...
     d                                1a
     d     performance_class...
     d                                4a
     d                                7a
     d     contex                      *
     d                               16a
      *
      * Bit 0, override specific object authority
      * 0 = No
      * 1 = Yes
      *
     d     attr                       4a
     d                               28a
     d     num_entries...
     d                               10u 0
     d                               12a

     /* Short *AUTL entry description */
     d autl_entry_short_desc_t...
     d                 ds                  qualified
     d     obj_type                   2a
     d                               14a
     d     object                      *

     /* Long *AUTL entry description */
     d autl_entry_long_desc_t...
     d                 ds                  qualified
     d     obj_type                   2a
     d     obj_name                  30a
     d                               16a
     d     object                      *
     d     obj_owner                   *
     d     ctx_type                   2a
     d     ctx_name                  30a
     d     context                     *

     /**
      * @BIF _MATAL (Materialize Authority List (MATAL))
      */
     d matal           pr                  extproc('_MATAL')
     d     receiver                        likeds(matal_tmpl_t)
     d     autl                        *
     d     option                          likeds(matal_option_t)

     /* MATAUU template */
     d matauu_tmpl_t   ds            16    qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     public_auth...
     d                                2a
     d     num_private_users...
     d                                5i 0
     d     reserved                   4a

     /* long format privately authorized USRPRF struction */
     d auth_desc_long_t...
     d                 ds            80    qualified
     d                                     based(dummy_ptr)
     d     usrprf_type...
     d                                2a
     d     usrprf_name...
     d                               30a
     d     private_auth...
     d                                2a
     d     reserved                  12a
     d     usrprf                      *

     /* length of structure auth_desc_long_t */
     d AUTH_DESC_LONG_LENGTH...
     d                 c                   64

     /**
      * @BIF MATAUU (Materialize Authorized Users (MATAUU))
      */
     d matauu          pr                  extproc('_MATAUU')
     d     receiver                    *   value
     d     obj                         *
     d     option                     1a

     /**
      * @BIF _MODINVAU (Modify Invocation Authority Attributes (MODINVAU))
      */
     d modinvau        pr                  extproc('_MODINVAU')
      *
      * option
      *   hex 00 = Do not suppress adopted user profile authority
      *   hex 01 = Suppress adopted user profile authority
      *
     d     option                     1a

     /* Object template for TESTAU */
     d testau_object_tmpl_t...
     d                 ds                  qualified
     d     relative_invocation_number...
     d                                5i 0
      * reserved (binary 0)
     d                               14a
     d     object                      *

     /**
      * @BIF _TESTAU1 (Test Authority (TESTAU))
      *
      * Test the authority to an MI object of the current invocation
      * or a previous invocation.
      *
      * @return 1 = authroized; 0 = NOT authorized.
      *
      * @remark _TESTAU1 accept 2 operands.
      */
     d testau1         pr            10i 0 extproc('_TESTAU1')
      * System pointer to target MI object or space pointer to object
      * template DS defined by testau_object_tmpl_t.
     d     obj_or_tmpl...
     d                                 *
     d     auth_required...
     d                                2a

     /**
      * @BIF _TESTAU2 (Test Authority (TESTAU))
      *
      * Test the authority to an MI object of the current invocation
      * or a previous invocation.
      *
      * @return 1 = authroized; 0 = NOT authorized.
      *
      * @remark _TESTAU2 accept 3 operands including available
      *         authorities returned in operand 1.
      */
     d testau2         pr            10i 0 extproc('_TESTAU2')
     d     auth_available...
     d                                2a
      * System pointer to target MI object or space pointer to object
      * template DS defined by testau_object_tmpl_t.
     d     obj_or_tmpl...
     d                                 *
     d     auth_required...
     d                                2a

     /* Authorization template used by TESTEAU. */
     d testeau_auth_tmpl_t...
     d                 ds                  qualified
      *
      * Privileged instruction template
      *   Bit  0 = Create Logical Unit Description
      *   Bit  1 = Create Network Description
      *   Bit  2 = Create Controller Description
      *   Bit  3 = Create user profile
      *   Bit  4 = Modify user profile
      *   Bit  5 = Diagnose
      *   Bit  6 = Terminate machine processing
      *   Bit  7 = Initiate process
      *   Bit  8 = Modify Resource Management Control
      *   Bit  9 = Create Mode Description
      *   Bit 10 = Create Class of Service Description
      *   Bit 11-31, reserved (binary 0)
      *
     d     priv_inst_tmpl...
     d                                4a
      *
      * Special authority template
      *   Bit  0 = All object
      *   Bit  1 = Load (unrestricted)
      *   Bit  2 = Dump (unrestricted)
      *   Bit  3 = Suspend (unrestricted)
      *   Bit  4 = Load (restricted)
      *   Bit  5 = Dump (restricted)
      *   Bit  6 = Suspend (restricted)
      *   Bit  7 = Process control
      *   Bit  8 = Reserved (binary 0)
      *   Bit  9 = Service
      *   Bit 10 = Auditor authroity
      *   Bit 11 = Spool control
      *   Bit 12 = I/O system configuration
      *   Bit 13-23, reserved (binary 0)
      *   Bit 24-31, Modify machine attributes
      *     Bit 24 = Group 2
      *     Bit 25 = Group 3
      *     Bit 26 = Group 4
      *     Bit 27 = Group 5
      *     Bit 28 = Group 6
      *     Bit 29 = Group 7
      *     Bit 30 = Group 8
      *     Bit 31 = Group 9
      *
     d     spec_auth_tmpl...
     d                                4a

     /**
      * @BIF _TESTEAU3 (Test Extended Authorities (TESTEAU))
      */
     d testeau3        pr            10i 0 extproc('_TESTEAU3')
     d     avail_auth                      likeds(testeau_auth_tmpl_t)
     d     required_auth...
     d                                     likeds(testeau_auth_tmpl_t)

     /**
      * @BIF _TESTEAU4 (Test Extended Authorities (TESTEAU))
      */
     d testeau4        pr            10i 0 extproc('_TESTEAU4')
     d     required_auth...
     d                                     likeds(testeau_auth_tmpl_t)

     /* Selection template of MATUPID. */
     d matupid_select_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
      *
      * Format option
      *   hex 01 = return short template
      *   hex 02 = return long template
      *
      * @remark The short format contains only a system pointer to
      *         each materialized user profile object.
      *
     d     fmt_option                 1a
      *
      * Materialization type option
      *   hex 00 = list provided
      *   hex 41 = Return all gids starting with the specified gid
      *   hex 80 = Return all uids then all gids
      *   hex 81 = Return all uids then gids starting with the
      *            specified uid
      *
     d     type_option...
     d                                1a
     d     num_uids                  10u 0
     d     num_gids                  10u 0
     d                               10a
      * array of Ubin(4) uids or gids

     /* Materialization template of MATUPID. */
     d matupid_tmpl_t  ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
      * Number of uids returned
     d     num_uids                  10u 0
      * Number of gids returned
     d     num_gids                  10u 0
      *
      * Bit 0, one or more USRPRF pointers are not set.
      * Bits 1-7, reserved.
      *
     d     flag                       1a
     d                               15a
      * materialized user profile templates

     /* Long format materialization template. */
     d matupid_usrprf_long_t...
     d                 ds                  qualified
     d     prf_type                   2a
     d     prf_name                  30a
      * uid or gid
     d     id                        10u 0
      *
      * type of id
      *   hex 01 = user id
      *   hex 02 = group id
      *
     d     id_type                    1a
      *
      * Bit 0, system pointer to USRPRF is not set.
      * Bits 1-7, reserved.
      *
     d     flag                       1a
     d                               10a
     d     usrprf                      *

     /**
      * @BIF _MATUPID (Materialize User Profile Pointers from ID (MATUPID))
      */
     d matupid         pr                  extproc('_MATUPID')
     d     output                          likeds(matupid_tmpl_t)
     d     input                           likeds(matupid_select_tmpl_t)

     /* Template of available authorizations returned by TESTULA. */
     d testula_receiver_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     num_auth_returned...
     d                                5i 0
     d                                6a
      * authroization templates returned as array of char(2)

     /**
      * Test option tempalte used by TESTULA.
      *
      * This template contains a governing user profile and optionally
      * one or more group profiles as the sources of authorities to
      * an MI object.
      */
     d testula_option_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     num_group_pfrs...
     d                                5i 0
      *
      * Required authorities.
      *   Bit  0 = Object control
      *   Bit  1 = Object management
      *   Bit  2 = Authorized pointer
      *   Bit  3 = Space authority
      *   Bit  4 = Retrieve
      *   Bit  5 = Insert
      *   Bit  6 = Delete
      *   Bit  7 = Update
      *   Bit  8 = Ownership (1 = yes)
      *   Bit  9 = Excluded
      *   Bit 10 = Authority list management
      *   Bit 11 = Execute
      *   Bit 12 = Alter
      *   Bit 13 = Reference
      *   Bit 14 = Reserved (binary 0)
      *   Bit 15 = Test option
      *            0 = All of the above authorities must be present
      *            1 = Any one or more of the above authorities must be present
      *
     d     required_auth...
     d                                2a
      *
      * indicator of profile format
      *   hex 80 = Users are identified by system pointers
      *   hex 40 = Profiles are identified by uid/gid
      *
     d     indicator                  1a
      *
      * Test flag
      *   Bit 0 = Ignore pointer authority
      *   Bit 1-7, reserved (binary 0)
      *
     d     test_flag                  1a
     d                               10a
      * one user profile identification
      * zero or more group profile identifications

     /**
      * @BIF _TESTULA (Test User List Authority (TESTULA))
      *
      * @return 1 if authorized; otherwise 0.
      */
     d testula         pr            10i 0 extproc('_TESTULA')
     d     auth_available...
     d                                     likeds(testula_receiver_tmpl_t)
     d     object                      *
     d     test_option...
     d                                     likeds(testula_option_tmpl_t)

     /* end -- authorization management */

     /* process and thread management */

     /**
      * @BIF _PCOPTR (PCO Pointer (PCOPTR))
      *
      * A space pointer is returned, which points to the first byte of
      * the PCO (process communication object) for the process which
      * owns the program activation associated with the current
      * invocation. If the current invocation is a client executing in
      * a shared activation group then the pointer returned refers to
      * an object owned by a process other than the current process.
      */
     d pcoptr          pr              *   extproc('_PCOPTR')

     /**
      * @BIF _PCOPTR2 (Return PCO Pointer (PCOPTR2))
      *
      * Return PCO Pointer (PCOPTR2) obtains addressability to a
      * process' PCO (process communication object) and returns it in
      * a space pointer.
      */
     d pcoptr2         pr              *   extproc('_PCOPTR2')

     /**
      * @BIF _MATPRAGP (Materialize Process Activation Groups (MATPRAGP))
      */
     d matpragp        pr                  extproc('_MATPRAGP')
     d     receiver                    *   value

     d matpragp_...
     d   tmpl_t        ds                  qualified
     d                                     based(dummy_ptr)
     d     buf                    65535a
     d     bytes_in                  10i 0 overlay(buf : 1)
     d     bytes_out                 10i 0 overlay(buf : 5)
     d     agp_num                   10i 0 overlay(buf : 9)
     d     agp_marks                  4a   dim(16380)
     d                                     overlay(buf : 13)

     /**
      * Materialization template for MATPRATR when a scalar attribute
      * is materialized.
      */
     d matpratr_tmpl_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0

     /**
      * Materialization template for MATPRATR when a pointer attribute
      * is materialized.
      */
     d matpratr_ptr_tmpl_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d                                8a
     d     ptr                         *

     /* Process priority template */
     d process_priority_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     priority                   1a

     /**
      * @BIF _MATPRATR1 (Materialize Process Attributes (MATPRATR))
      */
     d matpratr1       pr                  extproc('_MATPRATR1')
     d     receiver                        likeds(matpratr_tmpl_t)
     d     option                     1a

     /**
      * @BIF _MATPRATR2 (Materialize Process Attributes (MATPRATR))
      */
     d matpratr2       pr                  extproc('_MATPRATR2')
     d     receiver                        likeds(matpratr_tmpl_t)
     d     pcs                         *
     d     option                     1a

     /**
      * @BIF _RETTHCNT (Retrive Thread Count (RETTHCNT))
      */
     d retthcnt        pr            10u 0 extproc('_RETTHCNT')

     /**
      * @BIF _RETTHID (Retrieve Thread Identifier (RETTHID))
      */
     d retthid         pr             8a   extproc('_RETTHID')

     /**
      * @BIF _TSTINLTH (Test Initial Thread (TSTINLTH))
      */
     d tstinlth        pr            10i 0 extproc('_TSTINLTH')

     /**
      * @BIF _TESTINTR (Test Pending Interrupts (TESTINTR))
      */
     d testintr        pr            10u 0 extproc('_TESTINTR')

     /**
      * @BIF _WAITTIME (Wait On Time (WAITTIME))
      */
     d waittime        pr                  extproc('_WAITTIME')
     d     wait_tmpl                 16a

     /* wait template for WAITTIME */
     d wait_tmpl_t     ds            16    qualified
     d     interval                  20u 0
     d     option                     2a
     d                                6a

     /* 8 microseconds in system closk format */
     d sysclock_eight_microsec...
     d                 c                   x'0000000000008000'

     /* 1 millisecond in system closk format */
     d sysclock_one_millisec...
     d                 c                   x'00000000003E8000'

     /* 1 second in format of system clock */
     d sysclock_one_second...
     d                 c                   x'00000000F4240000'

     /* 1 hour in format of system clock */
     d sysclock_one_hour...
     d                 c                   x'00000D693A400000'

     /* 1 week in format of system clock */
     d sysclock_one_week...
     d                 c                   x'0008CD0E3A000000'

     /* end -- process and thread management */

     /* Storage and Resource Management */

     /**
      * @BIF _ENSOBJ (Ensure Object (ENSOBJ))
      */
     d ensobj          pr                  extproc('_ENSOBJ')
     d     obj                         *

     /* Selection option for MATRMD */
     d matrmd_option_t...
     d                 ds                  qualified
     d     val                        1a
     d                                7a

     /* Materialization template for MATRMD */
     d matrmd_tmpl_t   ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     time_of_day...
     d                               20u 0
      * Resource management data

     /**
      * @BIF _MATRMD (Materialize Resource Management Data (MATRMD))
      */
     d matrmd          pr                  extproc('_MATRMD')
     d     receiver                        likeds(matrmd_tmpl_t)
     d     opt                             likeds(matrmd_option_t)

     /**
      * Materialization template for MATRMD with option hex 01 --
      * Materialize original processor utilization data (option hex 26
      * is preferred).
      */
     d matrmd_tmpl01_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     time_of_day...
     d                               20u 0
      * processor time since IPL
     d     prc_time                  20u 0
      * secondary workload processor time since IPL
     d     sec_prc_time...
     d                               20u 0
      * Database processor time since IPL
     d     db_prc_time...
     d                               20u 0
      * Database threshold
     d     db_threshold...
     d                                5u 0
      * Database limit
     d     db_limit                   5u 0
     d                                4a
      * Interactive processor time since IPL
     d     int_prc_time...
     d                               20u 0
      * Interactive threshold
     d     int_threshold...
     d                                5u 0
      * Interactive limit
     d     int_limit                  5u 0
     d                                4a

     /**
      * Materialization template for MATRMD with option hex 03 --
      * storage management counters
      */
     d matrmd_tmpl03_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     time_of_day...
     d                               20u 0
     d     access_pending...
     d                                5i 0
     d     stg_pool_delays...
     d                                5i 0
     d     dir_loopup_ops...
     d                               10i 0
     d     dir_page_faults...
     d                               10i 0
      * access group member page faults
     d     ag_mbr_page_faults...
     d                               10i 0
      * microcode page faults
     d     mc_page_faults...
     d                               10i 0
      * microtask read operations
     d     mt_read_ops...
     d                               10i 0
      * microtask write operations
     d     mt_write_ops...
     d                               10i 0
     d                                4a

     /**
      * Materialization template for MATRMD with option hex 04 --
      * Storage Transient Pool Information.
      */
     d matrmd_tmpl04_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     time_of_day...
     d                               20u 0
      *
      * The pool number materialized is the number of the main storage
      * pool, which is being used as the transient storage pool. A
      * value of 0 indicates that the transient pool attribute is
      * being ignored.
      *
     d     msp_num                    5i 0

     /**
      * Materialization template for MATRMD with option hex 08 --
      * Machine Address Threshold Data.
      */
     d matrmd_tmpl08_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     time_of_day...
     d                               20u 0
     d total_permanent_addresses_possible...
     d                               20u 0
     d total_temporary_addresses_possible...
     d                               20u 0
     d permanent_addresses_remaining...
     d                               20u 0
     d temporary_addresses_remaining...
     d                               20u 0
     d permanent_addresses_remaining_threshold...
     d                               20u 0
     d temporary_addresses_remaining_threshold...
     d                               20u 0
     d total_permanent_4gb_addresses_possible...
     d                               20u 0
     d total_permanent_256mb_addresses_possible...
     d                               20u 0
     d total_temporary_4gb_addresses_possible...
     d                               20u 0
     d total_temporary_256mb_addresses_possible...
     d                               20u 0
     d permanent_4gb_addresses_remaining...
     d                               20u 0
     d permanent_256mb_addresses_remaining...
     d                               20u 0
     d temporary_4gb_addresses_remaining...
     d                               20u 0
     d temporary_256mb_addresses_remaining...
     d                               20u 0
     d permanent_4gb_addresses_remaining_threshold...
     d                               20u 0
     d permanent_256mb_addresses_remaining_threshold...
     d                               20u 0
     d temporary_4gb_addresses_remaining_threshold...
     d                               20u 0
     d temporary_256mb_addresses_remaining_threshold...
     d                               20u 0

     /**
      * Materialization template for MATRMD with option hex 09 --
      * Materialize main storage pool information (option hex 2D is
      * preferred).
      *
      * @remark Option "Main Storage Pool Information (Hex 2D)" is the
      * preferred method of materializing main storage pool
      * information because some of the fields for this option may
      * overflow without any indication of error.
      */
     d matrmd_tmpl09_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     time_of_day...
     d                               20u 0
      *
      * Machine minimum transfer size is the smallest number of bytes
      * that may be transferred as a block to or from main storage. A
      * common value of this field is 4K.
      *
     d     machine_minimum_transfer_size...
     d                                5i 0
     d     maximum_number_of_pools...
     d                                5i 0
     d     current_number_of_pools...
     d                                5i 0
      *
      * Main storage size is the amount of main storage, in units
      * equal to the machine minimum transfer size, which may be
      * apportioned among main storage pools. Note that on overflow,
      * the machine returns 2,147,483,647 in the main storage size
      * field without any indication of error. You can use option
      * "Main Storage Pool Information (Hex 2D)" to materialize the
      * correct value.
      *
     d     main_storage_size...
     d                               10i 0
     d                                2a
     d     pool_1_minimum_size...
     d                               10i 0
      *
      * Array of individual main storage pool information DS of type
      * msp_info_t (repeated once for each pool, up to the current
      * number of pools)
      *

     /* Main storage pool information. */
     d msp_info_t      ds                  qualified
     d     pool_size...
     d                               10i 0
     d     pool_maintenance...
     d                               10i 0
     d     thread_interruptions_database...
     d                               10i 0
     d     thread_interruptions_nondatabase...
     d                               10i 0
     d     data_transferred_to_pool_database...
     d                               10i 0
     d     data_transferred_to_pool_nondatabase...
     d                               10i 0
     d     amount_of_pool_not_assigned_to_virtual_addresses...
     d                               10i 0
     d                               10i 0

     /**
      * Materialization template for MATRMD with option hex 0A --
      * MPL Control Data with 2-byte counts.
      *
      * @remark Option hex 16 is the preferred method of materializing
      * MPL control information. If option 0A is used and the actual
      * value of any returned template field, other than transition
      * counts, exceeds 32,767 then a value of 32,767 is returned (the
      * values will not wrap). The transition counts are an exception
      * and, as documented, do wrap after reaching their maximum
      * value.
      */
     d matrmd_tmpl0a_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     time_of_day...
     d                               20u 0
      *
      * Maximum number of MPL classes is the largest number of MPL
      * classes allowed in the machine. These are assumed to be
      * numbered from 1 to the maximum.
      *
     d     machine_maximum_number_of_mpl_classes...
     d                                5i 0
      *
      * Current number of MPL classes is a user-specified value for
      * the number of MPL classes in use. They are assumed to be
      * numbered from 1 to the current number.
      *
     d     machine_current_number_of_mpl_classes...
     d                                5i 0
      *
      * MPL (max) is the maximum number of processes which may
      * concurrently be in the active state in the machine.
      *
     d     mpl_max...
     d                                5i 0
      *
      * Ineligible event threshold is a number which, if exceeded by
      * the machine number of ineligible processes defined below, will
      * cause an event to be signaled.
      *
     d     ineligible_event_threshold...
     d                                5i 0
      *
      * MPL (current) is the current number of threads in the active
      * state.
      *
     d     mpl_current...
     d                                5i 0
      *
      * Number of threads in ineligible state is the number of threads
      * not currently active because of enforcement of both the
      * machine and class MPL rules.
      *
     d     number_of_threads_in_ineligible_state...
     d                                5i 0
     d                               10i 0
      *
      * array of MPL class information of type mpl_class_info_t.
      * (repeated for each MPL class, from 1 to the current number of
      * MPL classes)
      *

     /* 2-byte template of MPL class information */
     d mpl_class_info_t...
     d                 ds                  qualified
     d     mpl_max...
     d                                5i 0
     d     ineligible_event_threshold...
     d                                5i 0
     d     current_mpl...
     d                                5i 0
     d     number_of_threads_in_ineligible_state...
     d                                5i 0
     d     number_of_threads_assigned_to_class...
     d                                5i 0
     d     number_of_active_to_ineligible_transitions...
     d                                5i 0
     d     number_of_active_to_mi_wait_transitions...
     d                                5i 0
     d     number_of_mi_wait_to_ineligible_transitions...
     d                                5i 0

     /**
      * Materialization template for MATRMD with option hex 0C --
      * Machine Reserved Storage Pool Information.
      */
     d matrmd_tmpl0c_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     time_of_day...
     d                               20u 0
      * Current number of pools
     d     cur_pools                  5i 0
     d                                6a
      *
      * Individual main storage pool information of type
      * msp_mch_reserved_t (repeated once for each pool, up to the
      * current number of pools)
      *

     d msp_mch_reserved_t...
     d                 ds                  qualified
      *
      * Pool size is the amount of main storage assigned to the pool
      * (including the machine reserved portion). The units of measure
      * is the machine minimum transfer size. Note that on overflow,
      * the machine returns 2,147,483,647 in the pool size field
      * without any indication of error. The main storage pool size
      * field will return the correct value.
      *
     d     pool_size...
     d                               10u 0
      *
      * Machine portion of the pool specifies the amount of storage
      * from the pool that is dedicated to machine functions. The
      * units of measure is the machine minimum transfer size.
      *
     d     mch_reserved_size...
     d                               10u 0
      * 8-byte pool size
     d     pool_size8...
     d                               10u 0

     /**
      * Materialization template for MATRMD with option hex 17 --
      * Allocation and De-allocation counts per task and thread.
      *
      * @example test/t128.rpgle
      */
     d matrmd_tmpl17_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     time_of_day...
     d                               20u 0
      *
      * Requested function. Valid values:
      *   1 = Sorted by storage allocation
      *   2 = Sorted by storage de-allocation
      *   3 = Sorted by delta storage (allocated minus de-allocated)
      *
     d     req_func                   5u 0
     d     total_number_of_tasks_and_threads...
     d                               10u 0
     d     number_of_entries_returned...
     d                               10u 0
     d                                6a
      *
      * Task and thread information of type stg_alloc_info_t (Repeated
      * once for each task or thread. Located immediately after the
      * control information above.)
      *

     /* Allocation and De-allocation of auxiliary storage per task or thread */
     d stg_alloc_info_t...
     d                 ds                  qualified
      *
      * Task and thread control information
      * Bits 0-1, task and thread indicator
      *   00 = Secondary thread
      *   01 = Initial thread
      *   10 = Task
      *   11 = Reserved
      * Bits 2-15, reserved (binary 0)
      *
     d     flag                       2a
     d                                2a
     d     task_name                 32a
     d     task_id                    4a
     d     thd_id                     8a
     d     allocated_pages...
     d                               10u 0
     d     deallocated_pages...
     d                               10u 0
     d     delta_pages...
     d                               10u 0
     d                               20a

     /**
      * Access state template for SETACST
      */
     d access_state_tmpl_t...
     d                 ds                  qualified
     d                                     based(dummy_ptr)
     d     num_objs                  10i 0
     d                               12a
      * access state specifications of type access_state_spec_t
     d     spec                            likeds(access_state_spec_t)
     d                                     dim(128)

     /**
      * Access state specification
      */
     d access_state_spec_t...
     d                 ds                  qualified
     d     obj                         *
     d     state_code                 1a
     d                                3a
      * access state parameters (output fields)
     d     access_pool_id...
     d                                4a
     d     spc_length                10i 0
      * in units of minimum machine transfer size
     d     operational_object_size...
     d                               10i 0

     /**
      * @BIF _SETACST (Set Access State (SETACST))
      */
     d setacst         pr                  extproc('_SETACST')
     d     tmpl                            likeds(access_state_tmpl_t)

     /**
      * @BIF _YIELD (Yield (YIELD))
      */
     d yield           pr                  extproc('_YIELD')

     /* end -- Storage and Resource Management */

     /* Journal Management */

     /* end -- Journal Management */

     /* Machine Observation */

     /* Materialization template for MATSOBJ. */
     d matsobj_tmpl_t  ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
      *
      * Object state attributes
      *
      * Bit 0. Suspended state
      *   0 = Not suspended
      *   1 = Suspended
      * Bits 8-15. Reserved (binary 0)
      *
     d     obj_status                 2a
     d     ctx_id                    32a
     d     ctx_type                   2a   overlay(ctx_id)
     d     ctx_name                  30a   overlay(ctx_id:3)
     d     obj_id                    32a
     d     obj_type                   2a   overlay(obj_id)
     d     obj_name                  30a   overlay(obj_id:3)
      * Timestamp of creation
     d     crt_ts                     8a
      * Size of associated space
     d     spc_size                  10i 0
     d     obj_size                  10i 0
     d     owner                     32a
     d     owner_type                 2a   overlay(owner)
     d     owner_name                30a   overlay(owner:3)
      * Timestamp of last modification
     d     mod_ts                     8a
      * Recovery options
     d     rcv_opt                    4a
      * Machine internal use
     d     rcv_opt_internal_use...
     d                                2a   overlay(rcv_opt)
     d     asp_num                    5u 0 overlay(rcv_opt:3)
     d     perf_cls                   4a
     d     spc_init_val...
     d                                1a
      *
      * Object audit attributes
      *   Hex 00 = No audit for this object
      *   Hex 02 = Audit change for this object
      *   Hex 03 = Audit read and change for this object
      *   Hex 04 = Audit read and change for this object if the user
      *            profile is being audited
      *   Hex FF = User not allowed to materialize object audit attribute
      *
      * @remark @todo
      *
     d     audit_attr                 1a
      *
      * Sign state
      *   Hex 00 = Object not digitally signed
      *   Hex 01 = Object digitally signed
      *
     d     sign_sts                   1a
      *
      * Signed by a system-trusted source
      *   Hex 00 = Object not digitally signed by a system-trusted source
      *   Hex 01 = Object digitally signed by a system-trusted source
      *
     d     signed_by_trusted_source...
     d                                1a
      *
      * 0 = Object not in an authority list
      * 1 = Object in an authority list
      *
     d     in_autl                    5u 0
      *
      * Authority list ID, 48a
      *
      * Authority list (AL) status
      *   0 = Valid authority list
      *   1 = Damaged authority list
      *   2 = Destroyed authority list (no name below)
      *
     d     autl_sts                   5i 0
     d                               14a
     d     autl_type                  2a
     d     autl_name                 30a
     d     dump_for_previous_release_reason_code...
     d                                8a
     d     max_spc_size...
     d                               10i 0
      * Timestamp of last use of object
     d     use_ts                     8a
      * Count of number of days object was used
     d     used_days                  5u 0
      *
      * @todo ...
      *
     d     pgm_attr                   2a
      *
      * Type of program
      *   Hex 00 = Non-bound program
      *   Hex 01 = Bound program
      *   Hex 02 = Bound service program
      *   Hex 04 = Java program
      *
     d     pgm_type                   1a   overlay(pgm_attr:2)
      *
      * Domain of object
      *   @todo
      *   Hex 8000 = System domain
      *   Hex 0001 = User domain
      *
     d     domain                     2a
      *
      * State of program
      *   @todo
      *   Hex 0080 = System state
      *   Hex 0001 = User state
      *
     d     pgm_state                  2a
      * MI-supplied information
     d     mi_info                    8a
      *
      * @todo
      *
      *
     d     compatible_rls...
     d                                2a
      * Object size in basic storage units (512 bytes)
     d     obj_size2                 10u 0
      * Primary group identification
     d     grp_id                    32a
     d     grp_type                   2a   overlay(grp_id)
     d     grp_name                  30a   overlay(grp_id:3)
      * Hardware storage protection
     d     hardware_storage_protection...
     d                                1a
     d                                1a
      *
      * @todo comments on file_id/gen_id
      *
      *
     d     file_id                   10u 0
     d     gen_id                    10u 0
     d                               12a
     d     parent_obj                  *
     d     num_signer                10u 0
     d                               36a

     /**
      * @BIF _MATSOBJ (Materialize System Object (MATSOBJ))
      */
     d matsobj         pr                  extproc('_MATSOBJ')
     d     receiver                        likeds(matsobj_tmpl_t)
     d     obj                         *

     /**
      * @BIF _TESTTOBJ (Test Temporary Object (TESTTOBJ))
      *
      * @return 1 if syp points to a temporary object, otherwise 0.
      */
     d testtobj        pr            10i 0 extproc('_TESTTOBJ')
     d     syp                         *

     /**
      * @BIF _TESTPDC (Test Performance Data Collection (TESTPDC))
      *
      * A test is performed to determine whether or not the thread is
      * in an active Performance Data Collector (PDC) trace
      * collection.
      *
      * @return 1 if the thread is in an active Performance Data
      * Collector (PDC) trace collection, otherwise 0.
      */
     d testpdc         pr            10i 0 extproc('_TESTPDC')

     /* end -- Machine Observation */

     /* Machine Interface Support Functions */

     /* structure uuid_t */
     d uuid_t          ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d                                8a
     d     rtn_uuid                  16a

     /**
      * @BIF _GENUUID (Generate Universal Unique Identifier (GENUUID))
      */
     d genuuid         pr                  extproc('_GENUUID')
     d     uuid                            likeds(uuid_t)

     d matmatr_tmpl_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0

     /**
      * MATMATR instruction template for option hex 0004.
      *
      * The 8-bytes machine serial number is returned.
      */
     d matmatr_machine_srlnbr_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     srlnbr                     8a

     /**
      * MATMATR instruction template for option hex 0101 (Time-of-day
      * clock with clock-offset).
      */
     d matmatr_clock_offset_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     clock                      8a
     d     offset                     8a

     /**
      * Load/Dump tape device information DS in MISR information.
      */
     d tape_dev_info_t...
     d                 ds                  qualified
      * resource name
     d     rsc_name                  10a
     d                               38a

     /**
      * Recovery object DS which is used to represent elements in
      * the recovery object list in materialized MISR information.
      */
     d recovery_obj_t  ds                  qualified
     d     obj                         *
     d     obj_type                   1a
     d     obj_status                15a

     /**
      * Instruction template for option hex 0108 (MISR) of MATMATR.
      *
      * @remark MISR stands for Machine initialization status record.
      */
     d matmatr_misr_t  ds                  qualified
     d                                     based(dummy_ptr)
      *
      * MISR status.
      * Bit 0. Restart IMPL
      *   0 = IMPL was not initiated by the Terminate instruction
      *   1 = IMPL was initiated by the Terminate instruction
      * Bit 1. Manual power on
      *   0 = Power on NOT due to Manual power on
      *   1 = Manual power on occurred
      * Bit 2. Timed power on
      *   0 = Power on not due to Timed power on
      *   1 = Timed power on occurred
      * Bit 3. Remote power on
      *   0 = Power on not due to remote power on
      *   1 = Remote power on occurred
      * Bit 4. Auto-power restart power on
      *   0 = Power on not due to Auto-power restart power on
      *   1 = Auto-power restart power on occurred
      * Bit 5. Uninterrupted power supply (UPS) battery low
      *   0 = UPS battery not low
      *   1 = UPS battery low
      * Bit 6. Uninterrupted power supply (UPS) bypass active
      *   0 = UPS bypass not active
      *   1 = UPS bypass active
      * Bit 7. Utility power failed, running on UPS
      *   0 = Running on utility power
      *   1 = Running on UPS
      * Bit 8. Uninterrupted power supply installed
      *   0 = UPS not installed
      *   1 = UPS installed, ready for use
      * Bit 9. Operation panel battery failed
      *   0 = Operation panel battery good
      *   1 = Operation panel battery failed
      * Bit 10. Operation panel self test failed
      *   0 = Operation panel self test successful
      *   1 = Operation panel self test failed
      * Bit 11. Console status
      *   0 = Console is operative
      *   1 = Console is inoperative
      * Bit 12. Console state
      *   0 = Machine and OS version levels match
      *   1 = Machine and OS version levels mismatch
      * Bit 14. Reserved
      * Bit 15. Primary console status
      *   0 = Not using primary console
      *   1 = Using primary console
      * Bit 16. Reserved
      * Bit 17. ASCII console status
      *   0 = Not using ASCII console
      *   1 = Using ASCII console
      * Bit 18. Termination status
      *   0 = Normal (TERMMPR)
      *   1 = Abnormal
      * Bit 19. Duplicate user profile (AIPL only)
      *   0 = Not duplicate, new user profile created
      *   1 = Duplicate found and used by AIPL
      * Bit 20. Damaged user profile (AIPL only)
      *   0 = Not damaged, user profile used
      *   1 = Damaged user profile, profile deleted and re-created
      * Bit 21. Damaged machine context
      *   0 = Not damaged
      *   1 = Machine context damaged
      * Bit 22. Object recovery list status
      *   0 = Complete
      *   1 = Incomplete
      * Bit 23. Recovery phase completion
      *   0 = Complete
      *   1 = Incomplete
      * Bit 24. Most recent machine termination
      *   0 = Objects ensured
      *   1 = Object(s) not ensured at most recent machine termination
      * Bit 25. Last MISR reset
      *   0 = Object(s) ensured on every machine termination
      *   1 = Object(s) not ensured on every machine termination since last MISR reset
      * Bit 26-27. Reserved
      * Bit 28-29. IPL mode
      *   00 = DST and BOSS in unattended mode
      *   10 = DST and BOSS is attended mode
      * Bit 30. Service processor power on
      *   0 = Not first service processor power on
      *   1 = First service processor power on
      * Bit 31. MISR damage
      *   0 = MISR not damaged
      *   1 = MISR damaged, information reset to default values
      * Bit 32. Auto key mode
      *   0 = Key mode is not auto
      *   1 = Key mode is auto
      * Bit 33. Normal key mode
      *   0 = Key mode is not normal
      *   1 = Key mode is normal
      * Bit 34. Manual key mode
      *   0 = Key mode is not manual
      *   1 = Key mode is manual
      * Bit 35. Secure key mode
      *   0 = Key mode is not secure
      *   1 = Key mode is secure
      * Bit 36. Tower two presence on 9404 system unit
      *   0 = Tower two not present
      *   1 = Tower two present
      * Bit 37. Battery status for tower one on 9404 system unit
      *   0 = Battery good for tower one
      *   1 = Battery low for tower one
      * Bit 38. Battery status for tower two on 9404
      *   0 = Battery good for tower two
      *   1 = Battery low for tower two
      * Bit 39. Termination due to utility power failure and user specified delay time exceeded
      *   0 = Delay time not exceeded
      *   1 = Utility failure and delay time exceeded
      * Bit 40. Termination due to utility power failure and battery low
      *   0 = Battery not low
      *   1 = Utility failure and battery low
      * Bit 41. Termination due to forced microcode completion
      *   0 = Not forced microcode completion
      *   1 = Termination due to forced microcode completion
      * Bit 42. Auto power restart disabled due to utility failure
      *   0 = Auto power restart not disabled
      *   1 = Auto power restart disabled
      * Bit 43. Reserved
      * Bit 44. Spread the operating system
      *   0 = Do not spread the operating system
      *   1 = Spread the operating system
      * Bit 45. Install from disk/tape
      *   0 = Install from tape
      *   1 = Install from disk
      * Bit 46. Use primary/alternate PDT
      *   0 = Use primary process definition template
      *   1 = Use alternate process definition template
      * Bit 47. Time/Date source
      *   0 = Time/Date is accurate
      *   1 = Time/Date default value used
      *
     d     misr_status...
     d                                6a
     d     install_type...
     d                                5i 0
     d     number_of_damaged_main_storage_units...
     d                                5i 0
     d     national_language_index...
     d                                5i 0
     d     number_of_entries_in_object_recovery_list...
     d                               10i 0
     d     tape_sequence_number_for_an_aipl...
     d                               10i 0
     d     tape_volume_number_for_an_aipl...
     d                               10i 0
      * Address of object recovery list
     d     recovery_list_ptr...
     d                                 *
      * Process control space created as the result of IPL or AIPL
     d     pcs_ipl                     *
      * Queue space object created as the result of an IPL or AIPL
     d     qspc_ipl                    *
      *
      * Additional MISR status information
      * Bit 0. Automatic main storage dump IPL occurred
      *   0 = No
      *   1 = Yes
      * Bit 1-2. Power failure (CPM continuous powered mainstore) recovery
      *   00 = Not set
      *   01 = Recovery failed after CPM shutdown
      *   10 = Recovery successful after CPM shutdown
      *   11 = Reserved
      * Bit 3. Automatic main storage dump IPL requested
      *   0 = No
      *   1 = Yes
      * Bit 4-5. Power failure (On internal battery).
      *   00 = Not set
      *   01 = Shutdown did not complete, not all changed pages written
      *   10 = Shutdown did complete, all changed pages written
      *   11 = Reserved
      * Bit 6. Require full main storage dump copy
      *   0 = No. When copying a current main storage dump, the system
      *       is allowed to copy only the subset of the dump data
      *       deemed necessary for service to solve the problem.
      *   1 = Yes. When copying a current main storage dump, the
      *       system must copy all dump data.
      * Bit 7. Prefer full main storage dump copy
      *   0 = No. When copying a current main storage dump, the system
      *       should try to copy only the subset of the dump data
      *       deemed necessary for service to solve the problem.
      *   1 = Yes. When copying a current main storage dump, the
      *       system should copy all the dump data if there is enough
      *       room for it. Otherwise, the system should try to copy
      *       only the subset of the dump deemed necessary for service
      *       to solve the problem.
      * Bits 8-31. Reserved
      *
     d     ex_misr_info...
     d                                4a
      * Main storage dump data -- timestamp and SRC
     d     mstg_dmp                  76a
     d     mstg_dmp_ts...
     d                                8a   overlay(mstg_dmp)
      * SRC words
     d     mstg_dmp_src_words...
     d                                4a   overlay(mstg_dmp:9)
     d                                     dim(9)
      * Extended SRC word 1
     d     mstg_dmp_ex_src_word...
     d                               32a   overlay(mstg_dmp:45)
     d                              280a
      * Start of IPL timestamp (local time)
     d     ipl_start_timestamp...
     d                                8a
      * Optical media volume information
     d     optical_volume_id...
     d                               32a
     d     optical_volume_sequence...
     d                                5i 0
     d                               13a
      *
      * Licensed Internal Code install status
      * Bit 0. MRI level
      *   0 = Release level MRI
      *   1 = Post-release level MRI
      * Bit 1. Licensed Internal Code PTF install
      *   0 = Licensed Internal Code normal install
      *   1 = Licensed Internal Code PTF install
      * Bits 2-7. Reserved
      *
     d     lic_install_status...
     d                                1a
      * Load/Dump tape device information list. (1st=LUD information, 2nd=CD information)
     d     tape_dev_info_list...
     d                                     likeds(tape_dev_info_t)
     d                                     dim(2)
      * Recovery object list (located by recovery object list pointer).
      * Elements in this list are of type recovery_obj_t

     /**
      * MATMATR instruction template for option hex 0130 (network attributes).
      */
     d matmatr_net_attr_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     sys_name                   8a
     d     sys_name_len...
     d                                5i 0
     d     new_sys_name...
     d                                8a
     d     new_sys_name_len...
     d                                5i 0
     d     local_net_id...
     d                                8a
     d     local_net_id_len...
     d                                5i 0
      *
      * The end node data compression field controls whether the
      * machine will allow data compression when it's an end
      * node. This value is used when the mode description is equal to
      * *NETATR. If one of the values listed in the table below is not
      * specified, then the value specified is equal to the maximum
      * line speed that data should be compressed. Any configuration
      * with a line speed slower than what is specified here will
      * cause the data to be compressed. Valid values range from 1
      * bits-per-second through 2,147,483,647.
      *   0  = *NONE (default), no data compression will be done.
      *   -1 = *REQUEST, data compression is requested on the session.
      *   -2 = *ALLOW, data compression is allowed, but not requested for this session.
      *   -3 =*REQUIRE, data compression is required on this session.
      *
     d     end_node_data_cpr...
     d                               10i 0
      *
      * The intermediate node data compression field controls whether
      * data compression will be requested by the machine when it's an
      * intermediate node. This value is used when the mode
      * description is equal to *NETATR. If one of the values listed
      * in the table below is not specified, then the value specified
      * is equal to the maximum line speed that data should be
      * compressed. Any configuration with a line speed slower than
      * what is specified here will cause the data to be
      * compressed. Valid values range from 1 bits-per-second through
      * 2,147,483,647.
      *    0 = *NONE (default), no data compression will be done.
      *   -1 = *REQUEST, data compression is requested on the session.
      *
     d     int_node_data_cpr...
     d                               10i 0
     d                                2a
      * Local system control point name
     d     local_sys_ctrl_pnt_name...
     d                                8a
     d     local_sys_ctrl_pnt_name_len...
     d                                5i 0
      * Maximum APPN LUDs on virtual APPN CDs
     d     max_appn_lud_on_vrt_appc_cd...
     d                                5u 0
      *
      * The path switch timer - network priority traffic default is
      * 1. The maximum is 10000.  The unit of measure is minutes.
      *
     d     path_switch_timer_net...
     d                                5u 0
      *
      * The path switch timer - high priority traffic default is
      * 2. The maximum is 10000.  The unit of measure is minutes.
      *
     d     path_switch_timer_high...
     d                                5u 0
      *
      * The path switch timer - medium priority traffic default is
      * 4. The maximum is 10000.  The unit of measure is minutes.
      *
     d     path_switch_timer_medium...
     d                                5u 0
      *
      * The path switch timer - low priority traffic default is
      * 4. The maximum is 10000.  The unit of measure is minutes.
      *
     d     path_switch_timer_low...
     d                                5u 0
      * Default local location name
     d     dft_local_loc_name...
     d                                8a
     d     dft_local_loc_name_len...
     d                                5i 0
      *
      * Default mode name. The mode name default is all blanks and the
      * default mode length is eight.
      *
     d     dft_mode_name...
     d                                8a
     d     dft_mode_name_len...
     d                                5i 0
      * Maximum number of intermediate sessions
     d     max_int_session...
     d                                5i 0
      * Maximum number of conversations per APPN LUD
     d     max_conv_per_appn_lud...
     d                                5i 0
      * Local system node type. Default is hex 01
     d     lcl_sys_node_type...
     d                                1a
     d                                1a
      * Route addition resistance
     d     rut_add_res...
     d                                5i 0
      * List of network server network ID's
     d     network_ids...
     d                                8a   dim(5)
      * List of network server network ID lengths
     d     network_id_lens...
     d                                5u 0 dim(5)
      * List of network server control point names
     d     net_ctrl_pnt_names...
     d                                8a   dim(5)
      * List of network server control point name lengths
     d     net_ctrl_pnt_name_lens...
     d                                5u 0 dim(5)
      *
      * Alert flags.
      *   bit 0 = 1, alert primary focal point
      *   bit 1 = 1, alert default focal point
      *   bits 2-7, reserved
      *
     d     alert_flags...
     d                                1a
      *
      * Network attribute flags
      *   bit 0 = 1, network attributes initialized
      *   bit 1 = 1, pending system name made current system name
      *   bit 2 = 1, allow ANYNET support over any transport protocol
      *   bit 3 = 1, allow APPN traffic to use virtual APPN CDs
      *   bit 4 = 1, allow HPR tower support to be used for APPN
      *   bit 5 = 1, local system performs as a branch extender node
      *   bits 6-7, reserved
      *
     d     net_attr_flags...
     d                                1a

     /**
      * MATMATR instruction template for option hex 0168 (Panel
      * status request).
      */
     d matmatr_ipl_req_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
      *
      * The current IPL type is the state of the IPL type at the
      * operations panel. Possible values are A, B, C, D.
      *
     d     cur_ipl_type...
     d                                1a
      *
      * Panel status.
      *
      * bit 0, UPS installed indicates that an Uninterrupted Power
      *        Supply is installed on the system and is available for
      *        use should the power fail.
      * bit 1, UPS power failed indicates that a utility failure has
      *        occurred and the system is currently running on battery
      *        power.
      * bit 2, UPS bypass active indicates that the UPS has been
      *        bypassed. If a utility power failure occurs, the UPS
      *        will not supply power.
      * bit 3, UPS battery low indicates that a UPS battery is
      *        installed on the system and the battery is low.
      * bit 4, auto key mode indicates that the key mode is currently
      *        set to auto on the operation panel.
      * bit 5, normal key mode indicates that the key mode is
      *        currently set to normal on the operation panel.
      * bit 6, manual key mode indicates that the key mode is
      *        currently set to manual on the operation panel.
      * bit 7, secure key mode indicates that the key mode is
      *        currently set to secure on the operation panel.
      * bits 8-15, reserved.
      *
     d        pnl_sts                 2a
     d                                5a
      * Most recent IPL type. Possible values are A, B, C, D.
     d        most_recent_ipl_type...
     d                                1a

     /**
      * MATMATR instruction template for option hex 01FC (Electronic
      * licensing identifier).
      *
      * The electronic licensing identifier field is the value of
      * version, release and modification level of the i5/OS to be
      * installed during the next upgrade whose license is accepted by
      * the customers. The format of the electronic licensing
      * identifier is vrmnn where v is the version, r, the release, m,
      * the modication level, and nn are operating system assigned
      * values.
      */
     d matmatr_elic_id_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     elic_id                    5a

     /**
      * MATMATR instruction template for option hex 020C (Licensed
      * Internal Code VRM).
      */
     d matmatr_lic_vrm_t...
     d                 ds                  qualified
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
     d     lic_vrm                    6a
     d                                2a

     /**
      * MATMATR instruction template for option hex 0204.
      *
      * Hardware management console (HMC) information.
      */
     d matmatr_hmc_t   ds                  qualified
     d                                     based(dummy_ptr)
     d     bytes_in                  10i 0
     d     bytes_out                 10i 0
      *
      * The number of entries returned field returns the number of
      * Hardware Management Console (HMC) information entries
      * returned. One entry is returned for each HMC attached to the
      * physical machine. On a non-HMC managed system, the value
      * returned will be binary 0.
      *
     d     num_ent                   10i 0
     d                                4a
     d     hmc_info                        likeds(hmc_info_t)
     d                                     dim(10)

     d hmc_info_t      ds          1036    qualified
     d     len                        5u 0
     d     info                    1034

     /**
      * @BIF _MATMATR (Materialize Machine Attributes (MATMATR))
      */
     d matmatr         pr                  extproc('_MATMATR1')
     d     receiver                        likeds(matmatr_tmpl_t)
     d     mat_attr                   2a

     /**
      * @BIF _MATTOD (Materialize Machine Data (MATMDATA))
      *
      * _MATTOD materializes time-of-day clock as local time.
      */
     d mattod          pr                  extproc('_MATTOD')
     d     now                       20u 0

     /**
      * @BIF _MATMDATA (Materialize Machine Data (MATMDATA))
      *
      * Valid values of operand option are:
      * hex 0000 = Materialize time-of-day clock as local time.
      *            Operand 1 points to a 8-byte scalar.
      * hex 0001 = Materialize system parameter integrity validation
      *            flag Operand 1 points to a 1-byte character scalar.
      *            A value of hex 01 indicates this additional
      *            checking is being performed. A value of hex 00 is
      *            returned otherwise.
      * hex 0002 = Materialize thread execution mode flag
      *            Operand 1 points to a 1-byte character scalar.  A
      *            returned value of hex 01 indicates that thread is
      *            currently executing in kernel mode. A value of hex
      *            00 is returned otherwise.
      * hex 0003 = Materialize maximum size of a space object or
      *            associated space when space alignment is chosen by
      *            the machine Operand 1 points to a 4-byte unsigned
      *            binary.
      * hex 0004 = Materialize time-of-day clock as Coordinated
      *            Universal Time (UTC) Operand 1 points to a 8-byte
      *            scalar.
      *
      * @example test/t117.rpgle
      */
     d matmdata        pr                  extproc('_MATMDATA')
     d     receiver                    *   value
     d     option                     2a   value

     /* end -- Machine Interface Support Functions */

     /* undocumented system builtins */

     /* jump buffer structure used by __setjmp, and libc procedure longjmp() */
     d jmp_buf_t       ds                  qualified
     d     inv_ptr                     *
     d     lbl_ptr                     *
     d     num                       10i 0

     /**
      * @BIF __setjmp
      */
     d setjmp          pr            10i 0 extproc('__setjmp')
     d     jmpbuf                          likeds(jmp_buf_t)

     /**
      * @BIF __setjmp2
      */
     d setjmp2         pr                  extproc('__setjmp2')
     d     lbl_ptr                     *

     /**
      * @BIF _SYSEPT
      * returns a space pointer to the SEPT
      */
     d sysept          pr              *   extproc('_SYSEPT')

     /**
      * @BIF _QTEMPPTR
      * returna a system pointer to current process' QTEMP
      */
     d qtempptr        pr              *   extproc('_QTEMPPTR')

     /* end -- undocumented system builtins */

      /endif
     /* eof - mih52.rpgleinc */
