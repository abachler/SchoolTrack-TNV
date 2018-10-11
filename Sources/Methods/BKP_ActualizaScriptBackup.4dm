//%attributes = {"executedOnServer":true}
  // Método: BKP_ActualizaScriptBackup
  // código original de: ABK (2014)
  // modificado por Alberto Bachler Klein, 16/03/18, 18:19:46
  // limpieza,
  // tipo de compresión forzado a "None"
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––



C_BLOB:C604($x_blob;$x_blob2)
C_TEXT:C284($t_docProcesado;$t_json;$t_metodoOnError;$t_plantilla;$t_rutaBD;$t_rutaPlanBackup;$t_rutaPreferenciasBackup;$t_scriptBackup)
C_OBJECT:C1216($ob_objeto)

C_BOOLEAN:C305(vb_archivoExiste;vb_esVolumenRemoto)
C_LONGINT:C283(vl_borrarRespaldoAntes;vl_CancelarDespuesReintentos;vl_frecuenciaMensualCada;vl_frecuenciaMensualDia;vl_frecuenciaSemanal;vl_frecuenciaSemanalDomingo;vl_frecuenciaSemanalJueves;vl_frecuenciaSemanalLunes;vl_frecuenciaSemanalMartes;vl_frecuenciaSemanalMiercoles)
C_LONGINT:C283(vl_frecuenciaSemanalSabado;vl_frecuenciaSemanalViernes;vl_HLcrypt;vl_incluirArchivoDeDatos;vl_incluirEstructura;vl_incluirEstructuraAlt;vl_integracionAutomaticaLog;vl_itemsRespaldo;vl_KbSegmentos;vl_logRespaldoVerboso)
C_LONGINT:C283(vl_programacionDiariaCada;vl_programacionHorariaCada;vl_reinicioAutomatico;vl_reintentarEn;vl_reintentarEnUnidad;vl_reintentarProxima;vl_reintentarSiguiente;vl_respaldoConModificacion;vl_respaldosConservados;vl_restauracionAutomatica)
C_LONGINT:C283(vl_tallaSegmentos;vl_transaccionEsperarTermino;vl_verificarArchivoRespaldo)
C_TIME:C306(vh_frecuenciaDomingoHora;vh_frecuenciaJuevesHora;vh_frecuenciaLunesHora;vh_frecuenciaMartesHora;vh_frecuenciaMiercolesHora;vh_frecuenciaSabadoHora;vh_frecuenciaViernesHora;vh_programacionDiariaInicio;vh_programacionHorariaInicio;vh_ref)
C_TIME:C306(vh_refDocumento;vh_reintentarEnValor;vh_reintentarTiempo;vh_transaccionTimeout)
C_TEXT:C284(vt_abortarReintentos;vt_borrarRespaldoAntes;vt_conservacionRespaldos;vt_contraseñaVolumenRemoto;vt_fechaUltimoRespaldo;vt_frecuenciaDomingoHora;vt_frecuenciaJuevesHora;vt_frecuenciaLunesHora;vt_frecuenciaMartesHora;vt_frecuenciaMensualHora)
C_TEXT:C284(vt_frecuenciaMiercolesHora;vt_frecuenciaSabadoHora;vt_frecuenciaViernesHora;vt_horaUltimoRespaldo;vt_incluirArchivoDeDatos;vt_incluirArchivoEstructuraAlt;vt_incluirEstructura;vt_integracionAutomaticaLog;vt_interlazado;vt_json)
C_TEXT:C284(vt_json1;vt_llavePublica;vt_logRespaldoVerboso;vt_metodoOnError;vt_numeroUltimoRespaldo;vt_programacion;vt_programacionDiariaInicio;vt_programacionHorariaInicio;vt_redundancia;vt_refjSon)
C_TEXT:C284(vt_reinicioAutomatico;vt_reintentarEnValor;vt_reintentarProxima;vt_respaldarDomingo;vt_respaldarJueves;vt_respaldarLunes;vt_respaldarMartes;vt_respaldarMiercoles;vt_respaldarSabado;vt_respaldarViernes)
C_TEXT:C284(vt_respaldoConModificacion;vt_restauracionAutomatica;vt_rutaBD;vt_rutaCarpetaPreferencias;vt_rutaCarpetaRespaldos;vt_rutaLog;vt_rutaPlantilla;vt_rutaPrefComplementos;vt_rutaUltimoRespaldo)
C_TEXT:C284(vt_texto2;vt_tipoCompresion;vt_transaccionEsperarTermino;vt_transaccionTimeout;vt_uriVolumenRemoto;vt_verificarArchivoRespaldo;vt_XMLrefPrefsRespaldo)

