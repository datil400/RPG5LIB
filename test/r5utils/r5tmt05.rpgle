**FREE

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('IBMIUNIT/IBMIUNIT': 'RPG5LIB');

/copy IBMiUnit/qrpglesrc,ibmiunit_h
/copy RPG5LIB,math_h


*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS MATH module - Test r5_random_number');

IBMiUnit_addTestCase(%paddr(test_random_number): 'test_random_number');

IBMiUnit_teardownSuite();
return;

dcl-proc test_random_number;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   dcl-c HIGH 50;
   dcl-c LOW 0;
   dcl-c MAX_TEST 10000;

   dcl-s n like(r5_int_t);
   dcl-s p like(r5_int_t);
   dcl-s r like(r5_int_t);

   p = r5_random_number(HIGH: LOW);
   assertOn((p>= LOW and p <= HIGH): 'Rand number in range');

   for n = 1 to MAX_TEST;

      r = r5_random_number(HIGH: LOW);
      assertOn((r>= LOW and r <= HIGH): 'Rand number in range');
      //assertOn(p <> n: 'Current rand number distinct from previous');

      p = r;

   endfor;
   return;
end-proc;

