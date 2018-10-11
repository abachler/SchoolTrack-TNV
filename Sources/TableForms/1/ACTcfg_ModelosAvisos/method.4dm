Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ACTcfg_LoadAvModels 
		xALPSet_ACT_ModelosAv 
		IT_SetButtonState (False:C215;->bEditarModelo;->bGuardarModelo;->bBorrarModelo;->bDuplicarModelo;->cb_EsEstandar)
		AL_SetLine (xAL_ModelosAvisos;0)
		$cond:=((Not:C34(Is compiled mode:C492)) & (<>lUSR_CurrentUserID<0))
		OBJECT SET VISIBLE:C603(*;"estandar@";$cond)
		cb_EsEstandar:=0
		ACTcfg_MarkStandardAvModels 
		AL_SetSort (xAL_ModelosAvisos;1)
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		ALP_SetInterface (xAL_ModelosAvisos)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
