**FREE

/IF DEFINED(R5_EXCEPMGRDEV)
/EOF
/ENDIF
/DEFINE R5_EXCEPMGRDEV

/COPY API,msgh_h
/COPY API,wrkman_h
/COPY RPG5LIB,types_h


/IF NOT DEFINED(R5_EXCMGR_SPANISH_ERRORS)
/IF NOT DEFINED(R5_EXCMGR_ENGLISH_ERRORS)
/DEFINE R5_EXCMGR_SPANISH_ERRORS
/ENDIF
/ENDIF

/IF DEFINED(R5_EXCMGR_SPANISH_ERRORS)

dcl-c UNEXPECTED_ERROR  'Error inesperado, revise los mensajes anteriores.';
dcl-c INTERNAL_ERROR  'Se produjo un error interno inesperado.';
dcl-c NULL_REFERENCE_ERROR  'Se especificó referencia nula a objeto.';
dcl-c NULL_ARGUMENT_ERROR  'Se indicó un argumento nulo en el procedmiento.';
dcl-c NULL_POINTER_ERROR  'Valor de puntero nulo.';

dcl-c TARGET_INVOCATION_ERROR  'Nivel de llamada incorrecto.';
dcl-c EMPTY_CALL_STACK_ERROR  'No hay entradas en la pila de llamadas.';
dcl-c NOT_PARSED_CALL_STACK_ERROR  'No se ha analizado la pila de llamadas.';
dcl-c MISSING_CALL_STACK_ERROR  'La pila de llamadas no está disponible.';
dcl-c UNDEFINED_TOP_OF_CALL_STACK_ERROR  'La cima de la pila no está definida.';
dcl-c INVALID_CALL_STACK_ENTRY_ERROR  'No es una entrada válida de la pila de llamadas.';

// Información no está disponible
// No se ha atrapado ninguna excepción
// Se intentó atrapar una excepción que no existe

/ELSEIF DEFINED(R5_EXCMGR_ENGLISH_ERRORS)

dcl-c UNEXPECTED_ERROR  '';
dcl-c INTERNAL_ERROR  '';
dcl-c NULL_REFERENCE_ERROR  '';
dcl-c NULL_ARGUMENT_ERROR  '';
dcl-c NULL_POINTER_ERROR  '';

dcl-c TARGET_INVOCATION_ERROR  '';
dcl-c EMPTY_CALL_STACK_ERROR  '';
dcl-c NOT_PARSED_CALL_STACK_ERROR  '';
dcl-c MISSING_CALL_STACK_ERROR  '';
dcl-c UNDEFINED_TOP_OF_CALL_STACK_ERROR  '';
dcl-c INVALID_CALL_STACK_ENTRY_ERROR  '';

/ENDIF



dcl-ds call_stack_entry_t align(*FULL) qualified template;
   entry0100_ptr like(r5_pointer_t);        // Puntero a la estructura CSTK0100
   is_program_boundary like(r5_boolean_t);
   is_program_entry_procedure like(r5_boolean_t);
   program_type like(r5_name_t);            // *PGM o *SRVPGM

   // Podría utilizarse un mapa de bits
   // Ejemplo 1xxxxxxx -> progam_boundary = Yes
   //         x0xxxxxx -> *PGM
   //         x1xxxxxx -> *SRVPGM
end-ds;

dcl-ds CSTK0100_entry_t likeds(CSTK0100_stackEnt_T) template;

//  Interrumpe la ejecución del procedimiento actual

dcl-pr crash extproc(*DCLCASE);
   msg pointer options(*STRING) value;
   s1 pointer options(*STRING: *NOPASS) value;
   s2 pointer options(*STRING: *NOPASS) value;
   s3 pointer options(*STRING: *NOPASS) value;
   s4 pointer options(*STRING: *NOPASS) value;
   s5 pointer options(*STRING: *NOPASS) value;
   s6 pointer options(*STRING: *NOPASS) value;
   s7 pointer options(*STRING: *NOPASS) value;
   s8 pointer options(*STRING: *NOPASS) value;
   s9 pointer options(*STRING: *NOPASS) value;
   s10 pointer options(*STRING: *NOPASS) value;
end-pr;

// Interrumpe la ejecución del procedimiento llamador si se cumple una condición.

dcl-pr crash_if extproc(*DCLCASE);
   condition like(r5_boolean_t) const;
   msg pointer options(*STRING) value;
   s1 pointer options(*STRING: *NOPASS) value;
   s2 pointer options(*STRING: *NOPASS) value;
   s3 pointer options(*STRING: *NOPASS) value;
   s4 pointer options(*STRING: *NOPASS) value;
   s5 pointer options(*STRING: *NOPASS) value;
   s6 pointer options(*STRING: *NOPASS) value;
   s7 pointer options(*STRING: *NOPASS) value;
   s8 pointer options(*STRING: *NOPASS) value;
   s9 pointer options(*STRING: *NOPASS) value;
   s10 pointer options(*STRING: *NOPASS) value;
end-pr;

dcl-pr min int(20) extproc(*DCLCASE);
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
end-pr;

dcl-pr is_program_entry_procedure like(r5_boolean_t) extproc(*DCLCASE);
   procedure_name like(r5_pointer_t) options(*STRING) value;
end-pr;

dcl-pr RCVM0300_to_exception pointer extproc(*DCLCASE);
   rcvm likeds(RCVM0300PM_T);
end-pr;

dcl-pr RCVM0300_pointer_to_replace_data pointer extproc(*DCLCASE);
   rcvm likeds(RCVM0300PM_T);
end-pr;

dcl-pr RCVM0300_pointer_to_message_text pointer extproc(*DCLCASE);
      rcvm likeds(RCVM0300PM_T);
end-pr;

dcl-pr RCVM0300_pointer_to_help pointer extproc(*DCLCASE);
      rcvm likeds(RCVM0300PM_T);
end-pr;

dcl-pr RCVM0300_pointer_to_sender pointer extproc(*DCLCASE);
      rcvm likeds(RCVM0300PM_T);
end-pr;