ARRAY TEXT:C222(at_ArchivosAdjuntos;0)

READ ONLY:C145([xShell_ApplicationData:45])
ALL RECORDS:C47([xShell_ApplicationData:45])
FIRST RECORD:C50([xShell_ApplicationData:45])
vt_uuidDatabase:=[xShell_ApplicationData:45]UUID_database:13
$t_rutaPlanBackup:=SYS_GetServerProperty (XS_StructureFolder)+"Preferences"+Folder separator:K24:12+"Backup"+Folder separator:K24:12+"BackupPlan-"+vt_uuidDatabase+".json"
If (Test path name:C476($t_rutaPlanBackup)=Is a document:K24:1)
	$t_json:=Document to text:C1236($t_rutaPlanBackup;"UTF-8")
	$ob_objeto:=OB_JsonToObject ($t_json)
End if 


OB_GET ($ob_objeto;->vl_transaccionEsperarTermino;"BKP_transaccionEsperarTermino")
OB_GET ($ob_objeto;->vh_transaccionTimeout;"BKP_transaccionTimeout")
OB_GET ($ob_objeto;->vl_reintentarProxima;"BKP_reintentarSiguiente")
OB_GET ($ob_objeto;->vl_CancelarDespuesReintentos;"BKP_respaldosAbortarTras")
OB_GET ($ob_objeto;->vl_reintentarEn;"BKP_reintentarEn")
OB_GET ($ob_objeto;->vl_reintentarEnUnidad;"BKP_reintentarEnUnidad")
OB_GET ($ob_objeto;->vh_reintentarTiempo;"BKP_tiempoReintento")
OB_GET ($ob_objeto;->vl_restauracionAutomatica;"BKP_restauracionAutomatica")
OB_GET ($ob_objeto;->vl_integracionAutomaticaLog;"BKP_integracionAutomaticaLog")
OB_GET ($ob_objeto;->vl_respaldoConModificacion;"BKP_respaldoSoloConModificacion")
OB_GET ($ob_objeto;->vl_reinicioAutomatico;"BKP_ReinicioAutomatico")
OB_GET ($ob_objeto;->vl_respaldosConservados;"BKP_Respaldos_aConservar")
OB_GET ($ob_objeto;->vl_borrarRespaldoAntes;"BKP_borrarRespaldoAntes")
OB_GET ($ob_objeto;->vl_incluirArchivoDeDatos;"BKP_incluirArchivoDeDatos")
OB_GET ($ob_objeto;->vl_incluirEstructura;"BKP_incluirEstructura")
OB_GET ($ob_objeto;->vl_incluirEstructuraAlt;"BKP_incluirEstructuraUsuario")
OB_GET ($ob_objeto;->at_ArchivosAdjuntos;"BKP_rutaArchivosAdjuntos")
OB_GET ($ob_objeto;->vt_rutaCarpetaRespaldos;"BKP_rutaCarpetaRespaldos")
OB_GET ($ob_objeto;->vt_tipoCompresion;"BKP_modoCompresion")
OB_GET ($ob_objeto;->vt_programacion;"BKP_programacion")
OB_GET ($ob_objeto;->vl_programacionHorariaCada;"BKP_frecuenciaHorariaCada")
OB_GET ($ob_objeto;->vh_programacionHorariaInicio;"BKP_frecuenciaHorariaInicio")
OB_GET ($ob_objeto;->vl_programacionDiariaCada;"BKP_frecuenciaDiariaCada")
OB_GET ($ob_objeto;->vh_programacionDiariaInicio;"BKP_frecuenciaDiariaInicio")
OB_GET ($ob_objeto;->vl_frecuenciaSemanal;"BKP_frecuenciaSemanalCada")
OB_GET ($ob_objeto;->vl_frecuenciaSemanalLunes;"BKP_SemanalLunes")
OB_GET ($ob_objeto;->vl_frecuenciaSemanalMartes;"BKP_SemanalMartes")
OB_GET ($ob_objeto;->vl_frecuenciaSemanalMiercoles;"BKP_SemanalMiercoles")
OB_GET ($ob_objeto;->vl_frecuenciaSemanalJueves;"BKP_SemanalJueves")
OB_GET ($ob_objeto;->vl_frecuenciaSemanalViernes;"BKP_SemanalViernes")
OB_GET ($ob_objeto;->vl_frecuenciaSemanalSabado;"BKP_SemanalSabado")
OB_GET ($ob_objeto;->vl_frecuenciaSemanalDomingo;"BKP_SemanalDomingo")
OB_GET ($ob_objeto;->vh_frecuenciaLunesHora;"BKP_SemanalInicioLunes")
OB_GET ($ob_objeto;->vh_frecuenciaMartesHora;"BKP_SemanalInicioMartes")
OB_GET ($ob_objeto;->vh_frecuenciaMiercolesHora;"BKP_SemanalInicioMiercoles")
OB_GET ($ob_objeto;->vh_frecuenciaJuevesHora;"BKP_SemanalInicioJueves")
OB_GET ($ob_objeto;->vh_frecuenciaViernesHora;"BKP_SemanalInicioViernes")
OB_GET ($ob_objeto;->vh_frecuenciaSabadoHora;"BKP_SemanalInicioSabado")
OB_GET ($ob_objeto;->vh_frecuenciaDomingoHora;"BKP_SemanalInicioDomingo")
OB_GET ($ob_objeto;->vl_verificarArchivoRespaldo;"BKP_verificarArchivoRespaldo")
OB_GET ($ob_objeto;->vl_logRespaldoVerboso;"BKP_logRespaldoDetallado")
OB_GET ($ob_objeto;->vt_redundancia;"BKP_redundancia")
OB_GET ($ob_objeto;->vt_interlazado;"BKP_interlazado")
OB_GET ($ob_objeto;->vl_tallaSegmentos;"BKP_tallaSegmentos")
OB_GET ($ob_objeto;->vl_reintentarSiguiente;"BKP_reintentarSiguiente")
OB_GET ($ob_objeto;->vl_reintentarEn;"BKP_reintentarEn")
OB_GET ($ob_objeto;->vl_reintentarEn;"BKP_emailAviso")


