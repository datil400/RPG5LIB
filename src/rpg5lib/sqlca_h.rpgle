**FREE

/IF DEFINED(R5_SQLCA_H)
/EOF
/ENDIF
/DEFINE R5_SQLCA_H

//  Package : RPG5LIB
//  SrvPgm  : R5EXCMGR
//
//  SQLCA_H
//
//  SQL communication area
//
//  Mayo 2021
//
//  Use:
//
//  /COPY RPG5LIB,sqlca_h


dcl-ds r5_sqlca_t qualified template;
   SQLCAID char(8) inz(X'0000000000000000');
     SQLAID char(8) overlay(SQLCAID);
   SQLCABC int(10);
     SQLABC bindec(9) overlay(SQLCABC);
   SQLCODE int(10);
     SQLCOD bindec(9) overlay(SQLCODE);
   SQLERRML int(5);
     SQLERL bindec(4) overlay(SQLERRML);
   SQLERRMC char(70);
     SQLERM char(70) overlay(SQLERRMC);
   SQLERRP char(8);
     SQLERP char(8) overlay(SQLERRP);
   SQLERR char(24);
     SQLER1 bindec(9) overlay(SQLERR: *NEXT);
     SQLER2 bindec(9) overlay(SQLERR: *NEXT);
     SQLER3 bindec(9) overlay(SQLERR: *NEXT);
     SQLER4 bindec(9) overlay(SQLERR: *NEXT);
     SQLER5 bindec(9) overlay(SQLERR: *NEXT);
     SQLER6 bindec(9) overlay(SQLERR: *NEXT);
     SQLERRD int(10) DIM(6) overlay(SQLERR);
   SQLWRN char(11);
     SQLWN0 char(1) overlay(SQLWRN: *NEXT);
     SQLWN1 char(1) overlay(SQLWRN: *NEXT);
     SQLWN2 char(1) overlay(SQLWRN: *NEXT);
     SQLWN3 char(1) overlay(SQLWRN: *NEXT);
     SQLWN4 char(1) overlay(SQLWRN: *NEXT);
     SQLWN5 char(1) overlay(SQLWRN: *NEXT);
     SQLWN6 char(1) overlay(SQLWRN: *NEXT);
     SQLWN7 char(1) overlay(SQLWRN: *NEXT);
     SQLWN8 char(1) overlay(SQLWRN: *NEXT);
     SQLWN9 char(1) overlay(SQLWRN: *NEXT);
     SQLWNA char(1) overlay(SQLWRN: *NEXT);
     SQLWARN char(1) dim(11) overlay(SQLWRN);
   SQLSTATE char(5);
     SQLSTT char(5) overlay(SQLSTATE);
end-ds;
