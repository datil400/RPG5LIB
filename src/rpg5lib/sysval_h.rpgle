**FREE

/IF DEFINED(R5_SYSVAL_H)
/EOF
/ENDIF
/DEFINE R5_SYSVAL_H

//  Package : RPG5LIB
//  SrvPgm  : R5SYS
//
//  SYSVAL_H
//
//  System values
//
//  April 2017
//
//  Use:
//
//  /COPY RPG5LIB,sysval_h


/COPY RPG5LIB,types_h


//  La función 'r5_get_system_value' devuelve todos los valores como una
//  secuencia de bytes. Los datos alfanuméricos se verán como una
//  cadena de caracteres 'al uso'. Los valores numéricos se entregan
//  en su codificación binaria original, por ejemplo, QCCSID se
//  devuelve como un entero de 4 bytes.
//
//  Una estregia para gestionar esta circunstancia consiste en
//  definir una estructura de datos por cada valor del sistema, sin
//  prestar atención al tipo de dato devuelto. El resultado deberá
//  almacenarse en dicha estructura.
//
//  Para acceder al valor, ya sea numérico o carácter, se definirá
//  un subcampo 'value' con el tipo de datos correcto.
//
//  Este modelo funciona porque las estructuras de datos siempre son
//  tratadas por el compilador como una secuencia de bytes.
//
//  http://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/apis/qwcrsval.htm


// Previous end of system indicator

dcl-ds r5_qabnormsw_t qualified template;
   value char(1);
end-ds;

// Accounting level

dcl-ds r5_qacglvl_t qualified template;
   value char(10) dim(8);
end-ds;

// Active jobs

dcl-ds r5_qactjob_t qualified template;
   value int(10);
end-ds;

// Additional active jobs

dcl-ds r5_qadlactj_t qualified template;
   value int(10);
end-ds;

// Additional spool storage

dcl-ds r5_qadlspla_t qualified template;
   value int(10);
end-ds;

// Additional total jobs

dcl-ds r5_qadltotj_t qualified template;
   value int(10);
end-ds;

// Allow jobs to be interrupted

dcl-ds r5_qalwjobitp_t qualified template;
   value char(1);
end-ds;

// Allow object restore options

dcl-ds r5_qalwobjrst_t qualified template;
   value char(10) dim(15);
end-ds;

// Allow user domain

dcl-ds r5_qalwusrdmn_t qualified template;
   value char(10) dim(50);
end-ds;

// Assistance level

dcl-ds r5_qastlvl_t qualified template;
   value char(10);
end-ds;

// Attention program

dcl-ds r5_qatnpgm_t qualified template;
   value char(20);
end-ds;

// Auditing control

dcl-ds r5_qaudctl_t qualified template;
   value char(10) dim(5);
end-ds;

// Auditing end action

dcl-ds r5_qaudendacn_t qualified template;
   value char(10);
end-ds;

// Auditing force level

dcl-ds r5_qaudfrclvl_t qualified template;
   value int(10);
end-ds;

// Auditing level

dcl-ds r5_qaudlvl_t qualified template;
   value char(10) dim(16);
end-ds;

// Auditing level extension

dcl-ds r5_qaudlvl2_t qualified template;
   value char(10) dim(99);
end-ds;

// Automatic configuration indicator

dcl-ds r5_qautocfg_t qualified template;
   value char(1);
end-ds;

// Automatic configuration for remote controllers

dcl-ds r5_qautormt_t qualified template;
   value char(1);
end-ds;

// Automatic system disabled reporting

dcl-ds r5_qautosprpt_t qualified template;
   value char(1);
end-ds;

// Automatic configuration for virtual devices

dcl-ds r5_qautovrt_t qualified template;
   value int(10);
end-ds;

// Base activity level

dcl-ds r5_qbasactlvl_t qualified template;
   value int(10);
end-ds;

// Base pool minimum size

dcl-ds r5_qbaspool_t qualified template;
   value int(10);
end-ds;

