**FREE

// Test r5_this

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt bnddir('RPG5LIB': 'IBMIUNIT/IBMIUNIT': 'OSSILE/OSSILE');
ctl-opt option(*SRCSTMT: *NODEBUGIO);

/copy IBMiUnit/qrpglesrc,ibmiunit_h
/copy RPG5LIB,calllevelh

/COPY RPG5LIB,pgmsts_h

dcl-pr R5TCL01A extpgm('R5TCL01A');
   result likeds(r5_call_level_info_t);
end-pr;

*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS CALLLEVEL module - Test r5_this');

IBMiUnit_addTestCase(%paddr(test_this): 'Test This');

IBMiUnit_teardownSuite();
return;

dcl-proc test_this;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   dcl-ds this likeds(r5_call_level_info_t);

   r5_this(this);
   assertCharEquals(X'01': this.program_type: '': *ON);
   assertCharEquals(%proc(): this.procedure_name: '': *ON);
   assertCharEquals(r5_pgmsts.program_name: this.program_name: '': *ON);
   assertCharEquals(r5_pgmsts.program_library: this.program_library: '': *ON);
   assertCharEquals(r5_pgmsts.module_name: this.module_name: '': *ON);
   assertCharEquals('QTEMP': this.module_library: '': *ON);
   //assertNumericEquals(expected: this.stmts_count);
   //assertCharEquals(expected: this.statements: '': *ON);
   assertCharEquals(r5_pgmsts.job_name: this.job.name: '': *ON);
   assertCharEquals(r5_pgmsts.job_user: this.job.user: '': *ON);
   assertCharEquals(r5_pgmsts.job_number: this.job.number: '': *ON);
   //assertCharEquals(expected: this.thread_id: '': *ON);
   //assertCharEquals(expected: this.char_thread_id: '': *ON);

   R5TCL01A(this);
   assertCharEquals(X'01': this.program_type: '': *ON);
   assertCharEquals('proc_3': this.procedure_name: '': *ON);
   assertCharEquals('R5TCL01A': this.program_name: '': *ON);
   assertCharEquals(r5_pgmsts.program_library: this.program_library: '': *ON);
   assertCharEquals('R5TCL01A': this.module_name: '': *ON);
   assertCharEquals('QTEMP': this.module_library: '': *ON);
   //assertNumericEquals(expected: this.stmts_count);
   //assertCharEquals(expected: this.statements: '': *ON);
   assertCharEquals(r5_pgmsts.job_name: this.job.name: '': *ON);
   assertCharEquals(r5_pgmsts.job_user: this.job.user: '': *ON);
   assertCharEquals(r5_pgmsts.job_number: this.job.number: '': *ON);
   //assertCharEquals(expected: this.thread_id: '': *ON);
   //assertCharEquals(expected: this.char_thread_id: '': *ON);
   return;
end-proc;
