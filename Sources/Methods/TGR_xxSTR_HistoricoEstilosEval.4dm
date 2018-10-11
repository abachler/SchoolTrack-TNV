//%attributes = {}
  // TGR_xxSTR_HistoricoEstilosEval()
  // Por: Alberto Bachler K.: 08-04-15, 17:05:46
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			If ([xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3=0)
				[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3:=SQ_SeqNumber (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3)
			End if 
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			If ([xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3=0)
				[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3:=SQ_SeqNumber (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3)
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	
End if 




