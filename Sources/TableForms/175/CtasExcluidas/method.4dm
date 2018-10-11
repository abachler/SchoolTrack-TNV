Case of 
	: (Form event:C388=On Load:K2:1)
		C_BOOLEAN:C305(vbACT_formPDFs)
		XS_SetInterface 
		xALP_Set_ACT_CtasExluidas 
		C_BOOLEAN:C305(vbACT_AllowGeneration)
		OBJECT SET TITLE:C194(bCancelar;vBtnTitle)
		IT_SetButtonState (vbACT_AllowGeneration;->bGenerate)
		OBJECT SET VISIBLE:C603(bCancel;vbACT_MostrarBoton)
		OBJECT SET VISIBLE:C603(bPrint;Not:C34(vbACT_formPDFs))  //20131002 RCH. Cuando es por PDF no se muestra el boton
End case 
