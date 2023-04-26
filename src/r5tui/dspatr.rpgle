**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5TUI
//  Module  : DSPATR
//
//  Display attributes P-field (DSPATR DDS keyword)
//
//  Author : datil400@gmail.com
//  Date   : December 2022
//
//  Compiling : R5TUII
//
//  Comments
//


ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('RPG5LIB');


/COPY RPG5LIB,excmgr_h
/COPY RPG5LIB,dspatr_h


// Inicializa atributo de pantalla para visualización 'normal'

dcl-proc r5_dspatr_set_normal export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
   end-pi;

   atr = R5_DSPATR_NORMAL;
   return;
end-proc;


// Averigua si el atributo de visualización es normal.

dcl-proc r5_dspatr_is_normal export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
   end-pi;

   return (atr = R5_DSPATR_NORMAL);
end-proc;


// Inicializa a un color para el atributo de pantalla.

dcl-proc r5_dspatr_set_color export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
      color char(1) const;
   end-pi;

   dcl-s p char(1);


   verify_color(color);

   if is_attribute(atr);
      p = %bitand(atr: R5_DSPATR_PROTECTED);
      atr = %bitor(color: p);
   else;
      atr = color;
   endif;
   return;
end-proc;


dcl-proc r5_dspatr_get_color export;

   dcl-pi *n char(1);
      atr like(r5_dspatr_t);
   end-pi;

   dcl-s color char(1);
   dcl-s exception like(r5_object_t);


   verify_attribute(atr);

   if r5_dspatr_is_non_displayable(atr);
      // UTILIZAR UN MENSAJE EXPECÍFICO EN RPG5MSGF
      exception = r5_exception_new('CPF9897': *OMIT:
                                  'Atributo de pantalla no visualizable');
      r5_throw(exception);
   endif;

   color = %bitand(atr: X'3A');        // 3A hex = 0011 1010
   verify_color(color);
   return color;
end-proc;


dcl-proc r5_dspatr_is_color export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
      color char(1) const;
   end-pi;

   dcl-s mask char(1) inz(X'3A');      // 0011 1010


   callp(E) verify_color(color);
   if %error();
      return *OFF;
   endif;

   if not is_attribute(atr);
      return *OFF;
   endif;

   if r5_dspatr_is_non_displayable(atr);
      return *OFF;
   endif;

   return (%bitand(atr: mask) = color);
end-proc;


dcl-proc verify_color;

   dcl-pi *N extproc(*DCLCASE);
      color char(1) const;
   end-pi;

   dcl-s exception like(r5_object_t);


   if color = R5_DSPATR_GREEN
   or color = R5_DSPATR_WHITE
   or color = R5_DSPATR_BLUE
   or color = R5_DSPATR_RED
   or color = R5_DSPATR_YELLOW
   or color = R5_DSPATR_TURQUOISE
   or color = R5_DSPATR_PINK;

      return;
   endif;

   // UTILIZAR UN MENSAJE EXPECÍFICO EN RPG5MSGF
   exception = r5_exception_new('CPF9897': *OMIT: 'No es un color válido');
   r5_throw(exception);

   return;
end-proc;


dcl-proc r5_dspatr_has_color export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
   end-pi;

   dcl-s color char(1);


   if not is_attribute(atr);
      return *OFF;
   endif;

   if r5_dspatr_is_non_displayable(atr);
      return *OFF;
   endif;

   color = %bitand(atr: X'7A');   // 7A hex = 0111 1010

   if color = R5_DSPATR_GREEN
   or color = R5_DSPATR_WHITE
   or color = R5_DSPATR_BLUE
   or color = R5_DSPATR_RED
   or color = R5_DSPATR_YELLOW
   or color = R5_DSPATR_TURQUOISE
   or color = R5_DSPATR_PINK;

      return *ON;

   else;
      return *OFF;
   endif;
end-proc;


//  Inicializa el atributo de pantalla para un campo de entrada/salida.

dcl-proc r5_dspatr_set_input_output_field export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
   end-pi;

   // Usar 'set_default_input_output_field' para establecer los atributos
   // por defecto para un campo de entrada salida.

   atr = %bitor(R5_DSPATR_NORMAL: R5_DSPATR_UNDERLINE: R5_DSPATR_HIGH_INTENSITY);
   return;
end-proc;


