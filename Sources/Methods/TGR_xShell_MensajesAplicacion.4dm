//%attributes = {}
  // TGR_xShell_MensajesAplicacion()
  // Por: Alberto Bachler K.: 08-04-15, 16:51:53
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[xShell_MensajesAplicacion:244]DTS_modificacion:8:=DTS_Get_GMT_TimeStamp 
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			If (KRL_RegistroFueModificado (->[xShell_MensajesAplicacion:244]))
				[xShell_MensajesAplicacion:244]DTS_modificacion:8:=DTS_Get_GMT_TimeStamp 
			End if 
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	
End if 