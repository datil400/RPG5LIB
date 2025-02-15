**FREE

// Test r5_api_error_occurred

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt bnddir('RPG5LIB': 'IBMIUNIT/IBMIUNIT': 'OSSILE/OSSILE');
ctl-opt option(*SRCSTMT: *NODEBUGIO);

/copy IBMiUnit/qrpglesrc,ibmiunit_h
/copy RPG5LIB,apierror_h


dcl-pr RtvObjD extpgm('QUSROBJD');
  rcvVar like(TypeBuffer) options(*VARSIZE);
  rcvVarLen like(TypeInt) const;
  format like(TypeApiFormat) const;
  objNamQ like(TypeQualName) const;
  objTyp like(TypeName) const;
  error like(ERRC0100_T) options(*VARSIZE);
end-pr;


dcl-ds error likeds(ERRC0100_T);
dcl-ds buffer qualified;
   four_bytes char(4) pos(1);
   api_bytes likeds(r5_api_bytes_t) pos(1);
   filler char(504);
end-ds;
dcl-s size like(r5_int_t);

*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS APIERROR module - Test r5_api_error_occurred');

IBMiUnit_addTestCase(%paddr(api_error_occurred): 'api_error_occurred');

IBMiUnit_teardownSuite();
return;

dcl-proc api_error_occurred;

   dcl-s objd char(2048);

   size = %size(error);
   r5_api_error_init_for_exception(error);

   assertOff(r5_api_error_occurred(error));

   size = %size(buffer.api_bytes);
   buffer = *ALLx'FF';
   r5_api_error_init_for_exception(buffer.api_bytes);

   assertOff(r5_api_error_occurred(buffer.api_bytes));

   size = %size(buffer.four_bytes);
   buffer = *ALLx'FF';
   r5_api_error_init_for_exception(buffer.four_bytes);

   assertOff(r5_api_error_occurred(buffer.four_bytes));

   clear objd;
   r5_api_error_init_for_monitor(error);
   RtvObjD(objd: %len(objd): 'OBJD0100': 'OBJECT    QGPL': '*DTAARA': error);

   assertOn(r5_api_error_occurred(error));
   return;
end-proc;

