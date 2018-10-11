Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		ACTtbl_CargaGlosasExtra 
		AL_UpdateArrays (xALP_FormasdePago;0)
		ACTcfg_OpcionesFormasDePago ("CargaArreglosConf")
		AL_UpdateArrays (xALP_FormasdePago;-2)
		xALP_Set_ACT_FdPago 
		ACTcfg_OpcionesFormasDePago ("ColorFormasDePagoXDefecto")
		vtACT_CPCAFechaCurrState:=vtACT_CPCAFecha
		vtACT_CCCAFechaCurrState:=vtACT_CCCAFecha
		vtACT_CCPCAFechaCurrState:=vtACT_CCPCAFecha
		vtACT_CCCCAFechaCurrState:=vtACT_CCCCAFecha
		vtACT_CAUXCCAFechaCurrState:=vtACT_CAUXCCAFecha
		vtACT_CAUXCCCAFechaCurrState:=vtACT_CAUXCCCAFecha
		
		vtACT_CICAFechaCurrState:=vtACT_CICAFecha
		
		vbACT_ModifiedCol:=False:C215
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
