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


dcl-ds qabnormsw_t qualified template;
   value char(1);
end-ds;

dcl-ds qacglvl_t qualified template;
   value char(10) dim(8);
end-ds;

dcl-ds qactjob_t qualified template;
   value int(10);
end-ds;

dcl-ds qadlactj_t qualified template;
   value int(10);
end-ds;

dcl-ds qadlspla_t qualified template;
   value int(10);
end-ds;

dcl-ds qadltotj_t qualified template;
   value int(10);
end-ds;

dcl-ds qalwjobitp_t qualified template;
   value char(1);
end-ds;

dcl-ds qalwobjrst_t qualified template;
   value char(10) dim(15);
end-ds;

dcl-ds qalwusrdmn_t qualified template;
   value char(10) dim(50);
end-ds;

dcl-ds qastlvl_t qualified template;
   value char(10);
end-ds;

dcl-ds qatnpgm_t qualified template;
   value char(20);
end-ds;

dcl-ds qaudctl_t qualified template;
   value char(10) dim(5);
end-ds;

dcl-ds qaudendacn_t qualified template;
   value char(10);
end-ds;

dcl-ds qaudfrclvl_t qualified template;
   value int(10);
end-ds;

dcl-ds qaudlvl_t qualified template;
   value char(10) dim(16);
end-ds;

dcl-ds qaudlvl2_t qualified template;
   value char(10) dim(99);
end-ds;

dcl-ds qautocfg_t qualified template;
   value char(1);
end-ds;

dcl-ds qautormt_t qualified template;
   value char(1);
end-ds;

dcl-ds qautosprpt_t qualified template;
   value char(1);
end-ds;

dcl-ds qautovrt_t qualified template;
   value int(10);
end-ds;

dcl-ds qbasactlvl_t qualified template;
   value int(10);
end-ds;

dcl-ds qbaspool_t qualified template;
   value int(10);
end-ds;

dcl-ds qbaspool2_t qualified template;
   value int(20);
end-ds;

dcl-ds qbookpath_t qualified template;
   value char(63) dim(5);
end-ds;

dcl-ds qccsid_t qualified template;
   value int(10);
end-ds;

dcl-ds qcentury_t qualified template;
   value char(1);
end-ds;

dcl-ds qcfgmsgq_t qualified template;
   value char(20);
end-ds;

dcl-ds qchrid_t qualified template;
   value char(20);
end-ds;

dcl-ds qchridctl_t qualified template;
   value char(10);
end-ds;

dcl-ds qcmnarb_t qualified template;
   value char(10);
end-ds;

dcl-ds qcmnrcylmt_t qualified template;
   value char(20);
end-ds;

dcl-ds qcntryid_t qualified template;
   value char(2);
end-ds;

dcl-ds qconsole_t qualified template;
   value char(10);
end-ds;

dcl-ds qcrtaut_t qualified template;
   value char(10);
end-ds;

dcl-ds qcrtobjaud_t qualified template;
   value char(10);
end-ds;

dcl-ds qctlsbsd_t qualified template;
   value char(20);
end-ds;

dcl-ds qcursym_t qualified template;
   value char(1);
end-ds;

dcl-ds qdate_t qualified template;
   value char(7);
end-ds;

dcl-ds qdatetime_t qualified template;
   value char(20);
end-ds;

dcl-ds qdatfmt_t qualified template;
   value char(3);
end-ds;

dcl-ds qdatsep_t qualified template;
   value char(1);
end-ds;

dcl-ds qday_t qualified template;
   value char(3);
end-ds;

dcl-ds qdayofweek_t qualified template;
   value char(4);
end-ds;

dcl-ds qdbfstccol_t qualified template;
   value char(10);
end-ds;

dcl-ds qdbrcvywt_t qualified template;
   value char(1);
end-ds;

dcl-ds qdecfmt_t qualified template;
   value char(1);
end-ds;

dcl-ds qdevnaming_t qualified template;
   value char(10);
end-ds;

dcl-ds qdevrcyacn_t qualified template;
   value char(20);
end-ds;

dcl-ds qdscjobitv_t qualified template;
   value char(10);
end-ds;

dcl-ds qdspsgninf_t qualified template;
   value char(1);
end-ds;

dcl-ds qdynptyadj_t qualified template;
   value char(1);
end-ds;

dcl-ds qdynptyscd_t qualified template;
   value char(1);
end-ds;

dcl-ds qendjoblmt_t qualified template;
   value int(10);
end-ds;

dcl-ds qfrccvnrst_t qualified template;
   value char(1);
end-ds;

dcl-ds qhour_t qualified template;
   value char(2);
