**FREE

// Test r5_api_error_init

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt bnddir('RPG5LIB': 'IBMIUNIT/IBMIUNIT': 'OSSILE/OSSILE');
ctl-opt option(*SRCSTMT: *NODEBUGIO);

/copy IBMiUnit/qrpglesrc,ibmiunit_h
/copy RPG5LIB,apierror_h


dcl-ds error likeds(ERRC0100_T);
dcl-ds buffer qualified;
   four_bytes char(4) pos(1);
   api_bytes likeds(r5_api_bytes_t) pos(1);
   filler char(504);
end-ds;
dcl-s size like(r5_int_t);


*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS APIERROR module - Test r5_api_error_init');

IBMiUnit_addTestCase(%paddr(api_error_init_for_exception): 'api_error_init_for_exception');
IBMiUnit_addTestCase(%paddr(api_error_init_for_monitor): 'api_error_init_for_monitor');

IBMiUnit_teardownSuite();
return;

dcl-proc api_error_init_for_exception;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   size = %size(error);

   r5_api_error_init_for_exception(error);

   assertNumericEquals(0: error.bytesPrv);
   assertNumericEquals(0: error.bytesAvl);
   assertCharEquals(X'00000000000000': error.msgID);
   assertOn(error.msgDta = *ALLx'00');

   size = %size(buffer.api_bytes);
   buffer = *ALLx'FF';

   r5_api_error_init_for_exception(buffer.api_bytes);

   assertNumericEquals(0: buffer.api_bytes.provided);
   assertNumericEquals(0: buffer.api_bytes.available);
   assertOn(buffer.filler = *ALLx'FF');

   size = %size(buffer.four_bytes);
   buffer = *ALLx'FF';

   r5_api_error_init_for_exception(buffer.four_bytes);

   assertCharEquals(X'00000000': buffer.four_bytes);
   assertNumericEquals(0: buffer.api_bytes.provided);
   assertOn(%subst(buffer: 5) = *ALLx'FF');
   assertOn(buffer.filler = *ALLx'FF');
   return;
end-proc;


dcl-proc api_error_init_for_monitor;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   size = %size(error);

   r5_api_error_init_for_monitor(error);

   assertNumericEquals(size: error.bytesPrv);
   assertNumericEquals(0: error.bytesAvl);
   assertCharEquals(X'00000000000000': error.msgID);
   assertOn(error.msgDta = *ALLx'00');

   size = %size(buffer.api_bytes);
   buffer = *ALLx'FF';

   r5_api_error_init_for_monitor(buffer.api_bytes);

   assertNumericEquals(8: buffer.api_bytes.provided);
   assertNumericEquals(0: buffer.api_bytes.available);
   assertOn(buffer.filler = *ALLx'FF');

   size = %size(buffer.four_bytes);
   buffer = *ALLx'FF';

   r5_api_error_init_for_monitor(buffer.four_bytes);

   assertCharEquals(X'00000000': buffer.four_bytes);
   assertNumericEquals(0: buffer.api_bytes.provided);
   assertOn(%subst(buffer: 5) = *ALLx'FF');
   assertOn(buffer.filler = *ALLx'FF');
   return;
end-proc;
