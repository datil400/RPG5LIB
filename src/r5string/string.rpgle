**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5STRING
//  Module  : STRING
//
//  String procedures and functions.
//
//  Author : Javier Mora
//  Date   : March 2014
//
//  Compiling : R5STRINGI
//
//  Comments
//

ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('RPG5LIB');


/COPY API,NLS_H
/COPY API,MIH_H

/COPY RPG5LIB,apierror_h
/COPY RPG5LIB,math_h
/COPY RPG5LIB,string_h


dcl-c JOB_CCSID  0;


//  Extrae una subcadena comenzando por la izquierda.
//
//  Si 'length' es cero, devuelve una cadena vacía.
//
//  Si 'length' excede la longitud de la cadena, devuelve la
//  cadena completa.

dcl-proc r5_left export;

   dcl-pi *N  like(r5_string_t);
      string like(r5_string_t) options(*VARSIZE) const;
      length like(r5_int_t) const;
   end-pi;

   if  length <= 0 or %len(string) = 0;
      return  '';
   endif;

   return  %subst(string: 1: %int(r5_min(%len(string): length)));
end-proc;


//  Extrae una subcadena comenzando por la derrecha.
//
//  Si 'length' es cero, devuelve una cadena vacía.
//
//  Si 'length' excede la longitud de la cadena, devuelve la
//  cadena completa.

dcl-proc r5_right export;

   dcl-pi *N  like(r5_string_t);
      string like(r5_string_t) options(*VARSIZE) const;
      length like(r5_int_t) const;
   end-pi;

   if  length <= 0 or %len(string) = 0;
      return  '';
   endif;

   return %subst( string
                : %int(r5_max(%len(string): length) - length + 1)
                : %int(r5_min(%len(string): length))
                );
end-proc;


//  Extrae una subcadena de longitud 'o_length' comenzando en 'start'.
//
//  Esta función es muy similar a %substr().
//
//  Si 'start' es mayor que la longitud de la cadena, devuelve una subcadena
//  vacía.
//
//  Si 'o_length' se omite o es cero, se devuelve una subcadena que
//  comienza en 'start' hasta el final de la cadena.

dcl-proc r5_mid export;

   dcl-pi *N  like(r5_string_t);
      string like(r5_string_t) options(*VARSIZE) const;
      start like(r5_int_t) const;
      o_length like(r5_int_t) options(*NOPASS) const;
   end-pi;

   dcl-s length like(o_length);


   if %parms() >= %parmnum(o_length);
      length = o_length;
   else;
      length = %len(string);
   endif;

   // Ajustar la longitud de la subcadena a extraer por si supera
   // la longitud de la cadena base. La BIF '%substr()' genera
   // un error en ese caso.

   if length > %len(string) - start + 1;
     length = %len(string) - start + 1;
   endif;

   // No hay nada que extraer

   if  length <= 0 or %len(string) = 0 or start > %len(string);
      return '';
   endif;

   return %subst( string
                : %int(r5_min(start: %len(string)))
                : length
                );
end-proc;


//  Convertir a mayúsculas o minúsculas una cadena de caracteres.
//
//  'in_string' es la cadena a convertir.
//  'in_str_size' es el tamaño en bytes de la cadena de entrada.
//  'out_str' recibe la cadena convertida.
//  'out_str_size' es el tamaño en bytes de la variable que
//  recibirá la cadena convertida.
//  'o_option' indica el tipo de conversión:
//                 0 = a mayúsculas (valor por defecto)
//                 1 = a minúsculas
//  'o_ccsid' es el identificador del juego de caracteres con
//  el que está codificada la cadena de entrada.

