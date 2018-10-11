//%attributes = {}
  // UD_20130823_Calificaciones()
  // Por: Alberto Bachler: 23/08/13, 14:21:47
  //  ---------------------------------------------
  // corrige un error que se presentaba en asignaturas evaluadas en símbolos, oficial en notas y promedios no calculados
  // (la nota oficial quedaba en símbolos aunque el estilo de evaluación utilizado indicaba que los promedios oficiales debían mostrarse en notas)
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_notas;$i_registros)
C_LONGINT:C283($l_idProcesoAvance)

ARRAY LONGINT:C221($al_Idalumnos;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY LONGINT:C221($al_RecNumsAsignaturas;0)
ARRAY LONGINT:C221($al_RecNumsCalificaciones;0)

QUERY:C277([Asignaturas:18];[Asignaturas:18]Resultado_no_calculado:47=True:C214)

$l_idProcesoAvance:=IT_Progress (1;$l_idProcesoAvance;0;"Verificando nota oficial en asignaturas con promedios no calculados....")
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_RecNums;"")
For ($i_registros;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Asignaturas:18];$al_RecNums{$i_registros})
	EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	If ((iPrintActa=Notas) & ((iEvaluationMode=Simbolos) | (iPrintMode=Simbolos)))
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1;*)
		QUERY:C277([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30#"")
		If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
			LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$al_RecNumsCalificaciones;"")
			If (Find in array:C230($al_RecNumsAsignaturas;$al_RecNums{$i_registros})<0)
				APPEND TO ARRAY:C911($al_RecNumsAsignaturas;$al_RecNums{$i_registros})
			End if 
			
			For ($i_notas;1;Size of array:C274($al_RecNumsCalificaciones))
				READ WRITE:C146([Alumnos_Calificaciones:208])
				GOTO RECORD:C242([Alumnos_Calificaciones:208];$al_RecNumsCalificaciones{$i_notas})
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;iPrintActa;vlNTA_DecimalesNO)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=NTA_Grade2LongText ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36)
				SAVE RECORD:C53([Alumnos_Calificaciones:208])
				If (Find in array:C230($al_Idalumnos;[Alumnos_Calificaciones:208]ID_Alumno:6)<0)
					APPEND TO ARRAY:C911($al_Idalumnos;[Alumnos_Calificaciones:208]ID_Alumno:6)
				End if 
			End for 
			IT_Progress (0;$l_idProcesoAvance;$i_registros/Size of array:C274($al_RecNums))
		End if 
	End if 
End for 
IT_Progress (-1;$l_idProcesoAvance)
KRL_UnloadReadOnly (->[Asignaturas:18])
KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])

$l_idProcesoAvance:=IT_Progress (1;$l_idProcesoAvance;0;"Recalculando promedio oficial general de las asignaturas con resultado no calculado...")
For ($i_registros;1;Size of array:C274($al_RecNumsAsignaturas))
	READ WRITE:C146([Asignaturas:18])
	GOTO RECORD:C242([Asignaturas:18];$al_RecNumsAsignaturas{$i_registros})
	EV2_ResultadosAsignatura ($al_RecNumsAsignaturas{$i_registros})
	SAVE RECORD:C53([Asignaturas:18])
	$l_idProcesoAvance:=IT_Progress (0;$l_idProcesoAvance;$i_registros/Size of array:C274($al_RecNumsAsignaturas))
End for 
IT_Progress (-1;$l_idProcesoAvance)
KRL_UnloadReadOnly (->[Asignaturas:18])


$l_idProcesoAvance:=IT_Progress (1;$l_idProcesoAvance;0;"Recalculando promedio oficial general para alumnos con asignaturas con resultado no calculado...")
For ($i_registros;1;Size of array:C274($al_Idalumnos))
	AL_CalculaPromediosGenerales ($al_Idalumnos{$i_registros})
	IT_Progress (0;$l_idProcesoAvance;$i_registros/Size of array:C274($al_Idalumnos))
End for 
IT_Progress (-1;$l_idProcesoAvance)

