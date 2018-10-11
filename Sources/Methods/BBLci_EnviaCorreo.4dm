//%attributes = {}
  //BBLci_EnviaCorreo(destinatario: &T; asunto: &T; texto: &T)
  //envía un correo a un usuario de la bilbioteca 
If (False:C215)
	  // Por: Alberto Bachler: 10/11/13, 19:25:45
	  //  ---------------------------------------------
	  // 
	  //
	  //  ---------------------------------------------
End if 
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_LONGINT:C283($l_modoAutenticacion;$l_puerto;$l_utilizarSSL)
C_TEXT:C284($t_asunto;$t_contraseña;$t_cuentaCorreo;$t_destinatario;$t_error;$t_mensaje;$t_Remitente;$t_servidorCorreo;$t_usuarioSMTP)

If (False:C215)
	C_TEXT:C284(BBLci_EnviaCorreo ;$0)
	C_TEXT:C284(BBLci_EnviaCorreo ;$1)
	C_TEXT:C284(BBLci_EnviaCorreo ;$2)
	C_TEXT:C284(BBLci_EnviaCorreo ;$3)
End if 

$t_destinatario:=$1
$t_asunto:=$2
$t_mensaje:=$3

OT GetVariable (vl_refObjectoPreferencias_BBLci;"$t_servidorCorreo";->$t_servidorCorreo)
OT GetVariable (vl_refObjectoPreferencias_BBLci;"$t_cuentaCorreo";->$t_cuentaCorreo)
OT GetVariable (vl_refObjectoPreferencias_BBLci;"$t_contraseña";->$t_contraseña)
OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_utilizarSSL";->$l_utilizarSSL)
OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_puerto";->$l_puerto)
OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_modoAutenticacion";->$l_modoAutenticacion)
If (($t_servidorCorreo="") | ($t_cuentaCorreo=""))
	$t_servidorCorreo:="mail.colegium.com"
	$t_usuarioSMTP:="appSchoolTrack@colegium.com"
	$t_contraseña:="quasimodo"
	$l_utilizarSSL:=0
	$l_puerto:=0
	$l_modoAutenticacion:=2
	If ($t_cuentaCorreo="")
		$t_Remitente:="mediatrack-NoReply@colegium.com"
	Else 
		$t_Remitente:=$t_cuentaCorreo
	End if 
Else 
	$t_usuarioSMTP:=$t_cuentaCorreo
	$t_Remitente:=$t_cuentaCorreo
End if 
$t_error:=Mail_QuickSend ($t_servidorCorreo;$t_Remitente;$t_destinatario;$t_asunto;$t_mensaje;$l_utilizarSSL;$l_puerto;$t_usuarioSMTP;$t_contraseña;$l_modoAutenticacion-1)

$0:=$t_error

