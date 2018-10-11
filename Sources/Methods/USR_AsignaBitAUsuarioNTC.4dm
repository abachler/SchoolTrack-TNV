//%attributes = {}
  //USR_AsignaBitAUsuarioNTC

C_LONGINT:C283($l_userId)
C_LONGINT:C283($l_bitsModules)
C_TEXT:C284($t_parametros)
C_BOOLEAN:C305($b_done)

$t_parametros:=$1

ST_Deconcatenate (";";$t_parametros;->$l_userId;->$l_bitsModules)

$b_done:=True:C214

KRL_FindAndLoadRecordByIndex (->[xShell_Users:47]No:1;->$l_userId;True:C214)
If ([xShell_Users:47]ReceiveNotifications_Modules:22=0)  //validacion para no intervenir posible configuracion ya realizada.
	If (ok=1)
		[xShell_Users:47]ReceiveNotifications_Modules:22:=$l_bitsModules  // actualizo el longint con los módulos autorizados/no autorizados
		If ([xShell_Users:47]Receive_email:21)
			[xShell_Users:47]ReceiveNotifications_Modules:22:=[xShell_Users:47]ReceiveNotifications_Modules:22 ?+ 0
		End if 
		SAVE RECORD:C53([xShell_Users:47])
	Else 
		If (Records in selection:C76([xShell_Users:47])=1)  // si encontramos usuario pero estaba en uso el registro, la tarea no se ejecuto
			$b_done:=False:C215
		End if 
	End if 
End if 
KRL_UnloadReadOnly (->[xShell_Users:47])

$0:=$b_done