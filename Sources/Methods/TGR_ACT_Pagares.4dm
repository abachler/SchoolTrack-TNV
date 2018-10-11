//%attributes = {}
  // Método: TGR_ACT_Pagares
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 09:49:10
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)

  // Código principal

If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				If ((Old:C35([ACT_Pagares:184]ID_Estado:6)#-101) & ([ACT_Pagares:184]ID_Estado:6=-101))
					
				End if 
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
		End case 
	End if 
End if 



