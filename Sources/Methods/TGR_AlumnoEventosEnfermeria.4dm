//%attributes = {}
  // Método: TGR_AlumnoEventosEnfermeria
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 09:59:57
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				[Alumnos_EventosEnfermeria:14]ID:15:=SQ_SeqNumber (->[Alumnos_EventosEnfermeria:14]ID:15)
		End case 
	End if 
	SN3_MarcarRegistros (SN3_DTi_Salud;SN3_SDTx_EventosEnfermeria)
End if 



