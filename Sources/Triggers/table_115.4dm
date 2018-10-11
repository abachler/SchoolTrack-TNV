  // Trigger sobre [BBL_Reservas]()
  // Por: Alberto Bachler K.: 20-05-15, 12:44:08
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)


If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		TGR_BBL_Reservas 
	End if 
End if 