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
//    DSPATR bit layout
//
//     7  6  5  4  3  2  1  0
//   +-----------------------+
//   |PR  0  1 CS BL UL HI RI|
//   +-----------------------+
//
//    PR = protect
//    CS = column separator
//    BL = blink
//    UL = underline
//    HI = high intensity
//    RI = reverse image
//    UL+HI+RI = non display
//
//    COLORS
//
//    turquoise = CS
//    white = HI
//    red (no blinking) = BL
//    red (with blinking) = HI + BL
//    yellow = CS + HI
//    pink = CS + BL
//    blue = CS + HI + BL


ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('RPG5LIB');


/COPY API,mih_h
/COPY RPG5LIB,excmgr_h
/COPY RPG5LIB,dspatr_h


dcl-c DFT_OUTPUT_FIELD_ATR  X'A2';         // PR+HI
dcl-c DFT_INPUT_OUTPUT_FIELD_ATR  X'26';   // UL+HI


dcl-s default_output_field_attributes like(r5_dspatr_t) inz(DFT_OUTPUT_FIELD_ATR);
dcl-s default_input_output_field_attributes like(r5_dspatr_t) inz(DFT_INPUT_OUTPUT_FIELD_ATR);


// Inicializa el atributo de pantalla para una visualización 'normal',
// sin ningún atributo activado.
//
// El color verde se asocia a este atributo.

dcl-proc r5_dspatr_set_normal export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
   end-pi;

   atr = R5_DSPATR_NORMAL;
   return;
end-proc;


// Averigua si el atributo de visualización es normal, es decir,
// no tiene ningún atributo activado.

dcl-proc r5_dspatr_is_normal export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
   end-pi;

   return (atr = R5_DSPATR_NORMAL);
end-proc;


// Inicializa a un color el atributo de pantalla.

dcl-proc r5_dspatr_set_color export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
      color like(r5_dspatr_color_t) value;
   end-pi;

   dcl-s p char(1);


   verify_color(color);

   if is_attribute(atr);
      p = %bitand(atr: R5_DSPATR_PROTECTED); // Guardar bit de 'protegido'
      atr = %bitor(color: p);
   else;
      atr = color;
   endif;
   return;
end-proc;


// Si está activado el atributo de 'no visualización',
// no es posible obtener un color válido.

dcl-proc r5_dspatr_get_color export;

   dcl-pi *n like(r5_dspatr_color_t);
      atr like(r5_dspatr_t);
   end-pi;

   dcl-s color like(r5_dspatr_color_t);


   verify_attribute(atr);
   verify_if_displayable(atr);

   color = %bitand(atr: X'3A');        // 3A hex = 0011 1010

   verify_color(color);
   return color;
end-proc;


// Lanza una excepción (RP51002) si el atributo de pantalla
// es no visualizable.

dcl-proc verify_if_displayable;

   dcl-pi *n extproc(*DCLCASE);
      atr like(r5_dspatr_t);
   end-pi;

   dcl-s exception like(r5_object_t);

   if r5_dspatr_is_displayable(atr);
      return;
   endif;

   exception = r5_exception_new('RP51002': 'RPG5MSG');
   r5_throw(exception);
   return;
end-proc;


// Comprueba si el atributo de pantalla es del color especificado.

dcl-proc r5_dspatr_is_color export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
      color like(r5_dspatr_color_t) value;
   end-pi;


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

   return (%bitand(atr: X'3A') = color);    // 3A hex = 0011 1010
end-proc;


dcl-proc verify_color;

   dcl-pi *N extproc(*DCLCASE);
      color like(r5_dspatr_color_t) value;
   end-pi;

   dcl-s exception like(r5_object_t);
   dcl-s hex_value char(2);


   if color = R5_DSPATR_GREEN
   or color = R5_DSPATR_WHITE
   or color = R5_DSPATR_BLUE
   or color = R5_DSPATR_RED
   or color = R5_DSPATR_YELLOW
   or color = R5_DSPATR_TURQUOISE
   or color = R5_DSPATR_PINK;

      return;
   endif;

   HexToChar(%addr(hex_value): %addr(color): %size(hex_value));
   exception = r5_exception_new('RP51001': 'RPG5MSG': hex_value);
   r5_throw(exception);
   return;
end-proc;


dcl-proc r5_dspatr_has_color export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
   end-pi;

   dcl-s color like(r5_dspatr_color_t);


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


dcl-proc r5_dspatr_set_default_input_output_field export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
   end-pi;


   verify_attribute(atr);
   verify_if_unprotected(atr);

   default_input_output_field_attributes = atr;
   return;
end-proc;


dcl-proc verify_if_unprotected;

   dcl-pi *n extproc(*DCLCASE);
      atr like(r5_dspatr_t);
   end-pi;

   dcl-s exception like(r5_object_t);


   if not r5_dspatr_is_protected_field(atr);
      return;
   endif;

   exception = r5_exception_new('RP51003': 'RPG5MSG');
   r5_throw(exception);
   return;
end-proc;


dcl-proc r5_dspatr_reset_default_input_output_field export;

   reset default_input_output_field_attributes;
   return;
end-proc;


// Inicializa el atributo de pantalla para un campo de entrada/salida.
//
// Usar 'set_default_input_output_field' para establecer los atributos
// por defecto para un campo de entrada salida.

dcl-proc r5_dspatr_set_input_output_field export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
   end-pi;

   atr = default_input_output_field_attributes;
   return;
end-proc;


// Averigua si es un campo de entrada/salida.
//
// Un campo 'no visualizable' puede ser de entrada/salida.

dcl-proc r5_dspatr_is_input_output_field export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
   end-pi;


   if not is_attribute(atr);
      return *OFF;
   endif;

   return (%bitand(atr: X'E0') = R5_DSPATR_NORMAL);   // E0 hex = 1110 0000
