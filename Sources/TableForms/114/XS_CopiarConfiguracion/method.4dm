Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		
		vtXS_CountryFrom:="cl"
		vtXS_LangageFrom:="es"
		vtXS_Countryto:=""
		vtXS_Langageto:=""
		cb_CopiarATodosPaises:=0
		cb_CopiarATodosLang:=0
		
		cb_CopyBlobs:=0
		cb_CopyFields:=0
		cb_CopyCommands:=0
		
		cb_CopyRSRList:=0
		cb_CopyRSRSTR:=0
		cb_CopyRSRText:=0
		
		_O_DISABLE BUTTON:C193(bCopy)
		
		hl_Paises1:=Load list:C383("XS_CountryCodes")
		hl_Paises2:=Load list:C383("XS_CountryCodes")
		hl_langages1:=Load list:C383("XS_LangageCodes")
		hl_langages2:=Load list:C383("XS_LangageCodes")
		
		IT_SetButtonState (True:C214;->hl_Paises2;->hl_langages2)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 