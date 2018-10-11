//%attributes = {}
  //AL_CreateGradeRecords

$idalumno:=[Alumnos:2]numero:1
$NoNivelAlumno:=[Alumnos:2]nivel_numero:29
$sexoAlumno:=[Alumnos:2]Sexo:49
$cursoAlumno:=[Alumnos:2]curso:20

If (([Alumnos:2]curso:20#"") & ([Alumnos:2]nivel_numero:29<Nivel_Egresados) & ([Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta))
	Case of 
		: ($sexoAlumno="")
			$sex:=1
		: ($sexoAlumno="F")
			$sex:=2
		: ($sexoAlumno="M")
			$sex:=3
	End case 
	READ ONLY:C145([Cursos:3])
	QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$cursoAlumno)
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$cursoAlumno;*)
	
	READ ONLY:C145([Asignaturas:18])
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1>0;*)
	QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Seleccion:17=False:C215;*)
	QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Electiva:11=False:C215)
	QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Seleccion_por_sexo:24=1;*)
	QUERY SELECTION:C341([Asignaturas:18]; | [Asignaturas:18]Seleccion_por_sexo:24=$sex)
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNums;"")
	For ($i;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([Asignaturas:18];$aRecNums{$i})
		AS_CreaRegistrosEvaluacion ($idalumno;[Asignaturas:18]Numero:1)
	End for 
End if 