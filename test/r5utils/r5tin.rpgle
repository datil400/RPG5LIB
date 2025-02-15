**FREE

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt bnddir('RPG5LIB': 'IBMIUNIT/IBMIUNIT': 'OSSILE/OSSILE');
ctl-opt option(*SRCSTMT: *NODEBUGIO);

/COPY IBMiUnit/qrpglesrc,ibmiunit_h

*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS IN Module Test Suite');

IBMiUnit_addTestSuite('R5TIN01');
IBMiUnit_addTestSuite('R5TIN02');

IBMiUnit_teardownSuite();
return;
