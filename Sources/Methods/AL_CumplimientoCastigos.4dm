//%attributes = {}
  //AL_CumplimientoCastigos


If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("El registro de información conductual está bloqueado para el ciclo escolar actual a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5))
Else 
	
	bOK:=0
	$pID:=IT_UThermometer (1;0;__ ("Buscando alumnos con castigos incumplidos..."))
	QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Castigo_cumplido:4=False:C215)
	CREATE SET:C116([Alumnos_Castigos:9];"Castigos")
	Case of 
		: (<>aCursos>0)
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=<>aCursos{<>aCursos})
			KRL_RelateSelection (->[Alumnos_Castigos:9]Alumno_Numero:8;->[Alumnos:2]numero:1;"")
			QUERY SELECTION:C341([Alumnos_Castigos:9];[Alumnos_Castigos:9]Castigo_cumplido:4=(bOk=1))
		: (<>at_NombreNivelesActivos>0)
			QUERY:C277([Alumnos:2];[Alumnos:2]Nivel_Nombre:34=<>at_NombreNivelesActivos{<>at_NombreNivelesActivos})
			KRL_RelateSelection (->[Alumnos_Castigos:9]Alumno_Numero:8;->[Alumnos:2]numero:1;"")
			QUERY SELECTION:C341([Alumnos_Castigos:9];[Alumnos_Castigos:9]Castigo_cumplido:4=(bOk=1))
		: (<>aListSect>0)
			QUERY:C277([Alumnos:2];[Alumnos:2]Sección:26=<>aListSect{<>aListSect})
			KRL_RelateSelection (->[Alumnos_Castigos:9]Alumno_Numero:8;->[Alumnos:2]numero:1;"")
			QUERY SELECTION:C341([Alumnos_Castigos:9];[Alumnos_Castigos:9]Castigo_cumplido:4=(bOk=1))
		Else 
			QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Castigo_cumplido:4=(bOk=1))
	End case 
	CREATE SET:C116([Alumnos_Castigos:9];"Castigos")
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	SELECTION TO ARRAY:C260([Alumnos_Castigos:9];alCastigos_RecNums;[Alumnos_Castigos:9]Castigo_cumplido:4;abCastigo_Cumplimiento;[Alumnos_Castigos:9]Fecha:9;adCastigo_Fecha;[Alumnos:2]curso:20;atCastigos_curso;[Alumnos:2]nivel_numero:29;alCastigos_NoNivel;[Alumnos:2]no_de_lista:53;aiCastigos_NumeroLista;[Alumnos:2]apellidos_y_nombres:40;atCastigos_NombreAlumno)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	IT_UThermometer (-2;$pID)
	
	WDW_OpenDialogInDrawer (->[Alumnos_Castigos:9];"Cumplimientos")
	If (ok=1)
		pr_PLPGncForm ("Detentions";"Castigos Pendientes";"Sesión del "+String:C10(dSesion;3))
	End if 
	CLEAR SET:C117("Castigos")
	ARRAY LONGINT:C221(alCastigos_RecNums;0)
	ARRAY INTEGER:C220(aiCastigos_NumeroLista;0)
	ARRAY LONGINT:C221(alCastigos_NoNivel;0)
	ARRAY INTEGER:C220(aiCastigos_Horas;0)
	ARRAY TEXT:C222(atCastigos_NombreAlumno;0)
	ARRAY DATE:C224(adCastigo_Fecha;0)
	ARRAY BOOLEAN:C223(abCastigo_Cumplimiento;0)
	ARRAY TEXT:C222(atCastigos_curso;0)
End if 