//%attributes = {}
  // Método: TGR_xxACT_ArchivosBancarios
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:48:19
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
				If ([xxACT_ArchivosBancarios:118]CreadoPorAsistente:9=False:C215)
					[xxACT_ArchivosBancarios:118]ID:1:=SQ_SeqNumber (->[xxACT_ArchivosBancarios:118]ID:1)
				Else 
					[xxACT_ArchivosBancarios:118]ID:1:=SQ_SeqNumber (->[xxACT_ArchivosBancarios:118]ID:1;True:C214)
				End if 
		End case 
		
	End if 
End if 



