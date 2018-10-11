//%attributes = {}
  // Método: TGR_TMT_Salas
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:35:01
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
				  //: (Database event=On Loading Record Event)
				
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				[TMT_Salas:167]ID_Sala:1:=SQ_SeqNumber (->[TMT_Salas:167]ID_Sala:1)
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				If ([TMT_Salas:167]NombreSala:2#Old:C35([TMT_Salas:167]NombreSala:2))
					READ WRITE:C146([TMT_Horario:166])
					QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Sala:6=[TMT_Salas:167]ID_Sala:1)
					ARRAY TEXT:C222($at_Sala;Records in selection:C76([TMT_Horario:166]))
					AT_Populate (->$at_Sala;->[TMT_Salas:167]NombreSala:2)
					ARRAY TO SELECTION:C261($at_Sala;[TMT_Horario:166]Sala:8)
				End if 
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				READ WRITE:C146([TMT_Horario:166])
				QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Sala:6=[TMT_Salas:167]ID_Sala:1)
				ARRAY TEXT:C222($at_Sala;Records in selection:C76([TMT_Horario:166]))
				$t_vacio:=""
				AT_Populate (->$at_Sala;->$t_vacio)
				ARRAY TO SELECTION:C261($at_Sala;[TMT_Horario:166]Sala:8)
		End case 
	End if 
End if 



