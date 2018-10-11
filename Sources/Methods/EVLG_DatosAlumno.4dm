//%attributes = {}
  //EVLG_DatosAlumno

$recNumAlumnos:=$1

If ($1>0)
	KRL_GotoRecord (->[Alumnos:2];$recNumAlumnos;False:C215)
	READ ONLY:C145([Cursos:3])
	READ ONLY:C145([Profesores:4])
	READ ONLY:C145([Personas:7])
	RELATE ONE:C42([Alumnos:2]curso:20)
	RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
	
	vtEVLG_Curso_ProfesorJefe:=[Alumnos:2]curso:20+" / "+[Profesores:4]Nombre_comun:21
	
	QUERY:C277([Personas:7];[Personas:7]No:1=[Alumnos:2]Apoderado_académico_Número:27)
	If (Records in selection:C76([Personas:7])=0)
		QUERY:C277([Personas:7];[Personas:7]No:1=[Alumnos:2]Apoderado_Cuentas_Número:28)
	End if 
	
	If ([Profesores:4]eMail_profesional:38#"")
		OBJECT SET FONT STYLE:C166(vtEVLG_Curso_ProfesorJefe;4)
		OBJECT SET COLOR:C271(vtEVLG_Curso_ProfesorJefe;-5)
	Else 
		OBJECT SET FONT STYLE:C166(vtEVLG_Curso_ProfesorJefe;1)
		OBJECT SET COLOR:C271(vtEVLG_Curso_ProfesorJefe;-15)
	End if 
	If ([Alumnos:2]eMAIL:68#"")
		OBJECT SET FONT STYLE:C166([Alumnos:2]apellidos_y_nombres:40;4)
		OBJECT SET COLOR:C271([Alumnos:2]apellidos_y_nombres:40;-5)
	Else 
		OBJECT SET FONT STYLE:C166([Alumnos:2]apellidos_y_nombres:40;1)
		OBJECT SET COLOR:C271([Alumnos:2]apellidos_y_nombres:40;-15)
	End if 
	If ([Personas:7]eMail:34#"")
		OBJECT SET FONT STYLE:C166([Personas:7]Nombre_Comun:60;4)
		OBJECT SET COLOR:C271([Personas:7]Nombre_Comun:60;-5)
	Else 
		OBJECT SET FONT STYLE:C166([Personas:7]Nombre_Comun:60;1)
		OBJECT SET COLOR:C271([Personas:7]Nombre_Comun:60;-15)
	End if 
	
	OBJECT SET VISIBLE:C603(*;"InfoAlumno@";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"InfoAlumno@";False:C215)
End if 

