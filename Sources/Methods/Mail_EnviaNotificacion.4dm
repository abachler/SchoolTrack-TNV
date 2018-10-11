//%attributes = {}
  // Método: MAIL_EnviaNotificacion (asunto:T; cuerpo:T; destinatario:T {; copiaA:T {; copiaOculta:T {;adjuntos:Y {;mensajeEnvio:T }}}})
  //
  //
  // creado por Alberto Bachler Klein
  // el 18/07/18, 06:27:58
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($5)
C_POINTER:C301($6)
C_TEXT:C284($7)

C_LONGINT:C283($i;$l_error;$l_errorEnvio;$l_largoLinea;$l_numeroDirecciones;$l_puertoActual;$l_ref_SMTP;$l_RetornoLineaActual;$l_timeOutActual;$l_tipoContenido)
C_LONGINT:C283($pID)
C_POINTER:C301($y_adjuntos)
C_TEXT:C284($t_adjunto;$t_asunto;$t_contraseña;$t_copiaA;$t_copiaOcultaA;$t_destinatario;$t_direccionesCorreo;$t_info;$t_mensaje;$t_Remitente)
C_TEXT:C284($t_servidorCorreo;$t_textoCorreo;$t_usuario)


If (False:C215)
	C_TEXT:C284(Mail_EnviaNotificacion ;$0)
	C_TEXT:C284(Mail_EnviaNotificacion ;$1)
	C_TEXT:C284(Mail_EnviaNotificacion ;$2)
	C_TEXT:C284(Mail_EnviaNotificacion ;$3)
	C_TEXT:C284(Mail_EnviaNotificacion ;$4)
	C_TEXT:C284(Mail_EnviaNotificacion ;$5)
	C_POINTER:C301(Mail_EnviaNotificacion ;$6)
	C_TEXT:C284(Mail_EnviaNotificacion ;$7)
End if 

$t_servidorCorreo:="mail.colegium.com"
$t_usuario:="appSchoolTrack@colegium.com"
$t_Remitente:="appSchoolTrack@colegium.com"
$t_contraseña:="quasimodo"

Case of 
	: (Count parameters:C259=7)
		$t_mensaje:=$7
		$y_adjuntos:=$6
		$t_copiaOcultaA:=$5
		$t_copiaA:=$4
		$t_destinatario:=$3
		$t_textoCorreo:=$2
		$t_asunto:=$1
		
	: (Count parameters:C259=6)
		$y_adjuntos:=$6
		$t_copiaOcultaA:=$5
		$t_copiaA:=$4
		$t_destinatario:=$3
		$t_textoCorreo:=$2
		$t_asunto:=$1
		
	: (Count parameters:C259=5)
		$t_copiaOcultaA:=$5
		$t_copiaA:=$4
		$t_destinatario:=$3
		$t_textoCorreo:=$2
		$t_asunto:=$1
		
	: (Count parameters:C259=4)
		$t_copiaA:=$4
		$t_destinatario:=$3
		$t_textoCorreo:=$2
		$t_asunto:=$1
		
	: (Count parameters:C259=3)
		$t_destinatario:=$3
		$t_textoCorreo:=$2
		$t_asunto:=$1
		
	: (Count parameters:C259=2)
		$t_textoCorreo:=$2
		$t_asunto:=$1
End case 

