$resp:=CD_Dlog (0;__ ("¿Desea importar un modelo de archivo de transferencia?");__ ("");__ ("Si");__ ("No");__ ("Cancelar"))
If ($resp#3)
	If ($resp=1)
		FORM SET INPUT:C55([xxACT_ArchivosBancarios:118];"Input")
		WDW_OpenFormWindow (->[xxACT_ArchivosBancarios:118];"Input";-1;4;__ ("Nuevo archivo de transferencia bancaria"))
		ADD RECORD:C56([xxACT_ArchivosBancarios:118];*)
		CLOSE WINDOW:C154
		ARRAY TEXT:C222(aTiposArchivosText;0)
		If (ok=1)
			ACTcfg_UpdateTransferAreas 
		End if 
	Else 
		WDW_OpenFormWindow (->[xxACT_ArchivosBancarios:118];"WizardO";-1;4;__ ("Edición de archivo ")+[xxACT_ArchivosBancarios:118]Nombre:3)
		DIALOG:C40([xxACT_ArchivosBancarios:118];"WizardO")
		CLOSE WINDOW:C154
		ACTtf_DeclareArrays 
		ARRAY TEXT:C222(aTiposArchivosText;0)
		If (ok=1)
			ACTcfg_UpdateTransferAreas 
		End if 
	End if 
End if 