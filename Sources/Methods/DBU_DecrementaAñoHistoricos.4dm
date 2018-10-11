//%attributes = {}
  // MÉTODO: DBU_DecrementaAñoHistoricos
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 12/01/12, 11:02:02
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // DBU_DecrementaAñoHistoricos()
  // ----------------------------------------------------
C_LONGINT:C283($i;$i_año;$l_desdeAño;$l_hastaAño;$newYear;$oldYear;$1;$2)
C_TEXT:C284($t_conversionAño;$t_mensaje;$t_mensajeIncrementacion)






<>vb_ImportHistoricos_STX:=True:C214



If (Count parameters:C259=2)
	$l_desdeAño:=$1
	$l_hastaAño:=$2
	OK:=1
	
Else 
	$t_mensaje:="Este método decrementa (-1) el numero del año en historicos\r"
	$t_mensaje:=$t_mensaje+"Antes de ejecutarlo es preciso asegurarse que al incrementar el año no se produzca superposición con registros del año actual ni con registros históricos de otros años."
	$t_mensaje:=$t_mensaje+"\r\r¿Quieres continuar?"
	
	CONFIRM:C162($t_mensaje)
	If (OK=1)
		$l_desdeAño:=Num:C11(Request:C163("Desde Año (año mas antiguo):"))
		$l_hastaAño:=Num:C11(Request:C163("Hasta Año (año mas reciente):";String:C10(<>gYear-1)))
	End if 
End if 

If (OK=1)
	Case of 
		: (($l_hastaAño=0) | ($l_desdeAño=0))
			CD_Dlog (0;"Los años mas reciente o más antiguos no fueron especificados correctamente. \r\rDecrementación abortada.")
			OK:=0
			
		: ($l_hastaAño=<>gYear)
			CD_Dlog (0;"El año histórico mas reciente especificado es el año actual. \r\rDecrementación abortada.")
			OK:=0
			
		: ($l_hastaAño<$l_desdeAño)
			CD_Dlog (0;"El año mas reciente especificado es inferior al año mas antiguo. \r\rDecrementación abortada.")
			OK:=0
		Else 
			OK:=1
	End case 
End if 


