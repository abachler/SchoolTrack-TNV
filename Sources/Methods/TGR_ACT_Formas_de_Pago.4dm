//%attributes = {}
  //TGR_ACT_Formas_de_Pago

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)

If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				READ WRITE:C146([ACT_EstadosFormasdePago:201])
				QUERY:C277([ACT_EstadosFormasdePago:201];[ACT_EstadosFormasdePago:201]id_forma_pago:2=[ACT_Formas_de_Pago:287]id:1)
				DELETE SELECTION:C66([ACT_EstadosFormasdePago:201])
				KRL_UnloadReadOnly (->[ACT_EstadosFormasdePago:201])
				
		End case 
	End if 
	
End if 



