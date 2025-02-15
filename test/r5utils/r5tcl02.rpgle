**FREE

// Test r5_caller
//
// First check where the IBMIUNIT and R5TCL02A programs are located.

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt bnddir('RPG5LIB': 'IBMIUNIT/IBMIUNIT': 'OSSILE/OSSILE');
ctl-opt option(*SRCSTMT: *NODEBUGIO);

/copy IBMiUnit/qrpglesrc,ibmiunit_h
/copy RPG5LIB,calllevelh

/COPY RPG5LIB,pgmsts_h

dcl-pr R5TCL02A extpgm('R5TCL02A');
   result likeds(r5_call_level_info_t);
   o_target int(10) options(*NOPASS) const;
end-pr;

*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS CALLLEVEL module - Test r5_caller');

IBMiUnit_addTestCase(%paddr(test_caller): 'Test Caller');

IBMiUnit_teardownSuite();
return;

dcl-proc test_caller;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   dcl-ds lvl likeds(r5_call_level_info_t);

   r5_caller(lvl);
   assertCharEquals(X'02': lvl.program_type: '': *ON);
   assertCharEquals('CALLTESTPROCEDURE': lvl.procedure_name: '': *ON);
   assertCharEquals('IBMIUNIT  ': lvl.program_name: '': *ON);
   assertCharEquals('IBMIUNIT  ': lvl.program_library: '': *ON);
   assertCharEquals('IBMIUNIT  ': lvl.module_name: '': *ON);
   assertCharEquals('QTEMP': lvl.module_library: '': *ON);
   //assertNumericEquals(expected: lvl.stmts_count);
   //assertCharEquals(expected: lvl.statements: '': *ON);
   assertCharEquals(r5_pgmsts.job_name: lvl.job.name: '': *ON);
   assertCharEquals(r5_pgmsts.job_user: lvl.job.user: '': *ON);
   assertCharEquals(r5_pgmsts.job_number: lvl.job.number: '': *ON);
   //assertCharEquals(expected: lvl.thread_id: '': *ON);
   //assertCharEquals(expected: lvl.char_thread_id: '': *ON);

   R5TCL02A(lvl);
   assertCharEquals(X'01': lvl.program_type: '': *ON);
   assertCharEquals('proc_2': lvl.procedure_name: '': *ON);
   assertCharEquals('R5TCL02A': lvl.program_name: '': *ON);
   assertCharEquals(r5_pgmsts.program_library: lvl.program_library: '': *ON);
   assertCharEquals('R5TCL02A': lvl.module_name: '': *ON);
   assertCharEquals('QTEMP': lvl.module_library: '': *ON);
   //assertNumericEquals(expected: lvl.stmts_count);
   //assertCharEquals(expected: lvl.statements: '': *ON);
   assertCharEquals(r5_pgmsts.job_name: lvl.job.name: '': *ON);
   assertCharEquals(r5_pgmsts.job_user: lvl.job.user: '': *ON);
   assertCharEquals(r5_pgmsts.job_number: lvl.job.number: '': *ON);
   //assertCharEquals(expected: lvl.thread_id: '': *ON);
   //assertCharEquals(expected: lvl.char_thread_id: '': *ON);

   R5TCL02A(lvl: 1);
   assertCharEquals(X'01': lvl.program_type: '': *ON);
   assertCharEquals('proc_1': lvl.procedure_name: '': *ON);
   assertCharEquals('R5TCL02A': lvl.program_name: '': *ON);
   assertCharEquals(r5_pgmsts.program_library: lvl.program_library: '': *ON);
   assertCharEquals('R5TCL02A': lvl.module_name: '': *ON);
   assertCharEquals('QTEMP': lvl.module_library: '': *ON);
   //assertNumericEquals(expected: lvl.stmts_count);
   //assertCharEquals(expected: lvl.statements: '': *ON);
   assertCharEquals(r5_pgmsts.job_name: lvl.job.name: '': *ON);
   assertCharEquals(r5_pgmsts.job_user: lvl.job.user: '': *ON);
   assertCharEquals(r5_pgmsts.job_number: lvl.job.number: '': *ON);
   //assertCharEquals(expected: lvl.thread_id: '': *ON);
   //assertCharEquals(expected: lvl.char_thread_id: '': *ON);

   R5TCL02A(lvl: 2);
   assertCharEquals(X'01': lvl.program_type: '': *ON);
   assertCharEquals('R5TCL02A': lvl.procedure_name: '': *ON);
   assertCharEquals('R5TCL02A': lvl.program_name: '': *ON);
   assertCharEquals(r5_pgmsts.program_library: lvl.program_library: '': *ON);
   assertCharEquals('R5TCL02A': lvl.module_name: '': *ON);
   assertCharEquals('QTEMP': lvl.module_library: '': *ON);
   //assertNumericEquals(expected: lvl.stmts_count);
   //assertCharEquals(expected: lvl.statements: '': *ON);
   assertCharEquals(r5_pgmsts.job_name: lvl.job.name: '': *ON);
   assertCharEquals(r5_pgmsts.job_user: lvl.job.user: '': *ON);
   assertCharEquals(r5_pgmsts.job_number: lvl.job.number: '': *ON);
   //assertCharEquals(expected: lvl.thread_id: '': *ON);
   //assertCharEquals(expected: lvl.char_thread_id: '': *ON);

   R5TCL02A(lvl: 3);
   assertCharEquals(X'01': lvl.program_type: '': *ON);
   assertCharEquals('_QRNP_PEP_R5TCL02A': lvl.procedure_name: '': *ON);
   assertCharEquals('R5TCL02A': lvl.program_name: '': *ON);
   assertCharEquals(r5_pgmsts.program_library: lvl.program_library: '': *ON);
   assertCharEquals('R5TCL02A': lvl.module_name: '': *ON);
   assertCharEquals('QTEMP': lvl.module_library: '': *ON);
   //assertNumericEquals(expected: lvl.stmts_count);
   //assertCharEquals(expected: lvl.statements: '': *ON);
   assertCharEquals(r5_pgmsts.job_name: lvl.job.name: '': *ON);
   assertCharEquals(r5_pgmsts.job_user: lvl.job.user: '': *ON);
   assertCharEquals(r5_pgmsts.job_number: lvl.job.number: '': *ON);
   //assertCharEquals(expected: lvl.thread_id: '': *ON);
   //assertCharEquals(expected: lvl.char_thread_id: '': *ON);
   return;
end-proc;
