**FREE

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt bnddir('RPG5LIB': 'IBMIUNIT/IBMIUNIT': 'OSSILE/OSSILE');
ctl-opt option(*SRCSTMT: *NODEBUGIO);

/COPY IBMiUnit/qrpglesrc,ibmiunit_h

*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS APIERROR Module Test Suite');

IBMiUnit_addTestSuite('R5TAE01');  // r5_api_error_init_*
IBMiUnit_addTestSuite('R5TAE02');  // r5_api_error_ocurred()

IBMiUnit_teardownSuite();
return;
