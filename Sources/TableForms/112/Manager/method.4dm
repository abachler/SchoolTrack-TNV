Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		xALP_SET_ADT_PostHist 
		OBJECT SET TITLE:C194(bObs;__ ("Observaciones"))
		_O_DISABLE BUTTON:C193(bObs)
		_O_DISABLE BUTTON:C193(bDeletePH)
		PST_InitVariablesPH 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
