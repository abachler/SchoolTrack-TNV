//%attributes = {}
  // FTP_Upload()
  // Por: Alberto Bachler K.: 07-11-14, 20:21:07
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($5)
C_TEXT:C284($6)
C_TEXT:C284($7)
C_TEXT:C284($8)

C_BOOLEAN:C305($b_eliminarArchivo)
C_LONGINT:C283($i;$l_closeError;$l_ConnexionID;$l_error;$l_izquierda;$objectType;$l_arriba;$l_modo)
C_TEXT:C284($t_Client;$t_error;$t_fileName;$t_hostPath;$t_login;$t_notificacion;$t_Password;$t_registeredClient;$t_SourceMachine;$t_sourcePath)
C_TEXT:C284($t_URl;$t_rutaDestino)
C_BOOLEAN:C305($b_registraLogEnArray;$b_agregarVersion)  //20160123 RCH

ARRAY TEXT:C222($at_FileList;0)

$b_registraLogEnArray:=False:C215

If (False:C215)
	C_LONGINT:C283(FTP_Upload ;$1)
	C_TEXT:C284(FTP_Upload ;$2)
	C_TEXT:C284(FTP_Upload ;$3)
	C_TEXT:C284(FTP_Upload ;$4)
	C_TEXT:C284(FTP_Upload ;$5)
	C_TEXT:C284(FTP_Upload ;$6)
	C_TEXT:C284(FTP_Upload ;$7)
	C_TEXT:C284(FTP_Upload ;$8)
End if 

$l_ConnexionID:=$1
$t_hostPath:=$2
$t_sourcePath:=$3
$t_URl:=$4
$t_login:=$5
$t_Password:=$6
$t_SourceMachine:=$7
$t_registeredClient:=$8
$l_modo:=1
$b_agregarVersion:=True:C214

  //If (Count parameters=9)
If (Count parameters:C259>=9)
	$b_eliminarArchivo:=$9
End if 

If (Count parameters:C259>=10)
	$b_registraLogEnArray:=$10  //MONO TICKET 187787
End if 

If (Count parameters:C259>=11)
	$l_modo:=$11
End if 

If (Count parameters:C259>=12)
	$b_agregarVersion:=$12
End if 

  // MOD Ticket N° 196415 20180203 Patricio Aliaga
