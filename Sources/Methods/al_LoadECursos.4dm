//%attributes = {}
  //al_LoadECursos

  //$1 nombre del área
  //$2 pestaña Observaciones 1. Pestaña HIstórico 2.
C_LONGINT:C283($1;$area;$2;$pestaña)
$area:=$1
$pestaña:=$2

AL_RemoveArrays ($area;1;30)

ARRAY DATE:C224(ad_FechaEvCurso;0)  //RCH 53871
ARRAY TEXT:C222(at_CategoriaEvCurso;0)
ARRAY TEXT:C222(at_TemaEvCurso;0)
ARRAY TEXT:C222(aYears;0)

ALP_DefaultColSettings ($area;1;"ad_FechaEvCurso";__ ("Fecha");80;"";2;0;0)  //´3 Fecha
ALP_DefaultColSettings ($area;2;"at_CategoriaEvCurso";__ ("Categoría");238;"";0;0;0)  //´4 Categoría
ALP_DefaultColSettings ($area;3;"at_TemaEvCurso";__ ("Tema");238;"";1;0;0)  //´5 Tema

  //ALP_SetDefaultAppareance ($area;9;2;8;1;6)//MONO Ticket 186325
AL_SetColOpts ($area;1;1;1;0;0)
AL_SetRowOpts ($area;0;1;0;0;1;0)
AL_SetCellOpts ($area;0;1;1)
AL_SetMiscOpts ($area;0;0;"\\";0;1)
AL_SetMainCalls ($area;"";"")
AL_SetSortOpts ($area;0;0)  //RCH
AL_SetCallbacks ($area;"";"")
AL_SetScroll ($area;0;-3)
AL_SetDrgOpts ($area;0;30;0)
AL_SetLine ($area;0)
AL_SetSort ($area;0)
AL_SetEntryOpts ($area;1)

  //dragging options

AL_SetDrgSrc ($area;1;"";"";"")
AL_SetDrgSrc ($area;2;"";"";"")
AL_SetDrgSrc ($area;3;"";"";"")
AL_SetDrgDst ($area;1;"";"";"")
AL_SetDrgDst ($area;2;"";"";"")
AL_SetDrgDst ($area;3;"";"";"")

Case of 
	: ($pestaña=1)  //pestaña comentarios en alumnos
		READ ONLY:C145([Alumnos:2])
		CREATE SET:C116([Alumnos:2];"AlumnoActual")
		QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
		CU_LoadEventosCurso (<>gYear;[Cursos:3]Numero_del_curso:6;$area)
		USE SET:C118("AlumnoActual")
		CLEAR SET:C117("AlumnoActual")
		
	: ($pestaña=2)  //pestaña histórico en alumnos
		If (vl_Year_Historico>0)
			CU_LoadEventosCurso (vl_Year_Historico;[Alumnos_SintesisAnual:210]ID_Curso:90;$area)
		Else 
			AL_UpdateArrays ($area;0)
			ARRAY DATE:C224(ad_FechaEvCurso;0)  //eventos curso
			ARRAY TEXT:C222(at_CategoriaEvCurso;0)
			ARRAY TEXT:C222(at_TemaEvCurso;0)
			AL_UpdateArrays ($area;-2)
		End if 
		
End case 