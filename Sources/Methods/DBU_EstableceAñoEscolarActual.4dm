//%attributes = {}
  // ` MÉTODO: DBU_EstableceAñoEscolarActual
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/02/12, 17:29:36
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // DBU_EstableceAñoEscolarActual()
  // ----------------------------------------------------
C_LONGINT:C283($i;$l_añoActual;$l_añoReemplazo)



  // CODIGO PRINCIPAL

If (Count parameters:C259=1)
	$l_añoReemplazo:=$1
	OK:=1
Else 
	$l_añoReemplazo:=Num:C11(Request:C163("Reemplazar año escolar actual "+String:C10(<>gYear)+" por: "))
	CONFIRM:C162("Este método debe ser utilizado sólo para corregir una situación en la que el año "+"escolar actual fue establecido incorrectamente.";"Continuar";"Cancelar")
	If (OK=1)
		$l_añoReemplazo:=Num:C11(Request:C163("Reemplazar año escolar actual "+String:C10(<>gYear)+" por: "))
		Case of 
			: ($l_añoReemplazo<<>gYear)
				CONFIRM:C162("¿Estas seguro que quieres reemplazar el año escolar actual "+String:C10(<>gYear)+" por un año anterior "+String:C10($l_añoReemplazo)+"?";"Si, seguro";"Cancelar")
			: ($l_añoReemplazo=<>gYear)
				CONFIRM:C162("¿Estas seguro que quieres reemplazar el año escolar actual "+String:C10(<>gYear)+" por un el mismo año "+String:C10($l_añoReemplazo)+"?";"Si, seguro";"Cancelar")
			: ($l_añoReemplazo><>gYear)
				CONFIRM:C162("¿Estas seguro que quieres reemplazar el año escolar actual "+String:C10(<>gYear)+" por el año "+String:C10($l_añoReemplazo)+"?";"Si, seguro";"Cancelar")
		End case 
	End if 
End if 


<>vb_ImportHistoricos_STX:=True:C214


