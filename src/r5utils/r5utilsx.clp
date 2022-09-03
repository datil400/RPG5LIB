/*  ===============================================================  */
/*  = Despliegue del c�digo fuente (versi�n 1.0)                  =  */
/*  =                                                             =  */
/*  = Par�metros                                                  =  */
/*  =   FROMLIB    Biblioteca donde est�n los nuevos fuentes.     =  */
/*  =   OVRFRMSRCF Archivo con los nuevos fuentes.                =  */
/*  =              Por defecto se buscan los fuentes en los       =  */
/*  =              ficheros est�ndar del AS/400 (QCMDSRC,         =  */
/*  =              QCLSRC, QRPGSRC, etc.). Se usar� este par�me-  =  */
/*  =              tro para indicar que todos los fuentes est�n   =  */
/*  =              en un �nico archivo.                           =  */
/*  =   TOLIB      Biblioteca donde se copiar�n los fuentes.      =  */
/*  =   OVRTOSRCF  Archivo donde se copiar�n los fuentes.         =  */
/*  =   CREATE     *YES para compilar los objetos en TOLIB.       =  */
/*  ===============================================================  */

PGM (                                                                +
     &FROMLIB       /* Biblioteca de origen de los fuentes */        +
     &OVRFRMSRCF    /* Alterar archivos fuente de origen */          +
     &TOLIB         /* Biblioteca de destino de los fuentes */       +
     &OVRTOSRCF     /* Alterar archivos fuente de destino */         +
     &CREATE        /* *YES para compilar objetos en destino */      +
)

DCL        VAR(&FROMLIB) TYPE(*CHAR) LEN(10)
DCL        VAR(&OVRFRMSRCF) TYPE(*CHAR) LEN(10)
DCL        VAR(&TOLIB) TYPE(*CHAR) LEN(10)
DCL        VAR(&OVRTOSRCF) TYPE(*CHAR) LEN(10)
DCL        VAR(&CREATE) TYPE(*CHAR) LEN(4)

/*  ================================================================ */
/*  =  VARIABLES DE TRABAJO                                        = */
/*  ================================================================ */

   DCL        VAR(&FRMCMDSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&FRMDSPSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&FRMCLSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&FRMRPGSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&FRMRPGLESR) TYPE(*CHAR) LEN(10)
   DCL        VAR(&FRMPNLSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&FRMSRVSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&FRMDDSSRC) TYPE(*CHAR) LEN(10)

   DCL        VAR(&TOCMDSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&TODSPSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&TOCLSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&TORPGSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&TORPGLESR) TYPE(*CHAR) LEN(10)
   DCL        VAR(&TOPNLSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&TOSRVSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&TODDSSRC) TYPE(*CHAR) LEN(10)

   DCL        VAR(&PKG)    TYPE(*CHAR) LEN(10) VALUE('RPG5LIB')

   MONMSG     MSGID(CPF0000) EXEC(GOTO ERROR)

/*  ================================================================ */
/*  =  VALIDACIONES                                                = */
/*  ================================================================ */

/*  ---------------------------------------------------------------  */
/*  - Biblioteca                                                  -  */
/*  ---------------------------------------------------------------  */
   CHKOBJ     OBJ(&FROMLIB) OBJTYPE(*LIB)
   CHKOBJ     OBJ(&TOLIB) OBJTYPE(*LIB)

