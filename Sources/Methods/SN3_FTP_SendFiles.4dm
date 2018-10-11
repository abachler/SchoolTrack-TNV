//%attributes = {}
  //SN3_FTP_SendFiles


C_LONGINT:C283($error)
  //declaro ID de conexion
C_LONGINT:C283($ftpConnectionID)

If (Count parameters:C259=1)
	$reTry:=$1
Else 
	$reTry:=False:C215
End if 

SN3_LoadGeneralSettings 
$t_carpetaArchivosSchoolNet:=SN3_GetFilesPath 

$currentErrorHandler:=SN3_SetErrorHandler ("set")

$ftpDirectory:="/SchoolFiles3/"
SN3_GetFilesPath 

ARRAY TEXT:C222(aLocalFiles;0)
SYS_DocumentList ($t_carpetaArchivosSchoolNet;->aLocalFiles)
If (Size of array:C274(aLocalFiles)>0)
	READ ONLY:C145([SN3_PublicationPrefs:161])
	ALL RECORDS:C47([SN3_PublicationPrefs:161])
	FIRST RECORD:C50([SN3_PublicationPrefs:161])
	If ($reTry)
		vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"Reintento de envío de archivos rezagados"
		vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"Iniciando la conexión con el servidor FTP..."+"\r"+vt_msg
	Else 
		vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"Iniciando la conexión con el servidor FTP..."
	End if 
	SN3_ConsolaEnvios ("OpenForm";->[SN3_PublicationPrefs:161];"Console";__ ("Transferencia de datos a SchoolNet"))  //20170610 ASM Ticket 176
	
	$err:=IT_GetTimeOut ($timeout)
	$tiempo:=127
	$err:=IT_SetTimeOut ($tiempo)
	$err:=IT_GetPort (1;$port)
	$err:=IT_SetPort (1;SN3_FTP_Port)
	
	$error:=FTP_Login (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$ftpConnectionID)
	If ($error=0)
		If ((Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Server:K5:6))
			SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP "+("pasiva "*SN3_FTP_Passive)+"iniciada en "+("el servidor"*SN3_SendFrom_Server)+(SN3_SendFrom_SelectedWS*SN3_SendFrom_Workstation)+".")
		Else 
			SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP "+("pasiva "*SN3_FTP_Passive)+"iniciada en esta máquina.")
		End if 
		SN3_RegisterLogEntry (SN3_Log_Info;"Conexión establecida, identificación aceptada.")
		vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"Conexión establecida, identificación aceptada."+"\r"+vt_msg
		SN3_ConsolaEnvios ("display";->[SN3_PublicationPrefs:161])
		
		$totalsize:=0
		For ($i;1;Size of array:C274(aLocalFiles))
			$filePath:=$t_carpetaArchivosSchoolNet+aLocalFiles{$i}
			If (aLocalFiles{$i}[[1]]#".")
				$totalsize:=$totalsize+Get document size:C479($filepath)
			End if 
		End for 
		
		$bytesTransfered:=0
		For ($i;1;Size of array:C274(aLocalFiles))
			$filePath:=$t_carpetaArchivosSchoolNet+aLocalFiles{$i}
			If (aLocalFiles{$i}[[1]]=".")
				DELETE DOCUMENT:C159($filePath)
			Else 
				$hostPath:=$ftpDirectory+aLocalFiles{$i}
				If (error=0)
					$docSize:=Get document size:C479($filePath)
					$m1:=Milliseconds:C459
					vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"Iniciando la transferencia de "+aLocalFiles{$i}+" ("+String:C10($docsize)+" bytes)"+"\r"+vt_msg
					SN3_ConsolaEnvios ("display";->[SN3_PublicationPrefs:161])
					$errFTP:=FTP_VerifyID ($ftpConnectionID)
					$errorString:=SN3_FTP_SendFile (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$ftpDirectory;$filePath;$hostPath;True:C214;->$ftpConnectionID;False:C215)
					$secondsStr:=String:C10((Milliseconds:C459-$m1)/1000;"#.###.###.##0,00")
					$kbps:=($docSize/1024)/((Milliseconds:C459-$m1)/1000)
					If ($errorString="")
						$bytesTransfered:=$bytesTransfered+$docSize
						vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"Transferencia de "+aLocalFiles{$i}+" terminada en "+$secondsStr+" segundos ("+String:C10(Round:C94($kbps;2))+"Kbps)"+"\r"+vt_msg
						SN3_RegisterLogEntry (SN3_Log_FileSent;"El archivo "+aLocalFiles{$i}+" ha sido transferido exitósamente.")
						
						  //20180406 RCH Se comentan las siguientes lineas porque no encuentra el lugar en donde se utiliza. Ticket 203156.
						  //If (Position("_"+String(SN3_Calificaciones);aLocalFiles{$i})#0)
						  //For ($b;1;Size of array(aNivelesCalificaciones))
						  //PREF_Set (0;"ue-"+String(aNivelesCalificaciones{$b});aDTSCalificaciones{$b})
						  //End for 
						  //End if 
						
					Else 
						vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"El archivo "+aLocalFiles{$i}+" no pudo ser transferido a causa de un error FTP "+"\r"+$errorString+"\r"+vt_msg
						SN3_RegisterLogEntry (SN3_Log_Error;"El archivo "+aLocalFiles{$i}+" no pudo ser transferido a causa de un error FTP: "+$errorString)
					End if 
					SN3_ConsolaEnvios ("display";->[SN3_PublicationPrefs:161])
				Else 
					error:=0
				End if 
			End if 
		End for 
		vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"Transferencia de archivos terminada ("+String:C10(Round:C94(($bytesTransfered/1024);2))+"Kb. transferidos)"+"\r"+vt_msg
		$error:=FTP_Logout ($ftpConnectionID)
		$err:=IT_SetPort (1;$port)
		$err:=IT_SetTimeOut ($timeout)
		  //$err:=IT_SetProxy (1;$proxyKind;$proxyHostName;$proxyPort;$proxyUserID)
		SN3_ConsolaEnvios ("display";->[SN3_PublicationPrefs:161])
		vStop:=False:C215
		SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP terminada.")
	Else 
		If ((Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Server:K5:6))
			SN3_RegisterLogEntry (SN3_Log_Error;"Conexión FTP imposible desde "+("el servidor"*SN3_SendFrom_Server)+(SN3_SendFrom_SelectedWS*SN3_SendFrom_Workstation)+" (identificación incorrecta).")
		Else 
			SN3_RegisterLogEntry (SN3_Log_Info;"Conexión FTP imposible desde esta máquina (identificación incorrecta).")
		End if 
		vt_msg:=vt_msg+"Imposible conectar con el servidor FTP..."
	End if 
	IT_WaitForTime (Current time:C178+15)
	SN3_ConsolaEnvios ("closeWindows")
Else 
	  //SN3_RegisterLogEntry (SN3_Log_Info;"No hay archivos a transferir.")
End if 
If (Not:C34($reTry))
	SYS_DocumentList ($t_carpetaArchivosSchoolNet;->aLocalFiles)
	If (Size of array:C274(aLocalFiles)>0)
		DELAY PROCESS:C323(Current process:C322;60*60*5)
		$error:=SN3_FTP_SendFiles (True:C214)
	End if 
End if 
$0:=$error
ARRAY TEXT:C222(aLocalFiles;0)
SN3_SetErrorHandler ("clear";$currentErrorHandler)