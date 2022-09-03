**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5UTILS
//  Module  : JOBLOG
//
//  Job log utilities
//
//  Author : Javier Mora
//  Date   : May 2021
//
//  Compiling : R5UTILSI
//
//  Comments
//
//    Operaciones relacionadas con las anotaciones de trabajo.
//

ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);


/COPY API,joblog_h
/COPY RPG5LIB,joblog_h


//  Registra en las anotaciones del trabajo un mensaje informativo.
//
//  El texto del mensaje tiene un formato al estilo de la función
//  'printf' del lenguaje C. Admite una lista de hasta 8 valores
//  de sustitución utilizando la máscara '%s'.
//
//  La lista de argumentos deben ser todos cadenas de caracteres.

dcl-proc r5_joblog export;

   dcl-pi *N like(r5_int_t);
      msg pointer options(*STRING) value;
      s1 pointer options(*STRING: *NOPASS) value;
      s2 pointer options(*STRING: *NOPASS) value;
      s3 pointer options(*STRING: *NOPASS) value;
      s4 pointer options(*STRING: *NOPASS) value;
      s5 pointer options(*STRING: *NOPASS) value;
      s6 pointer options(*STRING: *NOPASS) value;
      s7 pointer options(*STRING: *NOPASS) value;
      s8 pointer options(*STRING: *NOPASS) value;
   end-pi;

   dcl-s size like(r5_int_t);

   size = Qp0zLprintf(msg: s1: s2: s3: s4: s5: s6: s7: s8);
   size += Qp0zLprintf(JOBLOG_LF);
   return size;
end-proc;