vt_transaccionEsperarTermino:=Choose:C955(vl_transaccionEsperarTermino=1;"True";"False")
vt_transaccionTimeout:=String:C10(vh_transaccionTimeout;ISO time:K7:8)

vt_reintentarProxima:=Choose:C955(vl_reintentarProxima=1;"True";"False")
vt_reintentarEnValor:=String:C10(vh_reintentarTiempo;ISO time:K7:8)
vt_abortarReintentos:=Choose:C955(vl_CancelarDespuesReintentos>0;"True";"False")

vt_restauracionAutomatica:=Choose:C955(vl_restauracionAutomatica=1;"True";"False")
vt_integracionAutomaticaLog:=Choose:C955(vl_integracionAutomaticaLog=1;"True";"False")
vt_reinicioAutomatico:=Choose:C955(vl_reinicioAutomatico=1;"True";"False")
vt_respaldoConModificacion:=Choose:C955(vl_respaldoConModificacion=1;"True";"False")

vt_conservacionRespaldos:=Choose:C955(vl_respaldosConservados>1;"True";"False")

vt_tipoCompresion:="None"

vt_redundancia:="False"
vt_interlazado:="False"
vl_KbSegmentos:=0

vt_borrarRespaldoAntes:=Choose:C955(vl_borrarRespaldoAntes=1;"True";"False")
vt_verificarArchivoRespaldo:="True"
vt_logRespaldoVerboso:="True"