/*  ---------------------------------------------------------------  */
/*  - Archivo fuente                                              -  */
/*  ---------------------------------------------------------------  */
   IF         COND(&OVRFRMSRCF *NE ' ') THEN(             +
      CHKOBJ     OBJ(&FROMLIB/&OVRFRMSRCF) OBJTYPE(*FILE) +
   )

   IF         COND(&OVRFRMSRCF *NE ' ') THEN( DO )
      CHGVAR     VAR(&FRMCMDSRC) VALUE(&OVRFRMSRCF)
      CHGVAR     VAR(&FRMDSPSRC) VALUE(&OVRFRMSRCF)
      CHGVAR     VAR(&FRMCLSRC)  VALUE(&OVRFRMSRCF)
      CHGVAR     VAR(&FRMRPGSRC) VALUE(&OVRFRMSRCF)
      CHGVAR     VAR(&FRMRPGLESR) VALUE(&OVRFRMSRCF)
      CHGVAR     VAR(&FRMPNLSRC) VALUE(&OVRFRMSRCF)
      CHGVAR     VAR(&FRMSRVSRC) VALUE(&OVRFRMSRCF)
      CHGVAR     VAR(&FRMDDSSRC) VALUE(&OVRFRMSRCF)
   ENDDO
   ELSE  DO
      CHGVAR     VAR(&FRMCMDSRC) VALUE('QCMDSRC   ')
      CHGVAR     VAR(&FRMDSPSRC) VALUE('QDSPSRC   ')
      CHGVAR     VAR(&FRMCLSRC)  VALUE('QCLSRC    ')
      CHGVAR     VAR(&FRMRPGSRC) VALUE('QRPGSRC   ')
      CHGVAR     VAR(&FRMRPGLESR) VALUE('QRPGLESRC ')
      CHGVAR     VAR(&FRMPNLSRC) VALUE('QPNLSRC   ')
      CHGVAR     VAR(&FRMSRVSRC) VALUE('QSRVSRC   ')
      CHGVAR     VAR(&FRMDDSSRC) VALUE('QDDSSRC   ')
   ENDDO

   IF         COND(&OVRTOSRCF *NE ' ') THEN(              +
      CHKOBJ     OBJ(&TOLIB/&OVRTOSRCF) OBJTYPE(*FILE)    +
   )

   IF         COND(&OVRTOSRCF *NE ' ') THEN( DO )
      CHGVAR     VAR(&TOCMDSRC) VALUE(&OVRTOSRCF)
      CHGVAR     VAR(&TODSPSRC) VALUE(&OVRTOSRCF)
      CHGVAR     VAR(&TOCLSRC)  VALUE(&OVRTOSRCF)
      CHGVAR     VAR(&TORPGSRC) VALUE(&OVRTOSRCF)
      CHGVAR     VAR(&TORPGLESR) VALUE(&OVRTOSRCF)
      CHGVAR     VAR(&TOPNLSRC) VALUE(&OVRTOSRCF)
      CHGVAR     VAR(&TOSRVSRC) VALUE(&OVRTOSRCF)
      CHGVAR     VAR(&TODDSSRC) VALUE(&OVRTOSRCF)
   ENDDO
   ELSE  DO
      CHGVAR     VAR(&TOCMDSRC) VALUE('QCMDSRC   ')
      CHGVAR     VAR(&TODSPSRC) VALUE('QDSPSRC   ')
      CHGVAR     VAR(&TOCLSRC)  VALUE('QCLSRC    ')
      CHGVAR     VAR(&TORPGSRC) VALUE('QRPGSRC   ')
      CHGVAR     VAR(&TORPGLESR) VALUE('QRPGLESRC ')
      CHGVAR     VAR(&TOPNLSRC) VALUE('QPNLSRC   ')
      CHGVAR     VAR(&TOSRVSRC) VALUE('QSRVSRC   ')
      CHGVAR     VAR(&TODDSSRC) VALUE('QDDSSRC   ')
   ENDDO

/*  ================================================================ */
/*  =  COPIAR MIEMBROS DE COPIA                                    = */
/*  ================================================================ */

             CPYSRCF    FROMFILE(&FROMLIB/&FRMRPGLESR) +
                          TOFILE(&TOLIB/&TORPGLESR) FROMMBR(APIERROR_H)
             CPYSRCF    FROMFILE(&FROMLIB/&FRMRPGLESR) +
                          TOFILE(&TOLIB/&TORPGLESR) FROMMBR(ERRNO_H)
             CPYSRCF    FROMFILE(&FROMLIB/&FRMRPGLESR) +
                          TOFILE(&TOLIB/&TORPGLESR) FROMMBR(JOBLOG_H)
             CPYSRCF    FROMFILE(&FROMLIB/&FRMRPGLESR) +
                          TOFILE(&TOLIB/&TORPGLESR) FROMMBR(CALLLEVELH)
             CPYSRCF    FROMFILE(&FROMLIB/&FRMRPGLESR) +
                          TOFILE(&TOLIB/&TORPGLESR) FROMMBR(R5UTILS_H)

/*  ---------------------------------------------------------------  */
/*  - Mensaje de finalizaci�n                                     -  */
/*  ---------------------------------------------------------------  */

   SNDPGMMSG  MSG('Se ha desplegado el paquete ' *cat &pkg *tcat '.')   +
              MSGTYPE(*COMP)

/*  ===============================================================  */
/*  = LIMPIEZA                                                    =  */
/*  ===============================================================  */
LIMPIEZA:

   RETURN

/*  ===============================================================  */
/*  = MANEJADOR EST�NDAR DE ERRORES                               =  */
/*  ===============================================================  */

Error:

/*  ---------------------------------------------------------------  */
/*  - Se mueven todos los mensajes de diagn�stico de la cola de   -  */
/*  - mensajes de la actual entrada en la pila de llamadas a la   -  */
/*  - inmediata anterior.                                         -  */
/*  ---------------------------------------------------------------  */

   Call      QMHMOVPM    ( '    '                                 +
                           '*DIAG'                                +
                           x'00000001'                            +
                           '*PGMBDY   '                           +
                           x'00000001'                            +
                           x'0000000800000000'                    +
                         )

/*  ---------------------------------------------------------------  */
/*  - Reenviar el �ltimo mensaje de escape emitido en la entrada  -  */
/*  - actual de la pila de llamadas a su inmediata anterior.      -  */
/*  ---------------------------------------------------------------  */

   Call       QMHRSNEM   (                                        +
                           '    '                                 +
                           X'0000000800000000'                    +
                         )
   MonMsg     ( cpf0000 )

ENDPGM
