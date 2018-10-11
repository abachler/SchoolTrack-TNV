Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ACTbol_LoadParamsSubvenciones 
		IT_SetEnterable (cs_g01=1;0;->vt_TextoImprimir)
		If (cs_g01=0)
			vt_TextoImprimir:=""
		End if 
		wref:=WDW_GetWindowID 
	: (Form event:C388=On Deactivate:K2:10)
		WDW_SetFrontmost (wref)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