If (($t_asunto#"") & ($t_textoCorreo#"") & (($t_destinatario#"") | ($t_copiaA#"") | ($t_copiaOcultaA#"")))
	$t_info:=""
	$t_info:=$t_info+__ ("INSTITUCIÓN: ")+<>gCustom+Char:C90(Carriage return:K15:38)
	$t_info:=$t_info+__ ("ID INSTITUCIÓN: ")+<>gRolBd+Char:C90(Carriage return:K15:38)
	$t_info:=$t_info+__ ("VERSIÓN APPLICACIÓN: ")+SYS_LeeVersionEstructura +Char:C90(Carriage return:K15:38)
	Case of 
		: (Application type:C494=4D Server:K5:6)
			$t_info:=$t_info+__ ("TIPO APPLICACIÓN: ")+"SchoolTrack Server"+Char:C90(Carriage return:K15:38)
		: (Application type:C494=4D Remote mode:K5:5)
			$t_info:=$t_info+__ ("TIPO APPLICACIÓN: ")+"SchoolTrack Client"+Char:C90(Carriage return:K15:38)
		: (Application type:C494=4D Volume desktop:K5:2)
			$t_info:=$t_info+__ ("TIPO APPLICACIÓN: ")+"SchoolTrack Standalone"+Char:C90(Carriage return:K15:38)
		Else 
			$t_info:=""
	End case 
	
	If ($t_mensaje#"")
		$pID:=IT_UThermometer (1;0;$t_mensaje;-1)
		BRING TO FRONT:C326($pID)
	End if 
	
	$l_error:=SMTP_GetPrefs ($l_RetornoLineaActual;$l_tipoContenido;$l_largoLinea)
	$l_error:=IT_GetTimeOut ($l_timeOutActual)
	$l_error:=IT_SetTimeOut (30)
	$l_error:=IT_GetPort (2;$l_puertoActual)
	$l_error:=IT_SetPort (2;25)  //modo STMP estándar, puerto 587 para gmail
	$l_error:=SMTP_New ($l_ref_SMTP)
	  //$l_error:=SMTP_SetPrefs (1;5;0)
	$l_error:=SMTP_SetPrefs (1;1;0)  // 20180926 ASM Ticket 217252
	  //$l_error:=SMTP_Charset (0;1)
	$l_error:=SMTP_Charset (0;0)  // 20180926 ASM Ticket 217252
	$l_error:=SMTP_Host ($l_ref_SMTP;$t_servidorCorreo)
	$l_error:=SMTP_From ($l_ref_SMTP;$t_remitente)
	$l_error:=SMTP_ReplyTo ($l_ref_SMTP;$t_remitente)
	$l_error:=SMTP_Subject ($l_ref_SMTP;$t_asunto)
	$l_error:=SMTP_Auth ($l_ref_SMTP;$t_usuario;$t_contraseña;2)  //utilizar identificadores válidos
	$l_numeroDirecciones:=ST_CountWords ($t_destinatario;1;",")
	For ($i;1;$l_numeroDirecciones)
		$t_direccionesCorreo:=ST_GetWord ($t_destinatario;$i;",")
		$l_error:=SMTP_To ($l_ref_SMTP;$t_direccionesCorreo;0)
	End for 
	$l_numeroDirecciones:=ST_CountWords ($t_copiaA;1;",")
	For ($i;1;$l_numeroDirecciones)
		$t_direccionesCorreo:=ST_GetWord ($t_copiaA;$i;",")
		$l_error:=SMTP_Cc ($l_ref_SMTP;$t_direccionesCorreo;0)
	End for 
	$l_numeroDirecciones:=ST_CountWords ($t_copiaOcultaA;1;",")
	For ($i;1;$l_numeroDirecciones)
		$t_direccionesCorreo:=ST_GetWord ($t_copiaOcultaA;$i;",")
		$l_error:=SMTP_Bcc ($l_ref_SMTP;$t_direccionesCorreo;0)
	End for 
	
	
	$t_textoCorreo:=__ ("Este es un correo automático enviado desde SchoolTrack.\rPOR FAVOR NO RESPONDER")\
		+"\r\r\r"+$t_textoCorreo
	
	
	$l_error:=SMTP_Body ($l_ref_SMTP;$t_textoCorreo)
	If (Not:C34(Is nil pointer:C315($y_adjuntos)))
		For ($i;1;Size of array:C274($y_adjuntos->))
			$t_adjunto:=$y_adjuntos->{$i}
			$l_error:=SMTP_Attachment ($l_ref_SMTP;$t_adjunto;2)
		End for 
	End if 
	
	$l_errorEnvio:=SMTP_Send ($l_ref_SMTP;0)  //Envío en modo 'actualizable'
	$l_error:=SMTP_Clear ($l_ref_SMTP)
	$l_error:=IT_SetPort (2;$l_puertoActual)
	$l_error:=SMTP_SetPrefs ($l_RetornoLineaActual;$l_tipoContenido;$l_largoLinea)
	$l_error:=IT_SetTimeOut ($l_timeOutActual)
	
	If ($t_mensaje#"")
		IT_UThermometer (-2;$pID)
	End if 
	If ($l_errorEnvio#0)
		$0:=__ ("ERROR: No fue posible enviar el correo electronico a Colegium\rCódigo Error: ")+String:C10($l_errorEnvio)+"\r"+__ ("Descripción: ")+IT_ErrorText ($l_errorEnvio)
	End if 
End if 


