//%attributes = {}
  // UD_v20150529_SexoEnAprendizajes()
  // Por: Alberto Bachler K.: 29-05-15, 13:32:52
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

  //elimino los registros de evaluacion de competencias restringidas a alumnos de sexo femenino si el sexo es distinto de "F"
QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]RestriccionSexo:27=1)
ARRAY LONGINT:C221($al_RecNums;0)
LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$al_RecNums{$i_registros})
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=[MPA_DefinicionCompetencias:187]ID:1;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos:2]Sexo:49#"F";*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3>0)
	If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
		KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
	End if 
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[MPA_DefinicionCompetencias:187])

  //elimino los registros de evaluacion de competencias restringidas a alumnos de sexo masculino si el sexo es distinto de "M"
QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]RestriccionSexo:27=2)
ARRAY LONGINT:C221($al_RecNums;0)
LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$al_RecNums{$i_registros})
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=[MPA_DefinicionCompetencias:187]ID:1;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos:2]Sexo:49#"M";*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3>0)
	If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
		KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
	End if 
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[MPA_DefinicionCompetencias:187])