//%attributes = {}
  //dbu_ßVerifyPersEvalRecords

READ WRITE:C146([Alumnos_EvaluacionValorica:23])
QUERY:C277([Alumnos_EvaluacionValorica:23];[Alumnos_EvaluacionValorica:23]Alumno_Numero:1=[Alumnos:2]numero:1)
If (Records in selection:C76([Alumnos_EvaluacionValorica:23])=0)
	CREATE RECORD:C68([Alumnos_EvaluacionValorica:23])
	[Alumnos_EvaluacionValorica:23]Alumno_Numero:1:=[Alumnos:2]numero:1
	SAVE RECORD:C53([Alumnos_EvaluacionValorica:23])
End if 
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Alumnos:2])/Records in table:C83([Alumnos:2]);vmessage)
UNLOAD RECORD:C212([Alumnos_EvaluacionValorica:23])
READ ONLY:C145([Alumnos_EvaluacionValorica:23])