//%attributes = {}
  // Método: TGR_xxSTR_Materias
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:57:49
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
				[xxSTR_Materias:20]ID_Materia:16:=SQ_SeqNumber (->[xxSTR_Materias:20]ID_Materia:16)
				If ([xxSTR_Materias:20]Materia_NombreLargo:20="")
					[xxSTR_Materias:20]Materia_NombreLargo:20:=[xxSTR_Materias:20]Materia:2
				End if 
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				If ([xxSTR_Materias:20]Materia_NombreLargo:20="")
					[xxSTR_Materias:20]Materia_NombreLargo:20:=[xxSTR_Materias:20]Materia:2
				End if 
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
		End case 
		
		
	End if 
End if 



