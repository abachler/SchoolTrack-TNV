
vt_PLunes:=vtLunes
vt_PMartes:=vtMartes
vt_PMiercoles:=vtMiercoles
vt_PJueves:=vtJueves
vt_PViernes:=vtViernes
vt_PSabado:=vtSabado
vt_PDomingo:=vtDomingo
vd_FechaPrint:=Current date:C33

$line:=AL_GetLine (xALP_ListaAlumnos)
vt_NombreAlumno:=atBU_NombreAlumno{$line}
vt_Curso:=<>aCursos{<>acursos}

FORM SET OUTPUT:C54([BU_Rutas_Inscripciones:35];"PrintPrograma")
PRINT SELECTION:C60([BU_Rutas_Inscripciones:35])
