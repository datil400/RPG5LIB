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


/COPY UMISC_H
/COPY API,NLS_H
/COPY API,MIH_H

/COPY RPG5LIB,types_h
/COPY RPG5LIB,string_h


//  Extrae un n�mero de caracteres de una cadena comenzando
//  por la izquierda.
//
//  Si 'length' es cero, devuelve una cadena vac�a.
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

   return  %subst(string: 1: %int(min(%len(string): length)));
end-proc;


//  Extrae un n�mero de caracteres de una cadena comenzando
//  por la derecha.
//
//  Si 'length' es cero, devuelve una cadena vac�a.
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
                : %int(max(%len(string): length) - length + 1)
                : %int(min(%len(string): length))
                );
end-proc;


//  Extrae una subcadena de longitud 'o_length' comenzando en 'start'.
//
//  Esta funci�n es muy similar a %Substr().
//
//  Si 'start' es mayor que la cadena, devuelve una cadena vac�a.
//
//  Si 'o_length' se omite o es cero, se devuelve una subcadena que
//  comienza en 'start' hasta el final de la cadena.
//
//  Exception:
//
//  RNX0100  La longitud o posici�n de inicio est� fuera de rango
//           para la operaci�n de serie.

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
                : %int(min(start: %len(string)))
                : length
                );
end-proc;


//  Convertir a may�sculas o min�sculas una cadena de caracteres.
//
//  in_string  Expresi�n de tipo cadena para convertir a
//             may�sculas/min�sculas.
//  in_str_size  Tama�o en bytes de la cadena de entrada.
//  out_str      Cadena que recibir� la cadana convertida.
//  out_str_size  Tama�o en bytes de la variable que recibir�
//                la cadena convertida.
//  o_option     Tipo de conversi�n:
//                 0 = a may�sculas (valor por defecto)
//                 1 = a min�sculas
//  o_ccsid      Identificador del juego de caracteres con
//               el que est� codificada la cadena 'inStr'.

dcl-proc r5_convert_case export;

   dcl-pi *N;
      in_string like(TypeBuffer2) options(*VARSIZE) const;
      in_str_size like(r5_int_t) const;
      out_string like(TypeBuffer2) options(*VARSIZE);
      out_str_size like(r5_int_t) const;
      o_option like(r5_int_t) options(*NOPASS) const;
      o_ccsid like(r5_int_t) options(*NOPASS) const;
   end-pi;

   dcl-ds rcb likeds(NLS_reqCtlBlk_ccsid_T);
   dcl-ds error likeds(ERRC0100_T);
   dcl-s min_length like(r5_int_t);


   // Si no se indica el tama�o de la cadena de entrada ni
   // la de destino no es necesario realizar la conversi�n
   // ni ninguna otra cosa.

   if in_str_size <= 0 or out_str_size <= 0;
      return;
   endif;

   // Si la cadena de entrada s�lo contiene blancos, no hay
   // conversi�n, se devuelven los mismos blancos.

   if %subst(in_string: 1: in_str_size) = *BLANKS;
      %subst(out_string: 1: out_str_size) = *BLANKS;
      return;
   endif;

   // Configurar el bloque de control para la conversi�n.

   rcb = *ALLx'00';
   rcb.reqType = 1;            // Conversi�n por CCSID
   if %parms() >= %parmnum(o_ccsid);
      rcb.ccsid   = o_ccsid;
   else;
      rcb.ccsid   = 0;         // Usar el CCSID del trabajo
   endif;

   if %parms() >= %parmnum(o_option);
      rcb.caseReq = o_option;
   else;
      rcb.caseReq = STR_TO_UPPER;
   endif;

   min_length = min(in_str_size: out_str_size);

   clear  error;
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


//  Convertir a may�sculas una cadena de caracteres.

dcl-proc r5_to_upper export;

   dcl-pi *N like(r5_string_t);
      string like(r5_string_t) options(*VARSIZE) const;
      o_ccsid like(r5_int_t) options(*NOPASS) const;
   end-pi;

   dcl-s ccsid like(o_ccsid);
   dcl-s out_str like(string);
   dcl-s out_str_len like(r5_short_t) based(out_str_len_ptr);
   dcl-s buffer like(TypeBuffer) based(buffer_ptr);


   if %parms() >= %parmnum(o_ccsid);
      ccsid = o_ccsid;
   Else;
      ccsid = 0;
   Endif;

   out_str_len_ptr = %addr(out_str);        // Two bytes of string length
   buffer_ptr = out_str_len_ptr + %size(out_str_len); // The data
   out_str_len = %len(string);
   r5_convert_case( string: %len(string)
                  : buffer: %len(string)
                  : STR_TO_UPPER
                  : ccsid
                  );
   return out_str;
