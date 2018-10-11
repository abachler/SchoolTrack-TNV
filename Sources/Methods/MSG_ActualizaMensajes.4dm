//%attributes = {"executedOnServer":true}
  // MSG_ActualizaMensajes()
  // Por: Alberto Bachler: 22/04/13, 16:06:11
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_Id;$l_idRegistro;$l_registros)
C_TEXT:C284($t_carpetaPreferenciasMensajes;$t_documento;$t_dts)


ALL RECORDS:C47([xShell_MensajesAplicacion:244])
KRL_DeleteSelection (->[xShell_MensajesAplicacion:244])

If (Records in table:C83([xShell_MensajesAplicacion:244])=0)
	CREATE RECORD:C68([xShell_MensajesAplicacion:244])
	[xShell_MensajesAplicacion:244]ID:5:=-1
	[xShell_MensajesAplicacion:244]Modulo:1:="Registro omitido (recNum0)"
	SAVE RECORD:C53([xShell_MensajesAplicacion:244])
End if 

$t_carpetaPreferenciasMensajes:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+"Mensajes"
SYS_CreateFolder ($t_carpetaPreferenciasMensajes)

$t_documento:=$t_carpetaPreferenciasMensajes+Folder separator:K24:12+"mensajes.txt"

SET CHANNEL:C77(10;$t_documento)
If (OK=1)
	RECEIVE VARIABLE:C81($l_registros)
	If ($l_registros#0)
		For ($i_registros;1;$l_registros)
			RECEIVE VARIABLE:C81($l_idRegistro)
			RECEIVE VARIABLE:C81($t_dts)
			KRL_FindAndLoadRecordByIndex (->[xShell_MensajesAplicacion:244]ID:5;->$l_idRegistro;True:C214)
			If ([xShell_MensajesAplicacion:244]DTS_modificacion:8<$t_dts)
				RECEIVE RECORD:C79([xShell_MensajesAplicacion:244])
				SAVE RECORD:C53([xShell_MensajesAplicacion:244])
			Else 
				RECEIVE RECORD:C79([xShell_MensajesAplicacion:244])
			End if 
		End for 
	End if 
	SET CHANNEL:C77(11)
End if 

If (Records in table:C83([xShell_MensajesAplicacion:244])=0)
	CREATE RECORD:C68([xShell_MensajesAplicacion:244])
	[xShell_MensajesAplicacion:244]ID:5:=-1
	[xShell_MensajesAplicacion:244]Modulo:1:="Registro omitido (recNum0)"
	SAVE RECORD:C53([xShell_MensajesAplicacion:244])
End if 

ALL RECORDS:C47([xShell_MensajesAplicacion:244])
ORDER BY:C49([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]ID:5;<)
SET DATABASE PARAMETER:C642([xShell_MensajesAplicacion:244];Table sequence number:K37:31;[xShell_MensajesAplicacion:244]ID:5)
$l_Id:=Get database parameter:C643([xShell_MensajesAplicacion:244];Table sequence number:K37:31)

