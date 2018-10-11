//%attributes = {}
  //TGR_AlumnosActividades


C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				[Alumnos_Actividades:28]ID:63:=SQ_SeqNumber (->[Alumnos_Actividades:28]ID:63)
				If ([Alumnos_Actividades:28]Año:3=<>gYear)
					[Alumnos_Actividades:28]Actividad_numero:2:=Abs:C99([Alumnos_Actividades:28]Actividad_numero:2)
					[Alumnos_Actividades:28]Alumno_Numero:1:=Abs:C99([Alumnos_Actividades:28]Alumno_Numero:1)
				Else 
					[Alumnos_Actividades:28]Actividad_numero:2:=-Abs:C99([Alumnos_Actividades:28]Actividad_numero:2)
					[Alumnos_Actividades:28]Alumno_Numero:1:=-Abs:C99([Alumnos_Actividades:28]Alumno_Numero:1)
				End if 
				[Alumnos_Actividades:28]LlavePrincipal:5:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Actividades:28]Año:3)+"."+String:C10([Alumnos_Actividades:28]Nivel_Numero:64)+"."+String:C10(Abs:C99([Alumnos_Actividades:28]Actividad_numero:2))+"."+String:C10(Abs:C99([Alumnos_Actividades:28]Alumno_Numero:1))
				[Alumnos_Actividades:28]LlavePrimaria_Alumno:4:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Actividades:28]Año:3)+"."+String:C10([Alumnos_Actividades:28]Nivel_Numero:64)+"."+String:C10(Abs:C99([Alumnos_Actividades:28]Alumno_Numero:1))
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				If ([Alumnos_Actividades:28]Año:3=<>gYear)
					[Alumnos_Actividades:28]Actividad_numero:2:=Abs:C99([Alumnos_Actividades:28]Actividad_numero:2)
					[Alumnos_Actividades:28]Alumno_Numero:1:=Abs:C99([Alumnos_Actividades:28]Alumno_Numero:1)
				Else 
					[Alumnos_Actividades:28]Actividad_numero:2:=-Abs:C99([Alumnos_Actividades:28]Actividad_numero:2)
					[Alumnos_Actividades:28]Alumno_Numero:1:=-Abs:C99([Alumnos_Actividades:28]Alumno_Numero:1)
				End if 
				[Alumnos_Actividades:28]LlavePrincipal:5:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Actividades:28]Año:3)+"."+String:C10([Alumnos_Actividades:28]Nivel_Numero:64)+"."+String:C10(Abs:C99([Alumnos_Actividades:28]Actividad_numero:2))+"."+String:C10(Abs:C99([Alumnos_Actividades:28]Alumno_Numero:1))
				[Alumnos_Actividades:28]LlavePrimaria_Alumno:4:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Actividades:28]Año:3)+"."+String:C10([Alumnos_Actividades:28]Nivel_Numero:64)+"."+String:C10(Abs:C99([Alumnos_Actividades:28]Alumno_Numero:1))
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
		End case 
		CMT_RegistrosMarcados ("CMT_MarcaRegistros";->[Alumnos_Actividades:28])
	End if 
	SN3_MarcarRegistros (SN3_DTi_CalificacionesExtraCurr)
End if 
