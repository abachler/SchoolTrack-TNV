
Case of 
	: (Form event:C388=On Clicked:K2:4)
		WDW_OpenFormWindow (->[xxACT_ArchivosBancarios:118];"Configuracion";-1;4;__ ("Configuración avanzada"))
		BWR_ModifyRecord (->[xxACT_ArchivosBancarios:118];"Configuracion")
		CLOSE WINDOW:C154
End case 


