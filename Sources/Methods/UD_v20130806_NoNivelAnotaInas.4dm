//%attributes = {}
  //UD_v20130806_NoNivelAnotaInas

C_LONGINT:C283($i;$l_Therm)
ARRAY LONGINT:C221($al_RecNum;0)

READ ONLY:C145([Alumnos:2])
READ WRITE:C146([Alumnos_Inasistencias:10])
READ WRITE:C146([Alumnos_Anotaciones:11])

QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Nivel_Numero:9=0)
SELECTION TO ARRAY:C260([Alumnos_Inasistencias:10];$al_RecNum)
$l_Therm:=IT_UThermometer (1;0;"Verificando nivel de inasistencias del alumno.")
For ($i;1;Size of array:C274($al_RecNum))
	GOTO RECORD:C242([Alumnos_Inasistencias:10];$al_RecNum{$i})
	If ([Alumnos_Inasistencias:10]Año:8=<>gyear)
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Inasistencias:10]Alumno_Numero:4)
		[Alumnos_Inasistencias:10]Nivel_Numero:9:=[Alumnos:2]nivel_numero:29
		SAVE RECORD:C53([Alumnos_Inasistencias:10])
	Else 
		QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1=Abs:C99([Alumnos_Inasistencias:10]Alumno_Numero:4);*)
		QUERY:C277([Alumnos_Historico:25]; & ;[Alumnos_Historico:25]Año:2=[Alumnos_Inasistencias:10]Año:8)
		[Alumnos_Inasistencias:10]Nivel_Numero:9:=[Alumnos_Historico:25]Nivel:11
		SAVE RECORD:C53([Alumnos_Inasistencias:10])
	End if 
End for 
IT_UThermometer (-2;$l_Therm)

QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Nivel_Numero:13=0)
SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11];$al_RecNum)
$l_Therm:=IT_UThermometer (1;0;"Verificando nivel de anotaciones del alumno.")
For ($i;1;Size of array:C274($al_RecNum))
	GOTO RECORD:C242([Alumnos_Anotaciones:11];$al_RecNum{$i})
	If ([Alumnos_Anotaciones:11]Año:11=<>gyear)
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Anotaciones:11]Alumno_Numero:6)
		[Alumnos_Anotaciones:11]Nivel_Numero:13:=[Alumnos:2]nivel_numero:29
		SAVE RECORD:C53([Alumnos_Anotaciones:11])
	Else 
		QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1=Abs:C99([Alumnos_Anotaciones:11]Alumno_Numero:6);*)
		QUERY:C277([Alumnos_Historico:25]; & ;[Alumnos_Historico:25]Año:2=[Alumnos_Anotaciones:11]Año:11)
		[Alumnos_Anotaciones:11]Nivel_Numero:13:=[Alumnos_Historico:25]Nivel:11
		SAVE RECORD:C53([Alumnos_Anotaciones:11])
	End if 
End for 
IT_UThermometer (-2;$l_Therm)
KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
KRL_UnloadReadOnly (->[Alumnos_Anotaciones:11])

