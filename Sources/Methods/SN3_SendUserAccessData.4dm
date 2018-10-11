//%attributes = {}
$result:=""
$mail:=""
If (Count parameters:C259=1)
	$mail:=$1
End if 
$p:=0
  //$tempRol:="117765"
WEB SERVICE SET PARAMETER:C777("codpais";<>vtXS_CountryCode)
WEB SERVICE SET PARAMETER:C777("rolbd";<>gRolBD)
  //SET WEB SERVICE PARAMETER("rolbd";$tempRol)
WEB SERVICE SET PARAMETER:C777("mail";$mail)
If ($mail="")
	$p:=IT_UThermometer (1;0;__ ("Solicitando el envío de datos de acceso a SchoolNet 3..."))
End if 
$err:=SN3_CallWebService ("sn3ws_usuarios_proceso.enviamail")
If ($p#0)
	IT_UThermometer (-2;$p)
End if 
If ($err="")
	WEB SERVICE GET RESULT:C779($result;"resultado";*)
	If ($result="0")
		If ($mail="")
			CD_Dlog (0;__ ("La solicitud fue recibida con exito. Los eMail con los datos de acceso están siendo enviados en este momento."))
			SN3_RegisterLogEntry (SN3_Log_Info;"Envío de datos de acceso a todos los usuarios por eMail.")
			LOG_RegisterEvt ("Envío de datos de acceso a todos los usuarios por eMail.")
		Else 
			CD_Dlog (0;__ ("La solicitud fue recibida con exito. El eMail con los datos de acceso está siendo enviado en este momento."))
			SN3_RegisterLogEntry (SN3_Log_Info;"Envío de datos de acceso a "+$mail+".")
			LOG_RegisterEvt ("Envío de datos de acceso a "+$mail+".")
		End if 
	Else 
		CD_Dlog (0;__ ("Se produjo un error en el procesamiento de la solicitud. Por favor intente otra vez más tarde."))
	End if 
Else 
	CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
End if 