//%attributes = {}
  //TGR_AlumnosEvaluacionValorica

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)

If (Not:C34(<>vb_ImportHistoricos_STX))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[Alumnos_EvaluacionValorica:23]LlavePrimaria:28:=String:C10(<>gInstitucion)+"."+"."+String:C10([Alumnos_EvaluacionValorica:23]Nivel_Numero:27)+"."+String:C10(Abs:C99([Alumnos_EvaluacionValorica:23]Alumno_Numero:1))
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
			[Alumnos_EvaluacionValorica:23]LlavePrimaria:28:=String:C10(<>gInstitucion)+"."+"."+String:C10([Alumnos_EvaluacionValorica:23]Nivel_Numero:27)+"."+String:C10(Abs:C99([Alumnos_EvaluacionValorica:23]Alumno_Numero:1))
			
	End case 
End if 