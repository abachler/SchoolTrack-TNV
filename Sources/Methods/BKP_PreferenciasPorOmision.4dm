//%attributes = {}
  // BKP_PreferenciasPorOmision()
  // Por: Alberto Bachler K.: 20-09-14, 17:21:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob;$x_blobEntrada;$x_blobSalida;$x_llavePrivada)
C_LONGINT:C283($l_borrarRespaldoAntes;$l_CancelarDespuesReintentos;$l_frecuenciaMensualCada;$l_frecuenciaMensualDia;$l_frecuenciaSemanal;$l_frecuenciaSemanalCada;$l_frecuenciaSemanalDomingo;$l_frecuenciaSemanalJueves;$l_frecuenciaSemanalLunes;$l_frecuenciaSemanalMartes)
C_LONGINT:C283($l_frecuenciaSemanalMiercoles;$l_frecuenciaSemanalSabado;$l_frecuenciaSemanalViernes;$l_HLcrypt;$l_incluirArchivoDeDatos;$l_incluirEstructura;$l_incluirEstructuraAlt;$l_integracionAutomaticaLog;$l_KbSegmentos;$l_logRespaldoVerboso)
C_LONGINT:C283($l_programacionDiariaCada;$l_programacionHorariaCada;$l_reinicioAutomatico;$l_reintentarEn;$l_reintentarEnUnidad;$l_reintentarProximaProgramacion;$l_respaldoConModificacion;$l_respaldosConservados;$l_restauracionAutomatica;$l_transaccionEsperarTermino)
C_LONGINT:C283($l_verificarArchivoRespaldo)
C_TIME:C306($h_frecuenciaDomingoHora;$h_frecuenciaJuevesHora;$h_frecuenciaLunesHora;$h_frecuenciaMartesHora;$h_frecuenciaMensualHora;$h_frecuenciaMiercolesHora;$h_frecuenciaSabadoHora;$h_frecuenciaViernesHora;$h_programacionDiariaInicio;$h_programacionHorariaInicio)
C_TIME:C306($h_refDoc;$h_reintentarTiempo;$h_transaccionTimeout)
C_TEXT:C284($t_archivoIndex;$t_borrarRespaldoAntes;$t_CancelarReintentos;$t_conservacionRespaldos;$t_contraseñaVolumenRemoto;$t_frecuenciaDomingo;$t_frecuenciaJueves;$t_frecuenciaLunes;$t_frecuenciaMartes;$t_frecuenciaMiercoles)
C_TEXT:C284($t_frecuenciaSabado;$t_frecuenciaViernes;$t_incluirArchivoDeDatos;$t_incluirArchivoEstructuraAlt;$t_incluirEstructura;$t_integracionAutomaticaLog;$t_interlazado;$t_json;$t_llavePrivada;$t_logRespaldoVerboso)
C_TEXT:C284($t_programacion;$t_redundancia;$t_reinicioAutomatico;$t_reintentarProximaProgramacion;$t_respaldoConModificacion;$t_restauracionAutomatica;$t_rutaCarpetaRespaldos;$t_rutaPlantilla;$t_rutaPrefComplementos;$t_rutaPrefsRespaldo)
C_TEXT:C284($t_tipoCompresion;$t_transaccionEsperarTermino;$t_uriVolumenRemoto;$t_verificarArchivoRespaldo)
C_OBJECT:C1216($ob_raiz)

ARRAY TEXT:C222($at_ArchivosAdjuntos;0)

  // opciones no disponibles en configuración por parte del usuario
$l_transaccionEsperarTermino:=0
$h_transaccionTimeout:=?00:05:00?
$t_transaccionEsperarTermino:=Choose:C955($l_transaccionEsperarTermino=1;"True";"False")
  //$t_transaccionTimeout:=String($h_transaccionTimeout;ISO Time)
