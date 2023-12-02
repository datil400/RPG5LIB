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
   DCL        VAR(&MINVER) TYPE(*CHAR) LEN(6) VALUE('V6R1M0')
   DCL        VAR(&PKG)    TYPE(*CHAR) LEN(10) VALUE('R5STRING')
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

   CHKOBJ     OBJ(API) OBJTYPE(*FILE)
   CHKOBJ     OBJ(RPG5LIB) OBJTYPE(*FILE)
   CHKOBJ     OBJ(R5UTILS) OBJTYPE(*SRVPGM)
   CHKOBJ     OBJ(R5EXCMGR) OBJTYPE(*SRVPGM)

/*  ================================================================ */
/*  =  CREAR OBJETOS                                               = */
/*  ================================================================ */

   CRTBNDDIR  BNDDIR(&LIB/RPG5LIB) AUT(*USE) +
              TEXT('RPG5LIB Binding directory')
   MONMSG     MSGID(CPF0000)

   ADDBNDDIRE BNDDIR(&LIB/RPG5LIB) OBJ((R5STRING))
   MONMSG     MSGID(CPF0000)

/*  ---------------------------------------------------------------  */
/*  - Prepara el entorno de compilaci�n                           -  */
/*  ---------------------------------------------------------------  */

   CRTMSGF    MSGF(&LIB/RPG5MSG) TEXT('RPG5LIB message file')
   MONMSG     CPF0000

   RMVMSGD    MSGID(RP50100) MSGF(&LIB/RPG5MSG)
   MONMSG     CPF0000
   ADDMSGD    MSGID(RP50100)                                      +
              MSGF(&LIB/RPG5MSG)                                  +
              MSG('El ancho m�ximo del texto no es v�lido.')      +
              SECLVL('Causa . . . . . :   Se ha especificado un ancho +
                      m�ximo de &1 posiciones para un texto de +
                      resultado, pero no est� permitido un valor +
                      negativo o cero. &N +
                      Recuperaci�n . .:   Especifique un valor +
                      positivo para el ancho y vuelva a intentar la +
                      operaci�n.')                                +
              FMT((*BIN  4))

/* ESTE MENSAJE ES GEN�RICO PARA TODA LA BIBLIOTECA RPG5LIB */
/* INCLUIRLO EN UN PROGRAMA DE INSTALACION ESPEC�FICO */

   RMVMSGD    MSGID(RP5FF00) MSGF(&LIB/RPG5MSG)
   MONMSG     CPF0000
   ADDMSGD    MSGID(RP5FF00)                                      +
              MSGF(&LIB/RPG5MSG)                                  +
              MSG('No se ha especificado una funci�n de respuesta +
                   (callback) requerida.') +
              SECLVL('Causa . . . . . :   El procedimiento &1 del +
                      programa &2 de la biblioteca &3 requiere una +
                      funci�n de respuesta (callback) como par�metro, +
                      pero no se ha especificado.&N +
                      Recuperaci�n . .:   Especifique la direcci�n +
                      de una funci�n de respuesta que se ajuste al +
                      prototipo esperado. Consulte con el fabricante +
                      del software.')                             +
              FMT((*CHAR 256) (*CHAR 10) (*CHAR 10))

/*  ---------------------------------------------------------------  */
/*  - Compilaci�n                                                 -  */
/*  ---------------------------------------------------------------  */

   CRTRPGMOD  MODULE(QTEMP/STRING) +
              SRCFILE(&LIB/&RPGLESRC) DBGVIEW(&DBG)
   CRTRPGMOD  MODULE(QTEMP/WORDWRAP) +
              SRCFILE(&LIB/&RPGLESRC) DBGVIEW(&DBG)
   RTVMBRD    FILE(&LIB/&RPGLESRC) MBR(R5STRINGB) TEXT(&TEXT)
   CRTSRVPGM  SRVPGM(&LIB/R5STRING) MODULE(QTEMP/STRING +
              QTEMP/WORDWRAP) EXPORT(*SRCFILE) +
              SRCFILE(&LIB/&SRVSRC) SRCMBR(R5STRINGB) +
              TEXT(&TEXT) OPTION(*DUPPROC)
   SNDPGMMSG  MSG('Se ha creado el programa de servicio R5STRING.') +
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
