**FREE

//  Package : RPG5LIB
//  SrvPgm  : R5SYS
//  Module  : OBJMAN
//
//  Object management
//
//  Author : datil400@gmail.com
//  Date   : April 2023
//
//  Compiling : R5SYSI
//
//  Comments
//


ctl-opt nomain;
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt text(*SRCMBRTXT);

/COPY API,object_h
/COPY API,file_h
/COPY RPG5LIB,apierror_h
/COPY RPG5LIB,joblog_h
/COPY RPG5LIB,in_h
/COPY RPG5LIB,objman_h


//  Comprueba la existencia de un objeto.
//
//  'obj_name' admite los siguientes formatos:
//      'biblioteca/objeto'
//      'Objeto    Biblioteca'
//
//  'obj_type' puede ser cualquier tipo de objeto definido en el sistema.

dcl-proc r5_check_object export;

   dcl-pi *N like(r5_boolean_t);
      obj_name char(21) const;
      obj_type like(r5_name_t) const;
   end-pi;

   dcl-s found like(r5_boolean_t) inz(*ON);
   dcl-s object char(20);
   dcl-ds objd likeds(OBJD0100_T) inz;
   dcl-ds error likeds(ERRC0100_T);


   object = r5_parse_object_name(obj_name);

   r5_api_error_init_for_monitor(error);
   RtvObjd( objd: %size(objd)
          : 'OBJD0100'
          : object: obj_type
          : error
          );
   if r5_api_error_occurred(error);
      if not r5_in(error.msgId: 'CPF9801': 'CPF9810': 'CPF9811': 'CPF9812': 'CPF9814');
         r5_joblog('%s: %s': %proc(): error.msgId);
      endif;
      return not found;
   endif;

   return found;
end-proc;


//  Comprueba la existencia de un miembro de archivo.
//
//  'obj_name' admite los siguientes formatos:
//      'biblioteca/objeto'
//      'Objeto    Biblioteca'
//
// 'o_member' si no se indica por defecto *FIRST.
//
//  'o_use_ovr'  ¿Utilizar alteración temporal?

//   Basado en un procedimiento similar de:
//
//   Bob Cozzi's "RPG TnT: 101 Tips 'n Techniques for RPG IV"
//   (c) 2006 by Robert Cozzi, Jr.

dcl-proc r5_check_member export;

   dcl-pi *N like(r5_boolean_t);
      obj_name char(21) const;
      o_member like(r5_name_t) options(*NOPASS) const;
      o_use_ovr like(r5_boolean_t) options(*NOPASS) const;
   end-pi;

   dcl-s found like(r5_boolean_t) inz(*ON);
   dcl-s object char(20);
   dcl-s member char(10) inz('*FIRST');
   dcl-s use_ovr char(1) inz(*OFF);

   dcl-ds mbrd likedS(MBRD0100_T) inz;
   dcl-ds error likeds(ERRC0100_T);


   if %parms() >= %parmnum(o_member);
      member = o_member;
   endif;

   if %parms() >= %parmnum(o_use_ovr);
      use_ovr = o_use_ovr;
   endIf;

   object = r5_parse_object_name(obj_name);

   r5_api_error_init_for_monitor(error);
   RtvMbrD( mbrd: %size(mbrd)
          : 'MBRD0100'
          : object: member
          : use_ovr
          : error
          );
   if r5_api_error_occurred(error);
      if not r5_in(error.msgId: 'CPF32DE': 'CPF3C22': 'CPF3C23': 'CPF3C26': 'CPF3C27') and
         not (%subst(error.msgID: 1: 5) = 'CPF98') and
         not (%subst(error.msgID: 1: 5) = 'CPF81');

         r5_joblog('%s: %s': %proc(): error.msgId);
      endif;
      return not found;
   endif;

   return found;
end-proc;


//  Analizar un nombre de objeto
//
//  'obj_name' admite los siguientes formatos:
//      'biblioteca/objeto'
//      'Objeto    Biblioteca'
//
//  Devuelve el nombre del objeto en formato 'Objeto----Biblioteca'.

//   Basado en un procedimiento similar de:
//
//   Bob Cozzi's "RPG TnT: 101 Tips 'n Techniques for RPG IV"
//   (c) 2006 by Robert Cozzi, Jr.

dcl-proc r5_parse_object_name export;

   dcl-pi *N likeds(r5_qualified_name_t);
      obj_name char(21) const;
   end-pi;

   dcl-ds obj likeds(r5_qualified_name_t);
   dcl-s i int(10);


   for i = 1 to %len(obj_name);

      // ¿Es un nombre de objecto calificado?
      if  %subst(obj_name: i: 1) = '/';
         if i < %len(obj_name);
            obj.name = %subst(obj_name: i + 1);
         endif;
         if i > 1;
            obj.lib = %subst(obj_name: 1: i - 1);
         endif;
         leave;

      // ¿Podría ser un nombre del estilo objeto+biblioteca?
      elseif  %subst(obj_name: i: 1) = ' ';
         if i >  1;
            if (i - 1) <= %size(obj.name);
               obj.name = %subst(obj_name: 1: i - 1);
               if i < %len(obj_name);
                  obj.lib = %trim(%subst(obj_name: i + 1));
               endif;

            // Si se ha superado el máximo para el nombre de un
            // objeto se asume que el valor tiene el formato
            // tradicional objeto+biblioteca.
            else;
               obj.name = %subst(obj_name: 1: %size(obj.name));
               obj.lib  = %trimL(%subst(obj_name: %size(obj.name) + 1));
            endif;
         endif;
         leave;

      // Formato tradicional sin marcas.
      elseif i >= %len(obj_name);
        obj.name = %subst(obj_name: 1: %size(obj.name));
        obj.lib  = %trimL(%subst(obj_name: %size(obj.name) + 1));
        leave;
      endif;
   endfor;

   // Si no se ha indicado biblioteca se toma *LIBL por defecto
   if obj.lib = *BLANKS;
      obj.lib = '*LIBL';
   endif;
   return obj;
end-proc;


