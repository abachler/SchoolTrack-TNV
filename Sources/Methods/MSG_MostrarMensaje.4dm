//%attributes = {}
  // MSG_MostrarMensaje()
  // Por: Alberto Bachler: 27/03/13, 12:14:48
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_IdMensaje)
C_TEXT:C284($t_texto)

GET MACRO PARAMETER:C997(Highlighted method text:K5:18;$t_texto)
$l_IdMensaje:=Num:C11($t_texto)

KRL_FindAndLoadRecordByIndex (->[xShell_MensajesAplicacion:244]ID:5;->$l_IdMensaje;False:C215)

If (OK=1)
	WDW_OpenFormWindow (->[xShell_MensajesAplicacion:244];"Mensaje";-1;Pop up form window:K39:11)
	DIALOG:C40([xShell_MensajesAplicacion:244];"Mensaje")
	CLOSE WINDOW:C154
End if 

