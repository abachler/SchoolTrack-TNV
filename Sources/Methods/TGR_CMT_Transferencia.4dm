//%attributes = {}
  // Método: TGR_CMT_Transferencia
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:17:08
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones

  // Código principal
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)
If (Not:C34(<>vb_ImportHistoricos_STX))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			If ([CMT_Transferencia:158]Id:1=0)
				[CMT_Transferencia:158]Id:1:=SQ_SeqNumber (->[CMT_Transferencia:158]Id:1)
			End if 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
End if 



