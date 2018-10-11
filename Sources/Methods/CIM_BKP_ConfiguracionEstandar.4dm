//%attributes = {"executedOnServer":true}
  // CIM_BKP_ConfiguracionEstandar()
  // Por: Alberto Bachler K.: 08-09-14, 14:58:17
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob;$x_blob2)
C_BOOLEAN:C305($b_CancelarReintentos;$b_reintentarProximaProgramacion)
C_LONGINT:C283($l_borrarRespadoAntes;$l_CancelarDespuesReintentos;$l_FrecuenciaDiariaCadaX;$l_frecuenciaDomingo;$l_frecuenciaHorariaCadaX;$l_frecuenciaJueves;$l_frecuenciaLunes;$l_frecuenciaMartes;$l_frecuenciaMensualCada;$l_frecuenciaMensualDia)
C_LONGINT:C283($l_frecuenciaMiercoles;$l_frecuenciaSemanalCadaX;$l_frecuenciaSemanalDomingo;$l_frecuenciaSemanalJueves;$l_frecuenciaSemanalLunes;$l_frecuenciaSemanalMartes;$l_frecuenciaSemanalMiercoles;$l_frecuenciaSemanalSabado;$l_frecuenciaSemanalViernes;$l_frecuenciaViernes)
C_LONGINT:C283($l_integracionAutomaticaLog;$l_reinicioAutomatico;$l_reintentarProximaProgramacion;$l_respaldoConModificacion;$l_respaldosConservados;$l_restauracionAutomatica;$l_TamañoSegmentos;$l_transaccionEsperarTermino)
C_TIME:C306($h_frecuenciaDomingoHora;$h_frecuenciaJuevesHora;$h_frecuenciaLunesHora;$h_frecuenciaMartesHora;$h_frecuenciaMensualHora;$h_frecuenciaMiercolesHora;$h_frecuenciaSabadoHora;$h_frecuenciaViernesHora;$h_refDocumento;$h_reintentarEn)
C_TIME:C306($h_transaccionTimeout)
C_TEXT:C284($t_archivoDatos;$t_borrarRespadoAntes;$t_CancelarReintentos;$t_conservacionRespaldos;$t_frecuencia;$t_FrecuenciaDiariaInicio;$t_frecuenciaDomingo;$t_frecuenciaDomingoHora;$t_frecuenciaHorariaInicio;$t_frecuenciaJueves)
C_TEXT:C284($t_frecuenciaJuevesHora;$t_frecuenciaLunes;$t_frecuenciaLunesHora;$t_frecuenciaMartes;$t_frecuenciaMartesHora;$t_frecuenciaMensualHora;$t_frecuenciaMiercoles;$t_frecuenciaMiercolesHora;$t_frecuenciaSabado;$t_frecuenciaSabadoHora)
C_TEXT:C284($t_frecuenciaViernes;$t_frecuenciaViernesHora;$t_incluirArchivoDeDatos;$t_incluirArchivoEstructura;$t_incluirArchivoEstructuraAlt;$t_integracionAutomaticaLog;$t_interlazado;$t_logRespaldoVerboso;$t_redundancia;$t_reinicioAutomatico)
C_TEXT:C284($t_reintentarEn;$t_reintentarProximaProgramacion;$t_respaldoConModificacion;$t_restauracionAutomatica;$t_rutaCarpetaRespaldos;$t_rutaPlantilla;$t_rutaPreferenciasBackup;$t_texto2;$t_tipoCompresion;$t_transaccionEsperarTermino)
C_TEXT:C284($t_transaccionTimeout;$t_verificarArchivoRespaldo)

ARRAY TEXT:C222($at_ArchivosAdjuntos;0)


  // ESPERA PARA FINALIZACION DE TRANSACCION
$l_transaccionEsperarTermino:=0
$t_transaccionEsperarTermino:=Choose:C955($l_transaccionEsperarTermino=1;"True";"False")
$h_transaccionTimeout:=?00:05:00?
$t_transaccionTimeout:=String:C10($h_transaccionTimeout;ISO time:K7:8)

  // COMPORTAMIENTO EN CASO DE FALLA
$h_reintentarEn:=?00:03:00?
$l_reintentarProximaProgramacion:=0
$t_reintentarProximaProgramacion:=Choose:C955($l_reintentarProximaProgramacion=1;"True";"False")
$t_reintentarEn:=String:C10($h_reintentarEn;ISO time:K7:8)
$l_CancelarDespuesReintentos:=3
$t_CancelarReintentos:=Choose:C955($l_CancelarDespuesReintentos>0;"True";"False")

  // OPCIONES RESTAURACION
$l_restauracionAutomatica:=1
$t_restauracionAutomatica:=Choose:C955($l_restauracionAutomatica=1;"True";"False")
$l_integracionAutomaticaLog:=1
$t_integracionAutomaticaLog:=Choose:C955($l_integracionAutomaticaLog=1;"True";"False")
$l_respaldoConModificacion:=0
$t_respaldoConModificacion:=Choose:C955($l_respaldoConModificacion=1;"True";"False")
$l_reinicioAutomatico:=1
$t_reinicioAutomatico:=Choose:C955($l_reinicioAutomatico=1;"True";"False")

  // CONSERVACION DE RESPALDOS
$l_respaldosConservados:=7
$t_conservacionRespaldos:=Choose:C955($l_respaldosConservados>0;"True";"False")
$l_borrarRespadoAntes:=0
$t_borrarRespadoAntes:=Choose:C955($l_borrarRespadoAntes=1;"True";"False")

  // COMPRESION Y SEGURIDAD
