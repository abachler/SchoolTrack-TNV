Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vdACT_FechaPago:=Current date:C33(*)
		vdACT_FechaDocumento:=!00-00-00!
		ACTvr_LoadItems 
		xALP_Set_ACT_ItemsRapidos 
		ACTpgs_ClearDlogVarsVR 
		AL_SetEnterable (ALP_ItemsVentaRapida;3;Num:C11(USR_GetMethodAcces ("ACTpgs_CreaCargoDesctoEspecial";0)))
		IT_SetButtonState (False:C215;->bFormasdePago;->bIngresarPago)
		FORM GOTO PAGE:C247(1)
		atACT_FormasdePago:=1
		vsACT_FormasdePago:=atACT_FormasdePago{atACT_FormasdePago}
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		ALP_SetInterface (ALP_ItemsRapidos)
		ALP_SetInterface (ALP_ItemsVentaRapida)
		
	: (Form event:C388=On Activate:K2:9)
		XS_SetInterface 
		ALP_SetInterface (ALP_ItemsRapidos)
		ALP_SetInterface (ALP_ItemsVentaRapida)
End case 