//%attributes = {}
  //EV2dbu_NormalizaSepDecimal


If (Application type:C494=4D Local mode:K5:1)
	<>vb_ImportHistoricos_STX:=True:C214
	If (Count parameters:C259=0)
		$año:=<>gYear
	Else 
		$año:=$1
	End if 
	
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=$año)
	
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$aRecNums;"")
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Ajustando separador decimal (calificaciones)...")
	For ($i;1;Size of array:C274($aRecNums))
		READ WRITE:C146([Alumnos_Calificaciones:208])
		GOTO RECORD:C242([Alumnos_Calificaciones:208];$aRecNums{$i})
		For ($iFields;42;412;5)
			Field:C253(208;$iFields+4)->:=EV2_Literal_Aplicacion (Field:C253(208;$iFields+4)->)
		End for 
		[Alumnos_Calificaciones:208]P01_Final_Literal:116:=EV2_Literal_Aplicacion ([Alumnos_Calificaciones:208]P01_Final_Literal:116)
		[Alumnos_Calificaciones:208]P02_Final_Literal:191:=EV2_Literal_Aplicacion ([Alumnos_Calificaciones:208]P02_Final_Literal:191)
		[Alumnos_Calificaciones:208]P03_Final_Literal:266:=EV2_Literal_Aplicacion ([Alumnos_Calificaciones:208]P03_Final_Literal:266)
		[Alumnos_Calificaciones:208]P04_Final_Literal:341:=EV2_Literal_Aplicacion ([Alumnos_Calificaciones:208]P04_Final_Literal:341)
		[Alumnos_Calificaciones:208]P05_Final_Literal:416:=EV2_Literal_Aplicacion ([Alumnos_Calificaciones:208]P05_Final_Literal:416)
		
		[Alumnos_Calificaciones:208]Anual_Literal:15:=EV2_Literal_Aplicacion ([Alumnos_Calificaciones:208]Anual_Literal:15)
		[Alumnos_Calificaciones:208]ExamenAnual_Literal:20:=EV2_Literal_Aplicacion ([Alumnos_Calificaciones:208]Anual_Literal:15)
		[Alumnos_Calificaciones:208]ExamenExtra_Literal:25:=EV2_Literal_Aplicacion ([Alumnos_Calificaciones:208]ExamenExtra_Literal:25)
		[Alumnos_Calificaciones:208]Anual_Literal:15:=EV2_Literal_Aplicacion ([Alumnos_Calificaciones:208]Anual_Literal:15)
		[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:=EV2_Literal_Aplicacion ([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30)
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=EV2_Literal_Aplicacion ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36)
		SAVE RECORD:C53([Alumnos_Calificaciones:208])
		
		KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
		[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99:=EV2_Literal_Aplicacion ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99)
		SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
		
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);"Ajustando separador decimal...")
	End for 
	KRL_UnloadReadOnly (->[Alumnos_ComplementoEvaluacion:209])
	KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])
	
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=$año)
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];$aRecNums;"")
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Ajustando separador decimal (resultados alumnos)...")
	For ($i;1;Size of array:C274($aRecNums))
		READ WRITE:C146([Alumnos_SintesisAnual:210])
		GOTO RECORD:C242([Alumnos_SintesisAnual:210];$aRecNums{$i})
		[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96:=EV2_Literal_Aplicacion ([Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96)
		[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125:=EV2_Literal_Aplicacion ([Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125)
		[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154:=EV2_Literal_Aplicacion ([Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154)
		[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183:=EV2_Literal_Aplicacion ([Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183)
		[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212:=EV2_Literal_Aplicacion ([Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212)
		
		[Alumnos_SintesisAnual:210]P01_PromedioOficial_Literal:241:=EV2_Literal_Aplicacion ([Alumnos_SintesisAnual:210]P01_PromedioOficial_Literal:241)
		[Alumnos_SintesisAnual:210]P02_PromedioOficial_Literal:246:=EV2_Literal_Aplicacion ([Alumnos_SintesisAnual:210]P02_PromedioOficial_Literal:246)
		[Alumnos_SintesisAnual:210]P03_PromedioOficial_Literal:251:=EV2_Literal_Aplicacion ([Alumnos_SintesisAnual:210]P03_PromedioOficial_Literal:251)
		[Alumnos_SintesisAnual:210]P04_PromedioOficial_Literal:256:=EV2_Literal_Aplicacion ([Alumnos_SintesisAnual:210]P04_PromedioOficial_Literal:256)
		[Alumnos_SintesisAnual:210]P05_PromedioOficial_Literal:261:=EV2_Literal_Aplicacion ([Alumnos_SintesisAnual:210]P05_PromedioOficial_Literal:261)
		
		[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14:=EV2_Literal_Aplicacion ([Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14)
		[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24:=EV2_Literal_Aplicacion ([Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24)
		[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19:=EV2_Literal_Aplicacion ([Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19)
		SAVE RECORD:C53([Alumnos_SintesisAnual:210])
		
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
	End for 
	KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])
	
	
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	
	QUERY:C277([Asignaturas_SintesisAnual:202];[Asignaturas_SintesisAnual:202]Año:3=$año)
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas_SintesisAnual:202];$aRecNums;"")
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Ajustando separador decimal (resultados Asignaturas)...")
	For ($i;1;Size of array:C274($aRecNums))
		READ WRITE:C146([Asignaturas_SintesisAnual:202])
		GOTO RECORD:C242([Asignaturas_SintesisAnual:202];$aRecNums{$i})
		[Asignaturas_SintesisAnual:202]Anual_Maximo_Literal:114:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]Anual_Maximo_Literal:114)
		[Asignaturas_SintesisAnual:202]Anual_Minimo_Literal:79:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]Anual_Minimo_Literal:79)
		[Asignaturas_SintesisAnual:202]PromedioAnual_Literal:14:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]PromedioAnual_Literal:14)
		
		[Asignaturas_SintesisAnual:202]Examen_Maximo_Literal:131:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]Examen_Maximo_Literal:131)
		[Asignaturas_SintesisAnual:202]Examen_Minimo_Literal:126:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]Examen_Minimo_Literal:126)
		[Asignaturas_SintesisAnual:202]Examen_Promedio_Literal:136:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]Examen_Promedio_Literal:136)
		
		[Asignaturas_SintesisAnual:202]Final_Maximo_Literal:119:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]Final_Maximo_Literal:119)
		[Asignaturas_SintesisAnual:202]Final_Minimo_Literal:83:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]Final_Minimo_Literal:83)
		[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19)
		
		[Asignaturas_SintesisAnual:202]Oficial_Maximo_Literal:146:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]Oficial_Maximo_Literal:146)
		[Asignaturas_SintesisAnual:202]Oficial_Minimo_Literal:141:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]Oficial_Minimo_Literal:141)
		[Asignaturas_SintesisAnual:202]PromedioOficial_Literal:24:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]PromedioOficial_Literal:24)
		
		
		[Asignaturas_SintesisAnual:202]P01_Minimo_Literal:65:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]P01_Minimo_Literal:65)
		[Asignaturas_SintesisAnual:202]P01_Maximo_Literal:105:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]P01_Maximo_Literal:105)
		[Asignaturas_SintesisAnual:202]P01_Promedio_Literal:29:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]P01_Promedio_Literal:29)
		
		[Asignaturas_SintesisAnual:202]P02_Minimo_Literal:66:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]P02_Minimo_Literal:66)
		[Asignaturas_SintesisAnual:202]P02_Maximo_Literal:106:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]P02_Maximo_Literal:106)
		[Asignaturas_SintesisAnual:202]P02_Promedio_Literal:34:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]P02_Promedio_Literal:34)
		
		[Asignaturas_SintesisAnual:202]P03_Minimo_Literal:67:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]P03_Minimo_Literal:67)
		[Asignaturas_SintesisAnual:202]P03_Maximo_Literal:107:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]P03_Maximo_Literal:107)
		[Asignaturas_SintesisAnual:202]P03_Promedio_Literal:39:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]P03_Promedio_Literal:39)
		
		[Asignaturas_SintesisAnual:202]P04_Minimo_Literal:68:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]P04_Minimo_Literal:68)
		[Asignaturas_SintesisAnual:202]P04_Maximo_Literal:108:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]P04_Maximo_Literal:108)
		[Asignaturas_SintesisAnual:202]P04_Promedio_Literal:44:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]P04_Promedio_Literal:44)
		
		[Asignaturas_SintesisAnual:202]P05_Minimo_Literal:69:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]P05_Minimo_Literal:69)
		[Asignaturas_SintesisAnual:202]P05_Maximo_Literal:109:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]P05_Maximo_Literal:109)
		[Asignaturas_SintesisAnual:202]P05_Promedio_Literal:49:=EV2_Literal_Aplicacion ([Asignaturas_SintesisAnual:202]P05_Promedio_Literal:49)
		
		SAVE RECORD:C53([Asignaturas_SintesisAnual:202])
		
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
	End for 
	KRL_UnloadReadOnly (->[Asignaturas_SintesisAnual:202])
	
	
	
	QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Año:2=$año)
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Cursos_SintesisAnual:63];$aRecNums;"")
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Ajustando separador decimal (resultados cursos)...")
	For ($i;1;Size of array:C274($aRecNums))
		READ WRITE:C146([Cursos_SintesisAnual:63])
		GOTO RECORD:C242([Cursos_SintesisAnual:63];$aRecNums{$i})
		[Cursos_SintesisAnual:63]P01_Promedio_Literal:31:=EV2_Literal_Aplicacion ([Cursos_SintesisAnual:63]P01_Promedio_Literal:31)
		[Cursos_SintesisAnual:63]P02_Promedio_Literal:36:=EV2_Literal_Aplicacion ([Cursos_SintesisAnual:63]P02_Promedio_Literal:36)
		[Cursos_SintesisAnual:63]P03_Promedio_Literal:41:=EV2_Literal_Aplicacion ([Cursos_SintesisAnual:63]P03_Promedio_Literal:41)
		[Cursos_SintesisAnual:63]P04_Promedio_Literal:46:=EV2_Literal_Aplicacion ([Cursos_SintesisAnual:63]P04_Promedio_Literal:46)
		[Cursos_SintesisAnual:63]P05_Promedio_Literal:51:=EV2_Literal_Aplicacion ([Cursos_SintesisAnual:63]P05_Promedio_Literal:51)
		
		[Cursos_SintesisAnual:63]PromedioAnual_Literal:16:=EV2_Literal_Aplicacion ([Cursos_SintesisAnual:63]PromedioAnual_Literal:16)
		[Cursos_SintesisAnual:63]PromedioFinal_Literal:21:=EV2_Literal_Aplicacion ([Cursos_SintesisAnual:63]PromedioFinal_Literal:21)
		[Cursos_SintesisAnual:63]PromedioOficial_Literal:26:=EV2_Literal_Aplicacion ([Cursos_SintesisAnual:63]PromedioOficial_Literal:26)
		
		SAVE RECORD:C53([Cursos_SintesisAnual:63])
		
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
	End for 
	KRL_UnloadReadOnly (->[Cursos_SintesisAnual:63])
	
	
	
	
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	<>vb_ImportHistoricos_STX:=False:C215
	
	
Else 
	CD_Dlog (0;"Por razones de seguridad este proceso SOLO debe ser ejecutado en modalidad mono-usuario")
End if 