// Base pool minimum size (long)

dcl-ds r5_qbaspool2_t qualified template;
   value int(20);
end-ds;

// Book and bookshelf search path

dcl-ds r5_qbookpath_t qualified template;
   value char(63) dim(5);
end-ds;

// Coded character set identifier

dcl-ds r5_qccsid_t qualified template;
   value int(10);
end-ds;

// Century indicator

dcl-ds r5_qcentury_t qualified template;
   value char(1);
end-ds;

// Configuration message queue

dcl-ds r5_qcfgmsgq_t qualified template;
   value char(20);
end-ds;

// Character set and code page

dcl-ds r5_qchrid_t qualified template;
   value char(20);
end-ds;

// Character identifier control

dcl-ds r5_qchridctl_t qualified template;
   value char(10);
end-ds;

// Communication arbiters

dcl-ds r5_qcmnarb_t qualified template;
   value char(10);
end-ds;

// Communications recovery limit

dcl-ds r5_qcmnrcylmt_t qualified template;
   value char(20);
end-ds;

// Country or region identifier

dcl-ds r5_qcntryid_t qualified template;
   value char(2);
end-ds;

// Console name

dcl-ds r5_qconsole_t qualified template;
   value char(10);
end-ds;

// Create authority

dcl-ds r5_qcrtaut_t qualified template;
   value char(10);
end-ds;

// Create object auditing

dcl-ds r5_qcrtobjaud_t qualified template;
   value char(10);
end-ds;

// Controlling subsystem

dcl-ds r5_qctlsbsd_t qualified template;
   value char(20);
end-ds;

// Currency symbol

dcl-ds r5_qcursym_t qualified template;
   value char(1);
end-ds;

// System date

dcl-ds r5_qdate_t qualified template;
   value char(7);
end-ds;

// System date and time

dcl-ds r5_qdatetime_t qualified template;
   value char(20);
end-ds;

// Date format

dcl-ds r5_qdatfmt_t qualified template;
   value char(3);
end-ds;

// Date separator

dcl-ds r5_qdatsep_t qualified template;
   value char(1);
end-ds;

// Day

dcl-ds r5_qday_t qualified template;
   value char(3);
end-ds;

// Day of the week

dcl-ds r5_qdayofweek_t qualified template;
   value char(4);
end-ds;

// Database file statistics collection

dcl-ds r5_qdbfstccol_t qualified template;
   value char(10);
end-ds;

// Database recovery wait

dcl-ds r5_qdbrcvywt_t qualified template;
   value char(1);
end-ds;

// Decimal format

dcl-ds r5_qdecfmt_t qualified template;
   value char(1);
end-ds;

// Device naming convention

dcl-ds r5_qdevnaming_t qualified template;
   value char(10);
end-ds;

// Device recovery action

dcl-ds r5_qdevrcyacn_t qualified template;
   value char(20);
end-ds;

// Disconnect job interval

dcl-ds r5_qdscjobitv_t qualified template;
   value char(10);
end-ds;

// Sign-on information

dcl-ds r5_qdspsgninf_t qualified template;
   value char(1);
end-ds;

// Dynamic priority adjustment

dcl-ds r5_qdynptyadj_t qualified template;
   value char(1);
end-ds;

// Dynamic priority scheduler

dcl-ds r5_qdynptyscd_t qualified template;
   value char(1);
end-ds;

// End job limit

dcl-ds r5_qendjoblmt_t qualified template;
   value int(10);
end-ds;

// Force conversion on restore

dcl-ds r5_qfrccvnrst_t qualified template;
   value char(1);
end-ds;

// Hour

dcl-ds r5_qhour_t qualified template;
   value char(2);
end-ds;

// History log size

dcl-ds r5_qhstlogsiz_t qualified template;
   value int(10);
end-ds;

// DBCS installed

dcl-ds r5_qigc_t qualified template;
   value char(1);
end-ds;

// Double-byte coded font name

dcl-ds r5_qigccdefnt_t qualified template;
   value char(20);
