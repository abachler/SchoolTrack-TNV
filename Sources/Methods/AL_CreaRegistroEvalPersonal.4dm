//%attributes = {}
  // AL_CreaRegistroEvalPersonal()
  // Por: Alberto Bachler K.: 09-06-14, 17:53:07
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$id:=$1
$recNum:=Find in field:C653([Alumnos_EvaluacionValorica:23]Alumno_Numero:1;$id)
If ($recNum<0)
	CREATE RECORD:C68([Alumnos_EvaluacionValorica:23])
	[Alumnos_EvaluacionValorica:23]Alumno_Numero:1:=$id
	SAVE RECORD:C53([Alumnos_EvaluacionValorica:23])
End if 
KRL_ReloadAsReadOnly (->[Alumnos_EvaluacionValorica:23])