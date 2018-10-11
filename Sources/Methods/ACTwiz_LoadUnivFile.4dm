//%attributes = {}
  //ACTwiz_LoadUnivFile

If (USR_GetMethodAcces (Current method name:C684))
	WDW_OpenFormWindow (->[xxACT_ArchivosBancarios:118];"ImportUniverso";0;4;__ ("Lectura archivo universo"))
	DIALOG:C40([xxACT_ArchivosBancarios:118];"ImportUniverso")
	ACTtf_DeclareArrays 
	CLOSE WINDOW:C154
End if 