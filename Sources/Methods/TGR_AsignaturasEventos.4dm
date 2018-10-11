//%attributes = {}
  // Método: TGR_AsignaturasEventos
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:05:05
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
				  //: (Database event=On Load Record Event)
				
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				[Asignaturas_Eventos:170]ID_Event:11:=SQ_SeqNumber (->[Asignaturas_Eventos:170]ID_Event:11)
				[Asignaturas_Eventos:170]DTS_creacion:6:=DTS_MakeFromDateTime   // MONO TICKET 179641
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				[Asignaturas_Eventos:170]DTS_ultimaModificacion:17:=DTS_MakeFromDateTime   // MONO TICKET 179641
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
		End case 
		SN3_MarcarRegistros (SN3_DTi_EventosAgenda)
	End if 
End if 



