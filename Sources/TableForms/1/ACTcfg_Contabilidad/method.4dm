Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		ACTcfg_ValidaCtasEspeciales 
		xAL_Set_ACT_Contabilidad 
		AL_UpdateArrays (xALP_Cuentas;0)
		AL_UpdateArrays (xALP_Centros;0)
		AL_UpdateArrays (xALP_CtasEspeciales;0)
		ACTcfg_LoadConfigData (10)
		AL_UpdateArrays (xALP_Cuentas;-2)
		AL_UpdateArrays (xALP_Centros;-2)
		AL_UpdateArrays (xALP_CtasEspeciales;-2)
		
		  //20121105 RCH pinta lineas de cuentas especiales por defecto
		ACTcfg_OpcionesContabilidad ("PintaCtasEspeciales")
		
		IT_SetButtonState (False:C215;->bClearCCo;->bClearCC;->bClearCEsp)
		AL_SetLine (xALP_Cuentas;0)
		AL_SetLine (xALP_Centros;0)
		AL_SetLine (xALP_CtasEspeciales;0)
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