end-ds;

// Double-byte coded font point size

dcl-ds r5_qigcfntsiz_t qualified template;
   value int(10);
end-ds;

// Inactive job time-out

dcl-ds r5_qinactitv_t qualified template;
   value char(10);
end-ds;

// Inactive message queue

dcl-ds r5_qinactmsgq_t qualified template;
   value char(20);
end-ds;

// Automatic IPL date and time

dcl-ds r5_qipldattim_t qualified template;
   value char(13);
end-ds;

// IPL status

dcl-ds r5_qiplsts_t qualified template;
   value char(1);
end-ds;

// IPL type

dcl-ds r5_qipltype_t qualified template;
   value char(1);
end-ds;

// Job message queue full

dcl-ds r5_qjobmsgqfl_t qualified template;
   value char(10);
end-ds;

// Job message queue maximum size

dcl-ds r5_qjobmsgqmx_t qualified template;
   value int(10);
end-ds;

// Job message queue initial size

dcl-ds r5_qjobmsgqsz_t qualified template;
   value int(10);
end-ds;

// Maximum job message queue initial size

dcl-ds r5_qjobmsgqtl_t qualified template;
   value int(10);
end-ds;

// Initial spooling size

dcl-ds r5_qjobspla_t qualified template;
   value int(10);
end-ds;

// Keyboard buffer

dcl-ds r5_qkbdbuf_t qualified template;
   value char(10);
end-ds;

// Keyboard type

dcl-ds r5_qkbdtype_t qualified template;
   value char(3);
end-ds;

// Language identifier

dcl-ds r5_qlangid_t qualified template;
   value char(3);
end-ds;

// Leap year adjustment

dcl-ds r5_qleapadj_t qualified template;
   value int(10);
end-ds;

// Library locking level

dcl-ds r5_qliblcklvl_t qualified template;
   value char(1);
end-ds;

// Limit device session

dcl-ds r5_qlmtdevssn_t qualified template;
   value char(1);
end-ds;

// Limit security officer

dcl-ds r5_qlmtsecofr_t qualified template;
   value char(1);
end-ds;

// Locale path name

dcl-ds r5_qlocale_t qualified template;
   value char(2080);
end-ds;

// Job log output

dcl-ds r5_qlogoutput_t qualified template;
   value char(10);
end-ds;

// Maximum activity level

dcl-ds r5_qmaxactlvl_t qualified template;
   value int(10);
end-ds;

// Maximum number of jobs

dcl-ds r5_qmaxjob_t qualified template;
   value int(10);
end-ds;

// Maximum sign-on action

dcl-ds r5_qmaxsgnacn_t qualified template;
   value char(1);
end-ds;

// Maximum not valid sign-on

dcl-ds r5_qmaxsign_t qualified template;
   value char(6);
end-ds;

// Maximum spooled files per job

dcl-ds r5_qmaxsplf_t qualified template;
   value int(10);
end-ds;

// Machine pool size

dcl-ds r5_qmchpool_t qualified template;
   value int(10);
end-ds;

/IF DEFINED(*V7R2M0)

// Machine pool size (long)

dcl-ds r5_qmchpool2_t qualified template;
   value int(20);
end-ds;

/ENDIF

// Minute

dcl-ds r5_qminute_t qualified template;
   value char(2);
end-ds;

// Multithreaded job action

dcl-ds r5_qmltthdacn_t qualified template;
   value char(1);
end-ds;

// System model

dcl-ds r5_qmodel_t qualified template;
   value char(4);
end-ds;

// Month

dcl-ds r5_qmonth_t qualified template;
   value char(2);
end-ds;

// Pass-through servers

dcl-ds r5_qpasthrsvr_t qualified template;
   value char(10);
end-ds;

// Performance adjustment

dcl-ds r5_qpfradj_t qualified template;
   value char(1);
end-ds;

// Problem filter

dcl-ds r5_qprbftr_t qualified template;
   value char(20);
end-ds;

// Problem hold interval

