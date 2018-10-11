//%attributes = {}
  // TGR_BBL_Items()
  // Por: Alberto Bachler: 17/09/13, 13:45:22
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)


If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				BBlitm_ClasificacionPrincipal 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				BBlitm_ClasificacionPrincipal 
		End case 
	End if 
End if 



