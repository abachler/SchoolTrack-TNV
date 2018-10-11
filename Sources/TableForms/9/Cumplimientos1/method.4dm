Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		WDW_SlideDrawer (->[Alumnos_Castigos:9];"Cumplimientos")
		<>aListSect:=0
		<>at_NombreNivelesActivos:=0
		<>aCursos:=0
		ARRAY LONGINT:C221(alCastigos_RecNums;0)
		ARRAY INTEGER:C220(aiCastigos_NumeroLista;0)
		ARRAY LONGINT:C221(alCastigos_NoNivel;0)
		ARRAY INTEGER:C220(aiCastigos_Horas;0)
		ARRAY TEXT:C222(atCastigos_NombreAlumno;0)
		ARRAY DATE:C224(adCastigo_Fecha;0)
		ARRAY BOOLEAN:C223(abCastigo_Cumplimiento;0)
		ARRAY TEXT:C222(atCastigos_curso;0)
		
		$pID:=IT_UThermometer (1;0;__ ("Buscando alumnos con castigos incumlidos..."))
		QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Castigo_cumplido:4=False:C215)
		CREATE SET:C116([Alumnos_Castigos:9];"Castigos")
		$err:=AL_SetArraysNam (xALP_Det;1;7;"atCastigos_curso";"aiCastigos_NumeroLista";"atCastigos_NombreAlumno";"adCastigo_Fecha";"abCastigo_Cumplimiento";"alCastigos_NoNivel";"alCastigos_RecNums")
		AL_SetHeaders (xALP_Det;1;5;__ ("Curso");__ ("NºLista");__ ("Alumno");__ ("Fecha");__ ("Cumplida"))
		AL_SetWidths (xALP_Det;1;5;60;40;150;75;75)
		ALP_SetDefaultAppareance (xALP_Det;9;1;4;1;4)
		AL_SetFormat (xALP_Det;5;"Si;No";1;1;1;0)
		AL_SetColOpts (xALP_Det;0;0;0;2;0;0;0)
		AL_SetSort (xALP_Det;6;1;2)
		AL_SetSortOpts (xALP_Det;1;1;1;"Ordenamiento";1)
		AL_SetMiscOpts (xALP_Det;0;1;"\\";0;3)
		AL_SetLine (xALP_Det;0)
		IT_UThermometer (-2;$pID)
End case 
