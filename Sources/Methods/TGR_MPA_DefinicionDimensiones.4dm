//%attributes = {}
  // Método: TGR_MPA_DefinicionDimensiones
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:28:49
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
				MPAcfg_Dim_AlGuardar 
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				MPAcfg_Dim_AlGuardar 
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
		End case 
	End if 
	
End if 



