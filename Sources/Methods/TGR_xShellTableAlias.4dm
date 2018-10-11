//%attributes = {}
  // TGR_xShellTableAlias()
  // Por: Alberto Bachler K.: 08-04-15, 16:54:56
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[xShell_TableAlias:199]PaisLenguaje:4:=Substring:C12([xShell_TableAlias:199]TableRef:1;Position:C15(".";[xShell_TableAlias:199]TableRef:1)+1)
			If ([xShell_TableAlias:199]DTS:3="")
				[xShell_TableAlias:199]DTS:3:=DTS_Get_GMT_TimeStamp (Current date:C33(*);Current time:C178(*))
			End if 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[xShell_TableAlias:199]PaisLenguaje:4:=Substring:C12([xShell_TableAlias:199]TableRef:1;Position:C15(".";[xShell_TableAlias:199]TableRef:1)+1)
			If (([xShell_TableAlias:199]DTS:3="") | (([xShell_TableAlias:199]Alias:2#Old:C35([xShell_TableAlias:199]Alias:2))))
				[xShell_TableAlias:199]DTS:3:=DTS_Get_GMT_TimeStamp (Current date:C33(*);Current time:C178(*))
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
End if 

