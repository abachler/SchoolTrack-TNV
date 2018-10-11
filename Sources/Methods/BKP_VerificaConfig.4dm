//%attributes = {"executedOnServer":true}
  // BKP_VerificaConfig()
  // Por: Alberto Bachler K.: 30-10-14, 06:40:34
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob;$x_blobEntrada;$x_blobSalida;$x_llavePrivada)
C_LONGINT:C283($l_abortarRespaldoTrasIntentos;$l_borrarRespaldoAntes;$l_CancelarDespuesReintentos;$l_frecuenciaMensualCada;$l_frecuenciaMensualDia;$l_frecuenciaSemanal;$l_frecuenciaSemanalCada;$l_frecuenciaSemanalDomingo;$l_frecuenciaSemanalJueves;$l_frecuenciaSemanalLunes)
C_LONGINT:C283($l_frecuenciaSemanalMartes;$l_frecuenciaSemanalMiercoles;$l_frecuenciaSemanalSabado;$l_frecuenciaSemanalViernes;$l_HLcrypt;$l_incluirArchivoDeDatos;$l_incluirEstructura;$l_incluirEstructuraAlt;$l_integracionAutomaticaLog;$l_KbSegmentos)
C_LONGINT:C283($l_logRespaldoVerboso;$l_numeroReintentos;$l_programacionDiariaCada;$l_programacionHorariaCada;$l_reinicioAutomatico;$l_reintentarEn;$l_reintentarEnUnidad;$l_reintentarProximaProgramacion;$l_respaldoConModificacion;$l_respaldosConservados)
C_LONGINT:C283($l_restauracionAutomatica;$l_transaccionEsperarTermino;$l_verificarArchivoRespaldo)
C_TIME:C306($h_frecuenciaDomingoHora;$h_frecuenciaJuevesHora;$h_frecuenciaLunesHora;$h_frecuenciaMartesHora;$h_frecuenciaMensualHora;$h_frecuenciaMiercolesHora;$h_frecuenciaSabadoHora;$h_frecuenciaViernesHora;$h_programacionDiariaInicio;$h_programacionHorariaInicio)
C_TIME:C306($h_refDoc;$h_reintentarEn;$h_reintentarEnValor;$h_reintentarTiempo;$h_tiempoReintento;$h_timeoutEsperaTransaccion;$h_transaccionTimeout)
C_TEXT:C284($t_archivoIndex;$t_backupPlan;$t_borrarRespadoAntes;$t_borrarRespaldoAntes;$t_CancelarReintentos;$t_conservacionRespaldos;$t_contraseñaVolumenRemoto;$t_FrecuenciaDiariaInicio;$t_frecuenciaDomingo;$t_frecuenciaDomingoHora)
C_TEXT:C284($t_frecuenciaHorariaInicio;$t_frecuenciaJueves;$t_frecuenciaJuevesHora;$t_frecuenciaLunes;$t_frecuenciaLunesHora;$t_frecuenciaMartes;$t_frecuenciaMartesHora;$t_frecuenciaMiercoles;$t_frecuenciaMiercolesHora;$t_frecuenciaSabado)
C_TEXT:C284($t_frecuenciaSabadoHora;$t_frecuenciaViernes;$t_frecuenciaViernesHora;$t_incluirArchivoDeDatos;$t_incluirArchivoEstructuraAlt;$t_incluirEstructura;$t_integracionAutomaticaLog;$t_interlazado;$t_json;$t_llavePrivada)
C_TEXT:C284($t_logRespaldoVerboso;$t_metodoOnError;$t_programacion;$t_redundancia;$t_refDoc;$t_refjSon;$t_reinicioAutomatico;$t_reintentarEn;$t_reintentarEnValor;$t_reintentarProximaProgramacion)
C_TEXT:C284($t_respaldarArchivoDatos;$t_respaldoConModificacion;$t_restauracionAutomatica;$t_rutaBD;$t_rutaCarpetaPrefBackup;$t_rutaCarpetaRespaldos;$t_rutaPlanBackup;$t_rutaPlantilla;$t_rutaPrefComplementos;$t_rutaPreferenciasBackup)
C_TEXT:C284($t_rutaPrefsRespaldo;$t_scriptBackup;$t_tipoCompresion;$t_transaccionEsperarTermino;$t_transaccionTimeout;$t_uriVolumenRemoto;$t_uuidDatabase;$t_verificacionDuranteRespaldo;$t_verificarArchivoRespaldo;$t_XMLrefPrefsRespaldo)

