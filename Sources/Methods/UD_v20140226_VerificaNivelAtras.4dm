//%attributes = {}
  //UD_v20140226_VerificaNivelAtras

C_LONGINT:C283($i;$l_Therm)
ARRAY LONGINT:C221($al_RecNum;0)

READ ONLY:C145([Alumnos:2])
READ WRITE:C146([Alumnos_Atrasos:55])

QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Nivel_Numero:8=0)
SELECTION TO ARRAY:C260([Alumnos_Atrasos:55];$al_RecNum)
$l_Therm:=IT_UThermometer (1;0;"Verificando nivel...")
For ($i;1;Size of array:C274($al_RecNum))
	GOTO RECORD:C242([Alumnos_Atrasos:55];$al_RecNum{$i})
	If ([Alumnos_Atrasos:55]Año:6=<>gyear)
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Atrasos:55]Alumno_numero:1)
		[Alumnos_Atrasos:55]Nivel_Numero:8:=[Alumnos:2]nivel_numero:29
		SAVE RECORD:C53([Alumnos_Atrasos:55])
	Else 
		QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1=Abs:C99([Alumnos_Atrasos:55]Alumno_numero:1);*)
		QUERY:C277([Alumnos_Historico:25]; & ;[Alumnos_Historico:25]Año:2=[Alumnos_Atrasos:55]Año:6)
		[Alumnos_Atrasos:55]Nivel_Numero:8:=[Alumnos_Historico:25]Nivel:11
		SAVE RECORD:C53([Alumnos_Atrasos:55])
	End if 
End for 
IT_UThermometer (-2;$l_Therm)
KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])