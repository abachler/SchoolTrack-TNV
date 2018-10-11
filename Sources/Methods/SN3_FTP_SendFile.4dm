//%attributes = {}
  //SN3_FTP_SendFile

C_TEXT:C284($0;$vt_ErrorString)
C_BOOLEAN:C305($9;$closeCon)
C_LONGINT:C283($serversize;$l_try)
C_DATE:C307($fechamod)
C_TIME:C306($horamod)

ARRAY TEXT:C222($at_DirectoryList;0)
ARRAY LONGINT:C221($al_ObjectSizes;0)
ARRAY INTEGER:C220($ai_ObjectKind;0)
ARRAY DATE:C224($ad_ObjectModDate;0)
  //declaro ID de conexion
C_LONGINT:C283($vl_FtpConnectionID)

$vl_FtpConnectionID:=0
$vt_ServerAddress:=$1
$vt_Login:=$2
$vt_Password:=$3
$vt_FtpDirectory:=$4
$vt_FilePath:=$5
$vt_HostPath:=$6
$vb_InitiateConexion:=False:C215
$vb_deleteOriginal:=False:C215
$closeCon:=True:C214
Case of 
	: (Count parameters:C259=9)
		$vb_deleteOriginal:=$7
		$vl_FtpConnectionID:=$8->
		$vb_InitiateConexion:=($vl_FtpConnectionID=0)
		$closeCon:=$9
	: (Count parameters:C259=8)
		$vb_deleteOriginal:=$7
		$vl_FtpConnectionID:=$8->
		$vb_InitiateConexion:=($vl_FtpConnectionID=0)
	: (Count parameters:C259=7)
		$vb_deleteOriginal:=$7
End case 

SN3_LoadGeneralSettings 

$vt_FileShortname:=SYS_Path2FileName ($vt_FilePath)

If ($vb_InitiateConexion)
	$err:=IT_GetTimeOut ($timeout)
	$tiempo:=127
	$err:=IT_SetTimeOut ($tiempo)
	$err:=IT_GetPort (1;$port)
	$err:=IT_SetPort (1;SN3_FTP_Port)
	$vl_Error:=FTP_Login ($vt_ServerAddress;$vt_Login;$vt_Password;$vl_FtpConnectionID)
Else 
	$vl_Error:=0
End if 

If ($vl_FtpConnectionID=0)
	$err:=IT_GetTimeOut ($timeout)
	$tiempo:=127
	$err:=IT_SetTimeOut ($tiempo)
	$err:=IT_GetPort (1;$port)
	$err:=IT_SetPort (1;SN3_FTP_Port)
	$vb_InitiateConexion:=True:C214
	$vl_Error:=FTP_Login ($vt_ServerAddress;$vt_Login;$vt_Password;$vl_FtpConnectionID)
End if 

If ($vl_Error=0)
	  //$vl_Error:=FTP_SetPassive ($vl_FtpConnectionID;<>ftp_UsePassive)
	$vl_Error:=FTP_SetPassive ($vl_FtpConnectionID;1)  //20170520 RCH. Se cambia a pedido de JHB
	$vl_Error:=FTP_GetDirList ($vl_FtpConnectionID;$vt_FtpDirectory;$at_DirectoryList;$al_ObjectSizes;$ai_ObjectKind;$ad_ObjectModDate)
	If ($vl_Error=0)
		If (Find in array:C230($at_DirectoryList;$vt_FileShortname)>0)
			$vl_Error:=FTP_Delete ($vl_FtpConnectionID;$vt_HostPath)
			If ($vl_Error#0)
				$vt_ErrorString:="No fue posible eliminar en el servidor el archivo existente: "+$vt_FileShortname+" (error N°"+String:C10($vl_Error)+")"
			End if 
		End if 
	Else 
		$vt_ErrorString:="Conexión FTP imposible al servidor "+$vt_ServerAddress+" -  (error N° "+String:C10($vl_Error)+")"
	End if 
	If ($vl_Error=0)
		$vl_Error:=FTP_Progress (-1;-1;"Progreso";"Enviando datos...";"")
		If (($vl_Error=0) | ($vl_Error=-2201))  //este error da por que esta funcionalidad no está implementada aun en 64bits (en la documentación del comando aparece)
			$vl_Error:=FTP_Send ($vl_FtpConnectionID;$vt_FilePath;$vt_HostPath;1)
			
			$l_try:=0
			While ($vl_Error#0) & ($l_try<3)  //MONO 
				If (($vl_Error=10064) | ($vl_Error=10054))  //20150401 RCH Ticket 144712. En algunos casos, el archivo se transfiere completo pero FTP_Send devuelve el error 10064. Desde ahora si ftp_send devuelve ese error, se intenta loguear para obtener el tamaño del archivo subido.
					$vl_Error:=FTP_Logout ($vl_FtpConnectionID)
					$vl_Error:=FTP_Login ($vt_ServerAddress;$vt_Login;$vt_Password;$vl_FtpConnectionID)
				End if 
				$vl_Error:=FTP_Send ($vl_FtpConnectionID;$vt_FilePath;$vt_HostPath;1)
				$l_try:=$l_try+1
			End while 
			
			If ($vl_Error=0)
				
				If ($vb_deleteOriginal)
					DELAY PROCESS:C323(Current process:C322;30)  //para permitir que FTP_Send "suelte" el archivo y poder borrarlo...
					DELETE DOCUMENT:C159($vt_FilePath)
				End if 
			Else 
				
				If (($vl_Error=10064) | ($vl_Error=10054))  //20150401 RCH Ticket 144712. En algunos casos, el archivo se transfiere completo pero FTP_Send devuelve el error 10064. Desde ahora si ftp_send devuelve ese error, se intenta loguear para obtener el tamaño del archivo subido.
					$vl_Error:=FTP_Logout ($vl_FtpConnectionID)
					$vl_Error:=FTP_Login ($vt_ServerAddress;$vt_Login;$vt_Password;$vl_FtpConnectionID)
				End if 
				
				$vt_ErrorString:="Transferencia del archivo "+$vt_FileShortname+" incorrecta."
			End if 
		Else 
			$vt_ErrorString:="Transferencia del archivo "+$vt_FileShortname+" imposible (error N° "+String:C10($vl_Error)+")"
		End if 
		
	End if 
	If (($vb_InitiateConexion) & ($closeCon))
		$vl_Error:=FTP_Logout ($vl_FtpConnectionID)
		$err:=IT_SetPort (1;$port)
		$err:=IT_SetTimeOut ($timeout)
	End if 
	If (Count parameters:C259>=8)
		$8->:=$vl_FtpConnectionID
	End if 
Else 
	$vt_ErrorString:="Conexión FTP imposible al servidor "+$vt_ServerAddress+" -  (error N° "+String:C10($vl_Error)+")"
End if 

$0:=$vt_ErrorString