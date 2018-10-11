//%attributes = {"executedOnServer":true}
  // Método: BKP_CierraRespaldo
  // código original de: ABK (2016)
  // modificado por Alberto Bachler Klein, 16/03/18, 17:27:05
  // compresión del respaldo usando 7z
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


C_LONGINT:C283($1)
C_TEXT:C284($2)

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_bloqueado;$b_invisible)
C_DATE:C307($d_creacion;$d_fechaProximoRespaldo;$d_fechaUltimoRespaldo;$d_modificacion)
C_LONGINT:C283($l_codigoError;$l_idProceso;$l_modoAutenticacion;$l_proc;$l_puerto;$l_statusRespaldo;$l_usarSSL)
C_TIME:C306($h_creacion;$h_horaProximoRespaldo;$h_horaUltimoRespaldo;$h_modificacion)
C_TEXT:C284($t_asunto;$t_contraseña;$t_Cuerpo;$t_destinatario;$t_emailAviso;$t_error;$t_json;$t_nombreBD;$t_nombreUsuario;$t_proximoRespaldo)
C_TEXT:C284($t_remitente;$t_respaldoInicio;$t_respaldoTermino;$t_rutaBaseDeDatos;$t_rutaPreferenciasBackup;$t_rutaUltimoDiario;$t_rutaUltimoRespaldo;$t_scriptBackup;$t_servidor;$t_statusRespaldo)
C_TEXT:C284($t_textoError;$t_UUID;$t_uuidDatabase;$t_XMLrefPrefsRespaldo)


If (False:C215)
	C_LONGINT:C283(BKP_CierraRespaldo ;$1)
	C_TEXT:C284(BKP_CierraRespaldo ;$2)
End if 

$l_codigoError:=$1
$t_textoError:=$2


Case of 
	: (($l_codigoError<-2) | ($l_codigoError>0))
		If (Num:C11(PREF_fGet (0;"EnviarProximoBackup";"0"))=1)
			BKP_EscribeLog ($t_asunto+". "+$t_Cuerpo)
		End if 
		
	: ($l_codigoError=0)
		While (Semaphore:C143("CerrandoRespaldo"))
			DELAY PROCESS:C323(Current process:C322;600)
		End while 
		BKP_LogRespaldo 
		
		READ ONLY:C145([xShell_ApplicationData:45])
		ALL RECORDS:C47([xShell_ApplicationData:45])
		FIRST RECORD:C50([xShell_ApplicationData:45])
		$t_uuidDatabase:=[xShell_ApplicationData:45]UUID_database:13
		<>gRolBD:=[xShell_ApplicationData:45]ID_Organizacion:17
		$t_rutaPreferenciasBackup:=SYS_GetServer_4DFolder (Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"Backup"+Folder separator:K24:12+"backup.xml"
		vt_XMLrefPrefsRespaldo:=BKP_ParseXML 
		DOM_SetElementValueAndAttr (vt_XMLrefPrefsRespaldo;"Preferences4D/Backup/Custom/DatabaseUUID";$t_uuidDatabase;True:C214)
		DOM EXPORT TO FILE:C862(vt_XMLrefPrefsRespaldo;$t_rutaPreferenciasBackup)
		DOM CLOSE XML:C722(vt_XMLrefPrefsRespaldo)
		
		
		
		If (Test path name:C476($t_rutaPreferenciasBackup)=Is a document:K24:1)
			$t_scriptBackup:=Replace string:C233(Data file:C490;".4DD";".backup.xml")
			If (Test path name:C476($t_scriptBackup)=Is a document:K24:1)
				DELETE DOCUMENT:C159($t_scriptBackup)
			End if 
			DOCUMENT TO BLOB:C525($t_rutaPreferenciasBackup;$x_blob)
			BLOB TO DOCUMENT:C526($t_scriptBackup;$x_blob)
		End if 
		
		If (Application version:C493>="17")
			  //$b_compresionOK:=BKP_Compress7z($t_rutaUltimoRespaldo)
		Else 
			$b_compresionOK:=BKP_Compress7z_v16 ($t_rutaUltimoRespaldo)
		End if 
		
		BKP_EnviaNotificaciones ($l_codigoError;$t_error)
		
		BKPs3_SubeRespaldo 
		CLEAR SEMAPHORE:C144("CerrandoRespaldo")
End case 