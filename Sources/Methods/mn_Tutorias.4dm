//%attributes = {}
  //mn_Tutorias

If (USR_GetMethodAcces (Current method name:C684))
	ARRAY TEXT:C222(aCursos;0)
	ARRAY TEXT:C222(aJefes;0)
	ARRAY LONGINT:C221(aNivelCurso;0)
	ARRAY TEXT:C222(aAlumnos;0)
	ARRAY LONGINT:C221(aAlumnosID;0)
	ARRAY TEXT:C222(aProfesores;0)
	ARRAY LONGINT:C221(aProfesoresID;0)
	ARRAY TEXT:C222(aPupilos;0)
	ARRAY LONGINT:C221(aPupilosID;0)
	
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([Cursos:3])
	READ ONLY:C145([Profesores:4])
	
	  //ALL RECORDS([Cursos])
	QUERY:C277([Cursos:3];[Cursos:3]Numero_del_curso:6>=0)
	SELECTION TO ARRAY:C260([Cursos:3]Curso:1;aCursos;[Profesores:4]Apellidos_y_nombres:28;aJefes;[Cursos:3]Nivel_Numero:7;aNivelCurso)
	
	QUERY:C277([Profesores:4];[Profesores:4]Es_Tutor:34=True:C214)
	QUERY SELECTION:C341([Profesores:4];[Profesores:4]Inactivo:62=False:C215)
	SELECTION TO ARRAY:C260([Profesores:4]Apellidos_y_nombres:28;aProfesores;[Profesores:4]Numero:1;aProfesoresID)
	
	$winRef:=WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_Tutorias";-1;8;__ ("Tutorías"))
	DIALOG:C40([xxSTR_Constants:1];"STR_Tutorias")
	CLOSE WINDOW:C154
	
	
	ARRAY TEXT:C222(aCursos;0)
	ARRAY TEXT:C222(aJefes;0)
	ARRAY LONGINT:C221(aNivelCurso;0)
	ARRAY TEXT:C222(aAlumnos;0)
	ARRAY LONGINT:C221(aAlumnosID;0)
	ARRAY TEXT:C222(aProfesores;0)
	ARRAY LONGINT:C221(aProfesoresID;0)
	ARRAY TEXT:C222(aPupilos;0)
	ARRAY LONGINT:C221(aPupilosID;0)
End if 