$l_restauracionAutomatica:=0
$t_restauracionAutomatica:=Choose:C955($l_restauracionAutomatica=1;"True";"False")
$l_integracionAutomaticaLog:=0
$t_integracionAutomaticaLog:=Choose:C955($l_integracionAutomaticaLog=1;"True";"False")
$l_respaldoConModificacion:=1
$t_respaldoConModificacion:=Choose:C955($l_respaldoConModificacion=1;"True";"False")
$l_reinicioAutomatico:=1
$t_reinicioAutomatico:=Choose:C955($l_reinicioAutomatico=1;"True";"False")


  // reintentos de respaldos fallidos
$t_CancelarReintentos:="False"
$l_CancelarDespuesReintentos:=3
$l_reintentarProximaProgramacion:=1
$t_reintentarProximaProgramacion:=Choose:C955($l_reintentarProximaProgramacion=1;"True";"False")
$l_reintentarEn:=0
$l_reintentarEnUnidad:=2  //minutos
$h_reintentarTiempo:=?00:03:00?
  //$t_reintentarEnValor:=String($h_reintentarEn;ISO Time)


  // opciones de compresion y gestión de respaldos
$t_tipoCompresion:="Compact"
$t_redundancia:="None"
$t_interlazado:="None"
$l_KbSegmentos:=0
$l_verificarArchivoRespaldo:=1
$t_verificarArchivoRespaldo:=Choose:C955($l_verificarArchivoRespaldo>0;"True";"False")
$l_logRespaldoVerboso:=1
$t_logRespaldoVerboso:=Choose:C955($l_verificarArchivoRespaldo>0;"True";"False")
$l_respaldosConservados:=7
$t_conservacionRespaldos:=Choose:C955($l_logRespaldoVerboso>0;"True";"False")
$l_borrarRespaldoAntes:=0
$t_borrarRespaldoAntes:=Choose:C955($l_borrarRespaldoAntes=1;"True";"False")

  // archivos a respaldar
$l_incluirArchivoDeDatos:=1
$t_incluirArchivoDeDatos:=Choose:C955($l_incluirArchivoDeDatos=1;"True";"False")
$l_incluirEstructura:=0
$t_incluirEstructura:=Choose:C955($l_incluirEstructura=1;"True";"False")
$l_incluirEstructuraAlt:=0
$t_incluirArchivoEstructuraAlt:=Choose:C955($l_incluirEstructuraAlt=1;"True";"False")
$t_archivoIndex:=SYS_GetServerProperty (XS_DataFileFolder)+Replace string:C233(SYS_GetServerProperty (XS_DataFileName);".4DD";".4DIndx")
APPEND TO ARRAY:C911($at_ArchivosAdjuntos;$t_archivoIndex)


  // ubicacion del respaldo
READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])
<>gCustom:=[Colegio:31]Nombre_Colegio:1
<>gRolBD:=[Colegio:31]Rol Base Datos:9
$t_rutaCarpetaRespaldos:=SYS_GetFolderNam (Data file:C490)+"Respaldos_"+<>gRolBD
$t_uriVolumenRemoto:=""
$t_contraseñaVolumenRemoto:=""



  // programacion horaria
$l_programacionHorariaCada:=12
$h_programacionHorariaInicio:=?00:07:00?

  // programacion diaria
$l_programacionDiariaCada:=1
$h_programacionDiariaInicio:=?00:02:00?

$t_programacion:="Daily"


  // programacionSemanal
$l_frecuenciaSemanalCada:=1
$l_frecuenciaSemanalLunes:=0
$l_frecuenciaSemanalMartes:=0
$l_frecuenciaSemanalMiercoles:=0
$l_frecuenciaSemanalJueves:=0
$l_frecuenciaSemanalViernes:=0
$l_frecuenciaSemanalSabado:=0
$l_frecuenciaSemanalDomingo:=0
$t_frecuenciaLunes:=Choose:C955($l_frecuenciaSemanalLunes=1;"True";"False")
$t_frecuenciaMartes:=Choose:C955($l_frecuenciaSemanalMartes=1;"True";"False")
$t_frecuenciaMiercoles:=Choose:C955($l_frecuenciaSemanalMiercoles=1;"True";"False")
$t_frecuenciaJueves:=Choose:C955($l_frecuenciaSemanalJueves=1;"True";"False")
$t_frecuenciaViernes:=Choose:C955($l_frecuenciaSemanalViernes=1;"True";"False")
$t_frecuenciaSabado:=Choose:C955($l_frecuenciaSemanalSabado=1;"True";"False")
$t_frecuenciaDomingo:=Choose:C955($l_frecuenciaSemanalDomingo=1;"True";"False")


