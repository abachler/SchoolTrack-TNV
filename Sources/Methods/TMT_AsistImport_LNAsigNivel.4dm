//%attributes = {}
  //TMT_AsistImport_LNAsigNivel
  //MONO Listbox con las asignaturas del nivel del curso seleccionado.

C_LONGINT:C283($l_nivel;$1;l_ultimoNivelCargado)

$l_nivel:=$1

If (l_ultimoNivelCargado#$l_nivel)
	
	ARRAY TEXT:C222(at_lbGradeCurso;0)
	ARRAY TEXT:C222(at_lbGradeAsig;0)
	ARRAY TEXT:C222(at_lbGradeAsigProfe;0)
	ARRAY TEXT:C222(at_lbGradeAbrevAsig;0)
	ARRAY LONGINT:C221(al_lbGradeIdAsig;0)
	
	l_ultimoNivelCargado:=$l_nivel
	
	READ ONLY:C145([Asignaturas:18])
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$l_nivel)
	ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Curso:5;>)
	SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;al_lbGradeIdAsig;*)
	SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;at_lbGradeAsig;*)
	SELECTION TO ARRAY:C260([Asignaturas:18]Curso:5;at_lbGradeCurso;*)
	SELECTION TO ARRAY:C260([Asignaturas:18]profesor_nombre:13;at_lbGradeAsigProfe;*)
	SELECTION TO ARRAY:C260([Asignaturas:18]Abreviación:26;at_lbGradeAbrevAsig;*)
	SELECTION TO ARRAY:C260
End if 