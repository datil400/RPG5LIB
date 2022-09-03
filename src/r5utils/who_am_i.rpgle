**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5UTILS
//  Module  : WHO_AM_I
//
//  who_am_i utility.
//
//  Author : Javier Mora
//  Date   : September 2021
//
//  Compiling : R5UTILSI
//
//  Comments
//
//    Obtiene la información del nivel de invocación indicado.
//
//    Basado en el procedimiento del mismo nombre publicado por Junlei Li como parte
//    de su proyecto i5/OS Programmer's Toolkit.



ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);

/COPY RPG5LIB,c_lib_h
/COPY R5UTILS,who_am_i_h


//  Obtiene información sobre un nivel de llamada.
//
//  El parámetro 'inv_offset' es el desplazamiento al nivel de llamada
//  a consultar tomando como punto de referencia el nivel de llamada de
//  'who_am_i',
//  Un valor 0 identifica al nivel de llamada actual, es decir, el llamador
//  de 'who_am_i'.
//  Un valor 1 identifica al nivel de llamada anterior al actual, es decir,
//  el llamador del llamador de 'who_am_i'.

dcl-proc who_am_i export;

   dcl-pi *N;
      attrib likeds(r5_invocation_attr_t);
      thread likeds(r5_job_thread_id_t) options(*OMIT: *NOPASS);
      inv_offset like(r5_int_t) value options(*NOPASS);
   end-pi;

   /COPY R5UTILS,mih52

   dcl-c THIS_CALL_LEVEL  1;
   dcl-c SUSPEND_POINTER_ID  24;

   dcl-ds inv_id likeds(invocation_id_t);
   dcl-ds susptr likeds(matinvat_ptr_t);
   dcl-ds sel likeds(matinvat_selection_t);
   dcl-ds ptrd likeds(matptrif_susptr_tmpl_t);
   dcl-s mask char(4);
   dcl-s proc_name char(1024);
   dcl-s stmts like(r5_int_t) dim(4);
   dcl-ds pcs_tmpl likeds(matpratr_ptr_tmpl_t);
   dcl-s matpratr_opt char(1) inz(X'25');
   dcl-ds syp_attr likeds(matptr_sysptr_info_t);
   dcl-s thread_id char(8);
   dcl-s s int(3);


   memset(%addr(inv_id): X'00': %size(inv_id));
   if %parms() >= %parmnum(inv_offset);
      inv_id.src_inv_offset = -(THIS_CALL_LEVEL + inv_offset);
   else;
       inv_id.src_inv_offset = -(THIS_CALL_LEVEL);
   endif;

   // materialize suspend pointer of target invocation
   memset(%addr(sel): X'00': %size(sel));
   sel.num_attr = 1;
   sel.attr_id = SUSPEND_POINTER_ID;
   sel.rcv_length = 16;
   matinvat2(susptr: inv_id: sel);

   // materialize suspend ptr
   memset(%addr(ptrd): X'00': %size(ptrd));
   ptrd.bytes_in = %size(ptrd);
   ptrd.proc_name_length_in = %size(proc_name);
   ptrd.proc_name_ptr = %addr(proc_name);
   ptrd.stmt_ids_in = %elem(stmts);
   ptrd.stmt_ids_ptr = %addr(stmts);
   mask = x'5B280000';  // 01011011,00101000,00000000,00000000
     // bit 1 = 1, materialize program type
     // bit 3 = 1, materialize program context
     // bit 4 = 1, materialize program name
     // bit 6 = 1, materialize module name
     // bit 7 = 1, materialize module qualifier
     // bit 10 = 1, materialize procedure name
     // bit 12 = 1, materialize statement id list
   matptrif(ptrd: susptr.ptr: mask);

   // set output parameters
   memset(%addr(attrib): X'00': %size(attrib));

   attrib.type = ptrd.pgm_type;
   attrib.program_library = %trim(%subst(ptrd.pgm_ctx: 1: 10));
   attrib.program_name = %trim(%subst(ptrd.pgm_name: 1: 10));
   attrib.module_name = %trim(%subst(ptrd.mod_name: 1: 10));
   attrib.module_library = %trim(%subst(ptrd.mod_qual: 1: 10));
   attrib.procedure_name = %trim(%subst(proc_name: 1:
                                 min(ptrd.proc_name_length_in: ptrd.proc_name_length_out)));
   attrib.stmts_count = min(ptrd.stmt_ids_in: ptrd.stmt_ids_out);
   for s = 1 to attrib.stmts_count;
      attrib.stmt(s) = stmts(s);
   endfor;

   // materialice job and thread id
   if %parms() >= %parmnum(thread) and %addr(thread) <> *NULL;

      memset(%addr(thread): X'00': %size(thread));

      // retrieve the PCS pointer of the current MI process
      pcs_tmpl.bytes_in = %size(pcs_tmpl);
      matpratr1(pcs_tmpl : matpratr_opt);

      // retrieve the name of the PCS ptr, aka job ID
      syp_attr.bytes_in = %size(syp_attr);
      matptr(syp_attr : pcs_tmpl.ptr);

      thread_id = retthid();

      thread.job_id = syp_attr.obj_name;
      thread.thread_id = thread_id;
   endif;

   return;
end-proc;


//  Devuelve el valor más pequeño de la lista.
//
//  Inspirado en un procedimiento similar publicado por Bob Cozzi.

//  EXISTE UNA COPIA EN R5EXCMGR,UTILITIES

dcl-proc min export;

   dcl-pi *N int(20) extproc(*DCLCASE);
      value1 int(20) const;
      value2 int(20) const;
      value3 int(20) options(*NOPASS) const;
      value4 int(20) options(*NOPASS) const;
      value5 int(20) options(*NOPASS) const;
      value6 int(20) options(*NOPASS) const;
      value7 int(20) options(*NOPASS) const;
      value8 int(20) options(*NOPASS) const;
      value9 int(20) options(*NOPASS) const;
      value10 int(20) options(*NOPASS) const;
      value11 int(20) options(*NOPASS) const;
      value12 int(20) options(*NOPASS) const;
      value13 int(20) options(*NOPASS) const;
      value14 int(20) options(*NOPASS) const;
      value15 int(20) options(*NOPASS) const;
   end-pi;

   dcl-s minimum like(value1);


   minimum = value1;

   if minimum > value2;
      minimum = value2;
   endif;

   if %parms() >= 3 and minimum > value3;
      minimum = value3;
   endif;

   if %parms() >= 4 and minimum > value4;
      minimum = value4;
   endif;

   if %parms() >= 5 and minimum > value5;
      minimum = value5;
   endif;

   if %parms() >= 6 and minimum > value6;
      minimum = value6;
   endif;

   if %parms() >= 7 and minimum > value7;
      minimum = value7;
   endif;

   if %parms() >= 8 and minimum > value8;
      minimum = value8;
   endif;

   if %parms() >= 9 and minimum > value9;
      minimum = value9;
   endif;

   if %parms() >= 10 and minimum > value10;
      minimum = value10;
   endif;

   if %parms() >= 11 and minimum > value11;
      minimum = value11;
   endif;

   if %parms() >= 12 and minimum > value12;
      minimum = value12;
   endif;

   if %parms() >= 13 and minimum > value13;
      minimum = value13;
   endif;

   if %parms() >= 14 and minimum > value14;
      minimum = value14;
   endif;

   if %parms() >= 15 and minimum > value15;
      minimum = value15;
   endif;

   return minimum;
end-proc;
