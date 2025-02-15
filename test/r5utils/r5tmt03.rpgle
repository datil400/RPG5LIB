**FREE

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('IBMIUNIT/IBMIUNIT': 'RPG5LIB');

/copy IBMiUnit/qrpglesrc,ibmiunit_h
/copy RPG5LIB,math_h


*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS MATH module - Test r5_min');

IBMiUnit_addTestCase(%paddr(test_min): 'test_min');

IBMiUnit_teardownSuite();
return;

dcl-proc test_min;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   assertNumericEquals(0: r5_min(0: 1: 2: 3: 4: 5: 6: 7: 8: 9: 10: 11: 12: 13: 14));
   assertNumericEquals(0: r5_min(1: 0: 2: 3: 4: 5: 6: 7: 8: 9: 10: 11: 12: 13: 14));
   assertNumericEquals(0: r5_min(1: 2: 0: 3: 4: 5: 6: 7: 8: 9: 10: 11: 12: 13: 14));
   assertNumericEquals(0: r5_min(1: 2: 3: 0: 4: 5: 6: 7: 8: 9: 10: 11: 12: 13: 14));
   assertNumericEquals(0: r5_min(1: 2: 3: 4: 0: 5: 6: 7: 8: 9: 10: 11: 12: 13: 14));
   assertNumericEquals(0: r5_min(1: 2: 3: 4: 5: 0: 6: 7: 8: 9: 10: 11: 12: 13: 14));
   assertNumericEquals(0: r5_min(1: 2: 3: 4: 5: 6: 0: 7: 8: 9: 10: 11: 12: 13: 14));
   assertNumericEquals(0: r5_min(1: 2: 3: 4: 5: 6: 7: 0: 8: 9: 10: 11: 12: 13: 14));
   assertNumericEquals(0: r5_min(1: 2: 3: 4: 5: 6: 7: 8: 0: 9: 10: 11: 12: 13: 14));
   assertNumericEquals(0: r5_min(1: 2: 3: 4: 5: 6: 7: 8: 9: 0: 10: 11: 12: 13: 14));
   assertNumericEquals(0: r5_min(1: 2: 3: 4: 5: 6: 7: 8: 9: 10: 0: 11: 12: 13: 14));
   assertNumericEquals(0: r5_min(1: 2: 3: 4: 5: 6: 7: 8: 9: 10: 11: 0: 12: 13: 14));
   assertNumericEquals(0: r5_min(1: 2: 3: 4: 5: 6: 7: 8: 9: 10: 11: 12: 0: 13: 14));
   assertNumericEquals(0: r5_min(1: 2: 3: 4: 5: 6: 7: 8: 9: 10: 11: 12: 13: 0: 14));
   assertNumericEquals(0: r5_min(1: 2: 3: 4: 5: 6: 7: 8: 9: 10: 11: 12: 13: 14: 0));

   assertNumericEquals(0: r5_min(14: 13: 12: 11: 10: 9: 8: 7: 6: 5: 4: 3: 2: 1: 0));
   assertNumericEquals(0: r5_min(14: 13: 12: 11: 10: 9: 8: 7: 6: 5: 4: 3: 2: 0: 1));
   assertNumericEquals(0: r5_min(14: 13: 12: 11: 10: 9: 8: 7: 6: 5: 4: 3: 0: 2: 1));
   assertNumericEquals(0: r5_min(14: 13: 12: 11: 10: 9: 8: 7: 6: 5: 4: 0: 3: 2: 1));
   assertNumericEquals(0: r5_min(14: 13: 12: 11: 10: 9: 8: 7: 6: 5: 0: 4: 3: 2: 1));
   assertNumericEquals(0: r5_min(14: 13: 12: 11: 10: 9: 8: 7: 6: 0: 5: 4: 3: 2: 1));
   assertNumericEquals(0: r5_min(14: 13: 12: 11: 10: 9: 8: 7: 0: 6: 5: 4: 3: 2: 1));
   assertNumericEquals(0: r5_min(14: 13: 12: 11: 10: 9: 8: 0: 7: 6: 5: 4: 3: 2: 1));
   assertNumericEquals(0: r5_min(14: 13: 12: 11: 10: 9: 0: 8: 7: 6: 5: 4: 3: 2: 1));
   assertNumericEquals(0: r5_min(14: 13: 12: 11: 10: 0: 9: 8: 7: 6: 5: 4: 3: 2: 1));
   assertNumericEquals(0: r5_min(14: 13: 12: 11: 0: 10: 9: 8: 7: 6: 5: 4: 3: 2: 1));
   assertNumericEquals(0: r5_min(14: 13: 12: 0: 11: 10: 9: 8: 7: 6: 5: 4: 3: 2: 1));
   assertNumericEquals(0: r5_min(14: 13: 0: 12: 11: 10: 9: 8: 7: 6: 5: 4: 3: 2: 1));
   assertNumericEquals(0: r5_min(14: 0: 13: 12: 11: 10: 9: 8: 7: 6: 5: 4: 3: 2: 1));
   assertNumericEquals(0: r5_min(0: 14: 13: 12: 11: 10: 9: 8: 7: 6: 5: 4: 3: 2: 1));

   assertNumericEquals(-14
                      : r5_min(0: -1: -2: -3: -4: -5: -6: -7: -8: -9: -10: -11: -12: -13: -14));
   assertNumericEquals(-14
                      : r5_min(-1: 0: -2: -3: -4: -5: -6: -7: -8: -9: -10: -11: -12: -13: -14));
   assertNumericEquals(-14
                      : r5_min(-1: -2: 0: -3: -4: -5: -6: -7: -8: -9: -10: -11: -12: -13: -14));
   assertNumericEquals(-14
                      : r5_min(-1: -2: -3: 0: -4: -5: -6: -7: -8: -9: -10: -11: -12: -13: -14));
   assertNumericEquals(-14
                      : r5_min(-1: -2: -3: -4: 0: -5: -6: -7: -8: -9: -10: -11: -12: -13: -14));
   assertNumericEquals(-14
                      : r5_min(-1: -2: -3: -4: -5: 0: -6: -7: -8: -9: -10: -11: -12: -13: -14));
   assertNumericEquals(-14
                      : r5_min(-1: -2: -3: -4: -5: -6: 0: -7: -8: -9: -10: -11: -12: -13: -14));
   assertNumericEquals(-14
                      : r5_min(-1: -2: -3: -4: -5: -6: -7: 0: -8: -9: -10: -11: -12: -13: -14));
   assertNumericEquals(-14
                      : r5_min(-1: -2: -3: -4: -5: -6: -7: -8: 0: -9: -10: -11: -12: -13: -14));
   assertNumericEquals(-14
                      : r5_min(-1: -2: -3: -4: -5: -6: -7: -8: -9: 0: -10: -11: -12: -13: -14));
   assertNumericEquals(-14
                      : r5_min(-1: -2: -3: -4: -5: -6: -7: -8: -9: -10: 0: -11: -12: -13: -14));
   assertNumericEquals(-14
                      : r5_min(-1: -2: -3: -4: -5: -6: -7: -8: -9: -10: -11: 0: -12: -13: -14));
   assertNumericEquals(-14
                      : r5_min(-1: -2: -3: -4: -5: -6: -7: -8: -9: -10: -11: -12: 0: -13: -14));
   assertNumericEquals(-14
                      : r5_min(-1: -2: -3: -4: -5: -6: -7: -8: -9: -10: -11: -12: -13: 0: -14));
   assertNumericEquals(-14
                      : r5_min(-1: -2: -3: -4: -5: -6: -7: -8: -9: -10: -11: -12: -13: -14: 0));

   assertNumericEquals(-14
                      : r5_min(-14: -13: -12: -11: -10: -9: -8: -7: -6: -5: -4: -3: -2: -1: 0));
   assertNumericEquals(-14
                      : r5_min(-14: -13: -12: -11: -10: -9: -8: -7: -6: -5: -4: -3: -2: 0: -1));
   assertNumericEquals(-14
                      : r5_min(-14: -13: -12: -11: -10: -9: -8: -7: -6: -5: -4: -3: 0: -2: -1));
   assertNumericEquals(-14
                      : r5_min(-14: -13: -12: -11: -10: -9: -8: -7: -6: -5: -4: 0: -3: -2: -1));
   assertNumericEquals(-14
                      : r5_min(-14: -13: -12: -11: -10: -9: -8: -7: -6: -5: 0: -4: -3: -2: -1));
   assertNumericEquals(-14
                      : r5_min(-14: -13: -12: -11: -10: -9: -8: -7: -6: 0: -5: -4: -3: -2: -1));
   assertNumericEquals(-14
                      : r5_min(-14: -13: -12: -11: -10: -9: -8: -7: 0: -6: -5: -4: -3: -2: -1));
   assertNumericEquals(-14
                      : r5_min(-14: -13: -12: -11: -10: -9: -8: 0: -7: -6: -5: -4: -3: -2: -1));
   assertNumericEquals(-14
                      : r5_min(-14: -13: -12: -11: -10: -9: 0: -8: -7: -6: -5: -4: -3: -2: -1));
   assertNumericEquals(-14
                      : r5_min(-14: -13: -12: -11: -10: 0: -9: -8: -7: -6: -5: -4: -3: -2: -1));
   assertNumericEquals(-14
                      : r5_min(-14: -13: -12: -11: 0: -10: -9: -8: -7: -6: -5: -4: -3: -2: -1));
   assertNumericEquals(-14
                      : r5_min(-14: -13: -12: 0: -11: -10: -9: -8: -7: -6: -5: -4: -3: -2: -1));
   assertNumericEquals(-14
                      : r5_min(-14: -13: 0: -12: -11: -10: -9: -8: -7: -6: -5: -4: -3: -2: -1));
   assertNumericEquals(-14
                      : r5_min(-14: 0: -13: -12: -11: -10: -9: -8: -7: -6: -5: -4: -3: -2: -1));
   assertNumericEquals(-14
                      : r5_min(0: -14: -13: -12: -11: -10: -9: -8: -7: -6: -5: -4: -3: -2: -1));
   return;
end-proc;

