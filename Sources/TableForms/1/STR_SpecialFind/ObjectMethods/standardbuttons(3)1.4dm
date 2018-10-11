  //ALL RECORDS(vyQRY_TablePointer->)
If (cbSearchSelection=1)
	Case of 
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Anotaciones:11]))
			KRL_RelateSelection (->[Alumnos_Anotaciones:11]Alumno_Numero:6;->[Alumnos:2]numero:1)
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Atrasos:55]))
			KRL_RelateSelection (->[Alumnos_Atrasos:55]Alumno_numero:1;->[Alumnos:2]numero:1)
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Castigos:9]))
			KRL_RelateSelection (->[Alumnos_Castigos:9]Alumno_Numero:8;->[Alumnos:2]numero:1)
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_ControlesMedicos:99]))
			KRL_RelateSelection (->[Alumnos_ControlesMedicos:99]Numero_Alumno:1;->[Alumnos:2]numero:1)
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_EventosEnfermeria:14]))
			KRL_RelateSelection (->[Alumnos_EventosEnfermeria:14]Alumno_Numero:1;->[Alumnos:2]numero:1)
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_EventosOrientacion:21]))
			KRL_RelateSelection (->[Alumnos_EventosOrientacion:21]Alumno_Numero:1;->[Alumnos:2]numero:1)
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Inasistencias:10]))
			KRL_RelateSelection (->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos:2]numero:1)
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_ObsOrientacion:127]))
			KRL_RelateSelection (->[Alumnos_ObsOrientacion:127]Alumno_Numero:1;->[Alumnos:2]numero:1)
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Suspensiones:12]))
			KRL_RelateSelection (->[Alumnos_Suspensiones:12]Alumno_Numero:7;->[Alumnos:2]numero:1)
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Asignaturas_Inasistencias:125]))
			KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Alumnos:2]numero:1)
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Licencias:73]))
			KRL_RelateSelection (->[Alumnos_Licencias:73]Alumno_numero:1;->[Alumnos:2]numero:1)
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_EventosPersonales:16]))
			KRL_RelateSelection (->[Alumnos_EventosPersonales:16]Alumno_Numero:1;->[Alumnos:2]numero:1)
	End case 
Else 
	$inicioCicloEscolar:=PERIODOS_InicioAñoSTrack 
	$finCicloEscolar:=PERIODOS_FinAñoPeriodosSTrack 
	Case of 
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Anotaciones:11]))
			QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Año:11=<>gYear)
			
			
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Atrasos:55]))
			QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Año:6=<>gYear)
			
			
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Castigos:9]))
			QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Año:5=<>gYear)
			
			
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_ControlesMedicos:99]))
			QUERY:C277([Alumnos_ControlesMedicos:99];[Alumnos_ControlesMedicos:99]Fecha:2;>=;$inicioCicloEscolar;*)
			QUERY:C277([Alumnos_ControlesMedicos:99]; & ;[Alumnos_ControlesMedicos:99]Fecha:2;<=;$finCicloEscolar)
			
			
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_EventosEnfermeria:14]))
			QUERY:C277([Alumnos_EventosEnfermeria:14];[Alumnos_EventosEnfermeria:14]Fecha:2;>=;$inicioCicloEscolar;*)
			QUERY:C277([Alumnos_EventosEnfermeria:14]; & ;[Alumnos_EventosEnfermeria:14]Fecha:2;<=;$finCicloEscolar)
			
			
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_EventosOrientacion:21]))
			QUERY:C277([Alumnos_EventosOrientacion:21];[Alumnos_EventosOrientacion:21]Fecha:2;>=;$inicioCicloEscolar;*)
			QUERY:C277([Alumnos_EventosOrientacion:21]; & ;[Alumnos_EventosOrientacion:21]Fecha:2;<=;$finCicloEscolar)
			
			
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Inasistencias:10]))
			QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Año:8=<>gYear)
			
			
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_ObsOrientacion:127]))
			QUERY:C277([Alumnos_ObsOrientacion:127];[Alumnos_ObsOrientacion:127]Fecha_observación:2;>=;$inicioCicloEscolar;*)
			QUERY:C277([Alumnos_ObsOrientacion:127]; & ;[Alumnos_ObsOrientacion:127]Fecha_observación:2;<=;$finCicloEscolar)
			
			
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Suspensiones:12]))
			QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Año:1=<>gYear)
			
			
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Asignaturas_Inasistencias:125]))
			QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4;>=;$inicioCicloEscolar;*)
			QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4;<=;$finCicloEscolar)
			
			
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_Licencias:73]))
			QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Año:9=<>gYear)
			
			
		: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos_EventosPersonales:16]))
			QUERY:C277([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]Fecha:3;>=;$inicioCicloEscolar;*)
			QUERY:C277([Alumnos_EventosPersonales:16]; & ;[Alumnos_EventosPersonales:16]Fecha:3;<=;$finCicloEscolar)
	End case 
	
	
End if 


If (Records in selection:C76(vyQRY_TablePointer->)>0)
	ACCEPT:C269
Else 
	$ignore:=CD_Dlog (0;__ ("No se encontró ningún registro en el rango de fechas especificado."))
End if 