$t_tipoCompresion:="Compact"
$t_redundancia:="None"
$t_interlazado:="None"
$t_verificarArchivoRespaldo:="True"
$t_logRespaldoVerboso:="True"
$l_KbSegmentos:=0

  // OPCIONES GENERALES
$t_incluirArchivoEstructura:="False"
$t_incluirArchivoEstructuraAlt:="False"
$t_incluirArchivoDeDatos:="True"
  // destino de los respaldos
$t_rutaCarpetaRespaldos:=SYS_GetFolderNam (Data file:C490)+"Respaldos_"+<>gRolBD
  // archivos adjuntos
$t_archivoDatos:=Data file:C490
ARRAY TEXT:C222($at_ArchivosAdjuntos;0)
APPEND TO ARRAY:C911($at_ArchivosAdjuntos;Replace string:C233($t_archivoDatos;".4DD";".4DIndx"))
APPEND TO ARRAY:C911($at_ArchivosAdjuntos;Replace string:C233($t_archivoDatos;".4DD";".Match"))


  // PROGRAMACION
$t_programacion:="Daily"

  // frecuencia horaria
$l_frecuenciaHorariaCadaX:=0
$t_frecuenciaHorariaInicio:=String:C10(?00:00:00?;ISO time:K7:8)

  // frecuencia diaria
$l_FrecuenciaDiariaCadaX:=1
$t_FrecuenciaDiariaInicio:=String:C10(?02:00:00?;ISO time:K7:8)

  // frecuencia semanal
$l_frecuenciaSemanalCadaX:=1
$l_frecuenciaLunes:=0
$t_frecuenciaLunes:=Choose:C955($l_frecuenciaSemanalLunes=1;"True";"False")
$h_frecuenciaLunesHora:=?02:00:00?
$t_frecuenciaLunesHora:=String:C10($h_frecuenciaLunesHora;ISO time:K7:8)
$l_frecuenciaMartes:=0
$t_frecuenciaMartes:=Choose:C955($l_frecuenciaSemanalMartes=1;"True";"False")
$h_frecuenciaMartesHora:=?02:00:00?
$t_frecuenciaMartesHora:=String:C10($h_frecuenciaMartesHora;ISO time:K7:8)
$l_frecuenciaMiercoles:=0
$t_frecuenciaMiercoles:=Choose:C955($l_frecuenciaSemanalMiercoles=1;"True";"False")
$h_frecuenciaMiercolesHora:=?02:00:00?
$t_frecuenciaMiercolesHora:=String:C10($h_frecuenciaMiercolesHora;ISO time:K7:8)
$l_frecuenciaMiercoles:=0
$t_frecuenciaJueves:=Choose:C955($l_frecuenciaSemanalJueves=1;"True";"False")
$h_frecuenciaJuevesHora:=?02:00:00?
$t_frecuenciaJuevesHora:=String:C10($h_frecuenciaJuevesHora;ISO time:K7:8)
$l_frecuenciaJueves:=0
$t_frecuenciaViernes:=Choose:C955($l_frecuenciaSemanalViernes=1;"True";"False")
$h_frecuenciaViernesHora:=?02:00:00?
$t_frecuenciaViernesHora:=String:C10($h_frecuenciaViernesHora;ISO time:K7:8)
$l_frecuenciaViernes:=0
$t_frecuenciaSabado:=Choose:C955($l_frecuenciaSemanalSabado=1;"True";"False")
$h_frecuenciaSabadoHora:=?02:00:00?
$t_frecuenciaSabadoHora:=String:C10($h_frecuenciaSabadoHora;ISO time:K7:8)
$l_frecuenciaDomingo:=0
$t_frecuenciaDomingo:=Choose:C955($l_frecuenciaSemanalDomingo=1;"True";"False")
$h_frecuenciaDomingoHora:=?02:00:00?
$t_frecuenciaDomingoHora:=String:C10($h_frecuenciaDomingoHora;ISO time:K7:8)

  // frecuencia mensual
$l_frecuenciaMensualCada:=1
$l_frecuenciaMensualDia:=1
$h_frecuenciaMensualHora:=?02:00:00?
$t_frecuenciaMensualHora:=String:C10($h_frecuenciaMensualHora;ISO time:K7:8)


$t_nombreArchivo:=SYS_GetServerProperty (XS_DataFileFolder)
$t_nombreArchivo:=Substring:C12($t_nombreArchivo;1;Length:C16($t_nombreArchivo)-3)+"journal"
SELECT LOG FILE:C345($t_nombreArchivo)



$t_rutaPlantilla:=SYS_GetServerProperty (XS_StructureFolder)+"Config"+Folder separator:K24:12+"plantillaRespaldos.xml"
DOCUMENT TO BLOB:C525($t_rutaPlantilla;$x_blob)
PROCESS 4D TAGS:C816($x_blob;$x_blob2)


$t_texto2:=BLOB to text:C555($x_blob2;UTF8 text without length:K22:17)
$t_rutaPreferenciasBackup:=SYS_GetServerProperty (XS_StructureFolder)+"Preferences"+Folder separator:K24:12+"Backup"+Folder separator:K24:12+"testBackup.xml"
If (Test path name:C476($t_rutaPreferenciasBackup)#Is a document:K24:1)
	$h_refDocumento:=Create document:C266($t_rutaPreferenciasBackup;"TEXT")
	CLOSE DOCUMENT:C267($h_refDocumento)
End if 
BLOB TO DOCUMENT:C526($t_rutaPreferenciasBackup;$x_blob2)

