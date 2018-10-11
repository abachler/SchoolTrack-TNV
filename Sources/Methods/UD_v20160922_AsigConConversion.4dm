//%attributes = {}
  // UD_v20160922_AsigConConversion()
  // 
  //
  // creado por: Alberto Bachler Klein: 23-09-16, 14:51:32
  // -----------------------------------------------------------


ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])


$y_tabla:=->[xxSTR_EstilosEvaluacion:44]
ARRAY LONGINT:C221($al_recNum;0)
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNum)
$l_ProgressProcID:=IT_Progress (1;0;0;"")
For ($i_registros;1;Size of array:C274($al_recNum))
	KRL_GotoRecord ($y_tabla;$al_recNum{$i_registros};False:C215)
	If (OK=1)
		EVS_ReadStyleData ([xxSTR_EstilosEvaluacion:44]ID:1)
		If ((iEvaluationMode#iPrintActa) & (iConversionTable=1))
			READ WRITE:C146([Asignaturas:18])
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=[xxSTR_EstilosEvaluacion:44]ID:1)
			APPLY TO SELECTION:C70([Asignaturas:18];[Asignaturas:18]NotaOficial_conEstiloAsignatura:95:=True:C214)
		End if 
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_registros/Size of array:C274($al_recNum);"")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
UNLOAD RECORD:C212($y_tabla->)
UNLOAD RECORD:C212([Asignaturas:18])
