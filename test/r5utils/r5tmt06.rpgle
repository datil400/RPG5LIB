**FREE

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('IBMIUNIT/IBMIUNIT': 'RPG5LIB');

/copy IBMiUnit/qrpglesrc,ibmiunit_h
/copy RPG5LIB,math_h


*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS MATH module - Test r5_sign');

IBMiUnit_addTestCase(%paddr(test_sign): 'test_sign');
IBMiUnit_addTestCase(%paddr(test_opposite_sign): 'test_opposite_sign');

IBMiUnit_teardownSuite();
return;

dcl-proc test_sign;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   dcl-c NEGATIVE -1;
   dcl-c ZERO 0;
   dcl-c POSITIVE 1;

   assertNumericEquals(NEGATIVE: r5_sign(-0.001));
   assertNumericEquals(NEGATIVE: r5_sign(-0.99));
   assertNumericEquals(NEGATIVE: r5_sign(-1));
   assertNumericEquals(NEGATIVE: r5_sign(-1.00001));
   assertNumericEquals(NEGATIVE: r5_sign(-236874));

   assertNumericEquals(POSITIVE: r5_sign(0.001));
   assertNumericEquals(POSITIVE: r5_sign(0.99));
   assertNumericEquals(POSITIVE: r5_sign(1));
   assertNumericEquals(POSITIVE: r5_sign(1.00001));
   assertNumericEquals(POSITIVE: r5_sign(236874));

   assertNumericEquals(ZERO: r5_sign(0));
   return;
end-proc;


dcl-proc test_opposite_sign;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   dcl-c NEGATIVE -1;
   dcl-c ZERO 0;
   dcl-c POSITIVE 1;

   assertNumericEquals(POSITIVE: r5_opposite_sign(-0.001));
   assertNumericEquals(POSITIVE: r5_opposite_sign(-0.99));
   assertNumericEquals(POSITIVE: r5_opposite_sign(-1));
   assertNumericEquals(POSITIVE: r5_opposite_sign(-1.00001));
   assertNumericEquals(POSITIVE: r5_opposite_sign(-236874));

   assertNumericEquals(NEGATIVE: r5_opposite_sign(0.001));
   assertNumericEquals(NEGATIVE: r5_opposite_sign(0.99));
   assertNumericEquals(NEGATIVE: r5_opposite_sign(1));
   assertNumericEquals(NEGATIVE: r5_opposite_sign(1.00001));
   assertNumericEquals(NEGATIVE: r5_opposite_sign(236874));

   assertNumericEquals(ZERO: r5_opposite_sign(0));
   return;
end-proc;

