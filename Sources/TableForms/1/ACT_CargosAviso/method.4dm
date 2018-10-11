Case of 
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		ALP_SetInterface (ALP_CargosXPagar)
		
	: (Form event:C388=On Activate:K2:9)
		XS_SetInterface 
		ALP_SetInterface (ALP_CargosXPagar)
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		xALSet_ACT_IngresoPagos 
		AL_SetLine (ALP_CargosXPagar;0)
		IT_SetButtonState (False:C215;->bSubir;->bBajar;->bDelCargos)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 