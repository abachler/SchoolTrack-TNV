//%attributes = {}


ARRAY LONGINT:C221($aRecNumAsignaturas;0)
ARRAY LONGINT:C221($aRecNumEvaluaciones;0)

$m:=Milliseconds:C459
ALL RECORDS:C47([Asignaturas:18])
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNumAsignaturas;"")
$l_ProgressProcID:=IT_Progress (1;0;0;"Calculando promedios en asignaturas...")
For ($iAsignaturas;1;Size of array:C274($aRecNumAsignaturas))
	GOTO RECORD:C242([Asignaturas:18];$aRecNumAsignaturas{$iAsignaturas})
	
	$r_progress1:=$iAsignaturas/Size of array:C274($aRecNumAsignaturas)
	$t_Progress1:="Calculando promedios en asignaturas...\r"+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5
	
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
	
	
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$aRecNumEvaluaciones;"")
	For ($iEvaluaciones;1;Size of array:C274($aRecNumEvaluaciones))
		KRL_GotoRecord (->[Alumnos_Calificaciones:208];$aRecNumEvaluaciones{$iEvaluaciones})
		RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Alumno:6)
		$r_progress2:=$iEvaluaciones/Size of array:C274($aRecNumEvaluaciones)
		$t_Progress2:=[Alumnos:2]apellidos_y_nombres:40
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$r_progress1;$t_Progress1;$r_progress2;$t_Progress2)
		$t_PromedioP1:=[Alumnos_Calificaciones:208]P01_Final_Literal:116
		$t_PromedioP2:=[Alumnos_Calificaciones:208]P02_Final_Literal:191
		$t_PromedioP3:=[Alumnos_Calificaciones:208]P03_Final_Literal:266
		$t_PromedioP4:=[Alumnos_Calificaciones:208]P04_Final_Literal:341
		$t_PromedioP5:=[Alumnos_Calificaciones:208]P05_Final_Literal:416
		$t_PromedioPF:=[Alumnos_Calificaciones:208]Anual_Literal:15
		$t_PromedioNF:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
		$t_PromedioNO:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36
		
	End for 
	
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
$m_Relate:=Milliseconds:C459-$m




SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Structure configuration:K51:2)
$m:=Milliseconds:C459
ALL RECORDS:C47([Asignaturas:18])
SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_Id_asignaturas;[Asignaturas:18]Numero_del_Nivel:6;$al_NumeroNivel;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$al_ID_EstiloEvaluacion;[Asignaturas:18]denominacion_interna:16;$at_Nombre_Asignaturas;[Asignaturas:18]Curso:5;$at_Curso_Asignaturas)
$l_ProgressProcID:=IT_Progress (1;0;0;"Calculando promedios en asignaturas...")
For ($iAsignaturas;1;Size of array:C274($al_Id_asignaturas))
	
	$r_progress1:=$iAsignaturas/Size of array:C274($al_Id_asignaturas)
	$t_Progress1:="Calculando promedios en asignaturas...\r"+$at_Nombre_Asignaturas{$iAsignaturas}+", "+$at_Curso_Asignaturas{$iAsignaturas}
	
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$al_Id_asignaturas{$iAsignaturas})
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];$aRecNumEvaluaciones;[Alumnos:2]apellidos_y_nombres:40;$at_NombresAlumnos;[Alumnos_Calificaciones:208]P01_Final_Literal:116;$at_promedioP1;[Alumnos_Calificaciones:208]P02_Final_Literal:191;$at_promedioP2;[Alumnos_Calificaciones:208]P03_Final_Literal:266;$at_promedioP3;[Alumnos_Calificaciones:208]P04_Final_Literal:341;$at_promedioP4;[Alumnos_Calificaciones:208]P05_Final_Literal:416;$at_promedioP5;[Alumnos_Calificaciones:208]Anual_Literal:15;$at_promedioPF;[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;$at_promedioNF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;$at_promedioNO)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$aRecNumEvaluaciones;"")
	For ($iEvaluaciones;1;Size of array:C274($aRecNumEvaluaciones))
		$r_progress2:=$iEvaluaciones/Size of array:C274($aRecNumEvaluaciones)
		$t_Progress2:=$at_NombresAlumnos{$iEvaluaciones}
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$r_progress1;$t_Progress1;$r_progress2;$t_Progress2)
		
		
	End for 
	
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Structure configuration:K51:2)
$m_array:=Milliseconds:C459-$m


ALERT:C41("RelateOne: "+String:C10($m_Relate)+"\rArreglo: "+String:C10($m_array))