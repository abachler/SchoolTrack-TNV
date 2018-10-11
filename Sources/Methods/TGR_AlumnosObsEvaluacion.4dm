//%attributes = {}
  // Método: TGR_AlumnosObsEvaluacion
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:03:07
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
				[Alumnos_ObservacionesEvaluacion:30]Key:9:=KRL_MakeStringAccesKey (->[Alumnos_ObservacionesEvaluacion:30]ID_Alumno:1;->[Alumnos_ObservacionesEvaluacion:30]ID_Asignatura:2;->[Alumnos_ObservacionesEvaluacion:30]Periodo:3)
				[Alumnos_ObservacionesEvaluacion:30]DTS_FechaHoraModificacion:7:=[Alumnos_ObservacionesEvaluacion:30]DTS_FechaHoraCreacion:6
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				[Alumnos_ObservacionesEvaluacion:30]Key:9:=KRL_MakeStringAccesKey (->[Alumnos_ObservacionesEvaluacion:30]ID_Alumno:1;->[Alumnos_ObservacionesEvaluacion:30]ID_Asignatura:2;->[Alumnos_ObservacionesEvaluacion:30]Periodo:3)
				[Alumnos_ObservacionesEvaluacion:30]DTS_FechaHoraModificacion:7:=DTS_MakeFromDateTime (Current date:C33;Current time:C178)
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
		End case 
		
	End if 
End if 



