**FREE

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt bnddir('RPG5LIB': 'IBMIUNIT/IBMIUNIT': 'OSSILE/OSSILE');
ctl-opt option(*SRCSTMT: *NODEBUGIO);

/COPY IBMiUnit/qrpglesrc,ibmiunit_h

*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS MATH Module Test Suite');

IBMiUnit_addTestSuite('R5TMT01');   // r5_cube_root()
IBMiUnit_addTestSuite('R5TMT03');   // r5_min()
IBMiUnit_addTestSuite('R5TMT04');   // r5_max()
IBMiUnit_addTestSuite('R5TMT05');   // r5_random_number()
IBMiUnit_addTestSuite('R5TMT06');   // r5_sign()

IBMiUnit_teardownSuite();
return;
