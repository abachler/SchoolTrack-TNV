//%attributes = {}
  //CMT_SendFiles2FTP

C_LONGINT:C283($error;$ftpConnectionID)

Error:=0

$aplicacion:="CMT"
$ftpDirectory:="/CommTrack/"

NET_Configuration ("Read";$aplicacion)
ON ERR CALL:C155("ERR_CMTErrorsCallBack")

C_TEXT:C284($body;$response)
C_OBJECT:C1216($ob_request)
ARRAY TEXT:C222($at_files;0)

$t_rutaCarpetaSchoolTrack:=SYS_CarpetaAplicacion (CLG_Intercambios_CMT)
DOCUMENT LIST:C474($t_rutaCarpetaSchoolTrack;$at_files)
If (Size of array:C274($at_files)>0)
	
	READ ONLY:C145([xxSTR_Constants:1])
	ALL RECORDS:C47([xxSTR_Constants:1])
	FIRST RECORD:C50([xxSTR_Constants:1])
	vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"Iniciando la conexión con el servidor FTP "+<>vt_CMT_FTP_ServerAddres
	  //WDW_OpenFormWindow (->[xxSTR_Constants];"CMT_Console";0;Palette form window;__ ("Transferencia de datos"))
	  //FORM SET INPUT([xxSTR_Constants];"CMT_Console")
	  //DISPLAY RECORD([xxSTR_Constants])
	SN3_ConsolaEnvios ("OpenForm";->[xxSTR_Constants:1];"CMT_Console";__ ("Transferencia de datos"))
	SN3_ConsolaEnvios ("display";->[xxSTR_Constants:1])
	
	
	$error:=IT_SetTimeOut (127)
	$error:=FTP_Login (<>vt_CMT_FTP_ServerAddres;<>vt_CMT_FTP_Login;<>vt_CMT_FTP_Password;$ftpConnectionID)
	If ($error=0)
		  //$error:=FTP_SetPassive ($ftpConnectionID;<>ftp_UsePassive)
		$error:=FTP_SetPassive ($ftpConnectionID;1)  //20170520 RCH. Se cambia a pedido de JHB
		CMT_LogAction ("Información";"Conexión FTP iniciada.")
		
		vt_msg:=vt_msg+"\r"+String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"Conexión establecida, identificación aceptada."
		SN3_ConsolaEnvios ("display";->[xxSTR_Constants:1])
		
		$totalsize:=0
		For ($i;1;Size of array:C274($at_files))
			  // Modificado por: Saúl Ponce (01-03-2017) Ticket Nº 175827
			  // $filePath:=$vt_LocalFolder+$at_files{$i}
			$filePath:=$t_rutaCarpetaSchoolTrack+$at_files{$i}
			$totalsize:=$totalsize+Get document size:C479($filepath)
		End for 
		
		$bytesTransfered:=0
		For ($i;1;Size of array:C274($at_files))
			$hostPath:=$ftpDirectory+$at_files{$i}
			  // Modificado por: Saúl Ponce (01-03-2017) Ticket Nº 175827
			  // $filePath:=$vt_LocalFolder+$at_files{$i}
			$filePath:=$t_rutaCarpetaSchoolTrack+$at_files{$i}
			If (error=0)
				$ref:=Append document:C265($filePath)
				$currentPosition:=Get document position:C481($ref)
				SET DOCUMENT POSITION:C482($ref;-3;2)
				RECEIVE PACKET:C104($ref;$text;3)
				If ($text#"EOF")
					SET DOCUMENT POSITION:C482($ref;$currentPosition;1)
					SEND PACKET:C103($ref;"EOF")
					CLOSE DOCUMENT:C267($ref)
				Else 
					CLOSE DOCUMENT:C267($ref)
				End if 
				If (error=0)
					$docSize:=Get document size:C479($filePath)
					$m1:=Milliseconds:C459
					vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"Iniciando la transferencia de "+$at_files{$i}+" ("+String:C10($docsize)+" bytes)"+"\r"+vt_msg
					SN3_ConsolaEnvios ("display";->[xxSTR_Constants:1])
					$errorString:=NET_SendFile2FTP (<>vt_CMT_FTP_ServerAddres;<>vt_CMT_FTP_Login;<>vt_CMT_FTP_Password;<>vl_CMT_FTP_ServerPort;<>ftp_UsePassive;$ftpDirectory;$filePath;$hostPath;True:C214;$ftpConnectionID)
					If ($errorString#"")
						CMT_LogAction ("Supresión del archivo existente en FTP: "+$fileShortname;"ERR";$error)
					End if 
					$secondsStr:=String:C10((Milliseconds:C459-$m1)/1000;"#.###.###.##0,00")
					$kbps:=($docSize/1024)/((Milliseconds:C459-$m1)/1000)
					If ($errorString="")
						$bytesTransfered:=$bytesTransfered+$docSize
						vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"Transferencia de "+$at_files{$i}+" terminada en "+$secondsStr+" segundos ("+String:C10(Round:C94($kbps;2))+"Kbps)"+"\r"+vt_msg
						CMT_LogAction ("Información";"El archivo "+$at_files{$i}+" ha sido transferido exitosamente.")
					Else 
						vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"El archivo "+$at_files{$i}+" no pudo ser transferido a causa de un error FTP "+"\r"+$errorString+"\r"+vt_msg
						CMT_LogAction ("Error";$errorString)
						If ($errorString="Conexión FTP imposible@")
							$i:=Size of array:C274($at_files)+1
						End if 
						
						  //Aviso a Colegium que hubo problemas en la transmisíon de archivos
						ARRAY TEXT:C222($at_msg;0)
						C_TEXT:C284($msg_html)
						AT_Text2Array (->$at_msg;vt_msg;"\r")
						$msg_html:="<html><body><table>"
						For ($i_msg;Size of array:C274($at_msg);1;-1)
							$msg_html:=$msg_html+"<tr><td>"+$at_msg{$i_msg}+"</td></tr>"
						End for 
						$msg_html:=$msg_html+"</table></body></html>"
						
						$ob_request:=OB_Create 
						OB_SET ($ob_request;-><>gRolBD;"rol")
						OB_SET ($ob_request;-><>vtXS_CountryCode;"cod_pais")
						OB_SET ($ob_request;->vt_msg;"msg")
						$body:=OB_Object2Json ($ob_request;True:C214)
						$httpStatus_l:=Intranet3_LlamadoWS ("WSin_CT_AlertFilesFail";$body)
						If ($httpStatus_l#200)
							CMT_LogAction ("Error";"Problemas de comunicación con la intranet para reportar fallas de transmisión de datos. Error: "+String:C10($httpStatus_l)+"...")
						End if 
						
					End if 
					SN3_ConsolaEnvios ("display";->[xxSTR_Constants:1])
				End if 
			End if 
		End for 
		vt_msg:=String:C10(Current date:C33(*);"00/00/00")+", "+String:C10(Current time:C178(*);"00:00:00")+"\t"+"Transferencia de archivos terminada ("+String:C10($bytesTransfered/1024)+"Kb. transferidos)"+"\r"+vt_msg
		$error:=FTP_Logout ($ftpConnectionID)
		
		SN3_ConsolaEnvios ("display";->[xxSTR_Constants:1])
		vStop:=False:C215
		IT_WaitForTime (Current time:C178+15)
	Else 
		CMT_LogAction ("Error";"Conexión FTP imposible (identificación incorrecta).")
		vt_msg:="Conexión FTP imposible (identificación incorrecta)."
		SN3_ConsolaEnvios ("display";->[xxSTR_Constants:1])
		
		  //Aviso a Colegium que hubo problemas en la conexión con el ftp
		$ob_request:=OB_Create 
		OB_SET ($ob_request;-><>gRolBD;"rol")
		OB_SET ($ob_request;-><>vtXS_CountryCode;"cod_pais")
		OB_SET ($ob_request;->vt_msg;"msg")
		$body:=OB_Object2Json ($ob_request;True:C214)
		$httpStatus_l:=Intranet3_LlamadoWS ("WSin_CT_AlertFilesFail";$body)
		If ($httpStatus_l#200)
			CMT_LogAction ("Error";"Problemas de comunicación con la intranet para reportar fallas de conexión al ftp. Error: "+String:C10($httpStatus_l)+"...")
		End if 
		
	End if 
	SN3_ConsolaEnvios ("closeWindows")
Else 
	CMT_LogAction ("Información";"No hay datos a transferir.")
End if 
$0:=$error
ON ERR CALL:C155("")