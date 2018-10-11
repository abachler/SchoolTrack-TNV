//%attributes = {}
  // AL_Rankings()
  // Por: Alberto Bachler K.: 16-06-14, 19:56:49
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


$l_avance:=IT_UThermometer (1;0;__ ("Calculando ranking de alumnos en curso y nivel..."))
QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Promedio_General_Numerico:57#0)
SELECTION TO ARRAY:C260([Alumnos:2];$al_recNumAlumnos)
For ($i;1;Size of array:C274($al_recNumAlumnos))
	READ WRITE:C146([Alumnos:2])
	GOTO RECORD:C242([Alumnos:2];$al_recNumAlumnos{$i})
	[Alumnos:2]RankingEnCurso:93:=_RankingEnCurso 
	SAVE RECORD:C53([Alumnos:2])
	[Alumnos:2]RankingEnNivel:94:=_RankingEnNivel 
	SAVE RECORD:C53([Alumnos:2])
End for 
UNLOAD RECORD:C212([Alumnos:2])
READ ONLY:C145([Alumnos:2])
$l_avance:=IT_UThermometer (-2;$l_avance)