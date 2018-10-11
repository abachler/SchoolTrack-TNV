Case of 
	: (Form event:C388=On Load:K2:1)
		C_TEXT:C284(vtACT_MonedaSel)
		vtACT_MonedaSel:=""
		XS_SetConfigInterface 
		xALSet_ACT_ConfigImpuestoTimbre 
		xALSet_ACT_ConfigDivisas 
		  //xALSet_ACT_ConfigFreqFacturacio 
		xALSet_ACT_ConfigIPC 
		xALSet_ACT_UF 
		AL_UpdateArrays (xALP_Divisas;0)
		AL_UpdateArrays (xALP_UF;0)
		AL_UpdateArrays (xALP_IPC;0)
		AL_UpdateArrays (xALP_Impuesto;0)
		ACTcfg_LoadConfigData (6)
		AL_UpdateArrays (xALP_IPC;-2)
		AL_UpdateArrays (xALP_UF;-2)
		AL_UpdateArrays (xALP_Divisas;-2)
		AL_UpdateArrays (xALP_Impuesto;-2)
		
		AL_SetLine (xALP_Divisas;1)
		AL_UpdateArrays (xALP_Divisas;-1)
		ACTcfgmyt_OpcionesGenerales ("SeleccionaLineaForm")
		
		If (<>vtXS_CountryCode="cl")
			OBJECT SET VISIBLE:C603(*;"cl@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"cl@";False:C215)
		End if 
		_O_DISABLE BUTTON:C193(bDeleteMoneda)
		vrACT_IVAInicial:=<>vrACT_TasaIVA
		ACTcfg_ColorUndelDivisas 
		AL_SetLine (xALP_Divisas;0)
		
		  //20171018 RCH
		  //vtACT_URLUTMSII:="http://www.sii.cl/pagina/valores/utm/utmAAAA.htm"
		vtACT_URLUTMSII_PRE2017:="http://www.sii.cl/pagina/valores/utm/utmAAAA.htm"
		vtACT_URLUTMSII_2017:="http://www.sii.cl/valores_y_fechas/utm/utmAAAA.htm"  //20171018 RCH
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
