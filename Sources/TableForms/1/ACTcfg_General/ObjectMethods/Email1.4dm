If (Semaphore:C143("GeneracionPDFAvisoXEmail"))  //20130905 RCH Para evitar que se modifique la conf mientras se esta en un proceso de envio...
	CD_Dlog (0;__ ("En estos momentos hay un proceso de generación de PDFs en curso. Intente realizar la operación más tarde."))
Else 
	
	If (Semaphore:C143("EnvioPDFAvisoXEmail"))
		CD_Dlog (0;__ ("En estos momentos hay un proceso de envío de e-Mail en curso. Intente realizar la operación más tarde."))
	Else 
		
		WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTcfg_TextoMail";-1;4;__ ("Texto del cuerpo del correo"))
		DIALOG:C40([xxSTR_Constants:1];"ACTcfg_TextoMail")
		CLOSE WINDOW:C154
		
		CLEAR SEMAPHORE:C144("EnvioPDFAvisoXEmail")
	End if 
	CLEAR SEMAPHORE:C144("GeneracionPDFAvisoXEmail")
End if 