dcl-ds r5_qprbhlditv_t qualified template;
   value int(10);
end-ds;

// Processor feature

dcl-ds r5_qprcfeat_t qualified template;
   value char(4);
end-ds;

// Processor multitasking

dcl-ds r5_qprcmlttsk_t qualified template;
   value char(1);
end-ds;

// Printer device

dcl-ds r5_qprtdev_t qualified template;
   value char(10);
end-ds;

// Print key format

dcl-ds r5_qprtkeyfmt_t qualified template;
   value char(10);
end-ds;

// Print text

dcl-ds r5_qprttxt_t qualified template;
   value char(30);
end-ds;

// Block password change

dcl-ds r5_qpwdchgblk_t qualified template;
   value char(10);
end-ds;

// Days password valid

dcl-ds r5_qpwdexpitv_t qualified template;
   value char(6);
end-ds;

// Password expiration warning

dcl-ds r5_qpwdexpwrn_t qualified template;
   value int(10);
end-ds;

// Limit adjacent digits

dcl-ds r5_qpwdlmtajc_t qualified template;
   value char(1);
end-ds;

// Limit characters

dcl-ds r5_qpwdlmtchr_t qualified template;
   value char(10);
end-ds;

// Limit repeat characters

dcl-ds r5_qpwdlmtrep_t qualified template;
   value char(1);
end-ds;

// Password level

dcl-ds r5_qpwdlvl_t qualified template;
   value int(10);
end-ds;

// Maximum password length

dcl-ds r5_qpwdmaxlen_t qualified template;
   value int(10);
end-ds;

// Minimum password length

dcl-ds r5_qpwdminlen_t qualified template;
   value int(10);
end-ds;

// Limit character positions

dcl-ds r5_qpwdposdif_t qualified template;
   value char(1);
end-ds;

// Required password digits

dcl-ds r5_qpwdrqddgt_t qualified template;
   value char(1);
end-ds;

// Duplicate password

dcl-ds r5_qpwdrqddif_t qualified template;
   value char(1);
end-ds;

// Password rules

dcl-ds r5_qpwdrules_t qualified template;
   value char(15) dim(50);
end-ds;

// Password validation program

dcl-ds r5_qpwdvldpgm_t qualified template;
   value char(20);
end-ds;

// Power down limit

dcl-ds r5_qpwrdwnlmt_T qualified template;
   value int(10);
end-ds;

// Power restore IPL

dcl-ds r5_qpwrrstipl_t qualified template;
   value char(1);
end-ds;

// Parallel processing degree

dcl-ds r5_qqrydegree_t qualified template;
   value char(10);
end-ds;

// Query processing time limit

dcl-ds r5_qqrytimlmt_t qualified template;
   value char(10);
end-ds;

// Reclaim spool storage

dcl-ds r5_qrclsplttg_t qualified template;
   value char(10);
end-ds;

// Retain server security data

dcl-ds r5_qretsvrsec_t qualified template;
   value char(1);
end-ds;

// Remote IPL

dcl-ds r5_qrmtipl_t qualified template;
   value char(1);
end-ds;

// Remote sign-on

dcl-ds r5_qrmtsign_t qualified template;
   value char(20);
end-ds;

// Remote service attribute

dcl-ds r5_qrmtsrvatr_t qualified template;
   value char(1);
end-ds;

// Save access paths

dcl-ds r5_qsavaccpth_t qualified template;
   value char(1);
end-ds;

// Scan file systems

dcl-ds r5_qscanfs_t qualified template;
   value char(10) dim(20);
end-ds;

// Scan file systems control

dcl-ds r5_qscanfsctl_t qualified template;
   value char(10) dim(20);
end-ds;

// IPL action with console problem

dcl-ds r5_qscpfcons_t qualified template;
   value char(1);
end-ds;

// Second

dcl-ds r5_qsecond_t qualified template;
   value char(2);
end-ds;

// Security level

dcl-ds r5_qsecurity_t qualified template;
   value char(2);