$h_frecuenciaLunesHora:=?02:00:00?
$h_frecuenciaMartesHora:=?02:00:00?
$h_frecuenciaMiercolesHora:=?02:00:00?
$h_frecuenciaJuevesHora:=?02:00:00?
$h_frecuenciaViernesHora:=?02:00:00?
$h_frecuenciaSabadoHora:=?02:00:00?
$h_frecuenciaDomingoHora:=?02:00:00?

$l_frecuenciaMensualCada:=0
$h_frecuenciaMensualHora:=?00:30:00?
$l_frecuenciaMensualDia:=7


$t_rutaPlantilla:=SYS_GetServerProperty (XS_StructureFolder)+"Config"+Folder separator:K24:12+"plantillaRespaldos.xml"
DOCUMENT TO BLOB:C525($t_rutaPlantilla;$x_blobEntrada)
PROCESS 4D TAGS:C816($x_blobEntrada;$x_blobSalida)
$t_rutaPrefsRespaldo:=System folder:C487(Desktop:K41:16)+"PrefRespaldo3.xml"
$h_refDoc:=Create document:C266($t_rutaPrefsRespaldo;"TEXT")
CLOSE DOCUMENT:C267($h_refDoc)
BLOB TO DOCUMENT:C526(document;$x_blobSalida)



