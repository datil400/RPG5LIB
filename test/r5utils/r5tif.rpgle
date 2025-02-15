**FREE

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt bnddir('RPG5LIB': 'IBMIUNIT/IBMIUNIT': 'OSSILE/OSSILE');
ctl-opt option(*SRCSTMT: *NODEBUGIO);

/COPY IBMiUnit/qrpglesrc,ibmiunit_h

*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS IIF Module Test Suite');

IBMiUnit_addTestSuite('R5TIF01');

IBMiUnit_teardownSuite();
return;
