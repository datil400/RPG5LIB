**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5SYS
//  Module  : SYSVAL
//
//  System Values
//
//  Author : datil400@gmail.com
//  Date   : April 2017
//
//  Compiling : R5SYSI
//
//  Comments
//


ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('RPG5LIB');


/COPY API,WrkMan_H
/COPY RPG5LIB,apierror_h
/COPY RPG5LIB,exceptionh
/COPY RPG5LIB,excmgr_h
/COPY RPG5LIB,sysval_h


//  Obtiene el valor del 'valor del sistema' seleccionado.
//
//  Valor de retorno:
//
//    Esta función devuelve todos los valores como una secuencia de
//    bytes. Los datos alfanuméricos se verán como una cadena de
//    caracteres al uso.
//
//    Los valores numéricos se entregan en su codificación binaria
//    original, por ejemplo, QCCSID se devuelve como un entero de 4
//    bytes.
//
//    El llamador será el responsable de almacenar el valor en una
//    variable del tipo correcto.
//
//    RTNPARM mejora el rendimiento en el retorno de valores muy
//    grandes, pero sólo es válido a partir de ver. 7.1.
//
//    No se considera que este procedimiento sea de uso intensivo
//    y no se cree que sea apreciable el impacto que pudiera
//    producirse en el rendimiento.
//
//  Excepciones:
//
//  CPF100A  La recuperación del valor del sistema ha sido errónea.
//  CPF1860  Valor &1 en lista no válido.

dcl-proc r5_get_system_value export;

   dcl-pi *N char(16384) rtnparm;
      sysval like(r5_name_t) const;
   end-pi;


   //  Ver estructura QWCRSVAL_T en el miembro fuente WrkMan_H
   //
   //  %size(rcvvar) = %size(nbrOfSysValRtn)  +
   //                  %size(sysValOffs)      +
   //                  %size(QWCRSVAL_info_T) +
   //                  16384
   //                = 16408 bytes

   dcl-ds buffer len(16408) qualified;
      nbrOfSysValRtn like(r5_int_t);
      sysValOffs like(r5_int_t);
   end-ds;

   dcl-ds info likeds(QWCRSVAL_info_T) based(info_ptr);
   dcl-s data char(16384) based(data_ptr);

   dcl-ds error likeds(ERRC0100_T);
   dcl-s exception like(r5_object_t);

   // La API QWCRSVAL permite recuperar más de un valor del sistema
   // en una sola llamada. Esta operativa complica algo más el código,
   // pero no demasiado. Aunque se podría mejorar el rendimiento
   // cuando se recuperan varios valores a la vez, esa ganancia no se
   // aprecia en escenarios realistas.

   r5_api_error_init_for_exception(error);
   callp(E) RtvSysVal( buffer
                     : %size(buffer)
                     : 1
                     : sysval
                     : error
                     );
    if %error();
       exception = r5_exception_new('RP52000': 'RPG5MSG': %trim(sysval));
       r5_throw(exception);
    endif;

    info_ptr = %addr(buffer) + buffer.sysValOffs;

    if info.status = 'L';
       exception = r5_exception_new('CPF100A': *OMIT: %trim(sysval));
       r5_throw(exception);
    endif;

    data_ptr = info_ptr + %size(info);
    return %subst(data: 1: info.length);
end-proc;