vt_incluirEstructura:="False"
vt_incluirArchivoDeDatos:="True"
vt_incluirArchivoEstructuraAlt:="False"

vt_programacionHorariaInicio:=String:C10(vh_programacionHorariaInicio;ISO time:K7:8)
vt_programacionDiariaInicio:=String:C10(vh_programacionDiariaInicio;ISO time:K7:8)

vt_respaldarLunes:=Choose:C955(vl_frecuenciaSemanalLunes=1;"True";"False")
vt_respaldarMartes:=Choose:C955(vl_frecuenciaSemanalMartes=1;"True";"False")
vt_respaldarMiercoles:=Choose:C955(vl_frecuenciaSemanalMiercoles=1;"True";"False")
vt_respaldarJueves:=Choose:C955(vl_frecuenciaSemanalJueves=1;"True";"False")
vt_respaldarViernes:=Choose:C955(vl_frecuenciaSemanalViernes=1;"True";"False")
vt_respaldarSabado:=Choose:C955(vl_frecuenciaSemanalSabado=1;"True";"False")
vt_respaldarDomingo:=Choose:C955(vl_frecuenciaSemanalDomingo=1;"True";"False")

vt_frecuenciaLunesHora:=String:C10(vh_frecuenciaLunesHora;ISO time:K7:8)
vt_frecuenciaMartesHora:=String:C10(vh_frecuenciaMartesHora;ISO time:K7:8)
vt_frecuenciaMiercolesHora:=String:C10(vh_frecuenciaMiercolesHora;ISO time:K7:8)
vt_frecuenciaJuevesHora:=String:C10(vh_frecuenciaJuevesHora;ISO time:K7:8)
vt_frecuenciaViernesHora:=String:C10(vh_frecuenciaViernesHora;ISO time:K7:8)
vt_frecuenciaSabadoHora:=String:C10(vh_frecuenciaSabadoHora;ISO time:K7:8)
vt_frecuenciaDomingoHora:=String:C10(vh_frecuenciaDomingoHora;ISO time:K7:8)

vl_frecuenciaMensualCada:=1
vt_frecuenciaMensualHora:="0000-00-00T00:00:00"
vl_frecuenciaMensualDia:=1

vl_itemsRespaldo:=Size of array:C274(at_ArchivosAdjuntos)

  // leo el documento actual para obtener informacion sobre el ultimo respaldo
vt_rutaCarpetaPreferencias:=SYS_GetServerProperty (XS_StructureFolder)+"Preferences"+Folder separator:K24:12+"Backup"
SYS_CreaCarpeta (vt_rutaCarpetaPreferencias)

