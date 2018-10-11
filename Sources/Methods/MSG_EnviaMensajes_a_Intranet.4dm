//%attributes = {}
  // MSG_EnviaMensajes_a_Intranet()
  // Por: Alberto Bachler: 12/06/13, 18:40:20
  //  ---------------------------------------------
  // Envia todos los mensajes a la intranet
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_error)

ARRAY LONGINT:C221($al_RecNums;0)

ALL RECORDS:C47([xShell_MensajesAplicacion:244])

LONGINT ARRAY FROM SELECTION:C647([xShell_MensajesAplicacion:244];$al_RecNums;"")
For ($i;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([xShell_MensajesAplicacion:244];$al_RecNums{$i})
	$l_error:=MSGws_EnviaMensaje_out ([xShell_MensajesAplicacion:244]ID:5)
	If ($l_error<0)
		ALERT:C41("Error al enviar los mensajes a la Intranet")
		$i:=Size of array:C274($al_RecNums)
	End if 
End for 

