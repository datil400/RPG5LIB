/*  ===============================================================  */
/*  = Instalador de las utilidades (Versi�n 1.3.4)                =  */
/*  =                                                             =  */
/*  = Par�metros                                                  =  */
/*  =   LIB        Biblioteca en donde est�n los fuentes y en     =  */
/*  =              donde se ubican los objetos.                   =  */
/*  =   OVRSRCFILE Por defecto se buscan los fuentes en los       =  */
/*  =              ficheros est�ndar del AS/400 (QCMDSRC,         =  */
/*  =              QCLSRC, QRPGSRC, etc.). Se usar� este par�me-  =  */
/*  =              tro para indicar que todos los fuentes est�n   =  */
/*  =              en un �nico archivo.                           =  */
/*  ===============================================================  */

PGM (                                                                +
     &LIB           /* Biblioteca en donde instalar */               +
     &OVRSRCFILE    /* Alterar archivos fuente por defecto */        +
)

DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)
DCL        VAR(&OVRSRCFILE) TYPE(*CHAR) LEN(10)

/*  ================================================================ */
/*  =  VARIABLES DE TRABAJO                                        = */
/*  ================================================================ */

   DCL        VAR(&CMDSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&DSPSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&CLSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&RPGSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&RPGLESRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&PNLSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&SRVSRC) TYPE(*CHAR) LEN(10)
   DCL        VAR(&DDSSRC) TYPE(*CHAR) LEN(10)

   DCL        VAR(&OSVER) TYPE(*CHAR) LEN(6)
   DCL        VAR(&MINVER) TYPE(*CHAR) LEN(6) VALUE('V7R1M0')
   DCL        VAR(&PKG)    TYPE(*CHAR) LEN(10) VALUE('R5TUI')
   DCL        VAR(&TEXT) TYPE(*CHAR) LEN(50)

   DCL        VAR(&DBG)    TYPE(*CHAR) LEN(10) VALUE('*SOURCE')

   MONMSG     MSGID(CPF0000) EXEC(GOTO ERROR)

/*  ================================================================ */
/*  =  VALIDACIONES                                                = */
/*  ================================================================ */

/*  Biblioteca  */
   CHKOBJ     OBJ(&LIB) OBJTYPE(*LIB)

/*  Archivo fuente  */
   IF         COND(&OVRSRCFILE *NE ' ') THEN(             +
      CHKOBJ     OBJ(&LIB/&OVRSRCFILE) OBJTYPE(*FILE)     +
   )

   IF         COND(&OVRSRCFILE *NE ' ') THEN( DO )
      CHGVAR     VAR(&CMDSRC) VALUE(&OVRSRCFILE)
      CHGVAR     VAR(&DSPSRC) VALUE(&OVRSRCFILE)
      CHGVAR     VAR(&CLSRC)  VALUE(&OVRSRCFILE)
      CHGVAR     VAR(&RPGSRC) VALUE(&OVRSRCFILE)
      CHGVAR     VAR(&RPGLESRC) VALUE(&OVRSRCFILE)
      CHGVAR     VAR(&PNLSRC) VALUE(&OVRSRCFILE)
      CHGVAR     VAR(&SRVSRC) VALUE(&OVRSRCFILE)
      CHGVAR     VAR(&DDSSRC) VALUE(&OVRSRCFILE)
   ENDDO
   ELSE  DO
      CHGVAR     VAR(&CMDSRC) VALUE('QCMDSRC   ')
      CHGVAR     VAR(&DSPSRC) VALUE('QDSPSRC   ')
      CHGVAR     VAR(&CLSRC)  VALUE('QCLSRC    ')
      CHGVAR     VAR(&RPGSRC) VALUE('QRPGSRC   ')
      CHGVAR     VAR(&RPGLESRC) VALUE('QRPGLESRC ')
      CHGVAR     VAR(&PNLSRC) VALUE('QPNLSRC   ')
      CHGVAR     VAR(&SRVSRC) VALUE('QSRVSRC   ')
      CHGVAR     VAR(&DDSSRC) VALUE('QDDSSRC   ')
   ENDDO

/*  ---------------------------------------------------------------  */
/*  - Requisitos                                                  -  */
/*  ---------------------------------------------------------------  */

/*  Verificar versi�n del sistema operativo                          */
   RTVDTAARA  DTAARA(QSS1MRI (1 6)) RTNVAR(&OSVER)
   IF         COND(&OSVER < &MINVER) THEN(DO)
      SNDPGMMSG  MSGID(CPF9897) MSGF(QCPFMSG) MSGDTA('Release +
                   m�nima para esta utlidad (' || &MINVER || +
                   ') no es compatible con la del sistema (' +
                   || &OSVER || ').') MSGTYPE(*ESCAPE)
   ENDDO

/*  ================================================================ */
/*  =  CREAR OBJETOS                                               = */
/*  ================================================================ */

/*  ---------------------------------------------------------------  */
/*  - Prepara el entorno de compilaci�n                           -  */
/*  ---------------------------------------------------------------  */

/*  ---------------------------------------------------------------  */
/*  - Compilaci�n                                                 -  */
/*  ---------------------------------------------------------------  */

   CRTRPGMOD  MODULE(QTEMP/DSPATR) SRCFILE(&LIB/&RPGLESRC) +
              DBGVIEW(&DBG)
   CRTRPGMOD  MODULE(QTEMP/UIM) SRCFILE(&LIB/&RPGLESRC) +
              DBGVIEW(&DBG)
   RTVMBRD    FILE(&LIB/&RPGLESRC) MBR(R5TUIB) TEXT(&TEXT)
   CRTSRVPGM  SRVPGM(&LIB/R5TUI) MODULE(QTEMP/DSPATR QTEMP/UIM) +
              EXPORT(*SRCFILE) SRCFILE(&LIB/&SRVSRC) +
              SRCMBR(R5TUIB) TEXT(&TEXT) +
              OPTION(*DUPPROC)
   SNDPGMMSG  MSG('Se ha creado el programa de servicio R5TUI.') +
              MSGTYPE(*COMP)

   SNDPGMMSG  MSG('Se ha instalado el paquete ' *cat &pkg *tcat '.') +
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
   MonMsg     ( cpf0000 )

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
