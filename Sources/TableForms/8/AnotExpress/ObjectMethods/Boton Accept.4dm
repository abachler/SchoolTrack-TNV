Case of 
	: (Form event:C388=On Clicked:K2:4)
		AL_UpdateArrays (xALP_Anot;0)
		For ($i;Size of array:C274(alSTRal_NumeroAlumno);1;-1)
			READ ONLY:C145([Alumnos:2])
			CREATE RECORD:C68([Alumnos_Anotaciones:11])
			[Alumnos_Anotaciones:11]Fecha:1:=adSTRal_FechaAnotacion{$i}
			[Alumnos_Anotaciones:11]Alumno_Numero:6:=alSTRal_NumeroAlumno{$i}
			[Alumnos_Anotaciones:11]Nivel_Numero:13:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->[Alumnos_Anotaciones:11]Alumno_Numero:6;->[Alumnos:2]nivel_numero:29)
			[Alumnos_Anotaciones:11]Motivo:3:=atSTRal_MotivoAnotacion{$i}
			[Alumnos_Anotaciones:11]Profesor_Numero:5:=alSTRal_NoProfesorAnot{$i}
			[Alumnos_Anotaciones:11]Observaciones:4:=atSTRal_NotasAnotacion{$i}
			[Alumnos_Anotaciones:11]Categoria:8:=atSTRal_CategoriaAnotacion{$i}
			[Alumnos_Anotaciones:11]Signo:7:=atSTRal_TipoAnotacion{$i}
			[Alumnos_Anotaciones:11]Puntos:9:=alSTRal_PuntosAnotacion{$i}
			[Alumnos_Anotaciones:11]Asignatura:10:=atSTRal_AsignaturaAnot{$i}
			If ([Alumnos_Anotaciones:11]Asignatura:10#"")
				[Alumnos_Anotaciones:11]Observaciones:4:=[Alumnos_Anotaciones:11]Observaciones:4+" ("+[Alumnos_Anotaciones:11]Asignatura:10+")"
			End if 
			SAVE RECORD:C53([Alumnos_Anotaciones:11])
			UNLOAD RECORD:C212([Alumnos_Anotaciones:11])
		End for 
		ACCEPT:C269
		AT_Initialize (->atSTRal_NombreAlumno;->adSTRal_FechaAnotacion;->atSTRal_NombreProfesorAnot;->atSTRal_MotivoAnotacion;->alSTRal_NoProfesorAnot;->atSTRal_NotasAnotacion;->atSTRal_CategoriaAnotacion;->alSTRal_PuntosAnotacion;->alSTRal_NumeroAlumno;->atSTRal_TipoAnotacion)
End case 