$t_fileName:=SYS_Path2FileName ($t_sourcePath)
If ($b_agregarVersion)
	  // Modificado por: Saúl Ponce (22/09/2017) Ticket 187868, añadir la versión de la BD
	$vt_version:=PREF_fGet (0;"VersionResource")
	If ($vt_version#"")
		$t_fileName:="v"+$vt_version+"_"+$t_fileName
	End if 
End if 
$t_HostPath:=$t_hostPath+"/"+$t_fileName
  // CODIGO PRINCIPAL
  //$l_error:=FTP_VerifyConexionStatus (0;$t_URl;$t_login;$t_Password;->$l_ConnexionID)
$l_error:=FTP_VerifyConexionStatus (0;$t_URl;$t_login;$t_Password;->$l_ConnexionID;$l_modo)

TRACE:C157

$objectType:=Test path name:C476($t_sourcePath)
Case of 
	: ($objectType=Is a document:K24:1)
		If ($l_error#0)
			$t_error:=IT_ErrorText ($l_error)
			  //If ($b_registraLogEnArray)
			BKP_EscribeLog ("Error: "+$t_error)
			  //Else 
			EXECUTE ON CLIENT:C651($t_registeredClient;"CD_Dlog";0;__ ("No fue posible establecer la conexión FTP debido a un error: \r\r")+"<b>"+$t_error+"</b>")
			  //End if 
		Else 
			  //If ($b_registraLogEnArray)
			BKP_EscribeLog ("Inicio subida archivo: "+SYS_Path2FileName ($t_sourcePath)+". Tamaño archivo: "+String:C10(Round:C94(Get document size:C479($t_sourcePath)/1024;2))+".")
			  //End if 
			$l_izquierda:=Screen width:C187-300
			$l_arriba:=Screen height:C188-120
			$l_error:=FTP_Progress (10;60;"Enviando: "+$t_fileName;"*";"Cancelar")
			  // MOD Ticket N° 210367 Patricio Aliaga 20180904
			  //$l_error:=FTP_Send ($l_ConnexionID;$t_sourcePath;$t_hostPath;1)
			$l_error:=CURL_SendToFTP1 ($t_sourcePath;$t_URl+$t_hostPath;$t_login;$t_Password;"Enviando: "+$t_fileName)
			Case of 
				: ($l_error=10000)
					  //If ($b_registraLogEnArray)
					$t_notificacion:="Envío cancelado por el usuario."
					BKP_EscribeLog ($t_notificacion)
					  //End if 
				: ($l_error#0)
					$t_error:=IT_ErrorText ($l_error)
					$t_notificacion:=__ ("No fue posible completar la transferencia del archivo \"^0\" debido a un error:\r\r^1")
					$t_notificacion:=Replace string:C233($t_notificacion;"^0";$t_FileName)
					$t_notificacion:=Replace string:C233($t_notificacion;"^1";$t_error)
					  //If ($b_registraLogEnArray)
					BKP_EscribeLog ($t_notificacion)
					  //Else 
					EXECUTE ON CLIENT:C651($t_registeredClient;"Notificacion_Mostrar";__ ("Envio fallido de archivo al FTP");$t_notificacion)
					  //End if 
					If ($b_eliminarArchivo)
						DELETE DOCUMENT:C159($t_sourcePath)
					End if 
				Else 
					  //OBJECT SET STYLED TEXT ATTRIBUTES($t_fileName;1;32000;Attribute bold style;1)
					$t_notificacion:=__ ("El archivo \"^0\" fue enviado al FTP.")
					$t_notificacion:=Replace string:C233($t_notificacion;"^0";$t_FileName)
					  //If ($b_registraLogEnArray)
					BKP_EscribeLog ($t_notificacion)
					  //Else 
					EXECUTE ON CLIENT:C651($t_registeredClient;"Notificacion_Mostrar";__ ("Envio de archivo al FTP");$t_notificacion)
					  //End if 
			End case 
		End if 
		
		
	: ($objectType=Is a folder:K24:2)
		  // obtengo recursivamente la ruta de todos los subdirectorios del directorio a transferir
		ARRAY TEXT:C222($at_DirectoryList;1)
		$at_DirectoryList{1}:=$t_sourcePath
		SYS_GetAllSubpaths (->$at_DirectoryList)
		
		  // obtengo la ruta de todos los archivos de todos los directorios a transferir
		SYS_DocumentList ($t_sourcePath;->$at_FileList;Client)
		
		  // replico la jerarquía de directorios a transferir
		For ($i;1;Size of array:C274($at_DirectoryList))
			  //$t_rutaDestino:=Replace string($at_DirectoryList{$i};$t_sourcePath;"")
			$t_rutaDestino:=$t_hostPath+Replace string:C233($at_DirectoryList{$i};$t_sourcePath;"")
			$t_rutaDestino:=Replace string:C233($t_rutaDestino;Folder separator:K24:12;"/")
			$l_error:=FTP_MakeDir ($l_ConnexionID;$t_rutaDestino)
			If ($l_error#0)
				CD_Dlog (0;IT_ErrorText ($l_error))
			End if 
		End for 
		
		$l_error:=FTP_Progress (100;100;"Uploading...";"*";"*")
		For ($i;1;Size of array:C274($at_FileList))
			$t_rutaDestino:=Replace string:C233($at_FileList{$i};$t_sourcePath;"")
			$t_rutaDestino:=$t_hostPath+$t_rutaDestino
			$t_rutaDestino:=Replace string:C233($t_rutaDestino;Folder separator:K24:12;"/")
			  // MOD Ticket N° 210367 Patricio Aliaga 20180904
			  //$l_error:=FTP_Send ($l_ConnexionID;$at_FileList{$i};$t_rutaDestino;1)
			$l_error:=CURL_SendToFTP1 ($at_FileList{$i};$t_URl+$t_hostPath;$t_login;$t_Password)
			If ($l_error#10000)  // Cancel by the user
				If ($l_error#0)
					ALERT:C41(IT_ErrorText ($l_error))
				End if 
			Else 
				ALERT:C41(IT_ErrorText ($l_error))
			End if 
			
		End for 
		
End case 

$l_closeError:=FTP_Logout ($l_ConnexionID)
$0:=$l_error