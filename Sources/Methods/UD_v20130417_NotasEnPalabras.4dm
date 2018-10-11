//%attributes = {}
  // UD v20130417_NotasEnPalabras()
  // Por: Alberto Bachler: 17/04/13, 11:25:17
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36#"";*)
QUERY:C277([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492="")
ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3;>;[Alumnos_Calificaciones:208]ID_Asignatura:5;>;[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;>)
If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
	$b_SinEjecucionDeTriggers:=<>vb_ImportHistoricos_STX
	<>vb_ImportHistoricos_STX:=True:C214
	$l_IdProceso:=IT_Progress (1;0;0;"Calculando evaluación final oficial en palabras...")
	ARRAY LONGINT:C221($al_RecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$al_RecNums;"")
	For ($i;1;Size of array:C274($al_RecNums))
		READ WRITE:C146([Alumnos_Calificaciones:208])
		GOTO RECORD:C242([Alumnos_Calificaciones:208];$al_RecNums{$i})
		If ([Alumnos_Calificaciones:208]ID_Asignatura:5>0)
			RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
			EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=NTA_Grade2LongText ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36)
			$l_IdProceso:=IT_Progress (0;$l_IdProceso;$i/Size of array:C274($al_RecNums);"Calculando evaluación final oficial en palabras...\r"+String:C10([Alumnos_Calificaciones:208]Año:3)+" - "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5)
		Else 
			RELATE ONE:C42([Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493)
			EVS_LeeEstiloEvalHist_byID ([Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25)
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=NTA_Grade2LongText ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36)
			$l_IdProceso:=IT_Progress (0;$l_IdProceso;$i/Size of array:C274($al_RecNums);"Calculando evaluación final oficial en palabras...\r"+String:C10([Alumnos_Calificaciones:208]Año:3)+" - "+[Asignaturas_Historico:84]Nombre_interno:3+", "+[Asignaturas_Historico:84]Curso:14)
		End if 
		
		SAVE RECORD:C53([Alumnos_Calificaciones:208])
	End for 
	KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])
	$l_IdProceso:=IT_Progress (-1;$l_IdProceso)
	<>vb_ImportHistoricos_STX:=$b_SinEjecucionDeTriggers
Else 
	
End if 






