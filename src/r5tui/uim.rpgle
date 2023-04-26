**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5TUI
//  Module  : DSM
//
//  User Interface Manager
//
//  Author : datil400@gmail.com
//  Date   : March 2023
//
//  Compiling : R5TUII
//
//  Comments
//


ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('RPG5LIB');


/COPY API,uim_h
/COPY RPG5LIB,apierror_h
/COPY RPG5LIB,uim_h


//  Muestra en pantalla una ventana de texto.
//
//  'text' es el texto a visualizar en la ventana.
//
//  'o_title_id' es el identificador para el título de la
//  ventana, que se extrae a partir de un id de mensaje y
//  del archivo de mensajes en donde está incluido.

dcl-proc r5_text_box export;

   dcl-pi *N;
      text varchar(8192) options(*VARSIZE) const;
      o_title_id likeds(r5_qualified_msg_id_t) options(*NOPASS) const;
   end-pi;

   dcl-c QCPFMSG  'QCPFMSG   *LIBL';
   dcl-s msg_id like(r5_qualified_msg_id_t.id);
   dcl-ds msg_file likeds(r5_qualified_msg_id_t.file);
   dcl-ds error likeds(ERRC0100_T);


   if %parms() >= %parmnum(o_title_id);
      msg_id = o_title_id.id;

      if o_title_id.file = *BLANKS;
         msg_file = QCPFMSG;
      else;
         msg_file = o_title_id.file;
      endif;
   endif;

   r5_api_error_init_for_exception(error);
   DspLngTxt( text: %len(text)
            : msg_id: msg_file
            : error
            );
   return;
end-proc;

