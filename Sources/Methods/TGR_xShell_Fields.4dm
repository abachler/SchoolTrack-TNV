//%attributes = {}
  // TGR_xShell_Fields()
  // Por: Alberto Bachler K.: 08-04-15, 16:39:47
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[xShell_Fields:52]ID:24:=SQ_SeqNumber (->[xShell_Fields:52]ID:24)
			If ([xShell_Fields:52]FormatoNombres:15#0)
				READ WRITE:C146([xShell_Tables:51])
				RELATE ONE:C42([xShell_Fields:52]NumeroTabla:1)
				[xShell_Tables:51]EnConfiguracionFormatos:38:=True:C214
				SAVE RECORD:C53([xShell_Tables:51])
				KRL_ReloadAsReadOnly (->[xShell_Tables:51])
			End if 
			[xShell_Fields:52]ReferenciaTablaCampo:7:=KRL_MakeStringAccesKey (->[xShell_Fields:52]NumeroTabla:1;->[xShell_Fields:52]NumeroCampo:2)
			[xShell_Fields:52]DTS_modificacion:25:=DTS_Get_GMT_TimeStamp 
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			If ([xShell_Fields:52]ID:24=0)
				[xShell_Fields:52]ID:24:=SQ_SeqNumber (->[xShell_Fields:52]ID:24)
			End if 
			If ([xShell_Fields:52]FormatoNombres:15#0)
				READ WRITE:C146([xShell_Tables:51])
				RELATE ONE:C42([xShell_Fields:52]NumeroTabla:1)
				[xShell_Tables:51]EnConfiguracionFormatos:38:=True:C214
				SAVE RECORD:C53([xShell_Tables:51])
				KRL_ReloadAsReadOnly (->[xShell_Tables:51])
			End if 
			[xShell_Fields:52]DTS_modificacion:25:=DTS_Get_GMT_TimeStamp 
			[xShell_Fields:52]ReferenciaTablaCampo:7:=KRL_MakeStringAccesKey (->[xShell_Fields:52]NumeroTabla:1;->[xShell_Fields:52]NumeroCampo:2)
			
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
			
	End case 
End if 