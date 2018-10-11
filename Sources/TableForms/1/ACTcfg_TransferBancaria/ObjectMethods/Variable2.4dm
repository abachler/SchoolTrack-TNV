$line:=AL_GetLine (xALP_Archivos)
If ($line>0)
	$r:=CD_Dlog (0;__ ("¿Está seguro que desea eliminar el archivo ")+atACT_ABArchivoNombre{$line}+__ ("?");__ ("");__ ("No");__ ("Si"))
	If ($r=2)
		$id:=alACT_ABArchivoID{$line}
		READ WRITE:C146([xxACT_ArchivosBancarios:118])
		QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ID:1=$id)
		If (Records in selection:C76([xxACT_ArchivosBancarios:118])=1)
			LOG_RegisterEvt ("Eliminación de archivo de transferencia número: "+String:C10([xxACT_ArchivosBancarios:118]ID:1)+", nombre: "+[xxACT_ArchivosBancarios:118]Nombre:3+", tipo: "+[xxACT_ArchivosBancarios:118]Tipo:6)
			DELETE RECORD:C58([xxACT_ArchivosBancarios:118])
			KRL_UnloadReadOnly (->[xxACT_ArchivosBancarios:118])
			ACTcfg_UpdateTransferAreas 
		Else 
			BEEP:C151
		End if 
	End if 
End if 