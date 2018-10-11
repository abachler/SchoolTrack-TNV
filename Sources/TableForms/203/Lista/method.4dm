  // [Alumnos_EvaluacionAprendizajes].Lista()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 17/12/12, 08:52:02
  // ---------------------------------------------


  // CODIGO




If (Form event:C388=On Display Detail:K2:22)
	If ([Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
		Case of 
			: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
				RELATE ONE:C42([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
				[Alumnos_EvaluacionAprendizajes:203]Enunciado:9:=[MPA_DefinicionCompetencias:187]Competencia:6
				[Alumnos_EvaluacionAprendizajes:203]OrdenCompetencia:87:=[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25
				
				
			: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
				RELATE ONE:C42([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
				[Alumnos_EvaluacionAprendizajes:203]Enunciado:9:=[MPA_DefinicionDimensiones:188]Dimensión:4
				[Alumnos_EvaluacionAprendizajes:203]OrdenDimension:86:=[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20
				
			: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje)
				RELATE ONE:C42([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
				[Alumnos_EvaluacionAprendizajes:203]Enunciado:9:=[MPA_DefinicionEjes:185]Nombre:3
				[Alumnos_EvaluacionAprendizajes:203]OrdenEje:85:=[MPA_DefinicionEjes:185]OrdenamientoNumerico:9
				
		End case 
		RELATE ONE:C42([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
		RELATE ONE:C42([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
		vtAsignatura:=[Asignaturas:18]denominacion_interna:16
	Else 
		$idAlumno:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
		KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$idAlumno)
		$key:=String:C10([Alumnos_EvaluacionAprendizajes:203]Id_Institucion:78)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Año:77)+"."+String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1))
		KRL_FindAndLoadRecordByIndex (->[Asignaturas_Historico:84]LlavePrimaria:9;->$key)
		vtAsignatura:=[Asignaturas_Historico:84]Nombre_interno:3
		
	End if 
	
	
	Case of 
		: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=1)
			vtTipo:="Eje"
		: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=2)
			vtTipo:="Dim"
		: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=3)
			vtTipo:="Comp"
	End case 
End if 