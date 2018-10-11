If (ADTcdd_esRegistroValido )
	
	SAVE RECORD:C53([Alumnos:2])
	WDW_OpenFormWindow (->[ADT_Candidatos:49];"Documentacion";0;Palette form window:K39:9;__ ("Documentación"))
	DIALOG:C40([ADT_Candidatos:49];"Documentacion")
	CLOSE WINDOW:C154
	
End if 