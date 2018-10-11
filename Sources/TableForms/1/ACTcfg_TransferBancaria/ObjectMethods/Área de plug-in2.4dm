Case of 
	: (alProEvt=1)
		$line:=AL_GetLine (Self:C308->)
		IT_SetButtonState (($line>0);->bDeleteArchivo)
	: (alProEvt=2)
		$line:=AL_GetLine (Self:C308->)
		IT_SetButtonState (($line>0);->bDeleteArchivo)
		READ WRITE:C146([xxACT_ArchivosBancarios:118])
		$id:=alACT_ABArchivoID{$line}
		QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ID:1=$id)
		If (Records in selection:C76([xxACT_ArchivosBancarios:118])=1)
			WDW_OpenFormWindow (->[xxACT_ArchivosBancarios:118];"Input";-1;4;__ ("Modificación de archivo de transferencia bancaria");"WDW_CloseDlog")
			BWR_ModifyRecord (->[xxACT_ArchivosBancarios:118];"Input")
			CLOSE WINDOW:C154
			ACTcfg_UpdateTransferAreas 
		Else 
			KRL_UnloadReadOnly (->[xxACT_ArchivosBancarios:118])
			BEEP:C151
		End if 
End case 