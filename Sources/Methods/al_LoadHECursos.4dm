//%attributes = {}
  //al_LoadHECursos

AL_RemoveArrays (xALP_HNotasECursos;1;30)

ARRAY DATE:C224(ad_FechaEvCurso;0)  //RCH 53871
ARRAY TEXT:C222(at_CategoriaEvCurso;0)
ARRAY TEXT:C222(at_TemaEvCurso;0)

ALP_DefaultColSettings (xALP_HNotasECursos;1;"ad_FechaEvCurso";__ ("Fecha");150;"";2;0;0)  //´3 Fecha
ALP_DefaultColSettings (xALP_HNotasECursos;2;"at_CategoriaEvCurso";__ ("Categoría");211;"";0;0;0)  //´4 Categoría
ALP_DefaultColSettings (xALP_HNotasECursos;3;"at_TemaEvCurso";__ ("Tema");211;"";1;0;0)  //´5 Tema

ALP_SetDefaultAppareance (xALP_HNotasECursos;9;1;6;2;8)
AL_SetColOpts (xALP_HNotasECursos;1;1;1;0;0)
AL_SetRowOpts (xALP_HNotasECursos;0;1;0;0;1;0)
AL_SetCellOpts (xALP_HNotasECursos;0;1;1)
AL_SetMiscOpts (xALP_HNotasECursos;0;0;"\\";0;1)
AL_SetMainCalls (xALP_HNotasECursos;"";"")
AL_SetSortOpts (xALP_HNotasECursos;0;0)  //RCH
AL_SetCallbacks (xALP_HNotasECursos;"";"")
AL_SetScroll (xALP_HNotasECursos;0;-3)
AL_SetDrgOpts (xALP_HNotasECursos;0;30;0)
AL_SetSort (xALP_HNotasECursos;0)
AL_SetEntryOpts (xALP_ComentariosAlumno;1)

  //dragging options

AL_SetDrgSrc (xALP_HNotasECursos;1;"";"";"")
AL_SetDrgSrc (xALP_HNotasECursos;2;"";"";"")
AL_SetDrgSrc (xALP_HNotasECursos;3;"";"";"")
AL_SetDrgDst (xALP_HNotasECursos;1;"";"";"")
AL_SetDrgDst (xALP_HNotasECursos;1;"";"";"")
AL_SetDrgDst (xALP_HNotasECursos;1;"";"";"")

READ ONLY:C145([Cursos:3])
CREATE SET:C116([Cursos:3];"CursoActual")
QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos_Historico:25]Curso:3)
CU_LoadEventosCurso (vl_Year_Historico;[Cursos:3]Numero_del_curso:6;xALP_HNotasECursos)
USE SET:C118("CursoActual")
CLEAR SET:C117("CursoActual")