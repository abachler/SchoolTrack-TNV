//%attributes = {}
  // TGR_xShell_FieldAlias()
  // Por: Alberto Bachler K.: 08-04-15, 16:48:49
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[xShell_FieldAlias:198]Referencia_tablaCampo:1:=ST_GetWord ([xShell_FieldAlias:198]FieldRef:5;1;".")+"."+ST_GetWord ([xShell_FieldAlias:198]FieldRef:5;2;".")
			[xShell_FieldAlias:198]PaisLenguaje:6:=ST_GetWord ([xShell_FieldAlias:198]FieldRef:5;3;".")+"."+ST_GetWord ([xShell_FieldAlias:198]FieldRef:5;4;".")
			If ([xShell_FieldAlias:198]DTS:7="")
				[xShell_FieldAlias:198]DTS:7:=DTS_Get_GMT_TimeStamp (Current date:C33(*);Current time:C178(*))
			End if 
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[xShell_FieldAlias:198]Referencia_tablaCampo:1:=ST_GetWord ([xShell_FieldAlias:198]FieldRef:5;1;".")+"."+ST_GetWord ([xShell_FieldAlias:198]FieldRef:5;2;".")
			[xShell_FieldAlias:198]PaisLenguaje:6:=ST_GetWord ([xShell_FieldAlias:198]FieldRef:5;3;".")+"."+ST_GetWord ([xShell_FieldAlias:198]FieldRef:5;4;".")
			
			  //If (([xShell_FieldAlias]DTS="") | (([xShell_FieldAlias]Alias#Old([xShell_FieldAlias]Alias))))
			  //[xShell_FieldAlias]DTS:=DTS_Get_GMT_TimeStamp (Current date(*);Current time(*))
			  //End if 
			[xShell_FieldAlias:198]DTS:7:=DTS_Get_GMT_TimeStamp (Current date:C33(*);Current time:C178(*))
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
End if 
