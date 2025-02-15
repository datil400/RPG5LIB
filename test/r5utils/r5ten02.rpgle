**FREE

// Test r5_errno_to_msg_id

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt bnddir('RPG5LIB': 'IBMIUNIT/IBMIUNIT': 'OSSILE/OSSILE');
ctl-opt option(*SRCSTMT: *NODEBUGIO);

/copy IBMiUnit/qrpglesrc,ibmiunit_h
/copy RPG5LIB,errno_h

/COPY API,errno_h


*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS ERRNO module - Test r5_errno_to_msg_id');

IBMiUnit_addTestCase(%paddr(errno_to_msg_id): 'errno_to_msg_id');

IBMiUnit_teardownSuite();
return;

dcl-proc errno_to_msg_id;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   assertCharEquals('       ': r5_errno_to_msg_id(0));
   assertCharEquals('CPE3001': r5_errno_to_msg_id(EDOM));

   assertCharEquals('       ': r5_errno_to_msg_id(-1));
   assertCharEquals('       ': r5_errno_to_msg_id(10000));
   return;
end-proc;