dcl-proc r5_convert_case export;

   dcl-pi *N;
      in_string like(r5_buffer_t) options(*VARSIZE) const;
      in_str_size like(r5_int_t) const;
      out_string like(r5_buffer_t) options(*VARSIZE);
      out_str_size like(r5_int_t) const;
      o_option like(r5_int_t) options(*NOPASS) const;
      o_ccsid like(r5_int_t) options(*NOPASS) const;
   end-pi;

   dcl-ds rcb likeds(NLS_reqCtlBlk_ccsid_T);
   dcl-ds error likeds(ERRC0100_T);
   dcl-s min_length like(r5_int_t);


   if in_str_size <= 0 or out_str_size <= 0;
      return;
   endif;

   if %subst(in_string: 1: in_str_size) = *BLANKS;
      %subst(out_string: 1: out_str_size) = *BLANKS;
      return;
   endif;

   // Configurar el bloque de control para la conversión.

   rcb = *ALLx'00';
   rcb.reqType = 1;            // Conversión por CCSID
   if %parms() >= %parmnum(o_ccsid);
      rcb.ccsid   = o_ccsid;
   else;
      rcb.ccsid   = JOB_CCSID;
   endif;

   if %parms() >= %parmnum(o_option);
      rcb.caseReq = o_option;
   else;
      rcb.caseReq = R5_STR_TO_UPPER;
   endif;

   min_length = r5_min(in_str_size: out_str_size);

   r5_api_error_init_for_exception(error);
   QlgConvertCase( rcb
                 : %subst(in_string: 1: min_length)
                 : out_string
                 : min_length
                 : error
                 );
   if out_str_size > min_length;
      %subst(out_string: min_length + 1: out_str_size - min_length) = *BLANKS;
   endif;
   return;
end-proc;


//  Convertir a mayúsculas una cadena de caracteres.

dcl-proc r5_to_upper export;

   dcl-pi *N like(r5_string_t);
      string like(r5_string_t) options(*VARSIZE) const;
      o_ccsid like(r5_int_t) options(*NOPASS) const;
   end-pi;

   dcl-s ccsid like(o_ccsid);
   dcl-s out_str like(string);
   dcl-s out_str_len like(r5_short_t) based(out_str_len_ptr);
   dcl-s buffer like(r5_buffer_t) based(buffer_ptr);


   if %parms() >= %parmnum(o_ccsid);
      ccsid = o_ccsid;
   else;
      ccsid = JOB_CCSID;
   endif;

   out_str_len_ptr = %addr(out_str);        // Two bytes for string length
   buffer_ptr = out_str_len_ptr + %size(out_str_len); // The data
   out_str_len = %len(string);
   r5_convert_case( string: %len(string)
                  : buffer: %len(string)
                  : R5_STR_TO_UPPER
                  : ccsid
                  );
   return out_str;
end-proc;


//  Convertir a minúsculas una cadena de caracteres.

dcl-proc r5_to_lower export;

   dcl-pi *N like(r5_string_t);
      string like(r5_string_t) options(*VARSIZE) const;
      o_ccsid like(r5_int_t) options(*NOPASS) const;
   end-pi;

   dcl-s ccsid like(o_ccsid);
   dcl-s out_str like(string);
   dcl-s out_str_len like(r5_short_t) based(out_str_len_ptr);
   dcl-s buffer like(r5_buffer_t) based(buffer_ptr);


   if %parms() >= %parmnum(o_ccsid);
      ccsid = o_ccsid;
   else;
      ccsid = JOB_CCSID;
   endif;

   out_str_len_ptr = %addr(out_str);        // Two bytes for string length
   buffer_ptr = out_str_len_ptr + %size(out_str_len); // The data
   out_str_len = %len(string);
   r5_convert_case( string: %len(string)
                  : buffer: %len(string)
                  : R5_STR_TO_LOWER
                  : ccsid
                  );
   return out_str;
end-proc;


