**FREE

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt bnddir('RPG5LIB': 'IBMIUNIT/IBMIUNIT': 'OSSILE/OSSILE');
ctl-opt option(*SRCSTMT: *NODEBUGIO);

/COPY IBMiUnit/qrpglesrc,ibmiunit_h

*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS CALLLEVEL Module Test Suite');

IBMiUnit_addTestSuite('R5TCL01');  // r5_this()
IBMiUnit_addTestSuite('R5TCL02');  // r5_caller()

IBMiUnit_teardownSuite();
return;