end-ds;

dcl-ds qhstlogsiz_t qualified template;
   value int(10);
end-ds;

dcl-ds qigc_t qualified template;
   value char(1);
end-ds;

dcl-ds qigccdefnt_t qualified template;
   value char(20);
end-ds;

dcl-ds qigcfntsiz_t qualified template;
   value int(10);
end-ds;

dcl-ds qinactitv_t qualified template;
   value char(10);
end-ds;

dcl-ds qinactmsgq_t qualified template;
   value char(20);
end-ds;

dcl-ds qipldattim_t qualified template;
   value char(13);
end-ds;

dcl-ds qiplsts_t qualified template;
   value char(1);
end-ds;

dcl-ds qipltype_t qualified template;
   value char(1);
end-ds;

dcl-ds qjobmsgqfl_t qualified template;
   value char(10);
end-ds;

dcl-ds qjobmsgqmx_t qualified template;
   value int(10);
end-ds;

dcl-ds qjobmsgqsz_t qualified template;
   value int(10);
end-ds;

dcl-ds qjobmsgqtl_t qualified template;
   value int(10);
end-ds;

dcl-ds qjobspla_t qualified template;
   value int(10);
end-ds;

dcl-ds qkbdbuf_t qualified template;
   value char(10);
end-ds;

dcl-ds qkbdtype_t qualified template;
   value char(3);
end-ds;

dcl-ds qlangid_t qualified template;
   value char(3);
end-ds;

dcl-ds qleapadj_t qualified template;
   value int(10);
end-ds;

dcl-ds qliblcklvl_t qualified template;
   value char(1);
end-ds;

dcl-ds qlmtdevssn_t qualified template;
   value char(1);
end-ds;

dcl-ds qlmtsecofr_t qualified template;
   value char(1);
end-ds;

dcl-ds qlocale_t qualified template;
   value char(2080);
end-ds;

dcl-ds qlogoutput_t qualified template;
   value char(10);
end-ds;

dcl-ds qmaxactlvl_t qualified template;
   value int(10);
end-ds;

dcl-ds qmaxjob_t qualified template;
   value int(10);
end-ds;

dcl-ds qmaxsgnacn_t qualified template;
   value char(1);
end-ds;

dcl-ds qmaxsign_t qualified template;
   value char(6);
end-ds;

dcl-ds qmaxsplf_t qualified template;
   value int(10);
end-ds;

dcl-ds qmchpool_t qualified template;
   value int(10);
end-ds;

 /IF DEFINED(*V7R2M0)
dcl-ds qmchpool2_t qualified template;
   value int(20);
end-ds;
 /ENDIF

dcl-ds qminute_t qualified template;
   value char(2);
end-ds;

dcl-ds qmltthdacn_t qualified template;
   value char(1);
end-ds;

dcl-ds qmodel_t qualified template;
   value char(4);
end-ds;

dcl-ds qmonth_t qualified template;
   value char(2);
end-ds;

dcl-ds qpasthrsvr_t qualified template;
   value char(10);
end-ds;

dcl-ds qpfradj_t qualified template;
   value char(1);
end-ds;

dcl-ds qprbftr_t qualified template;
   value char(20);
end-ds;

dcl-ds qprbhlditv_t qualified template;
   value int(10);
end-ds;

dcl-ds qprcfeat_t qualified template;
   value char(4);
end-ds;

dcl-ds qprcmlttsk_t qualified template;
   value char(1);
end-ds;

dcl-ds qprtdev_t qualified template;
   value char(10);
end-ds;

dcl-ds qprtkeyfmt_t qualified template;
   value char(10);
end-ds;

dcl-ds qprttxt_t qualified template;
   value char(30);
end-ds;

dcl-ds qpwdchgblk_t qualified template;
   value char(10);
end-ds;

dcl-ds qpwdexpitv_t qualified template;
   value char(6);
end-ds;

dcl-ds qpwdexpwrn_t qualified template;
   value int(10);
end-ds;

dcl-ds qpwdlmtajc_t qualified template;
   value char(1);
end-ds;

dcl-ds qpwdlmtchr_t qualified template;
   value char(10);
end-ds;

dcl-ds qpwdlmtrep_t qualified template;
   value char(1);
end-ds;

dcl-ds qpwdlvl_t qualified template;
   value int(10);
end-ds;

dcl-ds qpwdmaxlen_t qualified template;
   value int(10);
end-ds;

dcl-ds qpwdminlen_t qualified template;
   value int(10);
end-ds;

dcl-ds qpwdposdif_t qualified template;
   value char(1);
end-ds;

