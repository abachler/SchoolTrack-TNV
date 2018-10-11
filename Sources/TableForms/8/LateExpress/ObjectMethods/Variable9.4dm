C_LONGINT:C283($i)
For ($i;1;Size of array:C274(<>aExabs1))
	READ ONLY:C145([Alumnos_Inasistencias:10])
	QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=<>aExAbs2{$i};*)
	QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1=dDate)
	If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
		If (<>gAllowMultipleLates=0)
			READ ONLY:C145([Alumnos_Atrasos:55])
			QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=<>aExAbs2{$i};*)
			QUERY:C277([Alumnos_Atrasos:55]; & [Alumnos_Atrasos:55]Fecha:2=dDate)
		Else 
			REDUCE SELECTION:C351([Alumnos_Atrasos:55];0)
		End if 
		If (Records in selection:C76([Alumnos_Atrasos:55])=0)
			CREATE RECORD:C68([Alumnos_Atrasos:55])
			[Alumnos_Atrasos:55]Alumno_numero:1:=<>aExAbs2{$i}
			[Alumnos_Atrasos:55]Nivel_Numero:8:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->[Alumnos_Atrasos:55]Alumno_numero:1;->[Alumnos:2]nivel_numero:29)
			[Alumnos_Atrasos:55]Fecha:2:=dDate
			[Alumnos_Atrasos:55]MinutosAtraso:5:=<>aExAbs3{$i}  //EMA 05/10/06
			[Alumnos_Atrasos:55]id_justificacion:13:=vIdJustificacion
			[Alumnos_Atrasos:55]justificado:14:=Choose:C955(cb_justificarAtraso=1;True:C214;False:C215)
			SAVE RECORD:C53([Alumnos_Atrasos:55])
			UNLOAD RECORD:C212([Alumnos_Atrasos:55])
		End if 
	End if 
End for 
ACCEPT:C269