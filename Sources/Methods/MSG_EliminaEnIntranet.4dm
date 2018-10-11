//%attributes = {}
  // MSG_EliminaEnIntranet()
  // Por: Alberto Bachler: 18/06/13, 11:50:12
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_MensajeEliminado)
C_LONGINT:C283($l_IdMensaje)
C_TEXT:C284($t_textoError)

If (False:C215)
	C_BOOLEAN:C305(MSG_EliminaEnIntranet ;$0)
	C_LONGINT:C283(MSG_EliminaEnIntranet ;$1)
End if 

$l_IdMensaje:=$1
WEB SERVICE SET PARAMETER:C777("id";$l_IdMensaje)

$t_textoError:=WS_CallIntranetWebService ("WSmsg_EliminaMensaje")

If ($t_textoError="")
	WEB SERVICE GET RESULT:C779($b_MensajeEliminado;"mensajeEliminado";*)  //20180514 RCH Ticket 206788
End if 

$0:=$b_MensajeEliminado

