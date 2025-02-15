**FREE

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('IBMIUNIT/IBMIUNIT': 'RPG5LIB');

/copy IBMiUnit/qrpglesrc,ibmiunit_h
/copy RPG5LIB,math_h


*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS MATH module - Test r5_cube_root');

IBMiUnit_addTestCase(%paddr(test_cube_root): 'test_cube_root');

IBMiUnit_teardownSuite();
return;

dcl-proc test_cube_root;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   dcl-s delta float(8) inz(1E-6);
   dcl-s cube float(8);
   dcl-s value float(8);

   // positive

   value = 0;
   dow value <= 100;
      cube = value ** 3;
      assertFloatEquals(value: r5_cube_root(cube): delta);
      value += 0,1;
   enddo;

   // negative

   value = 0;
   dow value >= -100;
      cube = value ** 3;
      assertFloatEquals(value: r5_cube_root(cube): delta);
      value -= 0,1;
   enddo;

   assertFloatEquals(27: r5_cube_root(19683): delta);
   assertFloatEquals(5: r5_cube_root(125): delta);

   return;
end-proc;

