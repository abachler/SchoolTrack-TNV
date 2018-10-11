Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ACTcc_OpcionesAlertas ("DeclaraVars")
		ACTcc_OpcionesAlertas ("LlenaAsuntoYCuerpo")
		IT_SetEnterable (Not:C34(vbACTSM_SubjectDesh);0;->vtACT_subject)
		IT_SetEnterable (Not:C34(vbACTSM_BodyDesh);0;->vtACT_Body)
		IT_SetEnterable (Not:C34(vbACTSM_ToDesh);0;->vtACT_To)
		IT_SetEnterable (Not:C34(vbACTSM_CCDesh);0;->vtACT_CC)
		IT_SetEnterable (Not:C34(vbACTSM_BCCDesh);0;->vtACT_BCC)
End case 