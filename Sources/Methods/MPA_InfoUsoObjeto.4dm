//%attributes = {}
  // MÉTODO: MPA_InfoUsoObjeto
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 06/03/12, 19:00:28
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_InfoUsoObjeto()
  // ----------------------------------------------------
C_POINTER:C301($1;$y_IdObjeto)
C_LONGINT:C283($i;$l_elemento;$l_registros)
ARRAY LONGINT:C221($al_IdAsignaturas;0)
ARRAY LONGINT:C221($al_Niveles;0)

If (False:C215)
	C_POINTER:C301(MPA_InfoUsoObjeto ;$1)
End if 




  // CODIGO PRINCIPAL
$y_IdObjeto:=$1

vlMPA_PaginaInfoUsoObjeto:=0
If (Count parameters:C259=2)
	vlMPA_PaginaInfoUsoObjeto:=$2
End if 


C_LONGINT:C283(hl_InfoObjetos)
HL_ClearList (hl_InfoObjetos)
hl_InfoObjetos:=New list:C375
APPEND TO LIST:C376(hl_InfoObjetos;"Evaluaciones";1)
APPEND TO LIST:C376(hl_InfoObjetos;"Matrices";2)

Case of 
	: (Table:C252($y_IdObjeto)=Table:C252(->[MPA_DefinicionEjes:185]))
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3=$y_IdObjeto->)
		KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1;"")
		SELECTION TO ARRAY:C260([MPA_AsignaturasMatrices:189]Asignatura:3;at_MatrizAsignaturas;[MPA_AsignaturasMatrices:189]NumeroNivel:4;$al_Niveles)
		ARRAY TEXT:C222(at_NombreNiveles;Size of array:C274($al_Niveles))
		For ($i;1;Size of array:C274($al_Niveles))
			$l_elemento:=Find in array:C230(<>al_NumeroNivelesActivos;$al_Niveles{$i})
			If ($l_elemento>0)
				at_NombreNiveles{$i}:=<>at_NombreNivelesActivos{$l_elemento}
			Else 
				at_NombreNiveles{$i}:=""
			End if 
		End for 
		
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5=$y_IdObjeto->;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
		KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;"")
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>;[Asignaturas:18]denominacion_interna:16;>)
		SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;at_Asignaturas;[Asignaturas:18]Curso:5;at_Cursos;[Asignaturas:18]Numero:1;$al_IdAsignaturas)
		ARRAY LONGINT:C221(al_Evaluados;Size of array:C274($al_IdAsignaturas))
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
		For ($i;1;Size of array:C274($al_IdAsignaturas))
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$al_IdAsignaturas{$i};*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5=$y_IdObjeto->;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
			al_Evaluados{$i}:=$l_registros
		End for 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		$t_tituloVentana:=__ ("Utilización del Eje de aprendizaje")
		vtMPA_Enunciado:=[MPA_DefinicionEjes:185]Nombre:3
		
	: (Table:C252($y_IdObjeto)=Table:C252(->[MPA_DefinicionDimensiones:188]))
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4=$y_IdObjeto->)
		KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1;"")
		SELECTION TO ARRAY:C260([MPA_AsignaturasMatrices:189]Asignatura:3;at_MatrizAsignaturas;[MPA_AsignaturasMatrices:189]NumeroNivel:4;$al_Niveles)
		ARRAY TEXT:C222(at_NombreNiveles;Size of array:C274($al_Niveles))
		For ($i;1;Size of array:C274($al_Niveles))
			$l_elemento:=Find in array:C230(<>al_NumeroNivelesActivos;$al_Niveles{$i})
			If ($l_elemento>0)
				at_NombreNiveles{$i}:=<>at_NombreNivelesActivos{$l_elemento}
			Else 
				at_NombreNiveles{$i}:=""
			End if 
		End for 
		
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=$y_IdObjeto->;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
		KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;"")
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>;[Asignaturas:18]denominacion_interna:16;>)
		SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;at_Asignaturas;[Asignaturas:18]Curso:5;at_Cursos;[Asignaturas:18]Numero:1;$al_IdAsignaturas)
		ARRAY LONGINT:C221(al_Evaluados;Size of array:C274($al_IdAsignaturas))
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
		For ($i;1;Size of array:C274($al_IdAsignaturas))
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$al_IdAsignaturas{$i};*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=$y_IdObjeto->;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
			al_Evaluados{$i}:=$l_registros
		End for 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		$t_tituloVentana:=__ ("Utilización de la Dimensión de aprendizaje")
		vtMPA_Enunciado:=[MPA_DefinicionDimensiones:188]Dimensión:4
		
	: (Table:C252($y_IdObjeto)=Table:C252(->[MPA_DefinicionCompetencias:187]))
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5=$y_IdObjeto->)
		KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1;"")
		SELECTION TO ARRAY:C260([MPA_AsignaturasMatrices:189]Asignatura:3;at_MatrizAsignaturas;[MPA_AsignaturasMatrices:189]NumeroNivel:4;$al_Niveles)
		ARRAY TEXT:C222(at_NombreNiveles;Size of array:C274($al_Niveles))
		For ($i;1;Size of array:C274($al_Niveles))
			$l_elemento:=Find in array:C230(<>al_NumeroNivelesActivos;$al_Niveles{$i})
			If ($l_elemento>0)
				at_NombreNiveles{$i}:=<>at_NombreNivelesActivos{$l_elemento}
			Else 
				at_NombreNiveles{$i}:=""
			End if 
		End for 
		
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=$y_IdObjeto->;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
		KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;"")
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>;[Asignaturas:18]denominacion_interna:16;>)
		SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;at_Asignaturas;[Asignaturas:18]Curso:5;at_Cursos;[Asignaturas:18]Numero:1;$al_IdAsignaturas)
		ARRAY LONGINT:C221(al_Evaluados;Size of array:C274($al_IdAsignaturas))
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
		For ($i;1;Size of array:C274($al_IdAsignaturas))
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$al_IdAsignaturas{$i};*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=$y_IdObjeto->;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
			al_Evaluados{$i}:=$l_registros
		End for 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		$t_tituloVentana:=__ ("Utilización de la Competencia de aprendizaje")
		vtMPA_Enunciado:=[MPA_DefinicionCompetencias:187]Competencia:6
End case 

WDW_OpenFormWindow (->[MPA_DefinicionAreas:186];"InfoUsoObjeto";-1;8;$t_tituloVentana)
DIALOG:C40([MPA_DefinicionAreas:186];"InfoUsoObjeto")
CLOSE WINDOW:C154

HL_ClearList (hl_InfoObjetos)