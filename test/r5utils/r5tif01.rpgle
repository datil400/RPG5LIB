**FREE

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('IBMIUNIT/IBMIUNIT': 'RPG5LIB');

/copy IBMiUnit/qrpglesrc,ibmiunit_h
/COPY RPG5LIB,iif_h


*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS IIF module - Test r5_iif_*');

IBMiUnit_addTestCase(%paddr(test_iif_char): 'test_iif_char');
IBMiUnit_addTestCase(%paddr(test_iif_dec): 'test_iif_dec');
IBMiUnit_addTestCase(%paddr(test_iif_int): 'test_iif_int');
IBMiUnit_addTestCase(%paddr(test_iif_date): 'test_iif_date');
IBMiUnit_addTestCase(%paddr(test_iif_time): 'test_iif_time');
IBMiUnit_addTestCase(%paddr(test_iif_ts): 'test_iif_ts');

IBMiUnit_teardownSuite();
return;

dcl-proc test_iif_char;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   assertCharEquals('A': r5_iif_char(*ON: 'A': 'B'): '': *ON);
   assertCharEquals('B': r5_iif_char(*OFF: 'A': 'B'): '': *ON);
   return;
end-proc;


dcl-proc test_iif_dec;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   // r5_iif_dec tiene una precisión de (63, 9)
   // assertNumeric tiene una precisión de (60: 25)
   // Los valores se ajustan al número mínimo de la
   // parte entera y de la decimal.
   // 44 = 60 - 25 + 9

   dcl-s hival packed(44: 9) inz(*HIVAL);
   dcl-s loval packed(44: 9) inz(*LOVAL);

   assertNumericEquals(hival: r5_iif_dec(*ON: hival: loval));
   assertNumericEquals(loval: r5_iif_dec(*OFF: hival: loval));
   return;
end-proc;


dcl-proc test_iif_int;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   dcl-s hival int(20) inz(*HIVAL);
   dcl-s loval int(20) inz(*LOVAL);

   assertNumericEquals(hival: r5_iif_int(*ON: *HIVAL: *LOVAL));
   assertNumericEquals(loval: r5_iif_int(*OFF: *HIVAL: *LOVAL));
   return;
end-proc;


dcl-proc test_iif_date;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   assertDateEquals(*HIVAL: r5_iif_date(*ON: *HIVAL: *LOVAL));
   assertDateEquals(*LOVAL: r5_iif_date(*OFF: *HIVAL: *LOVAL));
   return;
end-proc;


dcl-proc test_iif_time;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   assertTimeEquals(*HIVAL: r5_iif_time(*ON: *HIVAL: *LOVAL));
   assertTimeEquals(*LOVAL: r5_iif_time(*OFF: *HIVAL: *LOVAL));
   return;
end-proc;


dcl-proc test_iif_ts;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   assertTimeStampEquals(*HIVAL: r5_iif_timestamp(*ON: *HIVAL: *LOVAL));
   assertTimeStampEquals(*LOVAL: r5_iif_timestamp(*OFF: *HIVAL: *LOVAL));
   return;
end-proc;