dcl-ds qpwdrqddgt_t qualified template;
   value char(1);
end-ds;

dcl-ds qpwdrqddif_t qualified template;
   value char(1);
end-ds;

dcl-ds qpwdrules_t qualified template;
   value char(15) dim(50);
end-ds;

dcl-ds qpwdvldpgm_t qualified template;
   value char(10);
end-ds;

dcl-ds qpwrdwnlmt_T qualified template;
   value int(10);
end-ds;

dcl-ds qpwrrstipl_t qualified template;
   value char(1);
end-ds;

dcl-ds qqrydegree_t qualified template;
   value char(10);
end-ds;

dcl-ds qqrytimlmt_t qualified template;
   value char(10);
end-ds;

dcl-ds qrclsplttg_t qualified template;
   value char(10);
end-ds;

dcl-ds qretsvrsec_t qualified template;
   value char(1);
end-ds;

dcl-ds qrmtipl_t qualified template;
   value char(1);
end-ds;

dcl-ds qrmtsign_t qualified template;
   value char(20);
end-ds;

dcl-ds qrmtsrvatr_t qualified template;
   value char(1);
end-ds;

dcl-ds qsavaccpth_t qualified template;
   value char(1);
end-ds;

dcl-ds qscanfs_t qualified template;
   value char(10) dim(20);
end-ds;

dcl-ds qscanfsctl_t qualified template;
   value char(10) dim(20);
end-ds;

dcl-ds qscpfcons_t qualified template;
   value char(1);
end-ds;

dcl-ds qsecond_t qualified template;
   value char(2);
end-ds;

dcl-ds qsecurity_t qualified template;
   value char(2);
end-ds;

dcl-ds qsetjobatr_t qualified template;
   value char(10) dim(16);
end-ds;

dcl-ds qsfwerrlog_t qualified template;
   value char(10);
end-ds;

dcl-ds qshrmemctl_t qualified template;
   value char(1);
end-ds;

dcl-ds qspcenv_t qualified template;
   value char(10);
end-ds;

dcl-ds qSplfacn_t qualified template;
   value char(10);
end-ds;

dcl-ds qsrlnbr_t qualified template;
   value char(8);
end-ds;

dcl-ds qsrtseq_t qualified template;
   value char(20);
end-ds;

dcl-ds qsrvdmp_t qualified template;
   value char(10);
end-ds;

dcl-ds qsslcsl_t qualified template;
   value char(40) dim(96);
end-ds;

dcl-ds qsslcslctl_t qualified template;
   value char(10);
end-ds;

dcl-ds qsslpcl_t qualified template;
   value char(10) dim(10);
end-ds;

dcl-ds qstglowacn_t qualified template;
   value char(10);
end-ds;

dcl-ds qstglowlmt_t qualified template;
   value int(10);
end-ds;

dcl-ds qstrprtwtr_t qualified template;
   value char(1);
end-ds;

dcl-ds qstruppgm_t qualified template;
   value char(20);
end-ds;

dcl-ds qstsmsg_t qualified template;
   value char(10);
end-ds;

dcl-ds qsvrautitv_t qualified template;
   value int(10);
end-ds;

dcl-ds qsyslibl_t qualified template;
   value char(10) dim(15);
end-ds;

dcl-ds qthdrscadj_t qualified template;
   value char(1);
end-ds;

dcl-ds qthdrscafn_t qualified template;
   value char(20);
end-ds;

dcl-ds qtimadj_t qualified template;
   value char(30);
end-ds;

dcl-ds qtime_t qualified template;
   value char(9);
end-ds;

dcl-ds qtimsep_t qualified template;
   value char(1);
end-ds;

dcl-ds qtimzon_t qualified template;
   value char(10);
end-ds;

dcl-ds qtotjob_t qualified template;
   value int(10);
end-ds;

dcl-ds qtsepool_t qualified template;
   value char(10);
end-ds;

dcl-ds qupsdlytim_t qualified template;
   value char(20);
end-ds;

dcl-ds qupsmsgq_t qualified template;
   value char(20);
end-ds;

dcl-ds quseadpaut_t qualified template;
   value char(10);
end-ds;

dcl-ds qusrlibl_t qualified template;
   value char(10) dim(25);
end-ds;

dcl-ds qutcoffSet_t qualified template;
   value char(5);
end-ds;

dcl-ds qvfyobjrst_t qualified template;
   value char(1);
end-ds;

dcl-ds qyear_t qualified template;
   value char(2);
end-ds;


dcl-pr r5_get_system_value char(16384) rtnparm extproc(*DCLCASE);
   sysval like(r5_name_t) const;
end-pr;