ARRAY TEXT:C222($at_ArchivosAdjuntos;0)

If (Application type:C494#4D Remote mode:K5:5)
	If (Not:C34(CIM_esBaseDeDatosNueva ))
		READ ONLY:C145([xShell_ApplicationData:45])
		ALL RECORDS:C47([xShell_ApplicationData:45])
		FIRST RECORD:C50([xShell_ApplicationData:45])
		$t_uuidDatabase:=[xShell_ApplicationData:45]UUID_database:13
		<>gRolBD:=[xShell_ApplicationData:45]ID_Organizacion:17
		
		
		  // leo las preferencias de respaldo para esta base de datos
		$t_backupPlan:=BKP_LeePlanBackup ($t_uuidDatabase)
		
		
		  // verifico que la carpeta Preferences/Backup exista en la carpeta de la aplicación. Si no existe se crea
		$t_rutaCarpetaPrefBackup:=SYS_GetServer_4DFolder (Database folder:K5:14)+"Preferences"+SYS_FolderDelimiterOnServer +"Backup"
		If (Test path name:C476($t_rutaCarpetaPrefBackup)#Is a folder:K24:2)
			SYS_CreaCarpetaServidor ($t_rutaCarpetaPrefBackup)
		End if 
		
		  // si el documento de preferencias de respaldo "backup.xml" no existe busco el documento de respaldo junto a la BD
		  // si el documento de respaldo existe lo copio a la carpeta preferences/backup/
		$t_rutaPreferenciasBackup:=SYS_GetServer_4DFolder (Database folder:K5:14)+"Preferences"+SYS_FolderDelimiterOnServer +"Backup"+SYS_FolderDelimiterOnServer +"backup.xml"
		If (Test path name:C476($t_rutaPreferenciasBackup)#Is a document:K24:1)
			$t_scriptBackup:=Replace string:C233(Data file:C490;".4DD";".backup.xml")
			If (Test path name:C476($t_scriptBackup)=Is a document:K24:1)
				$t_XMLrefPrefsRespaldoBD:=DOM Parse XML source:C719($t_scriptBackup)
				$t_ultimoRespaldoEnSet:=DOM_GetValue ($t_XMLrefPrefsRespaldoBD;"Preferences4D/Backup/DataBase/CurrentBackupSet/Item1")
				DOM EXPORT TO FILE:C862($t_XMLrefPrefsRespaldoBD;$t_rutaPreferenciasBackup)
			End if 
		End if 
		
		  // leo el nombre y el uuid de la base de datos para asegurarme que corresponda a la bd actual
		If (Test path name:C476($t_rutaPreferenciasBackup)=Is a document:K24:1)
			error:=0
			$t_metodoOnError:=Method called on error:C704
			ON ERR CALL:C155("ERR_EventoError")
			If (error=0)
				$t_XMLrefPrefsRespaldo:=DOM Parse XML source:C719($t_rutaPreferenciasBackup)
				$t_rutaBD:=DOM_GetValue ($t_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/DatabaseName/Item1")
				vt_uuidDatabase:=DOM_GetValue ($t_XMLrefPrefsRespaldo;"Preferences4D/Backup/Custom/DatabaseUUID")
			End if 
			ON ERR CALL:C155($t_metodoOnError)
		End if 
		
		  // si el uuid o el nombre de la de la base de datos en el documento backup.xml no existe busco el documento de respaldo junto a la BD
		  // si existe lo copio a la carpeta preferences/backup/
		If (Test path name:C476($t_rutaPreferenciasBackup)=Is a document:K24:1)
			If ((vt_uuidDatabase#$t_uuidDatabase) | ($t_rutaBD#Data file:C490))
				DELETE DOCUMENT:C159($t_rutaPreferenciasBackup)
				$t_scriptBackup:=Replace string:C233(Data file:C490;".4DD";".backup.xml")
				If (Test path name:C476($t_scriptBackup)=Is a document:K24:1)
					DOCUMENT TO BLOB:C525($t_scriptBackup;$x_blob)
					BLOB TO DOCUMENT:C526($t_rutaPreferenciasBackup;$x_blob)
					$t_metodoOnError:=Method called on error:C704
					ON ERR CALL:C155("ERR_EventoError")
					If (error=0)
						$t_XMLrefPrefsRespaldo:=DOM Parse XML source:C719($t_rutaPreferenciasBackup)
						$t_rutaBD:=DOM_GetValue ($t_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/DatabaseName/Item1")
						vt_uuidDatabase:=DOM_GetValue ($t_XMLrefPrefsRespaldo;"Preferences4D/Backup/Custom/DatabaseUUID")
					End if 
					ON ERR CALL:C155($t_metodoOnError)
				Else 
					$t_backupPlan:=""
				End if 
			End if 
		Else 
			$t_backupPlan:=""
		End if 
		
		
		  // si la ruta de la BD es distinto a la ruta de la BD en el documento de preferencias de respaldo Backup.xml
		  // (es posible que se haya abierto otra bd o se haya modificado el nombre)
		$t_backupPlan:=BKP_LeePlanBackup ($t_uuidDatabase)
		
		If ($t_backupPlan="")
			  // si no hay un plan de respaldos almacenado se crea el plan con la configuración por defecto
			
			  // CONFIGURACION POR DEFECTO
			  // opciones no disponibles en configuración por parte del usuario
			$l_transaccionEsperarTermino:=0
			$h_transaccionTimeout:=?00:05:00?
			$t_transaccionEsperarTermino:=Choose:C955($l_transaccionEsperarTermino=1;"True";"False")
			
			
			$l_restauracionAutomatica:=1
			$t_restauracionAutomatica:=Choose:C955($l_restauracionAutomatica=1;"True";"False")
			$l_integracionAutomaticaLog:=1
			$t_integracionAutomaticaLog:=Choose:C955($l_integracionAutomaticaLog=1;"True";"False")
			$l_respaldoConModificacion:=1
			$t_respaldoConModificacion:=Choose:C955($l_respaldoConModificacion=1;"True";"False")
			$l_reinicioAutomatico:=1
			$t_reinicioAutomatico:=Choose:C955($l_reinicioAutomatico=1;"True";"False")
			
			If (Log file:C928="")
				$t_nombreArchivo:=Data file:C490
				$t_nombreArchivo:=Substring:C12($t_nombreArchivo;1;Length:C16($t_nombreArchivo)-3)+"journal"
				SELECT LOG FILE:C345($t_nombreArchivo)
				BACKUP:C887
			End if 
			
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
			
			
			  // ubicacion del respaldo
			$t_rutaCarpetaRespaldos:=SYS_GetFolderNam (Data file:C490)+"Respaldos_"+<>gRolBD+Folder separator:K24:12
			$t_uriVolumenRemoto:=""
			$t_contraseñaVolumenRemoto:=""
			
			  // programacion horaria
			$l_programacionHorariaCada:=12
			$h_programacionHorariaInicio:=?00:07:00?
			
			  // programacion diaria
			$l_programacionDiariaCada:=1
			$h_programacionDiariaInicio:=?02:00:00?
			
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
			
			READ ONLY:C145([xShell_ApplicationData:45])
			ALL RECORDS:C47([xShell_ApplicationData:45])
			FIRST RECORD:C50([xShell_ApplicationData:45])
			$t_uuidDatabase:=[xShell_ApplicationData:45]UUID_database:13
			$t_rolBD:=[xShell_ApplicationData:45]ID_Organizacion:17
			$t_nombreInstitucion:=[xShell_ApplicationData:45]Razon_Social:21
			$t_nombreBD:=SYS_GetServerProperty (XS_DataFileName)
			
			
			$ob_raiz:=OB_Create 
			
			OB_SET ($ob_raiz;->$t_nombreInstitucion;"nombreInstitucion")
			OB_SET ($ob_raiz;->$t_rolBD;"rolBaseDeDatos")
			OB_SET ($ob_raiz;->$t_uuidDatabase;"uuidBD")
			OB_SET ($ob_raiz;->$t_nombreBD;"nombreBD")
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
			If (Test path name:C476($t_rutaCarpetaRespaldos)#Is a folder:K24:2)
				$t_rutaCarpetaRespaldos:=SYS_GetFolderNam (Data file:C490)+"Respaldos_"+<>gRolBD+SYS_FolderDelimiterOnServer 
				OB_SET ($ob_raiz;->$t_rutaCarpetaRespaldos;"BKP_rutaCarpetaRespaldos")
			End if 
			
		Else 
			  // Si el plan existe se hace el parsing del json y se elimina el arreglo con los archivos a respaldar
			  // ya que el nombre de la base de datos puede haber cambiado
			$ob_raiz:=OB_JsonToObject ($t_backupPlan)
		End if 
		
		
		
		  // El nombre del archivo de base de datos podría haber sido modificado
		  // Se elimina el arreglo con los archivos a respaldar y se actualiza con los que corresponden al nombre de la BD actual
		  // ya que el nombre de la base de datos puede haber cambiado
		OB_Remove ($ob_raiz;"BKP_rutaArchivosAdjuntos")
		AT_Initialize (->$at_ArchivosAdjuntos)
		APPEND TO ARRAY:C911($at_ArchivosAdjuntos;SYS_GetServerProperty (XS_DataFileFolder)+Replace string:C233(SYS_GetServerProperty (XS_DataFileName);".4DD";".4DIndx"))
		APPEND TO ARRAY:C911($at_ArchivosAdjuntos;SYS_GetServerProperty (XS_DataFileFolder)+Replace string:C233(SYS_GetServerProperty (XS_DataFileName);".4DD";".Match"))
		APPEND TO ARRAY:C911($at_ArchivosAdjuntos;SYS_GetServerProperty (XS_DataFileFolder)+Replace string:C233(SYS_GetServerProperty (XS_DataFileName);".4DD";".count"))
		APPEND TO ARRAY:C911($at_ArchivosAdjuntos;Replace string:C233(Data file:C490;".4DD";".backup.xml"))
		OB_SET ($ob_raiz;->$at_ArchivosAdjuntos;"BKP_rutaArchivosAdjuntos")
		
		  // la carpeta de respaldo puede haber sido removida o la base de datos cambiada de lugar
		If (Test path name:C476($t_rutaCarpetaRespaldos)#Is a folder:K24:2)
			$t_rutaCarpetaRespaldos:=SYS_GetFolderNam (Data file:C490)+"Respaldos_"+<>gRolBD+Folder separator:K24:12
			SYS_CreaCarpetaServidor ($t_rutaCarpetaRespaldos)
			OB_SET ($ob_raiz;->$t_rutaCarpetaRespaldos;"BKP_rutaCarpetaRespaldos")
		End if 
		
		$t_json:=OB_Object2Json ($ob_raiz;True:C214)
		
		
		If (($t_json#$t_backupPlan) | ($t_rutaBD#Data file:C490))
			If ($t_rutaBD#Data file:C490)
				$t_scriptBackup:=Replace string:C233(Data file:C490;".4DD";".backup.xml")
				If (Test path name:C476($t_scriptBackup)=Is a document:K24:1)
					If (Test path name:C476($t_rutaPreferenciasBackup)=Is a document:K24:1)
						DELETE DOCUMENT:C159($t_rutaPreferenciasBackup)
					End if 
					DOCUMENT TO BLOB:C525($t_scriptBackup;$x_blob)
					BLOB TO DOCUMENT:C526($t_rutaPreferenciasBackup;$x_blob)
				End if 
			End if 
			
			$t_rutaCarpetaPrefBackup:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+SYS_FolderDelimiterOnServer +"Backup"+SYS_FolderDelimiterOnServer 
			If (Test path name:C476($t_rutaCarpetaPrefBackup)#Is a folder:K24:2)
				SYS_CreaCarpetaServidor ($t_rutaCarpetaPrefBackup)
			End if 
			
			BKP_GuardaPlanBackup ($t_uuidDatabase;$t_json)
			BKP_ActualizaScriptBackup 
		End if 
		
	End if 
End if 


