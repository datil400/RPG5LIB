**FREE

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt bnddir('RPG5LIB');
ctl-opt option(*SRCSTMT: *NODEBUGIO);

/COPY RPG5LIB,calllevelh


dcl-pi R5TCL02A;
   result likeds(r5_call_level_info_t);
   o_target int(10) options(*NOPASS) const;
end-pi;

dcl-s target like(o_target) inz(0);


*inLR = *ON;

if %parms() >= %parmnum(o_target);
   target = o_target;
endif;

proc_1();
return;

dcl-proc proc_1;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   proc_2();
   return;
end-proc;


dcl-proc proc_2;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   proc_3();
   return;
end-proc;


dcl-proc proc_3;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   r5_caller(result: target);
   return;
end-proc;
