Case of 
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		ALP_SetInterface (xALP_PlanillaIntereses)
		
	: (Form event:C388=On Activate:K2:9)
		XS_SetInterface 
		ALP_SetInterface (xALP_PlanillaIntereses)
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		xALSet_ACT_PlanillaIntereses 
		AL_SetLine (xALP_PlanillaIntereses;0)
		_O_DISABLE BUTTON:C193(bDelCargos)
		ARRAY LONGINT:C221(alACT_AvisosModInt;0)
		modInt:=False:C215
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 