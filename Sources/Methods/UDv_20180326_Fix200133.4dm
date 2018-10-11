//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 26-03-18, 10:25:13
  // ----------------------------------------------------
  // Método: UDv_20180326_Fix200133
  // Descripción Fix del ticket 200133 para recaluclar los promedios de las asiganturas afectadas.
  // 
  // ----------------------------------------------------

C_LONGINT:C283($i;$l_idTermometro)
ARRAY LONGINT:C221($al_rnEva;0)
ARRAY LONGINT:C221($al_recnumAsigTemp;0)
ARRAY LONGINT:C221($al_RecNumAsignaturas;0)
C_BLOB:C604($x_recNumArray)

READ ONLY:C145([xxSTR_EstilosEvaluacion:44])
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Alumnos_Calificaciones:208])

$l_idTermometro:=IT_Progress (1;0;0;"Revisando calificaciones para recalculo ...")
ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
LONGINT ARRAY FROM SELECTION:C647([xxSTR_EstilosEvaluacion:44];$al_rnEva)
For ($i;1;Size of array:C274($al_rnEva))
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_rnEva);"Revisando calificaciones para recalculo ...")
	GOTO RECORD:C242([xxSTR_EstilosEvaluacion:44];$al_rnEva{$i})
	EVS_ReadStyleData ([xxSTR_EstilosEvaluacion:44]ID:1)
	If ((rGradesFrom=0) | (rPointsFrom=0))
		QUERY:C277([Alumnos_Calificaciones:208];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=[xxSTR_EstilosEvaluacion:44]ID:1)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]P01_Final_Nota:113=rGradesFrom;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; | ;[Alumnos_Calificaciones:208]P02_Final_Nota:188=rGradesFrom;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; | ;[Alumnos_Calificaciones:208]P03_Final_Nota:263=rGradesFrom;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; | ;[Alumnos_Calificaciones:208]P04_Final_Nota:338=rGradesFrom;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; | ;[Alumnos_Calificaciones:208]P05_Final_Nota:413=rGradesFrom)
		If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
			KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
			LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recnumAsigTemp;"")
			For ($n;1;Size of array:C274($al_recnumAsigTemp))
				If (Find in array:C230($al_RecNumAsignaturas;$al_recnumAsigTemp{$n})=-1)
					APPEND TO ARRAY:C911($al_RecNumAsignaturas;$al_recnumAsigTemp{$n})
				End if 
			End for 
		End if 
		REDUCE SELECTION:C351([Alumnos_Calificaciones:208];0)
		REDUCE SELECTION:C351([Asignaturas:18];0)
	End if 
End for 

$l_idTermometro:=IT_Progress (-1;$l_idTermometro)

BLOB_Variables2Blob (->$x_recNumArray;0;->$al_RecNumAsignaturas)
EV2dbu_Recalculos ($x_recNumArray;False:C215)