//  Transforma un buffer de datos en una cadena de caracteres de
//  longitud variable.
//
//  buffer  Espacio de memoria con los datos a transformar.
//  size    Tamaño (número de bytes) del buffer.
//
//  El buffer está limitado a 32767 bytes. La función no hace
//  ninguna suposición sobre el contenido del buffer y asume
//  que 'size' es el tamaño correcto. El desarrollador es el
//  responsable de fijar el valor adecuado de 'size'.
//
//  El uso de esta función supone un gran coste en espacio y
//  tiempo. ¡Utilícela con precaución!

dcl-proc r5_buffer_to_varlen export;

   dcl-pi *N like(r5_var_buffer_t);
      buffer like(r5_buffer_t) options(*VARSIZE) const;
      size like(r5_int_t) const;
   end-pi;

   dcl-s varlen like(r5_var_buffer_t) inz('');

   if size <= 0;
      return  '';
   endif;

   varlen = %subst(buffer: 1: size);
   return varlen;
end-proc;


//  Transforma una cadena de caracteres de longitud variable en
//  un buffer.
//
//  varlen  Cadena de caracteres a transformar.
//  buffer  Espacio de memoria que contendrá los datos.
//  size    Tamaño en bytes del buffer.
//
//  El buffer está limitado a 32767 bytes. La función no hace
//  ninguna suposición sobre el tamaño del buffer y asume que
//  que 'size' es el valor correcto. El desarrollador es el
//  responsable de fijar el valor adecuado de 'size'.
//
//  El uso de esta función supone un gran coste en espacio y
//  tiempo. ¡Utilícela con precaución!

dcl-proc r5_varlen_to_buffer export;

   dcl-pi *N;
     varlen like(r5_var_buffer_t) options(*VARSIZE) const;
     buffer like(r5_buffer_t) options(*VARSIZE);
     size like(r5_int_t) const;
   end-pi;

   if size <= 0 or %len(varlen) <= 0;
      return;
   endif;

   %subst(buffer: 1: size) = varlen;
   return;
end-proc;


//  Transforma un número contenido en una cadena de caractares
//  en un número decimal empaquetado.
//
//  'string' es la cadena de caracteres con el número. Se permiten
//  blancos al principio y final, signos (+/-), moneda, separadores
//  de millar y coma decimal.
//
//  'o_mask' especifica los símbolos permitidos, según:
//            1. Síbolo de moneda (p.e. $)
//            2. Separador de millar
//            3. Coma decimal
//
//  Por defecto: ' .,' para España
//
//  Developer:
//
//    Se podría utilizar los LOCALE o los atributos del trabajo para
//    fijar un valor por defecto a 'mask'.
//
//  Excepciones:
//
//  MCH1201  Los datos escalares no pueden cambiarse al tipo requerido

dcl-proc r5_char_to_dec export;

   dcl-pi *N like(r5_packed_t);
      string varchar(126) options(*TRIM) value;
      o_mask char(3) options(*NOPASS) value;
   end-pi;

   dcl-c BYTES_FOR_LENGTH  2;
   dcl-c DFT_MASK  ' .,';

   dcl-s result like(r5_packed_t);
   dcl-ds attr likeds(DPA_template_T) inz(*LIKEDS);
   dcl-ds mask likeDs(MIH_mask_T) inz;


   if %len(string) = 0;
      return 0;
   endif;

   if %parms() >= %parmnum(o_mask);
      mask = o_mask;
   else;
      mask = DFT_MASK;
   endif;

   // Estructura del campo numérico de resultado
   attr.type   = MIH_T_PACKED;
   attr.decPos = %decpos(result);
   attr.totDig = %len(result);

   CVTEFN( %addr(result)
         : attr
         : %addr(string) + BYTES_FOR_LENGTH
         : %len(string)
         : mask
         );
   return result;
end-proc;


dcl-proc r5_spaces export;

   dcl-pi *N varchar(16382) rtnparm;
      length like(r5_short_t) const;
   end-pi;

   dcl-s result varchar(16382);
   dcl-s s like(length);

   result = '';
   for s = 1 to length;
      result += ' ';
   endfor;

   return result;
end-proc;


