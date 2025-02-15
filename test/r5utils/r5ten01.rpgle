**FREE

// Test r5_errno_to_errc0100

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt bnddir('RPG5LIB': 'IBMIUNIT/IBMIUNIT': 'OSSILE/OSSILE');
ctl-opt option(*SRCSTMT: *NODEBUGIO);

/copy IBMiUnit/qrpglesrc,ibmiunit_h
/copy RPG5LIB,errno_h

/COPY API,errno_h

dcl-ds error likeds(ERRC0100_T);


*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS ERRNO module - Test r5_errno_to_errc0100');

IBMiUnit_addTestCase(%paddr(errno_to_errc0100): 'errno_to_errc0100');

IBMiUnit_teardownSuite();
return;

dcl-proc errno_to_errc0100;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   error = r5_errno_to_errc0100();
   assertNumericNotEquals(0: error.bytesPrv);
   assertNumericEquals(0: error.bytesAvl);

   error = r5_errno_to_errc0100(EDOM);
   assertNumericEquals(16: error.bytesPrv);
   assertNumericEquals(16: error.bytesAvl);
   assertCharEquals('CPE3001': error.msgID);
   return;
end-proc;

