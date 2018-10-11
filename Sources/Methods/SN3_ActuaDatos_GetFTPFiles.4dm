//%attributes = {}
C_LONGINT:C283($error)

$err:=IT_GetPort (1;$port)
  //$err:=IT_GetProxy (1;$proxyKind;$proxyHostName;$proxyPort;$proxyUserID)
SN3_LoadGeneralSettings 
WEB_LoadSettings 

$currentErrorHandler:=SN3_SetErrorHandler ("set")

$ftpDirectory:="/actuadatos/"+<>vtXS_CountryCode+"-"+<>gRolBD+"/"

$vt_carpeta_local:=SN3_GetFilesPath +"actuadatos"+Folder separator:K24:12
If (Test path name:C476($vt_carpeta_local)#Is a folder:K24:2)
	SYS_CreateFolder ($vt_carpeta_local)
End if 

ARRAY TEXT:C222(aLocalFiles;0)
ARRAY TEXT:C222(atFileList;0)



$err:=IT_SetPort (1;SN3_FTP_Port)
$error:=FTP_Login (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$ftpConnectionID)

If ($error=0)
	
	ARRAY DATE:C224($ad_FTP_ObjectDate;0)
	ARRAY INTEGER:C220($ai_FTP_ObjectKInd;0)
	ARRAY LONGINT:C221($al_FTP_ObjectSize;0)
	ARRAY LONGINT:C221($al_FTP_ObjectTime;0)
	ARRAY TEXT:C222($at_FTP_ObjectNames;0)
	
	$l_err:=FTP_GetDirList ($ftpConnectionID;$ftpDirectory;$at_FTP_ObjectNames;$al_FTP_ObjectSize;$ai_FTP_ObjectKInd;$ad_FTP_ObjectDate;$al_FTP_ObjectTime)
	
	For ($i;1;Size of array:C274($at_FTP_ObjectNames))
		If ($i>2)
			$error_ftp_r:=FTP_Receive ($ftpConnectionID;$ftpDirectory+$at_FTP_ObjectNames{$i};$vt_carpeta_local+$at_FTP_ObjectNames{$i};1)
			If ($error_ftp_r#0)
				LOG_RegisterEvt ("Actualización de Datos, el archivo en el ftp de SNet "+$ftpDirectory+$at_FTP_ObjectNames{$i}+", presentó el siguiente error en su descarga: "+IT_ErrorText ($error_ftp_r))
			Else 
				$error_ftp_d:=FTP_Delete ($ftpConnectionID;$ftpDirectory+$at_FTP_ObjectNames{$i})
				If ($error_ftp_d#0)
					LOG_RegisterEvt ("Actualización de Datos, la eliminación del archivo "+$ftpDirectory+$at_FTP_ObjectNames{$i}+", presentó el siguiente error : "+IT_ErrorText ($error_ftp_d))
				End if 
			End if 
		End if 
	End for 
	
	$error:=FTP_Logout ($ftpConnectionID)
	$err:=IT_SetPort (1;$port)
	  //$err:=IT_SetProxy (1;$proxyKind;$proxyHostName;$proxyPort;$proxyUserID)
	
	
End if 