end-ds;

// Set job attributes from locale

dcl-ds r5_qsetjobatr_t qualified template;
   value char(10) dim(16);
end-ds;

// Software error log

dcl-ds r5_qsfwerrlog_t qualified template;
   value char(10);
end-ds;

// Shared memory control

dcl-ds r5_qshrmemctl_t qualified template;
   value char(1);
end-ds;

// Special environment

dcl-ds r5_qspcenv_t qualified template;
   value char(10);
end-ds;

// Spooled file action

dcl-ds r5_qsplfacn_t qualified template;
   value char(10);
end-ds;

// Serial number

dcl-ds r5_qsrlnbr_t qualified template;
   value char(8);
end-ds;

// Sort sequence table

dcl-ds r5_qsrtseq_t qualified template;
   value char(20);
end-ds;

// Service dump

dcl-ds r5_qsrvdmp_t qualified template;
   value char(10);
end-ds;

// Transport Layer Security cipher specification list

dcl-ds r5_qsslcsl_t qualified template;
   value char(40) dim(96);
end-ds;

// Transport Layer Security cipher specification list control

dcl-ds r5_qsslcslctl_t qualified template;
   value char(10);
end-ds;

// Transport Layer Security protocols

dcl-ds r5_qsslpcl_t qualified template;
   value char(10) dim(10);
end-ds;

// Auxiliary storage lower limit action

dcl-ds r5_qstglowacn_t qualified template;
   value char(10);
end-ds;

// Auxiliary storage lower limit

dcl-ds r5_qstglowlmt_t qualified template;
   value int(10);
end-ds;

// Start printer writer

dcl-ds r5_qstrprtwtr_t qualified template;
   value char(1);
end-ds;

// Startup program name

dcl-ds r5_qstruppgm_t qualified template;
   value char(20);
end-ds;

// Status messages

dcl-ds r5_qstsmsg_t qualified template;
   value char(10);
end-ds;

// Server authentication interval

dcl-ds r5_qsvrautitv_t qualified template;
   value int(10);
end-ds;

// System library list

dcl-ds r5_qsyslibl_t qualified template;
   value char(10) dim(15);
end-ds;

// Thread resources adjustment

dcl-ds r5_qthdrscadj_t qualified template;
   value char(1);
end-ds;

// Thread resources affinity

dcl-ds r5_qthdrscafn_t qualified template;
   value char(20);
end-ds;

// Time adjustment

dcl-ds r5_qtimadj_t qualified template;
   value char(30);
end-ds;

// System time

dcl-ds r5_qtime_t qualified template;
   value char(9);
end-ds;

// Time separator

dcl-ds r5_qtimsep_t qualified template;
   value char(1);
end-ds;

// Time zone

dcl-ds r5_qtimzon_t qualified template;
   value char(10);
end-ds;

// Total jobs

dcl-ds r5_qtotjob_t qualified template;
   value int(10);
end-ds;

// Time-slice end pool

dcl-ds r5_qtsepool_t qualified template;
   value char(10);
end-ds;

// UPS delay time

dcl-ds r5_qupsdlytim_t qualified template;
   value char(20);
end-ds;

// UPS message queue

dcl-ds r5_qupsmsgq_t qualified template;
   value char(20);
end-ds;

// Use adopted authority

dcl-ds r5_quseadpaut_t qualified template;
   value char(10);
end-ds;

// User library list

dcl-ds r5_qusrlibl_t qualified template;
   value char(10) dim(25);
end-ds;

// Coordinated universal time offset

dcl-ds r5_qutcoffSet_t qualified template;
   value char(5);
end-ds;

// Verify object on restore

dcl-ds r5_qvfyobjrst_t qualified template;
   value char(1);
end-ds;

// Year

dcl-ds r5_qyear_t qualified template;
   value char(2);
end-ds;


dcl-pr r5_get_system_value char(16384) rtnparm extproc(*DCLCASE);
   sysval like(r5_name_t) const;
end-pr;