$t_rutaPreferenciasBackup:=vt_rutaCarpetaPreferencias+Folder separator:K24:12+"Backup.xml"
If (Test path name:C476($t_rutaPreferenciasBackup)=Is a document:K24:1)
	error:=0
	$t_metodoOnError:=Method called on error:C704
	ON ERR CALL:C155("ERR_EventoError")
	vt_XMLrefPrefsRespaldo:=BKP_ParseXML 
	If ((error=0) & (vt_XMLrefPrefsRespaldo#""))
		vt_rutaBD:=DOM_GetValue (vt_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/DatabaseName/Item1")
		If (vt_rutaBD="")
			vt_rutaBD:=Data file:C490
			DOM_SetElementValueAndAttr (vt_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/DatabaseName/Item1";vt_rutaBD;True:C214)
			DOM EXPORT TO FILE:C862(vt_XMLrefPrefsRespaldo;$t_rutaPreferenciasBackup)
			DOM CLOSE XML:C722(vt_XMLrefPrefsRespaldo)
			vt_XMLrefPrefsRespaldo:=BKP_ParseXML 
		End if 
		
		If (vt_rutaBD=Data file:C490)
			  // si el script de respaldo corresponde a la misma base de datos se conserva la información del último respaldo
			vt_rutaUltimoRespaldo:=DOM_GetValue (vt_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/LastBackupPath/Item1")
			vt_rutaLog:=DOM_GetValue (vt_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/LastBackupLogPath/Item1")
			vt_numeroUltimoRespaldo:=String:C10(DOM_GetValue (vt_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/CurrentBackupSet/Item1"))
			vt_fechaUltimoRespaldo:=DOM_GetValue (vt_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/LastBackupDate/Item1")
			vt_horaUltimoRespaldo:=DOM_GetValue (vt_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/LastBackupTime/Item1")
			
		Else 
			vt_rutaUltimoRespaldo:=""
			vt_rutaLog:=""
			vt_numeroUltimoRespaldo:=""
			vt_fechaUltimoRespaldo:=""
			vt_horaUltimoRespaldo:=""
			vt_rutaBD:=""
		End if 
		DOM CLOSE XML:C722(vt_XMLrefPrefsRespaldo)
	Else 
		vt_rutaUltimoRespaldo:=""
		vt_rutaLog:=""
		vt_numeroUltimoRespaldo:=""
		vt_fechaUltimoRespaldo:=""
		vt_horaUltimoRespaldo:=""
		vt_rutaBD:=""
	End if 
	ON ERR CALL:C155($t_metodoOnError)
	
	
Else 
	vt_rutaUltimoRespaldo:=""
	vt_rutaLog:=""
	vt_numeroUltimoRespaldo:=""
	vt_fechaUltimoRespaldo:=""
	vt_horaUltimoRespaldo:=""
	vt_rutaBD:=""
End if 


  //Si no se ha designado una carpeta de respaldos o no existe creamos la carpeta por defecto
READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])
<>gCustom:=[Colegio:31]Nombre_Colegio:1
<>gRolBD:=[Colegio:31]Rol Base Datos:9
If (Test path name:C476(vt_rutaCarpetaRespaldos)#Is a folder:K24:2)
	vt_rutaCarpetaRespaldos:=SYS_GetFolderNam (Data file:C490)+"Respaldos_"+<>gRolBD
	SYS_CreaCarpetaServidor (vt_rutaCarpetaRespaldos)
End if 


vt_rutaPlantilla:=SYS_GetServerProperty (XS_StructureFolder)+"Config"+Folder separator:K24:12+"4DtagsBackup.xml"
DOCUMENT TO BLOB:C525(vt_rutaPlantilla;$x_blob)
$t_plantilla:=BLOB to text:C555($x_blob;UTF8 text without length:K22:17)
PROCESS 4D TAGS:C816($t_plantilla;$t_docProcesado)
$t_rutaPreferenciasBackup:=SYS_GetServerProperty (XS_StructureFolder)+"Preferences"+Folder separator:K24:12+"Backup"+Folder separator:K24:12+"Backup.xml"
TEXT TO BLOB:C554($t_docProcesado;$x_blob2;UTF8 text without length:K22:17)
BLOB TO DOCUMENT:C526($t_rutaPreferenciasBackup;$x_blob2)


vt_XMLrefPrefsRespaldo:=BKP_ParseXML 
$t_rutaBD:=DOM_GetValue (vt_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/DatabaseName/Item1")
If ($t_rutaBD="")
	$t_rutaBD:=Data file:C490
	DOM_SetElementValueAndAttr (vt_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/DatabaseName/Item1";$t_rutaBD;True:C214)
	DOM EXPORT TO FILE:C862(vt_XMLrefPrefsRespaldo;$t_rutaPreferenciasBackup)
End if 
DOM CLOSE XML:C722(vt_XMLrefPrefsRespaldo)



If (Test path name:C476($t_rutaPreferenciasBackup)=Is a document:K24:1)
	$t_scriptBackup:=Replace string:C233(Data file:C490;".4DD";".backup.xml")
	If (Test path name:C476($t_scriptBackup)=Is a document:K24:1)
		DELETE DOCUMENT:C159($t_scriptBackup)
	End if 
	COPY DOCUMENT:C541($t_rutaPreferenciasBackup;$t_scriptBackup)
End if 