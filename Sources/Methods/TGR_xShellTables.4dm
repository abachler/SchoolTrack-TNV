//%attributes = {}
  // TGR_xShellTables()
  // Por: Alberto Bachler K.: 08-04-15, 16:55:57
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[xShell_Tables:51]DTS_modificacion:8:=DTS_Get_GMT_TimeStamp 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[xShell_Tables:51]DTS_modificacion:8:=DTS_Get_GMT_TimeStamp 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
End if 
