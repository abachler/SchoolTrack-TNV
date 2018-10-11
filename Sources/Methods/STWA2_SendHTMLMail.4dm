//%attributes = {}
  // STWA2_SendHTMLMail()
  //
  //
  // creado por: Alberto Bachler Klein: 30-05-16, 20:04:28
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($5)
C_TEXT:C284($6)
C_TEXT:C284($7)
C_LONGINT:C283($8)
C_TEXT:C284($9)
C_TEXT:C284($10)
C_TEXT:C284($11)
C_TEXT:C284($12)

C_LONGINT:C283($l_error;$l_largoLinea;$l_modoAutenticacion;$l_puertoActual;$l_refConexion;$l_RetornoLineaActual;$l_timeOutActual;$l_tipoContenido)
C_TEXT:C284($t_error;$t_asunto;$t_contraseña;$t_copiaA;$t_copiaOcultaA;$t_destinatario;$t_enRespuestaA;$t_remitente;$t_responderA;$t_rutaAdjunto1)
C_TEXT:C284($t_rutaAdjunto2;$t_rutaAdjunto3;$t_servidorCorreo;$t_textoCorreo;$t_usuario)



If (False:C215)
	C_TEXT:C284(STWA2_SendHTMLMail ;$0)
	C_TEXT:C284(STWA2_SendHTMLMail ;$1)
	C_TEXT:C284(STWA2_SendHTMLMail ;$2)
	C_TEXT:C284(STWA2_SendHTMLMail ;$3)
	C_TEXT:C284(STWA2_SendHTMLMail ;$4)
	C_TEXT:C284(STWA2_SendHTMLMail ;$5)
	C_TEXT:C284(STWA2_SendHTMLMail ;$6)
	C_TEXT:C284(STWA2_SendHTMLMail ;$7)
	C_LONGINT:C283(STWA2_SendHTMLMail ;$8)
	C_TEXT:C284(STWA2_SendHTMLMail ;$9)
	C_TEXT:C284(STWA2_SendHTMLMail ;$10)
	C_TEXT:C284(STWA2_SendHTMLMail ;$11)
	C_TEXT:C284(STWA2_SendHTMLMail ;$12)
End if 

$t_error:=""
$t_servidorCorreo:=$1
$t_remitente:=$2
$t_destinatario:=$3
$t_asunto:=$4
$t_textoCorreo:=$5
$t_usuario:=$6
$t_contraseña:=$7
$l_modoAutenticacion:=2
Case of 
	: (Count parameters:C259=9)
		$t_usuario:=$6
		$t_contraseña:=$7
		$l_modoAutenticacion:=$8
		$t_responderA:=$9
	: (Count parameters:C259=10)
		$t_usuario:=$6
		$t_contraseña:=$7
		$l_modoAutenticacion:=$8
		$t_responderA:=$9
		$t_copiaA:=$10
	: (Count parameters:C259=11)
		$t_usuario:=$6
		$t_contraseña:=$7
		$l_modoAutenticacion:=$8
		$t_responderA:=$9
		$t_copiaA:=$10
		$t_copiaOcultaA:=$11
	: (Count parameters:C259=12)
		$t_usuario:=$6
		$t_contraseña:=$7
		$l_modoAutenticacion:=$8
		$t_responderA:=$9
		$t_copiaA:=$10
		$t_copiaOcultaA:=$11
		$t_enRespuestaA:=$12
	: (Count parameters:C259=13)
		$t_usuario:=$6
		$t_contraseña:=$7
		$l_modoAutenticacion:=$8
		$t_responderA:=$9
		$t_copiaA:=$10
		$t_copiaOcultaA:=$11
		$t_enRespuestaA:=$12
		$t_rutaAdjunto1:=$13
	: (Count parameters:C259=14)
		$t_usuario:=$6
		$t_contraseña:=$7
		$l_modoAutenticacion:=$8
		$t_responderA:=$9
		$t_copiaA:=$10
		$t_copiaOcultaA:=$11
		$t_enRespuestaA:=$12
		$t_rutaAdjunto1:=$13
		$t_rutaAdjunto2:=$14
	: (Count parameters:C259=15)
		$t_usuario:=$6
		$t_contraseña:=$7
		$l_modoAutenticacion:=$8
		$t_responderA:=$9
		$t_copiaA:=$10
		$t_copiaOcultaA:=$11
		$t_enRespuestaA:=$12
		$t_rutaAdjunto1:=$13
		$t_rutaAdjunto2:=$14
		$t_rutaAdjunto3:=$15
End case 


$l_error:=SMTP_GetPrefs ($l_RetornoLineaActual;$l_tipoContenido;$l_largoLinea)
$l_error:=IT_GetTimeOut ($l_timeOutActual)
$l_error:=IT_SetTimeOut (30)
$l_error:=IT_GetPort (2;$l_puertoActual)
$l_error:=IT_SetPort (2;25)  //modo STMP estándar, puerto 587 para gmail

$l_error:=SMTP_SetPrefs (-1;1;-1)
$l_error:=SMTP_Charset (1;-1)

$l_error:=SMTP_New ($l_refConexion)
$l_error:=SMTP_Host ($l_refConexion;$t_servidorCorreo)
$l_error:=SMTP_From ($l_refConexion;$t_remitente)
$l_error:=SMTP_ReplyTo ($l_refConexion;$t_remitente)
$l_error:=SMTP_Subject ($l_refConexion;$t_asunto)
$l_error:=SMTP_Auth ($l_refConexion;$t_usuario;$t_contraseña;$l_modoAutenticacion)
$l_error:=SMTP_ReplyTo ($l_refConexion;$t_responderA)
$l_error:=SMTP_InReplyTo ($l_refConexion;$t_enRespuestaA)

$l_error:=SMTP_To ($l_refConexion;$t_destinatario)


$l_error:=SMTP_Body ($l_refConexion;$t_textoCorreo)
$l_error:=SMTP_Cc ($l_refConexion;$t_copiaA)
$l_error:=SMTP_Bcc ($l_refConexion;$t_copiaOcultaA)
If ($t_rutaAdjunto1#"")
	$l_error:=SMTP_Attachment ($l_refConexion;$t_rutaAdjunto1;1)
End if 
If ($t_rutaAdjunto2#"")
	$l_error:=SMTP_Attachment ($l_refConexion;$t_rutaAdjunto2;1)
End if 
If ($t_rutaAdjunto3#"")
	$l_error:=SMTP_Attachment ($l_refConexion;$t_rutaAdjunto3;1)
End if 

$l_error:=SMTP_AddHeader ($l_refConexion;"Content-Type:";"text/html;charset=utf-8";1)
$l_error:=SMTP_AddHeader ($l_refConexion;"X-SchoolTrack";SYS_LeeVersionEstructura )
$l_error:=SMTP_Comments ($l_refConexion;"Enviado desde SchoolTrack")


$l_error:=SMTP_Send ($l_refConexion;0)  //Envío en modo 'actualizable'
$l_error:=SMTP_Clear ($l_refConexion)
$l_error:=IT_SetPort (2;$l_puertoActual)
$l_error:=SMTP_SetPrefs ($l_RetornoLineaActual;$l_tipoContenido;$l_largoLinea)
IT_SetTimeOut ($l_timeOutActual)

If ($l_error#0)
	$0:=__ ("ERROR: No fue posible enviar el correo electronico a Colegium\rCódigo Error: ")+String:C10($l_error)+"\r"+__ ("Descripción: ")+IT_ErrorText ($l_error)
End if 