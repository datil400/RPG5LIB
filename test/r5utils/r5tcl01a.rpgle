**FREE

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt bnddir('RPG5LIB');
ctl-opt option(*SRCSTMT: *NODEBUGIO);

/COPY RPG5LIB,calllevelh

dcl-pi R5TCL01A;
   result likeds(r5_call_level_info_t);
end-pi;

*inLR = *ON;

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

   r5_this(result);
   return;
end-proc;
