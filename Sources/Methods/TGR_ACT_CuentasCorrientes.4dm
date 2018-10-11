//%attributes = {}
  // Método: TGR_ACT_CuentasCorrientes
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 09:46:14
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
				[ACT_CuentasCorrientes:175]ID:1:=SQ_SeqNumber (->[ACT_CuentasCorrientes:175]ID:1)
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				ACTter_Datos_ALP ("EliminaRegistrosCuentasCtes";->[ACT_CuentasCorrientes:175]ID:1)
		End case 
	End if 
End if 



