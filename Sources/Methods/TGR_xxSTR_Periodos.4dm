//%attributes = {}
  // Método: TGR_xxSTR_Periodos
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:59:32
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
	
	If (Not:C34(<>vb_AvoidTriggerExecution))
		
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				READ WRITE:C146([xxSTR_DatosPeriodos:132])
				QUERY:C277([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]ID_Configuracion:9=[xxSTR_Periodos:100]ID:1)
				DELETE SELECTION:C66([xxSTR_DatosPeriodos:132])
				
		End case 
		
	End if 
End if 