If (OK=1)
	$t_mensajeIncrementacion:=""
	For ($i_año;$l_desdeAño;$l_hastaAño)
		$oldYear:=$i_año
		$newYear:=$oldYear-1
		$t_conversionAño:="\r "+String:C10($oldYear)+" --> "+String:C10($newYear)
		
		ARRAY LONGINT:C221(aQR_longint1;0)
		
		QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Año:3=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_Actividades:28];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de actividades"+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Alumnos_Actividades:28])
			GOTO RECORD:C242([Alumnos_Actividades:28];aQR_longint1{$i})
			[Alumnos_Actividades:28]Año:3:=$newYear
			[Alumnos_Actividades:28]Actividad_numero:2:=-Abs:C99([Alumnos_Actividades:28]Actividad_numero:2)
			[Alumnos_Actividades:28]Alumno_Numero:1:=-Abs:C99([Alumnos_Actividades:28]Alumno_Numero:1)
			[Alumnos_Actividades:28]LlavePrincipal:5:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Actividades:28]Año:3)+"."+String:C10([Alumnos_Actividades:28]Nivel_Numero:64)+"."+String:C10(Abs:C99([Alumnos_Actividades:28]Actividad_numero:2))+"."+String:C10(Abs:C99([Alumnos_Actividades:28]Alumno_Numero:1))
			[Alumnos_Actividades:28]LlavePrimaria_Alumno:4:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Actividades:28]Año:3)+"."+String:C10([Alumnos_Actividades:28]Nivel_Numero:64)+"."+String:C10(Abs:C99([Alumnos_Actividades:28]Alumno_Numero:1))
			SAVE RECORD:C53([Alumnos_Actividades:28])
			KRL_UnloadReadOnly (->[Alumnos_Actividades:28])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([Alumnos_Anotaciones:11])
		ARRAY LONGINT:C221(aQR_longint1;0)
		QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Año:11=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_Anotaciones:11];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Anotaciones"+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Alumnos_Anotaciones:11])
			GOTO RECORD:C242([Alumnos_Anotaciones:11];aQR_longint1{$i})
			[Alumnos_Anotaciones:11]Año:11:=$newYear
			[Alumnos_Anotaciones:11]Alumno_Numero:6:=-Abs:C99([Alumnos_Anotaciones:11]Alumno_Numero:6)
			[Alumnos_Anotaciones:11]LlavePrimaria:14:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Anotaciones:11]Año:11)+"."+String:C10([Alumnos_Anotaciones:11]Nivel_Numero:13)+"."+String:C10(Abs:C99([Alumnos_Anotaciones:11]Alumno_Numero:6))
			SAVE RECORD:C53([Alumnos_Anotaciones:11])
			KRL_UnloadReadOnly (->[Alumnos_Anotaciones:11])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([Alumnos_Atrasos:55])
		QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Año:6=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_Atrasos:55];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Atrasos"+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Alumnos_Atrasos:55])
			GOTO RECORD:C242([Alumnos_Atrasos:55];aQR_longint1{$i})
			[Alumnos_Atrasos:55]Año:6:=$newYear
			[Alumnos_Atrasos:55]Alumno_numero:1:=-Abs:C99([Alumnos_Atrasos:55]Alumno_numero:1)
			[Alumnos_Atrasos:55]LlavePrimaria:9:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Atrasos:55]Año:6)+"."+String:C10([Alumnos_Atrasos:55]Nivel_Numero:8)+"."+String:C10(Abs:C99([Alumnos_Atrasos:55]Alumno_numero:1))
			SAVE RECORD:C53([Alumnos_Atrasos:55])
			KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([Alumnos_Castigos:9])
		QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Año:5=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_Castigos:9];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Castigos"+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Alumnos_Castigos:9])
			GOTO RECORD:C242([Alumnos_Castigos:9];aQR_longint1{$i})
			[Alumnos_Castigos:9]Año:5:=$newYear
			[Alumnos_Castigos:9]Alumno_Numero:8:=-Abs:C99([Alumnos_Castigos:9]Alumno_Numero:8)
			[Alumnos_Castigos:9]LlavePrimaria:1:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Castigos:9]Año:5)+"."+String:C10([Alumnos_Castigos:9]Nivel_Numero:11)+"."+String:C10(Abs:C99([Alumnos_Castigos:9]Alumno_Numero:8))
			SAVE RECORD:C53([Alumnos_Castigos:9])
			KRL_UnloadReadOnly (->[Alumnos_Castigos:9])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([Alumnos_Inasistencias:10])
		QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Año:8=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_Inasistencias:10];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Inasistencias"+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Alumnos_Inasistencias:10])
			GOTO RECORD:C242([Alumnos_Inasistencias:10];aQR_longint1{$i})
			[Alumnos_Inasistencias:10]Año:8:=$newYear
			[Alumnos_Inasistencias:10]Alumno_Numero:4:=-Abs:C99([Alumnos_Inasistencias:10]Alumno_Numero:4)
			[Alumnos_Inasistencias:10]LlavePrimaria:13:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Inasistencias:10]Año:8)+"."+String:C10([Alumnos_Inasistencias:10]Nivel_Numero:9)+"."+String:C10(Abs:C99([Alumnos_Inasistencias:10]Alumno_Numero:4))
			SAVE RECORD:C53([Alumnos_Inasistencias:10])
			KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([Alumnos_Licencias:73])
		QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Año:9=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_Licencias:73];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de licencias"+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Alumnos_Licencias:73])
			GOTO RECORD:C242([Alumnos_Licencias:73];aQR_longint1{$i})
			[Alumnos_Licencias:73]Año:9:=$newYear
			[Alumnos_Licencias:73]Alumno_numero:1:=-Abs:C99([Alumnos_Licencias:73]Alumno_numero:1)
			[Alumnos_Licencias:73]LlavePrimaria:11:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Licencias:73]Año:9)+"."+String:C10([Alumnos_Licencias:73]Nivel_Numero:10)+"."+String:C10(Abs:C99([Alumnos_Licencias:73]Alumno_numero:1))
			SAVE RECORD:C53([Alumnos_Licencias:73])
			KRL_UnloadReadOnly (->[Alumnos_Licencias:73])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([Alumnos_Suspensiones:12])
		QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Año:1=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_Suspensiones:12];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Suspensiones"+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Alumnos_Suspensiones:12])
			GOTO RECORD:C242([Alumnos_Suspensiones:12];aQR_longint1{$i})
			[Alumnos_Suspensiones:12]Año:1:=$newYear
			[Alumnos_Suspensiones:12]Alumno_Numero:7:=-Abs:C99([Alumnos_Suspensiones:12]Alumno_Numero:7)
			[Alumnos_Suspensiones:12]LlavePrimaria:11:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Castigos:9]Año:5)+"."+String:C10([Alumnos_Castigos:9]Nivel_Numero:11)+"."+String:C10(Abs:C99([Alumnos_Castigos:9]Alumno_Numero:8))
			SAVE RECORD:C53([Alumnos_Castigos:9])
			KRL_UnloadReadOnly (->[Alumnos_Castigos:9])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
		QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Año:3=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_ComplementoEvaluacion:209];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de complemento evaluación"+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Alumnos_ComplementoEvaluacion:209])
			GOTO RECORD:C242([Alumnos_ComplementoEvaluacion:209];aQR_longint1{$i})
			[Alumnos_ComplementoEvaluacion:209]Año:3:=$newYear
			[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5:=-Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5)
			[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6:=-Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6)
			[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1:=String:C10([Alumnos_ComplementoEvaluacion:209]ID_Institucion:2)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Año:3)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Nivel_Numero:4)+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5))+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6))
			[Alumnos_ComplementoEvaluacion:209]LLave_Asignatura:56:=String:C10([Alumnos_ComplementoEvaluacion:209]ID_Institucion:2)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Año:3)+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5))
			[Alumnos_ComplementoEvaluacion:209]LLave_Alumno:55:=String:C10([Alumnos_ComplementoEvaluacion:209]ID_Institucion:2)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Año:3)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Nivel_Numero:4)+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6))
			SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
			KRL_UnloadReadOnly (->[Alumnos_ComplementoEvaluacion:209])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([Alumnos_Calificaciones:208])
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de calificaciones"+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Alumnos_Calificaciones:208])
			GOTO RECORD:C242([Alumnos_Calificaciones:208];aQR_longint1{$i})
			[Alumnos_Calificaciones:208]Año:3:=$newYear
			[Alumnos_Calificaciones:208]ID_Asignatura:5:=-Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5)
			[Alumnos_Calificaciones:208]ID_Alumno:6:=-Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6)
			[Alumnos_Calificaciones:208]Llave_principal:1:=String:C10([Alumnos_Calificaciones:208]ID_institucion:2)+"."+String:C10([Alumnos_Calificaciones:208]Año:3)+"."+String:C10([Alumnos_Calificaciones:208]NIvel_Numero:4)+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5))+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6))
			[Alumnos_Calificaciones:208]Llave_Asignatura:494:=String:C10([Alumnos_Calificaciones:208]ID_institucion:2)+"."+String:C10([Alumnos_Calificaciones:208]Año:3)+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5))
			[Alumnos_Calificaciones:208]Llave_Alumno:495:=String:C10([Alumnos_Calificaciones:208]ID_institucion:2)+"."+String:C10([Alumnos_Calificaciones:208]Año:3)+"."+String:C10([Alumnos_Calificaciones:208]NIvel_Numero:4)+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6))
			SAVE RECORD:C53([Alumnos_Calificaciones:208])
			KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([Alumnos_EvaluacionAprendizajes:203])
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de MPA"+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
			GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];aQR_longint1{$i})
			[Alumnos_EvaluacionAprendizajes:203]Año:77:=$newYear
			[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
			[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
			[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
			[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
			[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
			[Alumnos_EvaluacionAprendizajes:203]Key:8:=String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1))+"."+String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3))+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
			[Alumnos_EvaluacionAprendizajes:203]LLaveCalificaciones:76:=String:C10([Alumnos_EvaluacionAprendizajes:203]Id_Institucion:78)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Año:77)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91)+"."+String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1))+"."+String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3))
			[Alumnos_EvaluacionAprendizajes:203]LlaveAlumno:92:=String:C10([Alumnos_EvaluacionAprendizajes:203]Id_Institucion:78)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Año:77)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91)+"."+String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1))
			[Alumnos_EvaluacionAprendizajes:203]LlaveAsignatura:93:=String:C10([Alumnos_EvaluacionAprendizajes:203]Id_Institucion:78)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Año:77)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91)+"."+String:C10(Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3))
			SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
			KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([Alumnos_SintesisAnual:210])
		QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Alumnos Sintesis Anual"+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Alumnos_SintesisAnual:210])
			GOTO RECORD:C242([Alumnos_SintesisAnual:210];aQR_longint1{$i})
			[Alumnos_SintesisAnual:210]Año:2:=$newYear
			[Alumnos_SintesisAnual:210]ID_Alumno:4:=-Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)
			[Alumnos_SintesisAnual:210]LlavePrincipal:5:=String:C10([Alumnos_SintesisAnual:210]ID_Institucion:1)+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6)+"."+String:C10(Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4))
			SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([Asignaturas_SintesisAnual:202])
		QUERY:C277([Asignaturas_SintesisAnual:202];[Asignaturas_SintesisAnual:202]Año:3=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Asignaturas_SintesisAnual:202];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de sintesis anual (Asignaturas)"+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Asignaturas_SintesisAnual:202])
			GOTO RECORD:C242([Asignaturas_SintesisAnual:202];aQR_longint1{$i})
			[Asignaturas_SintesisAnual:202]Año:3:=$newYear
			[Asignaturas_SintesisAnual:202]ID_Asignatura:2:=-Abs:C99([Asignaturas_SintesisAnual:202]ID_Asignatura:2)
			[Asignaturas_SintesisAnual:202]LLavePrimaria:5:=String:C10([Asignaturas_SintesisAnual:202]ID_Institucion:1)+"."+String:C10([Asignaturas_SintesisAnual:202]Año:3)+"."+String:C10(Abs:C99([Asignaturas_SintesisAnual:202]ID_Asignatura:2))
			SAVE RECORD:C53([Asignaturas_SintesisAnual:202])
			KRL_UnloadReadOnly (->[Asignaturas_SintesisAnual:202])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([Cursos_SintesisAnual:63])
		QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Año:2=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Cursos_SintesisAnual:63];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de sintesis anual (cursos)"+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Cursos_SintesisAnual:63])
			GOTO RECORD:C242([Cursos_SintesisAnual:63];aQR_longint1{$i})
			[Cursos_SintesisAnual:63]Año:2:=$newYear
			[Cursos_SintesisAnual:63]ID_Curso:52:=-Abs:C99([Cursos_SintesisAnual:63]ID_Curso:52)
			$id_curso:=Abs:C99([Cursos_SintesisAnual:63]ID_Curso:52)  //MONO 184433
			[Cursos_SintesisAnual:63]LLavePrimaria:6:=KRL_MakeStringAccesKey (->[Cursos_SintesisAnual:63]ID_Institucion:1;->[Cursos_SintesisAnual:63]Año:2;->[Cursos_SintesisAnual:63]NumeroNivel:3;->[Cursos_SintesisAnual:63]Curso:5;->$id_curso)  //MONO 184433
			SAVE RECORD:C53([Cursos_SintesisAnual:63])
			KRL_UnloadReadOnly (->[Cursos_SintesisAnual:63])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		QUERY:C277([BU_Rutas:26];[BU_Rutas:26]Año:2=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([BU_Rutas:26];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de rutas TT"+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([BU_Rutas:26])
			GOTO RECORD:C242([BU_Rutas:26];aQR_longint1{$i})
			[BU_Rutas:26]Año:2:=$newYear
			SAVE RECORD:C53([BU_Rutas:26])
			KRL_UnloadReadOnly (->[BU_Rutas:26])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([Alumnos_Historico:25])
		QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Año:2=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_Historico:25];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Alumnos_Historico..."+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Alumnos_Historico:25])
			GOTO RECORD:C242([Alumnos_Historico:25];aQR_longint1{$i})
			[Alumnos_Historico:25]Año:2:=$newYear
			[Alumnos_Historico:25]Llave:42:=String:C10([Alumnos_Historico:25]Alumno_Numero:1)+"."+String:C10([Alumnos_Historico:25]Año:2)
			[Alumnos_Historico:25]ID_SintesisAnual:44:=KRL_MakeStringAccesKey (-><>gInstitucion;->[Alumnos_Historico:25]Año:2;->[Alumnos_Historico:25]Nivel:11;->[Alumnos_Historico:25]Alumno_Numero:1)
			SAVE RECORD:C53([Alumnos_Historico:25])
			KRL_UnloadReadOnly (->[Alumnos_Historico:25])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([Asignaturas_Historico:84])
		QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Año:5=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Historico:84];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Asignaturas_Historico..."+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Asignaturas_Historico:84])
			GOTO RECORD:C242([Asignaturas_Historico:84];aQR_longint1{$i})
			[Asignaturas_Historico:84]Año:5:=$newYear
			[Asignaturas_Historico:84]LlavePrimaria:9:=String:C10([Asignaturas_Historico:84]ID_institucion:8)+"."+String:C10([Asignaturas_Historico:84]Año:5)+"."+String:C10([Asignaturas_Historico:84]ID_AsignaturaOriginal:30)
			SAVE RECORD:C53([Asignaturas_Historico:84])
			KRL_UnloadReadOnly (->[Asignaturas_Historico:84])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		
		READ ONLY:C145([Asignaturas_Inasistencias:125])
		QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]Año:11=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Inasistencias:125];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Asignaturas_Inasistencias..."+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Asignaturas_Inasistencias:125])
			GOTO RECORD:C242([Asignaturas_Inasistencias:125];aQR_longint1{$i})
			[Asignaturas_Inasistencias:125]Año:11:=$newYear
			SAVE RECORD:C53([Asignaturas_Inasistencias:125])
			KRL_UnloadReadOnly (->[Asignaturas_Inasistencias:125])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([Asignaturas_RegistroSesiones:168])
		QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Año:13=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de [Asignaturas_RegistroSesiones]..."+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([Asignaturas_RegistroSesiones:168])
			GOTO RECORD:C242([Asignaturas_RegistroSesiones:168];aQR_longint1{$i})
			[Asignaturas_RegistroSesiones:168]Año:13:=$newYear
			SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
			KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		
		READ ONLY:C145([xxSTR_DatosDeCierre:24])
		QUERY:C277([xxSTR_DatosDeCierre:24];[xxSTR_DatosDeCierre:24]Year:1=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([xxSTR_DatosDeCierre:24];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Datos de cierre..."+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([xxSTR_DatosDeCierre:24])
			GOTO RECORD:C242([xxSTR_DatosDeCierre:24];aQR_longint1{$i})
			[xxSTR_DatosDeCierre:24]Year:1:=$newYear
			SAVE RECORD:C53([xxSTR_DatosDeCierre:24])
			KRL_UnloadReadOnly (->[xxSTR_DatosDeCierre:24])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([xxSTR_HistoricoEstilosEval:88])
		QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]Año:2=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([xxSTR_HistoricoEstilosEval:88];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de historico niveles..."+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([xxSTR_HistoricoEstilosEval:88])
			GOTO RECORD:C242([xxSTR_HistoricoEstilosEval:88];aQR_longint1{$i})
			[xxSTR_HistoricoEstilosEval:88]Año:2:=$newYear
			SAVE RECORD:C53([xxSTR_HistoricoEstilosEval:88])
			KRL_UnloadReadOnly (->[xxSTR_HistoricoEstilosEval:88])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([xxSTR_HistoricoNiveles:191])
		QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Año:2=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([xxSTR_HistoricoNiveles:191];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de historico niveles..."+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([xxSTR_HistoricoNiveles:191])
			GOTO RECORD:C242([xxSTR_HistoricoNiveles:191];aQR_longint1{$i})
			[xxSTR_HistoricoNiveles:191]Año:2:=$newYear
			[xxSTR_HistoricoNiveles:191]LlavePrimaria:11:=String:C10([xxSTR_HistoricoNiveles:191]ID_Institucion:1)+"."+String:C10([xxSTR_HistoricoNiveles:191]NumeroNivel:3)+"."+String:C10([xxSTR_HistoricoNiveles:191]Año:2)
			SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
			KRL_UnloadReadOnly (->[xxSTR_HistoricoNiveles:191])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([MDATA_RegistrosDatosLocales:145])
		QUERY:C277([MDATA_RegistrosDatosLocales:145];[MDATA_RegistrosDatosLocales:145]Agno:4=$oldYear)
		LONGINT ARRAY FROM SELECTION:C647([MDATA_RegistrosDatosLocales:145];aQR_longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de [MDATA_RegistrosDatosLocales]..."+$t_conversionAño)
		For ($i;1;Size of array:C274(aQR_longint1))
			READ WRITE:C146([MDATA_RegistrosDatosLocales:145])
			GOTO RECORD:C242([MDATA_RegistrosDatosLocales:145];aQR_longint1{$i})
			[MDATA_RegistrosDatosLocales:145]Agno:4:=$newYear
			[MDATA_RegistrosDatosLocales:145]Llave:5:=KRL_MakeStringAccesKey (->[MDATA_RegistrosDatosLocales:145]Field_UUID:1;->[MDATA_RegistrosDatosLocales:145]ID_registro:3;->[MDATA_RegistrosDatosLocales:145]Agno:4)
			SAVE RECORD:C53([MDATA_RegistrosDatosLocales:145])
			KRL_UnloadReadOnly (->[MDATA_RegistrosDatosLocales:145])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		
		$t_mensajeIncrementacion:=$t_mensajeIncrementacion+$t_conversionAño
	End for 
	
	
	
	ALERT:C41("Incrementación de años históricos finalizada\r"+$t_mensajeIncrementacion)
End if 
<>vb_ImportHistoricos_STX:=False:C215