**FREE

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('IBMIUNIT/IBMIUNIT': 'RPG5LIB');

/copy IBMiUnit/qrpglesrc,ibmiunit_h
/COPY RPG5LIB,in_h


*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS IN module - Test r5_in_float');

IBMiUnit_addTestCase(%paddr(test_in_float): 'test_in_float');

IBMiUnit_teardownSuite();
return;


dcl-proc test_in_float;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   dcl-c PI  3.14159265358979323846264;
   dcl-s i like(r5_small_t);
   dcl-s float like(r5_double_t);
   dcl-s delta like(r5_double_t);

   float = PI;
   delta = 1.0E-5;

   for i = 2 to 6;
      assertOn(r5_in_float( float: delta
                          : 3.1416: 9.869604401: 3.100627668029982017E+1
                          : 9.740909103400243723644E+1
                          : 3.0601968478528145E+2
              ));
      float = PI ** i;
   endfor;

   delta = 1.0E-2;
   assertOff(r5_in_float(PI: delta: 3.13: 3.16));
   return;
end-proc;

