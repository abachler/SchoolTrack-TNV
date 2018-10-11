//%attributes = {}
  //ACTdte_SendFiles2FTP

C_TEXT:C284($vt_path;$vt_fileName;$0)
ARRAY TEXT:C222($atACAT_documents;0)
C_LONGINT:C283($ftpConnectionID)
C_BOOLEAN:C305($b_ambienteCertificacion)

SN3_InitGeneralSettings 

$vt_FTP_ServerAddres:=SN3_FTP_Server
$vt_FTP_Login:=SN3_FTP_User
$vt_FTP_Password:=SN3_FTP_Password
$vl_FTP_ServerPort:=SN3_FTP_Port
$vl_FTP_Passive:=SN3_FTP_Passive

$b_ambienteCertificacion:=(Num:C11(PREF_fGet (0;"ACT_AMBIENTE_CERTIFICACION_SII";"1"))=1)
If ($b_ambienteCertificacion)
	$ftpDirectory:="/dtenet/certificacion/"
Else 
	$ftpDirectory:="/dtenet/produccion/"
End if 
$ftp_folder1:="documentos_por_caja/"
$ftp_folder2:="documentos_masivos/"
$vt_pathDocumentos:="documentos"+Folder separator:K24:12

$vt_path:=ACTdte_GeneraArchivo ("ObtienePath")
If (Count parameters:C259=1)
	  //APPEND TO ARRAY($atACAT_documents;$1)
	$filePath:=$1
	APPEND TO ARRAY:C911($atACAT_documents;SYS_Path2FileName ($filePath))
Else 
	$filePath:=""
	$vt_path:=$vt_path+$vt_pathDocumentos
	DOCUMENT LIST:C474($vt_path;$atACAT_documents)
End if 
If (Size of array:C274($atACAT_documents)>0)
	SORT ARRAY:C229($atACAT_documents;>)
	$error:=FTP_Login ($vt_FTP_ServerAddres;$vt_FTP_Login;$vt_FTP_Password;$ftpConnectionID)
	vt_msg:=""
	If ($error=0)
		vt_msg:=vt_msg+"\r"+String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"Conexión establecida, identificación aceptada."
		For ($j;1;Size of array:C274($atACAT_documents))
			If ($filePath="")
				$filePath:=$vt_path+$atACAT_documents{$j}
			End if 
			$hostPath:=$ftpDirectory+$atACAT_documents{$j}
			  //$filePath:=$vt_newPath+SYS_FolderDelimiter +$atACAT_documents{$j}
			
			If (Num:C11(ST_CountWords ($atACAT_documents{$j};0;"_"))=6)
				$docSize:=Get document size:C479($filePath)
				If (Num:C11(ST_GetWord ($atACAT_documents{$j};6;"_"))=$docSize)
					$m1:=Milliseconds:C459
					vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"Iniciando la transferencia de "+$atACAT_documents{$j}+" ("+String:C10($docsize)+" bytes)"+"\r"+vt_msg
					$errorString:=NET_SendFile2FTP ($vt_FTP_ServerAddres;$vt_FTP_Login;$vt_FTP_Password;$vl_FTP_ServerPort;$vl_FTP_Passive;$ftpDirectory;$filePath;$hostPath;False:C215;$ftpConnectionID)
					
					$secondsStr:=String:C10((Milliseconds:C459-$m1)/1000;"#.###.###.##0,00")
					$kbps:=($docSize/1024)/((Milliseconds:C459-$m1)/1000)
					If ($errorString="")
						$0:="transferido"
						vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"Transferencia de "+$atACAT_documents{$j}+" terminada en "+$secondsStr+" segundos ("+String:C10(Round:C94($kbps;2))+"Kbps)"+"\r"+vt_msg
					Else 
						vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"El archivo "+$atACAT_documents{$j}+" no pudo ser transferido a causa de un error FTP "+"\r"+$errorString+"\r"+vt_msg
						If ($errorString="Conexión FTP imposible@")
							$j:=Size of array:C274($atACAT_documents)
						End if 
						$0:="no transferido"
						ACTdte_LogAction ("FTP: Archivo no transferido: "+$errorString)
					End if 
					
					ok:=1
					EM_ErrorManager ("Install")
					EM_ErrorManager ("SetMode";"")
					DELETE DOCUMENT:C159($filePath)
					EM_ErrorManager ("Clear")
					If (ok#1)
						ACTdte_LogAction ("FTP: El archivo "+$filePath+" no pudo ser eliminado.")
					End if 
				End if 
			End if 
		End for 
		vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"Transferencia de archivos terminada."+"\r"+vt_msg
		$error:=FTP_Logout ($ftpConnectionID)
	Else 
		ACTdte_LogAction ("Error de conexión al ftp. Los archivos no pueden ser enviados.")
	End if 
End if 