end-proc;


dcl-proc r5_dspatr_set_default_output_field export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
   end-pi;


   verify_attribute(atr);
   verify_if_protected(atr);

   default_output_field_attributes = atr;
   return;
end-proc;


dcl-proc verify_if_protected;

   dcl-pi *n extproc(*DCLCASE);
      atr like(r5_dspatr_t);
   end-pi;

   dcl-s exception like(r5_object_t);


   if r5_dspatr_is_protected_field(atr);
      return;
   endif;

   exception = r5_exception_new('RP51004': 'RPG5MSG');
   r5_throw(exception);
   return;
end-proc;


dcl-proc r5_dspatr_reset_default_output_field export;

   reset default_output_field_attributes;
   return;
end-proc;


// Inicializa el atributo de pantalla para un campo de sólo salida.
//
// Usar 'set_default_output_field' para establecer los atributos
// por defecto para un campo de salida.

dcl-proc r5_dspatr_set_output_field export;

   dcl-pi *n;
      atr like(r5_dspatr_t);
   end-pi;

   atr = default_output_field_attributes;
   return;
end-proc;


// Averigua si es un campo de solo salida.
//
// Un campo 'no visualizable' puede ser de salida.

dcl-proc r5_dspatr_is_output_field export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
   end-pi;

   dcl-s out_atr like(r5_dspatr_t);


   if not is_attribute(atr);
      return *OFF;
   endif;

   out_atr = %bitor(R5_DSPATR_NORMAL: R5_DSPATR_PROTECTED);
   return (%bitand(atr: X'E0') = out_atr);            // E0 hex = 1110 0000
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
// Cuando se activan los bits de no visualización se
// pierde información de 'estado' del atributo de pantalla
// que se está cambiando. Esto es debido a que se aprovechan
// los bits de subrayado, alta intensidad e imagen invertida
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


// Averigua si NO está activado el atributo de no visualización.

dcl-proc r5_dspatr_is_displayable export;

   dcl-pi *n like(r5_boolean_t);
      atr like(r5_dspatr_t);
   end-pi;


   if not is_attribute(atr);
      return *OFF;
   endif;

   return (%bitand(atr: R5_DSPATR_NON_DISPLAY) <> R5_DSPATR_NON_DISPLAY);
end-proc;


// Lanza una excepción (RP51000) si el atributo de pantalla
// no es válido.

dcl-proc verify_attribute;

   dcl-pi *N extproc(*DCLCASE);
      atr like(r5_dspatr_t);
   end-pi;

   dcl-s exception like(r5_object_t);
   dcl-s hex_value char(2);


   if is_attribute(atr);
      return;
   endif;

   HexToChar(%addr(hex_value): %addr(atr): %size(hex_value));
   exception = r5_exception_new('RP51000': 'RPG5MSG': hex_value);
   r5_throw(exception);
   return;
end-proc;


// Un atributo de pantalla siempre tiene los bits 6 y 5 con
// el valor '.01. ....' (20 HEX)

dcl-proc is_attribute;

   dcl-pi *N like(r5_boolean_t) extproc(*DCLCASE);
      atr like(r5_dspatr_t);
   end-pi;

   // si .XX. .... & 0110 0000 = .01. ....

   return (%bitand(atr: X'60') = X'20');
end-proc;


dcl-proc r5_dspatr_to_hex export;

   dcl-pi *N char(2);
      atr like(r5_dspatr_t) value;
   end-pi;

   dcl-s hex char(2);

   HexToChar(%addr(hex): %addr(atr): %size(hex));
   return hex;
end-proc;


dcl-proc r5_dspatr_to_bin export;

   dcl-pi *N char(8);
      atr like(r5_dspatr_t) value;
   end-pi;

   dcl-ds bin;
      bit char(1) dim(8);
   end-ds;
   dcl-s int_atr like(r5_byte_t) based(atr_ptr);
   dcl-s b like(r5_byte_t);


   atr_ptr = %addr(atr);

   for b = %elem(bit) downto 1;
      if %rem(int_atr: 2) = 0;
         bit(b) = '0';
      else;
         bit(b) = '1';
      endif;
      int_atr = %div(int_atr: 2);
   endfor;
   return bin;
end-proc;


dcl-proc r5_dspatr_debug export;

   dcl-pi *N varchar(20);
      atr like(r5_dspatr_t) value;
   end-pi;

   dcl-s debug varchar(20);

   debug = '';

   select;
   when r5_dspatr_is_normal(atr);
      debug = 'NORMAL';

   when r5_dspatr_is_non_displayable(atr);
      debug = 'NON DISPLAYABLE';

   when not is_attribute(atr);
      debug = 'UNDEFINED';

   other;
      if r5_dspatr_is_protected_field(atr);
         if debug <> '';
            debug = debug + '+';
         endif;
         debug = debug + 'PR';
      endif;
      if r5_dspatr_is_column_separators(atr);
         if debug <> '';
            debug = debug + '+';
         endif;
         debug = debug + 'CS';
      endif;
      if r5_dspatr_is_blinking(atr);
         if debug <> '';
            debug = debug + '+';
         endif;
         debug = debug + 'BL';
      endif;
      if r5_dspatr_is_underlined(atr);
         if debug <> '';
            debug = debug + '+';
         endif;
         debug = debug + 'UL';
      endif;
      if r5_dspatr_is_high_intensity(atr);
         if debug <> '';
            debug = debug + '+';
         endif;
         debug = debug + 'HI';
      endif;
      if r5_dspatr_is_reversed(atr);
         if debug <> '';
            debug = debug + '+';
         endif;
         debug = debug + 'RI';
      endif;
   endsl;

   return debug;
end-proc;

