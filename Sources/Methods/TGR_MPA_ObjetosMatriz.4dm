//%attributes = {}
  // TGR_MPA_ObjetosMatriz()
  // 
  //
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[MPA_ObjetosMatriz:204]Llave_unica:27:="0."+String:C10([MPA_ObjetosMatriz:204]ID_Matriz:1)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[MPA_ObjetosMatriz:204]Llave_unica:27:="0."+String:C10([MPA_ObjetosMatriz:204]ID_Matriz:1)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Eje:3)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4)+"."+String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5)
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
End if 



