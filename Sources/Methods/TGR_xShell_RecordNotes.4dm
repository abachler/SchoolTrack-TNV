//%attributes = {}
  // TGR_xShell_RecordNotes()
  // Por: Alberto Bachler K.: 08-04-15, 16:53:18
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[xShell_RecordNotes:283]DTS:6:=String:C10(Current date:C33;ISO date GMT:K1:10;Current time:C178)
			[xShell_RecordNotes:283]Llave:4:=String:C10([xShell_RecordNotes:283]ID_Tabla:1)+"."+[xShell_RecordNotes:283]UUID_Registro:2+"."+[xShell_RecordNotes:283]Referencia:3
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
End if 