//%attributes = {}
  // MSGws_EnviaMensaje_out()
  // Por: Alberto Bachler: 12/06/13, 17:35:24
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_BLOB:C604($x_Mensaje)
C_LONGINT:C283($l_IdMensaje;$l_tipo)
C_TEXT:C284($t_accion;$t_componente;$t_dts;$t_modulo;$t_Referencia;$t_textoError)
If (False:C215)
	C_LONGINT:C283(MSGws_EnviaMensaje_out ;$1)
End if 

$l_IdMensaje:=$1
KRL_FindAndLoadRecordByIndex (->[xShell_MensajesAplicacion:244]ID:5;->$l_IdMensaje)
TEXT TO BLOB:C554([xShell_MensajesAplicacion:244]Mensaje:4;$x_Mensaje;UTF8 text without length:K22:17)

$t_modulo:=[xShell_MensajesAplicacion:244]Modulo:1
$t_componente:=[xShell_MensajesAplicacion:244]Componente:2
$t_accion:=[xShell_MensajesAplicacion:244]Acción:3
$l_IdMensaje:=[xShell_MensajesAplicacion:244]ID:5
$l_tipo:=[xShell_MensajesAplicacion:244]Tipo:6
$t_Referencia:=[xShell_MensajesAplicacion:244]Referencia:7
$t_dts:=[xShell_MensajesAplicacion:244]DTS_modificacion:8

WEB SERVICE SET PARAMETER:C777("modulo";$t_modulo)
WEB SERVICE SET PARAMETER:C777("componente";$t_componente)
WEB SERVICE SET PARAMETER:C777("accion";$t_accion)
WEB SERVICE SET PARAMETER:C777("Mensaje";$x_Mensaje)
WEB SERVICE SET PARAMETER:C777("IdMensaje";$l_IdMensaje)
WEB SERVICE SET PARAMETER:C777("tipo";$l_tipo)
WEB SERVICE SET PARAMETER:C777("Referencia";$t_Referencia)
WEB SERVICE SET PARAMETER:C777("dts";$t_dts)

$t_textoError:=WS_CallIntranetWebService ("WSmsg_RecibeMensaje_in")

vl_resultado:=-1
If ($t_textoError="")
	WEB SERVICE GET RESULT:C779(vl_resultado;"resultado";*)
End if 

$0:=vl_Resultado

