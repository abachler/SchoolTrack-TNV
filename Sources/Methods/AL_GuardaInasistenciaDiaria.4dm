//%attributes = {}
C_LONGINT:C283($i)
For ($i;1;Size of array:C274(alABS_AlumnosID))
	READ ONLY:C145([Alumnos_Licencias:73])
	QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=alABS_AlumnosID{$i})
	SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Desde:2;$desde;[Alumnos_Licencias:73]Hasta:3;$hasta;[Alumnos_Licencias:73]ID:6;$lic)
	READ ONLY:C145([Alumnos_Inasistencias:10])
	QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=alABS_AlumnosID{$i};*)
	QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1=dDate)
	If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
		CREATE RECORD:C68([Alumnos_Inasistencias:10])
		[Alumnos_Inasistencias:10]Alumno_Numero:4:=alABS_AlumnosID{$i}
		[Alumnos_Inasistencias:10]Nivel_Numero:9:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos:2]nivel_numero:29)
		[Alumnos_Inasistencias:10]Fecha:1:=dDate
		[Alumnos_Inasistencias:10]RegistradaEl:11:=Current date:C33(*)
		[Alumnos_Inasistencias:10]RegistradaPor:10:=<>tUSR_CurrentUser
		For ($j;1;Size of array:C274($desde))
			If ((dDate>=$desde{$j}) & (dDate<=$hasta{$j}))
				[Alumnos_Inasistencias:10]Licencia:5:=$lic{$j}
				[Alumnos_Inasistencias:10]Justificación:2:="Licencia Nº "+String:C10($lic{$j})
				$j:=Size of array:C274($desde)
			End if 
		End for 
		SAVE RECORD:C53([Alumnos_Inasistencias:10])
		UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
		vb_AsignaSituacionfinal:=True:C214
		$idAlumno:=[Alumnos_Inasistencias:10]Alumno_Numero:4
		AL_CalculaSituacionFinal ($idAlumno)
		vb_AsignaSituacionfinal:=False:C215
		LOG_RegisterEvt ("Conducta - Registro de inasistencia diaria: "+String:C10(dDate;7)+" - "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
	End if 
End for 