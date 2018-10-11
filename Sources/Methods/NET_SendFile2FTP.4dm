//%attributes = {}
  //NET_SendFile2FTP

C_TEXT:C284($errorString;$serverAddress;$login;$password;$filePath;$ftpDirectory;$hostPath;$0;$1;$2;$3;$6;$7;$8)
C_BOOLEAN:C305($9;$deleteOriginal)
C_LONGINT:C283($4;$5;$10;$ftpConnectionID)
ARRAY TEXT:C222($directoryList;0)
ARRAY LONGINT:C221($objectSizes;0)
ARRAY INTEGER:C220($objectKind;0)
ARRAY DATE:C224($objectModDate;0)
C_LONGINT:C283($error)
$crlf:="\r"+Char:C90(10)


$ftpConnectionID:=0
$serverAddress:=$1
$login:=$2
$password:=$3
$ftpPort:=$4
$ftpPassive:=$5
$ftpDirectory:=$6
$filePath:=$7
$hostPath:=$8
$InitiateConexion:=False:C215
$deleteOriginal:=False:C215
Case of 
	: (Count parameters:C259=10)
		$deleteOriginal:=$9
		$ftpConnectionID:=$10
		$InitiateConexion:=($ftpConnectionID=0)
	: (Count parameters:C259>=9)
		$deleteOriginal:=$9
End case 

$fileShortname:=SYS_LongName2Filepath ($filePath)
TRACE:C157
If ($InitiateConexion)
	  //If ((<>vt_SNT_Proxy_Host#"") & (<>vl_SNT_Proxy_ServerPort#0))
	  //$err:=IT_SetProxy (1;<>vl_SNT_Proxy_IsSocks;<>vt_SNT_Proxy_Host;<>vl_SNT_Proxy_ServerPort;<>vt_SNT_Proxy_UserID)
	  //End if 
	$error:=FTP_Login ($serverAddress;$login;$password;$ftpConnectionID)
Else 
	$error:=0
End if 

If ($ftpConnectionID=0)
	  //If ((<>vt_SNT_Proxy_Host#"") & (<>vl_SNT_Proxy_ServerPort#0))
	  //$err:=IT_SetProxy (1;<>vl_SNT_Proxy_IsSocks;<>vt_SNT_Proxy_Host;<>vl_SNT_Proxy_ServerPort;<>vt_SNT_Proxy_UserID)
	  //End if 
	$InitiateConexion:=True:C214
	$error:=FTP_Login ($serverAddress;$login;$password;$ftpConnectionID)
End if 


If ($error=0)
	  //$error:=FTP_SetPassive ($ftpConnectionID;<>ftp_UsePassive)
	$error:=FTP_SetPassive ($ftpConnectionID;1)  //20170520 RCH. Se cambia a pedido de JHB
	$error:=FTP_GetDirList ($ftpConnectionID;$ftpDirectory;$directoryList;$objectSizes;$objectKind;$objectModDate)
	If ($error=0)
		If (Find in array:C230($directoryList;$fileShortname)>0)
			$error:=FTP_Delete ($ftpConnectionID;$hostPath)
			If ($error#0)
				$errorString:="No fue posible eliminar el archivo existente: "+$fileShortname+" (error N°"+String:C10($error)+")"
			End if 
		End if 
	Else 
		$errorString:="Conexión FTP imposible "+$serverAddress+"\t"+" (error N° "+String:C10($error)+")"
	End if 
	If ($error=0)
		$error:=FTP_Progress (-1;-1;"Progreso";"Enviando datos...";"Detener")
		If (($error=0) | ($error=-2201))  //este error da por que esta funcionalidad no está implementada aun en 64bits (en la documentación del comando aparece)
			$error:=FTP_Send ($ftpConnectionID;$filePath;$hostPath;1)
			If ($error=0)
				If ($deleteOriginal)
					DELETE DOCUMENT:C159($filePath)
				End if 
			Else 
				$errorString:="Transferencia del archivo "+$fileShortname+" imposible (error N° "+String:C10($error)+")"
			End if 
		End if 
	End if 
	If ($InitiateConexion)
		$error:=FTP_Logout ($ftpConnectionID)
	End if 
Else 
	$errorString:="Conexión FTP imposible "+$serverAddress+"\t"+" (error N° "+String:C10($error)+")"
End if 

$0:=$errorString