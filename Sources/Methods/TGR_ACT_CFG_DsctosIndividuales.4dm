//%attributes = {}
  //TGR_ACT_CFG_DsctosIndividuales

  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)

  // Código principal

If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				[ACT_DctosIndividuales_Cuentas:228]DTS_Creacion:3:=DTS_MakeFromDateTime 
				[ACT_DctosIndividuales_Cuentas:228]DTS_Modificacion:4:=DTS_MakeFromDateTime 
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				[ACT_DctosIndividuales_Cuentas:228]DTS_Modificacion:4:=DTS_MakeFromDateTime 
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
				
		End case 
	End if 
End if 