//%attributes = {}
  // TGR_BBL_Lectores()
  // Por: Alberto Bachler: 16/11/13, 19:29:10
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)


If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		
		If (Not:C34(Util_isValidUUID ([BBL_Lectores:72]Auto_UUID:46)))
			[BBL_Lectores:72]Auto_UUID:46:=Generate UUID:C1066
		End if 
		
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				[BBL_Lectores:72]Código_de_barra:10:=ST_Uppercase ([BBL_Lectores:72]Código_de_barra:10)
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				[BBL_Lectores:72]Código_de_barra:10:=ST_Uppercase ([BBL_Lectores:72]Código_de_barra:10)
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
		End case 
	End if 
End if 



