//%attributes = {}
  //AL_AsignaCodigoComuna

READ ONLY:C145([xxSTR_Comunas:94])
READ WRITE:C146([Alumnos:2])
SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums)
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
	QUERY:C277([xxSTR_Comunas:94];[xxSTR_Comunas:94]Nombre_comuna:7=[Alumnos:2]Comuna:14)
	[Alumnos:2]Codigo_Comuna:79:=[xxSTR_Comunas:94]Code_comuna:4
	SAVE RECORD:C53([Alumnos:2])
End for 
UNLOAD RECORD:C212([Alumnos:2])
READ ONLY:C145([Alumnos:2])