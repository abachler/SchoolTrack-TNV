Case of 
	: (Form event:C388=On Load:K2:1)
		<>aCursos:=1
		ARRAY TEXT:C222(atBU_NombreAlumno;0)
		ARRAY LONGINT:C221(alBU_AlumnoID;0)
		$err:=AL_SetArraysNam (xALP_ListaAlumnos;1;1;"atBU_NombreAlumno")
		$err:=AL_SetArraysNam (xALP_ListaAlumnos;2;1;"alBU_AlumnoID")
		AL_SetHeaders (xALP_ListaAlumnos;1;1;__ ("Alumnos"))
		ALP_SetDefaultAppareance (xALP_ListaAlumnos;11;1;2;1;4)
		AL_SetSort (xALP_ListaAlumnos;1)
		AL_SetWidths (xALP_ListaAlumnos;1;2;200;52)
		AL_SetMiscOpts (xALP_ListaAlumnos;0;0;"\\";0;1)
		AL_SetColOpts (xALP_ListaAlumnos;0;0;0;1;0;0;0)
		AL_SetRowOpts (xALP_ListaAlumnos;1;1;0;0;0)
		AL_SetSortOpts (xALP_ListaAlumnos;1;0;0;"";0)
		AL_SetScroll (xALP_ListaAlumnos;0;-3)
		AL_UpdateArrays (xALP_ListaAlumnos;0)
		If (<>aCursos>=1)
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20;=;<>aCursos{1})
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;atBU_NombreAlumno;[Alumnos:2]numero:1;alBU_AlumnoID)
			AL_UpdateArrays (xALP_ListaAlumnos;-2)
		End if 
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		If (Self:C308->#0)
			vtLunes:=""
			vtMartes:=""
			vtMiercoles:=""
			vtJueves:=""
			vtViernes:=""
			vtSabado:=""
			vtDomingo:=""
			AL_UpdateArrays (xALP_ListaAlumnos;0)
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20;=;<>aCursos{<>acursos})
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;atBU_NombreAlumno;[Alumnos:2]numero:1;alBU_AlumnoID)
			AL_UpdateArrays (xALP_ListaAlumnos;-2)
		End if 
End case 