end-proc;


//  Convertir a min�sculas una cadena de caracteres.

dcl-proc r5_to_lower export;

   dcl-pi *N like(r5_string_t);
      string like(r5_string_t) options(*VARSIZE) const;
      o_ccsid like(r5_int_t) options(*NOPASS) const;
   end-pi;

   dcl-s ccsid like(o_ccsid);
   dcl-s out_str like(string);
   dcl-s out_str_len like(r5_short_t) based(out_str_len_ptr);
   dcl-s buffer like(TypeBuffer) based(buffer_ptr);


   if %parms() >= %parmnum(o_ccsid);
      ccsid = o_ccsid;
   Else;
      ccsid = 0;
   Endif;

   out_str_len_ptr = %addr(out_str);        // Two bytes of string length
   buffer_ptr = out_str_len_ptr + %size(out_str_len); // The data
   out_str_len = %len(string);
   r5_convert_case( string: %len(string)
                  : buffer: %len(string)
                  : STR_TO_LOWER
                  : ccsid
                  );
   return out_str;
end-proc;


//  Transforma un buffer de datos en una cadena de caracteres de
//  longitud variable.
//
//  buffer  Espacio de memoria con los datos a transformar.
//  size    Tama�o (n�mero de bytes) del buffer.
//
//  El buffer est� limitado a 32767 bytes. La funci�n no hace
//  ninguna suposici�n sobre el contenido del buffer y asume
//  que 'size' es el tama�o correcto. El desarrollador es el
//  responsable de fijar el valor adecuado de 'size'.
//
//  El uso de esta funci�n supone un gran coste en espacio y
//  tiempo. �Util�cela con precauci�n!

dcl-proc r5_buffer_to_varlen export;

   dcl-pi *N like(TypeVarBuffer);
      buffer like(TypeBuffer) options(*VARSIZE) const;
      size like(r5_int_t) const;
   end-pi;

   dcl-s varlen like(TypeVarBuffer) inz('');

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
//  buffer  Espacio de memoria que contendr� los datos.
//  size    Tama�o en bytes del buffer.
//
//  El buffer est� limitado a 32767 bytes. La funci�n no hace
//  ninguna suposici�n sobre el tama�o del buffer y asume que
//  que 'size' es el valor correcto. El desarrollador es el
//  responsable de fijar el valor adecuado de 'size'.
//
//  El uso de esta funci�n supone un gran coste en espacio y
//  tiempo. �Util�cela con precauci�n!

dcl-proc r5_varlen_to_buffer export;

   dcl-pi *N;
     varlen like(TypeVarBuffer) options(*VARSIZE) const;
     buffer like(TypeBuffer) Options(*VARSIZE);
     size like(r5_int_t) const;
   end-pi;

   if size <= 0 or %len(varlen) <= 0;
      return;
   endif;

   %subst(buffer: 1: size) = varlen;
   return;
end-proc;


//  Transforma una cadena de caracteres con un n�mero en un
//  n�mero decimal empaquetado.
//
//  Transforma un n�mero contenido en una cadena de caractares
//  en un n�mero decimal empaquetado.
//
//  string  La cadena de caracteres con el n�mero.
//          Permite blancos al principio y final,
//          signos (+/-), moneda, separadores de
//          millar y coma decimal.
//  o_mask  S�mbolos permitidos, seg�n:
//            1. S�bolo de moneda (p.e. $)
//            2. Separador de millar
//            3. Coma decimal
//          Optativo.
//          Por defecto: ' .,' para Espa�a
//
//  Excepciones:
//
//  MCH1201  Los datos escalares no pueden cambiarse al tipo requerido

dcl-proc r5_char_to_dec export;

   dcl-pi *N like(r5_packed_t);
      string varchar(64) options(*TRIM) value;
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

   // Estructura del campo num�rico de resultado
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


dcl-proc r5_word_wrap export;

   dcl-pi *N;

   end-pi;

   return;
end-proc;
