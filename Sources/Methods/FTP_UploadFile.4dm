//%attributes = {}
  //FTP_UploadFile

C_TEXT:C284($1;$2;$filePath;$fileName;$hostPath;$targetPath)
C_LONGINT:C283($error;vlFTP_ConectionID)
$hostPath:=$1
$filePath:=$2

$fileName:=SYS_Path2FileName ($filePath)
If (Length:C16($hostPath)=1)
	$targetPath:=$hostPath+$fileName
Else 
	$targetPath:=$hostPath+"/"+$fileName
End if 

If (vlFTP_ConectionID=0)
	$error:=FTP_Login (vtFTP_Url;vtWS_ftpLoginName;vtWS_ftppassword;vlFTP_ConectionID)
	  //$error:=FTP_SetPassive (vlFTP_ConectionID;vlFTP_ConexionPasiva)
	$error:=FTP_SetPassive (vlFTP_ConectionID;1)  //20170520 RCH. Se cambia a pedido de JHB
End if 
$left:=Screen width:C187-300
$top:=Screen height:C188-120
$error:=FTP_Progress ($left;$top;"Transferencia FTP";"Enviando:"+$fileName;"Cancelar")

If (($error=0) | ($error=-2201))  //este error da por que esta funcionalidad no está implementada aun en 64bits (en la documentación del comando aparece)
	
	$error:=FTP_Send (vlFTP_ConectionID;$filePath;$targetPath;1)
	If ($error#10000)  // Cancel by the user
		If ($error#0)
			CD_Dlog (0;IT_ErrorText ($error))
		End if 
	End if 
	
Else 
	CD_Dlog (0;IT_ErrorText ($error))
End if 

$0:=$error