//%attributes = {}
  // Método: TGR_xxSTR_EstilosEvaluacion
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:56:00
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			If ([xxSTR_EstilosEvaluacion:44]ID:1=0)
				[xxSTR_EstilosEvaluacion:44]ID:1:=SQ_SeqNumber (->[xxSTR_EstilosEvaluacion:44]ID:1)
			End if 
			[xxSTR_EstilosEvaluacion:44]dtsModificacion:14:=Timestamp:C1445
			[xxSTR_EstilosEvaluacion:44]dtsCreacion:13:=Timestamp:C1445
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			If ([xxSTR_EstilosEvaluacion:44]ID:1=0)
				[xxSTR_EstilosEvaluacion:44]ID:1:=SQ_SeqNumber (->[xxSTR_EstilosEvaluacion:44]ID:1)
			End if 
			[xxSTR_EstilosEvaluacion:44]dtsModificacion:14:=Timestamp:C1445
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
End if 



