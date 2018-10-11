//%attributes = {}
  // Mail_QuickSend()
  // Por: Alberto Bachler: 15/10/13, 10:41:25
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($5)
C_LONGINT:C283($6)
C_LONGINT:C283($7)
C_TEXT:C284($8)
C_TEXT:C284($9)

C_LONGINT:C283($l_error;$l_puerto;$l_ref_SMTP;$l_utilizarSSL;$l_modoAutenticacion)
C_TEXT:C284($t_asunto;$t_contraseñaSMTP;$t_destinatario;$t_emailAddress;$t_Error;$t_ErrorIgnorado;$t_mensaje;$t_Remitente;$t_servidor;$t_usuarioSMTP)

If (False:C215)
	C_TEXT:C284(Mail_QuickSend ;$0)
	C_TEXT:C284(Mail_QuickSend ;$1)
	C_TEXT:C284(Mail_QuickSend ;$2)
	C_TEXT:C284(Mail_QuickSend ;$3)
	C_TEXT:C284(Mail_QuickSend ;$4)
	C_TEXT:C284(Mail_QuickSend ;$5)
	C_LONGINT:C283(Mail_QuickSend ;$6)
	C_LONGINT:C283(Mail_QuickSend ;$7)
	C_TEXT:C284(Mail_QuickSend ;$8)
	C_TEXT:C284(Mail_QuickSend ;$9)
End if 

$t_servidor:=$1
$t_Remitente:=$2
$t_destinatario:=$3
$t_asunto:=$4
$t_mensaje:=$5
$l_utilizarSSL:=0
$l_puerto:=25
Case of 
	: (Count parameters:C259=10)
		$l_modoAutenticacion:=$10
		$t_contraseñaSMTP:=$9
		$t_usuarioSMTP:=$8
		$l_utilizarSSL:=$6
		$l_puerto:=$7
		
	: (Count parameters:C259=9)
		$t_contraseñaSMTP:=$9
		$t_usuarioSMTP:=$8
		$l_utilizarSSL:=$6
		$l_puerto:=$7
		
	: (Count parameters:C259=7)
		$l_puerto:=$7
		$l_utilizarSSL:=$6
		
	: (Count parameters:C259=6)
		$l_utilizarSSL:=$6
End case 

If ($l_puerto=0)
	$l_puerto:=25
End if 

$l_error:=IT_GetPort (2;$l_puertoActual)

If ($l_utilizarSSL=1)
	If ($l_puerto>0)
		$l_err:=IT_SetPort (12;$l_puerto)
	Else 
		$l_err:=IT_SetPort (12;465)
	End if 
Else 
	If ($l_puerto>0)
		$l_err:=IT_SetPort (2;$l_puerto)
	Else 
		$l_err:=IT_SetPort (2;25)
	End if 
End if 


If (($t_asunto#"") & ($t_mensaje#"") & ($t_destinatario#""))
	SMTP_SetPrefs (1;5;0)
	$l_error:=SMTP_Charset (1;1)
	
	$pID:=IT_UThermometer (1;0;__ ("Enviando correo...");-1)
	
	SMTP_ErrorCheck ("Init")
	
	If ($t_Error="")
		$t_Error:=SMTP_ErrorCheck ("SMTP_New";SMTP_New ($l_ref_SMTP))
	End if 
	
	If ($t_Error="")
		$t_Error:=SMTP_ErrorCheck ("SMTP_Host";SMTP_Host ($l_ref_SMTP;$t_servidor;0))
	End if 
	
	If (($t_Error="") & (Count parameters:C259>=9))
		$t_Error:=SMTP_ErrorCheck ("SMTP_Auth";SMTP_Auth ($l_ref_SMTP;$t_usuarioSMTP;$t_contraseñaSMTP;$l_modoAutenticacion))
	End if 
	
	If ($t_Error="")
		$t_Error:=SMTP_ErrorCheck ("SMTP_From";SMTP_From ($l_ref_SMTP;$t_Remitente;1))
	End if 
	
	If ($t_Error="")
		$t_Error:=SMTP_ErrorCheck ("SMTP_Subject";SMTP_Subject ($l_ref_SMTP;$t_asunto;0))
	End if 
	
	If ($t_Error="")
		$t_Error:=SMTP_ErrorCheck ("SMTP_Body";SMTP_Body ($l_ref_SMTP;$t_mensaje;0))
	End if 
	
	If ($t_Error="")
		$l_numeroDirecciones:=ST_CountWords ($t_destinatario;1;",")
		For ($i;1;$l_numeroDirecciones)
			$t_direccionesCorreo:=ST_GetWord ($t_destinatario;$i;",")
			$t_Error:=SMTP_ErrorCheck ("SMTP_To";SMTP_To ($l_ref_SMTP;$t_direccionesCorreo;0))
		End for 
	End if 
	If ($t_Error="")
		If ($l_utilizarSSL=1)
			$t_Error:=SMTP_ErrorCheck ("SMTP_Send";SMTP_Send ($l_ref_SMTP;$l_utilizarSSL))
		Else 
			$t_Error:=SMTP_ErrorCheck ("SMTP_Send";SMTP_Send ($l_ref_SMTP))
		End if 
		$t_ErrorIgnorado:=SMTP_ErrorCheck ("SMTP_Clear";SMTP_Clear ($l_ref_SMTP))
		vtSMTP_LastError:=""
	Else 
		$t_ErrorIgnorado:=SMTP_ErrorCheck ("SMTP_Clear";SMTP_Clear ($l_ref_SMTP))
	End if 
	
	IT_UThermometer (-2;$pID)
End if 


$0:=$t_Error

