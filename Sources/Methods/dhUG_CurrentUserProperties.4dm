//%attributes = {}
  //dhUG_CurrentUserProperties

  // ----------------------------------------------------
  // Nombre usuario (OS): Administrator
  // Fecha y hora: 28-09-04, 09:46:59
  // ----------------------------------------------------
  // Método: dhUG_CurrentUserProperties
  // Descripción
  // lee información en la tabla relacionada de los usuarios para determinar permisos especiales
  //
  // Parámetros
  // ----------------------------------------------------



<>bUSR_EsProfesorJefe:=False:C215
<>tUSR_Curso:=""
<>lSTR_IDTutor_USR:=-1  // MONO 26-02-2014 cambio esto de 0 a -1 debido a que cuando el usuario no tiene registro relacionado en Profesores y Funcionarios,
  // cuando accede a alumnos que NO tienen tutor pueden entrar a la ficha completa debido a los permisos para profesores jefes y tutores.
<>tSTR_CursoProfesor_USR:=""

$recNum:=Find in field:C653([Cursos:3]Numero_del_profesor_jefe:2;<>lUSR_RelatedTableUserID)
If ($recNum>=0)
	READ ONLY:C145([Cursos:3])
	GOTO RECORD:C242([Cursos:3];$recNUm)
	<>bUSR_EsProfesorJefe:=True:C214
	<>tUSR_Curso:=[Cursos:3]Curso:1
	<>tSTR_CursoProfesor_USR:=<>tUSR_Curso
End if 

$recNum:=Find in field:C653([Profesores:4]Numero:1;<>lUSR_RelatedTableUserID)
If ($recNUm>=0)
	READ ONLY:C145([Profesores:4])
	GOTO RECORD:C242([Profesores:4];$recNum)
	<>lSTR_IDTutor_USR:=[Profesores:4]Numero:1
End if 