// Averigua si es un campo de entrada/salida

dcl-proc r5_dspatr_is_input_output_field export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
   end-pi;


   if not is_attribute(atr);
      return *OFF;
   endif;

   if r5_dspatr_is_non_displayable(atr);
      return *OFF;
   endif;

   return (%bitand(atr: X'E0') = R5_DSPATR_NORMAL);   // E0 hex = 1110 0000
end-proc;


// Inicializa el atributo de pantalla para un campo de sólo salida.

dcl-proc r5_dspatr_set_output_field export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
   end-pi;

   // Usar 'set_default_output_field' para establecer los atributos
   // por defecto para un campo de salida.

   atr = %bitor(R5_DSPATR_NORMAL: R5_DSPATR_PROTECTED: R5_DSPATR_HIGH_INTENSITY);
   return;
end-proc;


// Averigua si es un campo de solo salida.

dcl-proc r5_dspatr_is_output_field export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
   end-pi;

   dcl-s out_atr like(r5_dspatr_t);


   if not is_attribute(atr);
      return *OFF;
   endif;

   if r5_dspatr_is_non_displayable(atr);
      return *OFF;
   endif;

   out_atr = %bitor(R5_DSPATR_NORMAL: R5_DSPATR_PROTECTED);
   return (%bitand(atr: X'E0') = out_atr);            // E0 hex = 1110 0000
end-proc;


// Activa o desactiva el atributo de alta intensidad.

dcl-proc r5_dspatr_set_high_intensity export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
      hi  like(r5_boolean_t) const;
   end-pi;


   verify_attribute(atr);

   if hi = *ON;
      atr = %bitor(atr: R5_DSPATR_HIGH_INTENSITY);
   else;
      atr = %bitand(atr: %bitnot(R5_DSPATR_HIGH_INTENSITY));
   endif;
   return;
end-proc;


// Averigua si está activo el atributo de alta intensidad.

dcl-proc r5_dspatr_is_high_intensity export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
   end-pi;


   if not is_attribute(atr);
      return *OFF;
   endif;

   if r5_dspatr_is_non_displayable(atr);
      return *OFF;
   endif;

   return (%bitand(atr: R5_DSPATR_HIGH_INTENSITY) = R5_DSPATR_HIGH_INTENSITY);
end-proc;


// Activa o desactiva el atributo de contraste invertido.

dcl-proc r5_dspatr_set_reverse export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
      ri  like(r5_boolean_t) const;
   end-pi;


   verify_attribute(atr);

   if ri = *ON;
      atr = %bitor(atr: R5_DSPATR_REVERSE);
   else;
      atr = %bitand(atr: %bitnot(R5_DSPATR_REVERSE));
   endif;
   return;
end-proc;


// Averigua si está activo el atributo de contraste invertido.

dcl-proc r5_dspatr_is_reversed export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
   end-pi;


   if not is_attribute(atr);
      return *OFF;
   endif;

   if r5_dspatr_is_non_displayable(atr);
      return *OFF;
   endif;

   return (%bitand(atr: R5_DSPATR_REVERSE) = R5_DSPATR_REVERSE);
end-proc;


// Activa o desactiva el atributo de separador de columnas.

dcl-proc r5_dspatr_set_column_separators export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
      cs  like(r5_boolean_t) const;
   end-pi;


   verify_attribute(atr);

   if cs = *ON;
      atr = %bitor(atr: R5_DSPATR_COLUMN_SEPARATOR);
   else;
      atr = %bitand(atr: %bitnot(R5_DSPATR_COLUMN_SEPARATOR));
   endif;
   return;
end-proc;


// Averigua si está activo el atributo de separador de columnas.

dcl-proc r5_dspatr_is_column_separators export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
   end-pi;


   if not is_attribute(atr);
      return *OFF;
   endif;

   if r5_dspatr_is_non_displayable(atr);
      return *OFF;
   endif;

   return (%bitand(atr: R5_DSPATR_COLUMN_SEPARATOR) = R5_DSPATR_COLUMN_SEPARATOR);
end-proc;


// Activa o desactiva el atributo de parpadeo.

dcl-proc r5_dspatr_set_blink export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
      bl  like(r5_boolean_t) const;
   end-pi;


   verify_attribute(atr);

   if bl = *ON;
      atr = %bitor(atr: R5_DSPATR_BLINK);
   else;
      atr = %bitand(atr: %bitnot(R5_DSPATR_BLINK));
   endif;
   return;