$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$l_transaccionEsperarTermino;"BKP_transaccionEsperarTermino")
OB_SET ($ob_raiz;->$h_transaccionTimeout;"BKP_transaccionTimeout")
OB_SET ($ob_raiz;->$l_CancelarDespuesReintentos;"BKP_respaldosAbortarTras")
OB_SET ($ob_raiz;->$l_restauracionAutomatica;"BKP_restauracionAutomatica")
OB_SET ($ob_raiz;->$l_integracionAutomaticaLog;"BKP_integracionAutomaticaLog")
OB_SET ($ob_raiz;->$l_respaldoConModificacion;"BKP_respaldoSoloConModificacion")
OB_SET ($ob_raiz;->$l_reinicioAutomatico;"BKP_ReinicioAutomatico")
OB_SET ($ob_raiz;->$l_respaldosConservados;"BKP_Respaldos_aConservar")
OB_SET ($ob_raiz;->$l_borrarRespaldoAntes;"BKP_borrarRespaldoAntes")
OB_SET ($ob_raiz;->$l_incluirArchivoDeDatos;"BKP_incluirArchivoDeDatos")
OB_SET ($ob_raiz;->$l_incluirEstructura;"BKP_incluirEstructura")
OB_SET ($ob_raiz;->$l_incluirEstructuraAlt;"BKP_incluirEstructuraUsuario")
OB_SET ($ob_raiz;->$at_ArchivosAdjuntos;"BKP_rutaArchivosAdjuntos")
OB_SET ($ob_raiz;->$t_rutaCarpetaRespaldos;"BKP_rutaCarpetaRespaldos")
OB_SET ($ob_raiz;->$t_uriVolumenRemoto;"BKP_uriVolumenRemoto")
OB_SET ($ob_raiz;->$t_contraseñaVolumenRemoto;"BKP_passwordVolumenRemoto")
OB_SET ($ob_raiz;->$t_tipoCompresion;"BKP_modoCompresion")
OB_SET ($ob_raiz;->$l_reintentarProximaProgramacion;"BKP_reintentarSiguiente")
OB_SET ($ob_raiz;->$l_reintentarEn;"BKP_reintentarEn")
OB_SET ($ob_raiz;->$h_reintentarTiempo;"BKP_tiempoReintento")
OB_SET ($ob_raiz;->$l_reintentarEnUnidad;"BKP_reintentarEnUnidad")
OB_SET ($ob_raiz;->$t_programacion;"BKP_programacion")
OB_SET ($ob_raiz;->$l_programacionHorariaCada;"BKP_frecuenciaHorariaCada")
OB_SET ($ob_raiz;->$h_programacionHorariaInicio;"BKP_frecuenciaHorariaInicio")
OB_SET ($ob_raiz;->$l_programacionDiariaCada;"BKP_frecuenciaDiariaCada")
OB_SET ($ob_raiz;->$h_programacionDiariaInicio;"BKP_frecuenciaDiariaInicio")
OB_SET ($ob_raiz;->$l_frecuenciaSemanal;"BKP_frecuenciaSemanalCada")
OB_SET ($ob_raiz;->$l_frecuenciaSemanalLunes;"BKP_SemanalLunes")
OB_SET ($ob_raiz;->$l_frecuenciaSemanalMartes;"BKP_SemanalMartes")
OB_SET ($ob_raiz;->$l_frecuenciaSemanalMiercoles;"BKP_SemanalMiercoles")
OB_SET ($ob_raiz;->$l_frecuenciaSemanalJueves;"BKP_SemanalJueves")
OB_SET ($ob_raiz;->$l_frecuenciaSemanalViernes;"BKP_SemanalViernes")
OB_SET ($ob_raiz;->$l_frecuenciaSemanalSabado;"BKP_SemanalSabado")
OB_SET ($ob_raiz;->$l_frecuenciaSemanalDomingo;"BKP_SemanalDomingo")
OB_SET ($ob_raiz;->$h_frecuenciaLunesHora;"BKP_SemanalInicioLunes")
OB_SET ($ob_raiz;->$h_frecuenciaMartesHora;"BKP_SemanalInicioMartes")
OB_SET ($ob_raiz;->$h_frecuenciaMiercolesHora;"BKP_SemanalInicioMiercoles")
OB_SET ($ob_raiz;->$h_frecuenciaJuevesHora;"BKP_SemanalInicioJueves")
OB_SET ($ob_raiz;->$h_frecuenciaViernesHora;"BKP_SemanalInicioViernes")
OB_SET ($ob_raiz;->$h_frecuenciaSabadoHora;"BKP_SemanalInicioSabado")
OB_SET ($ob_raiz;->$h_frecuenciaDomingoHora;"BKP_SemanalInicioDomingo")
OB_SET ($ob_raiz;->$l_verificarArchivoRespaldo;"BKP_verificarArchivoRespaldo")
OB_SET ($ob_raiz;->$l_logRespaldoVerboso;"BKP_logRespaldoDetallado")

  // convierto objeto a json
$t_json:=OB_Object2Json ($ob_Raiz;True:C214)


$t_rutaPrefComplementos:=SYS_GetServerProperty (XS_StructureFolder)+"Preferences"+Folder separator:K24:12+"Backup"+Folder separator:K24:12+"BackupComp.txt"

  // encriptacion del documento json
TEXT TO BLOB:C554($t_json;$x_blob;UTF8 text without length:K22:17)
$l_HLcrypt:=Load list:C383("Crypt")
GET LIST ITEM PARAMETER:C985($l_HLcrypt;1;"priv";$t_llavePrivada)
TEXT TO BLOB:C554($t_llavePrivada;$x_llavePrivada;UTF8 text without length:K22:17)
ENCRYPT BLOB:C689($x_blob;$x_llavePrivada)
If (Test path name:C476($t_rutaPrefComplementos)#Is a document:K24:1)
	$h_refDoc:=Create document:C266($t_rutaPrefComplementos)
	CLOSE DOCUMENT:C267($h_refDoc)
End if 
BLOB TO DOCUMENT:C526($t_rutaPrefComplementos;$x_blob)

