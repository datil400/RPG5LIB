**FREE

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt bnddir('RPG5LIB': 'IBMIUNIT/IBMIUNIT': 'OSSILE/OSSILE');
ctl-opt option(*SRCSTMT: *NODEBUGIO);

/COPY IBMiUnit/qrpglesrc,ibmiunit_h

*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS ERRNO Module Test Suite');

IBMiUnit_addTestSuite('R5TEN01');  // r5_errno_to_errc0100()
IBMiUnit_addTestSuite('R5TEN02');  // r5_errno_to_msg_id()

IBMiUnit_teardownSuite();
return;