end-proc;


// Averigua si está activo el atributo de parpadeo.

dcl-proc r5_dspatr_is_blinking export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
   end-pi;


   if not is_attribute(atr);
      return *OFF;
   endif;

   if r5_dspatr_is_non_displayable(atr);
      return *OFF;
   endif;

   return (%bitand(atr: R5_DSPATR_BLINK) = R5_DSPATR_BLINK);
end-proc;


// Activa o desactiva el atributo de subrayado.

dcl-proc r5_dspatr_set_underline export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
      ul  like(r5_boolean_t) const;
   end-pi;


   verify_attribute(atr);

   if ul = *ON;
      atr = %bitor(atr: R5_DSPATR_UNDERLINE);
   else;
      atr = %bitand(atr: %bitnot(R5_DSPATR_UNDERLINE));
   endif;
   return;
end-proc;


// Averigua si está activo el atributo de subrayado.

dcl-proc r5_dspatr_is_underlined export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
   end-pi;


   if not is_attribute(atr);
      return *OFF;
   endif;

   if r5_dspatr_is_non_displayable(atr);
      return *OFF;
   endif;

   return (%bitand(atr: R5_DSPATR_UNDERLINE) = R5_DSPATR_UNDERLINE);
end-proc;


// Activa o desactiva el atributo de no visualización.
//
// Cuando se activa el atributo de no visualización se
// perderá información de 'estado' del atributo de pantalla
// que se está cambiando. Esto es debido a que se aprovechan
// los atributos subrayado, alta intensidad e imagen invertida
// para activar la no visualización.
//
// Al desactivar la no visualización no será posible recuperar
// el estado anterior del atributo de pantalla. En este caso,
// se decide dejar el atributo en estado normal y respetar el
// valor de 'campo protegido'.

dcl-proc r5_dspatr_set_non_display export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
      nd  like(r5_boolean_t) const;
   end-pi;

   dcl-s p char(1);


   verify_attribute(atr);

   if nd = *ON;
      atr = %bitor(atr: R5_DSPATR_NON_DISPLAY);
   else;
      p = %bitand(atr: R5_DSPATR_PROTECTED);
      atr = %bitor(R5_DSPATR_NORMAL: p);
   endif;
   return;
end-proc;


// Averigua si está activo el atributo de no visualización.

dcl-proc r5_dspatr_is_non_displayable export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
   end-pi;


   if not is_attribute(atr);
      return *OFF;
   endif;

   return (%bitand(atr: R5_DSPATR_NON_DISPLAY) = R5_DSPATR_NON_DISPLAY);
end-proc;


// Activa o desactiva el atributo de campo protegido.

dcl-proc r5_dspatr_set_protected_field export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
      pr  like(r5_boolean_t) const;
   end-pi;


   verify_attribute(atr);

   if pr = *ON;
      atr = %bitor(atr: R5_DSPATR_PROTECTED);
   else;
      atr = %bitand(atr: %bitnot(R5_DSPATR_PROTECTED));
   endif;
   return;
end-proc;


// Averigua si está activo el atributo de campo protegido.

dcl-proc r5_dspatr_is_protected_field export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
   end-pi;


   if not is_attribute(atr);
      return *OFF;
   endif;

   return (%bitand(atr: R5_DSPATR_PROTECTED) = R5_DSPATR_PROTECTED);
end-proc;


dcl-proc verify_attribute;

   dcl-pi *N extproc(*DCLCASE);
      atr like(r5_dspatr_t);
   end-pi;

   dcl-s exception like(r5_object_t);


   if is_attribute(atr);
      return;
   endif;

   // UTILIZAR UN MENSAJE EXPECÍFICO EN RPG5MSGF
   exception = r5_exception_new('CPF9897': *OMIT: 'No es un atributo de pantalla válido');
   r5_throw(exception);

   return;
end-proc;


dcl-proc is_attribute;

   dcl-pi *N like(r5_boolean_t) extproc(*DCLCASE);
      atr like(r5_dspatr_t);
   end-pi;

   // si .XX. .... & 0110 0000 = .01. ....

   return (%bitand(atr: X'60') = X'20');
end-proc;
