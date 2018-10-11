Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		IT_SetButtonState (False:C215;->bDelete)
		ACTtbl_CargaGlosasExtra 
		xALP_Set_ACT_GExtra 
		AL_SetLine (xALP_Glosas;0)
		vbACT_ModGlosasExtra:=False:C215
		cbReplace:=0
End case 