If (OK=1)
	$l_añoActual:=<>gYear
	$t_conversionAño:="\r "+String:C10($l_añoActual)+" --> "+String:C10($l_añoReemplazo)
	READ WRITE:C146([xxSTR_Constants:1])
	ALL RECORDS:C47([xxSTR_Constants:1])
	FIRST RECORD:C50([xxSTR_Constants:1])
	[xxSTR_Constants:1]Año:8:=$l_añoReemplazo
	SAVE RECORD:C53([xxSTR_Constants:1])
	STR_ReadGlobals 
	
	ARRAY LONGINT:C221(aQR_longint1;0)
	
	QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Año:3=$l_añoActual)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_Actividades:28];aQR_longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de actividades"+$t_conversionAño)
	For ($i;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([Alumnos_Actividades:28])
		GOTO RECORD:C242([Alumnos_Actividades:28];aQR_longint1{$i})
		[Alumnos_Actividades:28]Año:3:=$l_añoReemplazo
		If ([Alumnos_Actividades:28]Año:3=<>gYear)
			[Alumnos_Actividades:28]Actividad_numero:2:=Abs:C99([Alumnos_Actividades:28]Actividad_numero:2)
			[Alumnos_Actividades:28]Alumno_Numero:1:=Abs:C99([Alumnos_Actividades:28]Alumno_Numero:1)
		Else 
			[Alumnos_Actividades:28]Actividad_numero:2:=-Abs:C99([Alumnos_Actividades:28]Actividad_numero:2)
			[Alumnos_Actividades:28]Alumno_Numero:1:=-Abs:C99([Alumnos_Actividades:28]Alumno_Numero:1)
		End if 
		[Alumnos_Actividades:28]LlavePrincipal:5:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Actividades:28]Año:3)+"."+String:C10([Alumnos_Actividades:28]Nivel_Numero:64)+"."+String:C10(Abs:C99([Alumnos_Actividades:28]Actividad_numero:2))+"."+String:C10(Abs:C99([Alumnos_Actividades:28]Alumno_Numero:1))
		[Alumnos_Actividades:28]LlavePrimaria_Alumno:4:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Actividades:28]Año:3)+"."+String:C10([Alumnos_Actividades:28]Nivel_Numero:64)+"."+String:C10(Abs:C99([Alumnos_Actividades:28]Alumno_Numero:1))
		SAVE RECORD:C53([Alumnos_Actividades:28])
		KRL_UnloadReadOnly (->[Alumnos_Actividades:28])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	READ ONLY:C145([Alumnos_Anotaciones:11])
	ARRAY LONGINT:C221(aQR_longint1;0)
	QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Año:11=$l_añoActual)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_Anotaciones:11];aQR_longint1;"")
	C_LONGINT:C283($i)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Anotaciones"+$t_conversionAño)
	For ($i;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([Alumnos_Anotaciones:11])
		GOTO RECORD:C242([Alumnos_Anotaciones:11];aQR_longint1{$i})
		[Alumnos_Anotaciones:11]Año:11:=$l_añoReemplazo
		If ([Alumnos_Anotaciones:11]Año:11=<>gYear)
			[Alumnos_Anotaciones:11]Alumno_Numero:6:=Abs:C99([Alumnos_Anotaciones:11]Alumno_Numero:6)
		Else 
			[Alumnos_Anotaciones:11]Alumno_Numero:6:=-Abs:C99([Alumnos_Anotaciones:11]Alumno_Numero:6)
		End if 
		[Alumnos_Anotaciones:11]LlavePrimaria:14:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Anotaciones:11]Año:11)+"."+String:C10([Alumnos_Anotaciones:11]Nivel_Numero:13)+"."+String:C10(Abs:C99([Alumnos_Anotaciones:11]Alumno_Numero:6))
		SAVE RECORD:C53([Alumnos_Anotaciones:11])
		KRL_UnloadReadOnly (->[Alumnos_Anotaciones:11])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	READ ONLY:C145([Alumnos_Atrasos:55])
	QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Año:6=$l_añoActual)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_Atrasos:55];aQR_longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Atrasos"+$t_conversionAño)
	For ($i;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([Alumnos_Atrasos:55])
		GOTO RECORD:C242([Alumnos_Atrasos:55];aQR_longint1{$i})
		[Alumnos_Atrasos:55]Año:6:=$l_añoReemplazo
		If ([Alumnos_Atrasos:55]Año:6=<>gYear)
			[Alumnos_Atrasos:55]Alumno_numero:1:=Abs:C99([Alumnos_Atrasos:55]Alumno_numero:1)
		Else 
			[Alumnos_Atrasos:55]Alumno_numero:1:=-Abs:C99([Alumnos_Atrasos:55]Alumno_numero:1)
		End if 
		[Alumnos_Atrasos:55]LlavePrimaria:9:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Atrasos:55]Año:6)+"."+String:C10([Alumnos_Atrasos:55]Nivel_Numero:8)+"."+String:C10(Abs:C99([Alumnos_Atrasos:55]Alumno_numero:1))
		SAVE RECORD:C53([Alumnos_Atrasos:55])
		KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	READ ONLY:C145([Alumnos_Castigos:9])
	QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Año:5=$l_añoActual)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_Castigos:9];aQR_longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Castigos"+$t_conversionAño)
	For ($i;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([Alumnos_Castigos:9])
		GOTO RECORD:C242([Alumnos_Castigos:9];aQR_longint1{$i})
		[Alumnos_Castigos:9]Año:5:=$l_añoReemplazo
		If ([Alumnos_Castigos:9]Año:5=<>gYear)
			[Alumnos_Castigos:9]Alumno_Numero:8:=Abs:C99([Alumnos_Castigos:9]Alumno_Numero:8)
		Else 
			[Alumnos_Castigos:9]Alumno_Numero:8:=-Abs:C99([Alumnos_Castigos:9]Alumno_Numero:8)
		End if 
		[Alumnos_Castigos:9]LlavePrimaria:1:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Castigos:9]Año:5)+"."+String:C10([Alumnos_Castigos:9]Nivel_Numero:11)+"."+String:C10(Abs:C99([Alumnos_Castigos:9]Alumno_Numero:8))
		SAVE RECORD:C53([Alumnos_Castigos:9])
		KRL_UnloadReadOnly (->[Alumnos_Castigos:9])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	READ ONLY:C145([Alumnos_Inasistencias:10])
	QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Año:8=$l_añoActual)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_Inasistencias:10];aQR_longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Inasistencias"+$t_conversionAño)
	For ($i;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([Alumnos_Inasistencias:10])
		GOTO RECORD:C242([Alumnos_Inasistencias:10];aQR_longint1{$i})
		[Alumnos_Inasistencias:10]Año:8:=$l_añoReemplazo
		If ([Alumnos_Inasistencias:10]Año:8=<>gYear)
			[Alumnos_Inasistencias:10]Alumno_Numero:4:=Abs:C99([Alumnos_Inasistencias:10]Alumno_Numero:4)
		Else 
			[Alumnos_Inasistencias:10]Alumno_Numero:4:=-Abs:C99([Alumnos_Inasistencias:10]Alumno_Numero:4)
		End if 
		[Alumnos_Inasistencias:10]LlavePrimaria:13:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Inasistencias:10]Año:8)+"."+String:C10([Alumnos_Inasistencias:10]Nivel_Numero:9)+"."+String:C10(Abs:C99([Alumnos_Inasistencias:10]Alumno_Numero:4))
		SAVE RECORD:C53([Alumnos_Inasistencias:10])
		KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	READ ONLY:C145([Alumnos_Licencias:73])
	QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Año:9=$l_añoActual)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_Licencias:73];aQR_longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de licencias"+$t_conversionAño)
	For ($i;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([Alumnos_Licencias:73])
		GOTO RECORD:C242([Alumnos_Licencias:73];aQR_longint1{$i})
		[Alumnos_Licencias:73]Año:9:=$l_añoReemplazo
		If ([Alumnos_Licencias:73]Año:9=<>gYear)
			[Alumnos_Licencias:73]Alumno_numero:1:=Abs:C99([Alumnos_Licencias:73]Alumno_numero:1)
		Else 
			[Alumnos_Licencias:73]Alumno_numero:1:=-Abs:C99([Alumnos_Licencias:73]Alumno_numero:1)
		End if 
		[Alumnos_Licencias:73]LlavePrimaria:11:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Licencias:73]Año:9)+"."+String:C10([Alumnos_Licencias:73]Nivel_Numero:10)+"."+String:C10(Abs:C99([Alumnos_Licencias:73]Alumno_numero:1))
		SAVE RECORD:C53([Alumnos_Licencias:73])
		KRL_UnloadReadOnly (->[Alumnos_Licencias:73])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	READ ONLY:C145([Alumnos_Suspensiones:12])
	QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Año:1=$l_añoActual)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_Suspensiones:12];aQR_longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Suspensiones"+$t_conversionAño)
	For ($i;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([Alumnos_Suspensiones:12])
		GOTO RECORD:C242([Alumnos_Suspensiones:12];aQR_longint1{$i})
		[Alumnos_Suspensiones:12]Año:1:=$l_añoReemplazo
		If ([Alumnos_Suspensiones:12]Año:1=<>gYear)
			[Alumnos_Suspensiones:12]Alumno_Numero:7:=Abs:C99([Alumnos_Suspensiones:12]Alumno_Numero:7)
		Else 
			[Alumnos_Suspensiones:12]Alumno_Numero:7:=-Abs:C99([Alumnos_Suspensiones:12]Alumno_Numero:7)
		End if 
		[Alumnos_Suspensiones:12]LlavePrimaria:11:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Castigos:9]Año:5)+"."+String:C10([Alumnos_Castigos:9]Nivel_Numero:11)+"."+String:C10(Abs:C99([Alumnos_Castigos:9]Alumno_Numero:8))
		SAVE RECORD:C53([Alumnos_Castigos:9])
		KRL_UnloadReadOnly (->[Alumnos_Castigos:9])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
	QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Año:3=$l_añoActual)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_ComplementoEvaluacion:209];aQR_longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de complemento evaluación"+$t_conversionAño)
	For ($i;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([Alumnos_ComplementoEvaluacion:209])
		GOTO RECORD:C242([Alumnos_ComplementoEvaluacion:209];aQR_longint1{$i})
		[Alumnos_ComplementoEvaluacion:209]Año:3:=$l_añoReemplazo
		If ([Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
			[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5:=Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5)
			[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6:=Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6)
		Else 
			[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5:=-Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5)
			[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6:=-Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6)
		End if 
		[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1:=String:C10([Alumnos_ComplementoEvaluacion:209]ID_Institucion:2)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Año:3)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Nivel_Numero:4)+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5))+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6))
		[Alumnos_ComplementoEvaluacion:209]LLave_Asignatura:56:=String:C10([Alumnos_ComplementoEvaluacion:209]ID_Institucion:2)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Año:3)+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5))
		[Alumnos_ComplementoEvaluacion:209]LLave_Alumno:55:=String:C10([Alumnos_ComplementoEvaluacion:209]ID_Institucion:2)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Año:3)+"."+String:C10([Alumnos_ComplementoEvaluacion:209]Nivel_Numero:4)+"."+String:C10(Abs:C99([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6))
		SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
		KRL_UnloadReadOnly (->[Alumnos_ComplementoEvaluacion:209])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	READ ONLY:C145([Alumnos_Calificaciones:208])
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=$l_añoActual)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];aQR_longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de calificaciones"+$t_conversionAño)
	For ($i;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([Alumnos_Calificaciones:208])
		GOTO RECORD:C242([Alumnos_Calificaciones:208];aQR_longint1{$i})
		[Alumnos_Calificaciones:208]Año:3:=$l_añoReemplazo
		If ([Alumnos_Calificaciones:208]Año:3=<>gYear)
			[Alumnos_Calificaciones:208]ID_Asignatura:5:=Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5)
			[Alumnos_Calificaciones:208]ID_Alumno:6:=Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6)
		Else 
			[Alumnos_Calificaciones:208]ID_Asignatura:5:=-Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5)
			[Alumnos_Calificaciones:208]ID_Alumno:6:=-Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6)
		End if 
		[Alumnos_Calificaciones:208]Llave_principal:1:=String:C10([Alumnos_Calificaciones:208]ID_institucion:2)+"."+String:C10([Alumnos_Calificaciones:208]Año:3)+"."+String:C10([Alumnos_Calificaciones:208]NIvel_Numero:4)+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5))+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6))
		[Alumnos_Calificaciones:208]Llave_Asignatura:494:=String:C10([Alumnos_Calificaciones:208]ID_institucion:2)+"."+String:C10([Alumnos_Calificaciones:208]Año:3)+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5))
		[Alumnos_Calificaciones:208]Llave_Alumno:495:=String:C10([Alumnos_Calificaciones:208]ID_institucion:2)+"."+String:C10([Alumnos_Calificaciones:208]Año:3)+"."+String:C10([Alumnos_Calificaciones:208]NIvel_Numero:4)+"."+String:C10(Abs:C99([Alumnos_Calificaciones:208]ID_Alumno:6))
		SAVE RECORD:C53([Alumnos_Calificaciones:208])
		KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	
	READ ONLY:C145([Alumnos_EvaluacionAprendizajes:203])
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=$l_añoActual)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];aQR_longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de MPA"+$t_conversionAño)
	For ($i;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
		GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];aQR_longint1{$i})
		[Alumnos_EvaluacionAprendizajes:203]Año:77:=$l_añoReemplazo
		If ([Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
			[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
			[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
			[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
			[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
			[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
		Else 
			[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
			[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
			[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
			[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
			[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7:=-Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
		End if 
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
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=$l_añoActual)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];aQR_longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Sintesis Anual (Alumnos)"+$t_conversionAño)
	For ($i;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([Alumnos_SintesisAnual:210])
		GOTO RECORD:C242([Alumnos_SintesisAnual:210];aQR_longint1{$i})
		[Alumnos_SintesisAnual:210]Año:2:=$l_añoReemplazo
		If ([Alumnos_SintesisAnual:210]Año:2=<>gYear)
			[Alumnos_SintesisAnual:210]ID_Alumno:4:=Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)
		Else 
			[Alumnos_SintesisAnual:210]ID_Alumno:4:=-Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)
		End if 
		[Alumnos_SintesisAnual:210]LlavePrincipal:5:=String:C10([Alumnos_SintesisAnual:210]ID_Institucion:1)+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6)+"."+String:C10(Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4))
		
		SAVE RECORD:C53([Alumnos_SintesisAnual:210])
		KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	READ ONLY:C145([Asignaturas_SintesisAnual:202])
	QUERY:C277([Asignaturas_SintesisAnual:202];[Asignaturas_SintesisAnual:202]Año:3=$l_añoActual)
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas_SintesisAnual:202];aQR_longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de sintesis anual (Asignaturas)"+$t_conversionAño)
	For ($i;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([Asignaturas_SintesisAnual:202])
		GOTO RECORD:C242([Asignaturas_SintesisAnual:202];aQR_longint1{$i})
		[Asignaturas_SintesisAnual:202]Año:3:=$l_añoReemplazo
		If ([Asignaturas_SintesisAnual:202]Año:3=<>gYear)
			[Asignaturas_SintesisAnual:202]ID_Asignatura:2:=Abs:C99([Asignaturas_SintesisAnual:202]ID_Asignatura:2)
		Else 
			[Asignaturas_SintesisAnual:202]ID_Asignatura:2:=-Abs:C99([Asignaturas_SintesisAnual:202]ID_Asignatura:2)
		End if 
		[Asignaturas_SintesisAnual:202]LLavePrimaria:5:=String:C10([Asignaturas_SintesisAnual:202]ID_Institucion:1)+"."+String:C10([Asignaturas_SintesisAnual:202]Año:3)+"."+String:C10(Abs:C99([Asignaturas_SintesisAnual:202]ID_Asignatura:2))
		SAVE RECORD:C53([Asignaturas_SintesisAnual:202])
		KRL_UnloadReadOnly (->[Asignaturas_SintesisAnual:202])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	
	READ ONLY:C145([Cursos_SintesisAnual:63])
	QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Año:2=$l_añoActual)
	LONGINT ARRAY FROM SELECTION:C647([Cursos_SintesisAnual:63];aQR_longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de sintesis anual (cursos)"+$t_conversionAño)
	For ($i;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([Cursos_SintesisAnual:63])
		GOTO RECORD:C242([Cursos_SintesisAnual:63];aQR_longint1{$i})
		[Cursos_SintesisAnual:63]Año:2:=$l_añoReemplazo
		If ([Cursos_SintesisAnual:63]Año:2=<>gYear)
			[Cursos_SintesisAnual:63]ID_Curso:52:=Abs:C99([Cursos_SintesisAnual:63]ID_Curso:52)
		Else 
			[Cursos_SintesisAnual:63]ID_Curso:52:=-Abs:C99([Cursos_SintesisAnual:63]ID_Curso:52)
		End if 
		$l_idCurso:=Abs:C99([Cursos_SintesisAnual:63]ID_Curso:52)  //MONO 184433
		[Cursos_SintesisAnual:63]LLavePrimaria:6:=KRL_MakeStringAccesKey (->[Cursos_SintesisAnual:63]ID_Institucion:1;->[Cursos_SintesisAnual:63]Año:2;->[Cursos_SintesisAnual:63]NumeroNivel:3;->[Cursos_SintesisAnual:63]Curso:5;->$l_idCurso)  //MONO 184433
		SAVE RECORD:C53([Cursos_SintesisAnual:63])
		KRL_UnloadReadOnly (->[Cursos_SintesisAnual:63])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	QUERY:C277([BU_Rutas:26];[BU_Rutas:26]Año:2=$l_añoActual)
	LONGINT ARRAY FROM SELECTION:C647([BU_Rutas:26];aQR_longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de rutas TT"+$t_conversionAño)
	For ($i;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([BU_Rutas:26])
		GOTO RECORD:C242([BU_Rutas:26];aQR_longint1{$i})
		[BU_Rutas:26]Año:2:=$l_añoReemplazo
		SAVE RECORD:C53([BU_Rutas:26])
		KRL_UnloadReadOnly (->[BU_Rutas:26])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Año:13=$l_añoActual)
	QUERY:C277([Asignaturas_RegistroSesiones:168];[BU_Rutas:26]Año:2=$l_añoActual)
	LONGINT ARRAY FROM SELECTION:C647([BU_Rutas:26];aQR_longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de sesiones de clases"+$t_conversionAño)
	For ($i;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([Asignaturas_RegistroSesiones:168])
		GOTO RECORD:C242([Asignaturas_RegistroSesiones:168];aQR_longint1{$i})
		[Asignaturas_RegistroSesiones:168]Año:13:=$l_añoReemplazo
		SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
		KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	
	READ ONLY:C145([Asignaturas_Inasistencias:125])
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]Año:11=$l_añoActual)
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Inasistencias:125];aQR_longint1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando el año de Asignaturas_Inasistencias..."+$t_conversionAño)
	For ($i;1;Size of array:C274(aQR_longint1))
		READ WRITE:C146([Asignaturas_Inasistencias:125])
		GOTO RECORD:C242([Asignaturas_Inasistencias:125];aQR_longint1{$i})
		[Asignaturas_Inasistencias:125]Año:11:=$l_añoReemplazo
		SAVE RECORD:C53([Asignaturas_Inasistencias:125])
		KRL_UnloadReadOnly (->[Asignaturas_Inasistencias:125])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	
	
	If (Count parameters:C259=0)
		ALERT:C41("Se estableció "+String:C10($l_añoReemplazo)+" como año actual.\r\rSi el colegio utiliza SchoolNet es necesario eliminar "+"y enviar todo todos los datos actuales nuevamente.")
	End if 
End if 
<>vb_ImportHistoricos_STX:=False:C215
