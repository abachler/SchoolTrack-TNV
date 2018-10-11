//%attributes = {}
  // EVS_MenuContextualEsfuerzo()
  //
  //
  // creado por: Alberto Bachler Klein: 16-07-16, 16:19:45
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_editable)
C_LONGINT:C283($l_columna;$l_fila;$l_indice;$l_opcion;$l_posicion;$l_registros)
C_POINTER:C301($y_descripciones;$y_factores;$y_indicadores;$y_variable)
C_TEXT:C284($t_indice)

$y_indicadores:=OBJECT Get pointer:C1124(Object named:K67:5;"esfuerzo_indicador")
$y_descripciones:=OBJECT Get pointer:C1124(Object named:K67:5;"esfuerzo_descripcion")
$y_factores:=OBJECT Get pointer:C1124(Object named:K67:5;"esfuerzo_factor")

LISTBOX GET CELL POSITION:C971(*;"lbEsfuerzo";$l_columna;$l_fila;$y_variable)

$b_editable:=OBJECT Get enterable:C1067(*;"esfuerzo_factor")
Case of 
	: (Not:C34($b_editable))
		$l_opcion:=Pop up menu:C542("("+__ ("Agregar indicador")+";("+__ ("Eliminar indicador"))  //MONO Ticket 172479
	: ($l_fila=0)
		$l_opcion:=Pop up menu:C542(__ ("Agregar indicador")+";("+__ ("Eliminar indicador"))
	Else 
		$l_opcion:=Pop up menu:C542(__ ("Agregar indicador")+";"+__ ("Eliminar indicador"))
End case 

Case of 
	: ($l_opcion=1)
		$l_indice:=Size of array:C274($y_indicadores->)+1
		$t_indice:="I #"+String:C10($l_indice)
		$l_posicion:=Find in array:C230($y_indicadores->;$t_indice)
		While ($l_posicion>0)
			$l_indice:=$l_indice+1
			$t_indice:="I #"+String:C10($l_indice)
			$l_posicion:=Find in array:C230($y_indicadores->;$t_indice)
		End while 
		
		LISTBOX GET CELL POSITION:C971(*;"lbEsfuerzo";$l_columna;$l_fila;$y_variable)
		APPEND TO ARRAY:C911($y_indicadores->;$t_indice)
		APPEND TO ARRAY:C911($y_descripciones->;"")
		APPEND TO ARRAY:C911($y_factores->;0)
		$l_fila:=Size of array:C274($y_indicadores->)
		LISTBOX SELECT ROW:C912(*;"lbEsfuerzo";$l_fila)
		POST KEY:C465(Character code:C91("+");Command key mask:K16:1+Shift key mask:K16:3)
		
	: ($l_opcion=2)
		If ($l_fila>0)
			Case of 
				: ($y_indicadores->{$l_fila}="")
					LISTBOX DELETE ROWS:C914(*;"lbEsfuerzo";$l_fila)
					Case of 
						: (($l_fila-1)>0)
							LISTBOX SELECT ROW:C912(*;"lbEsfuerzo";$l_fila-1)
						: ($l_fila<=LISTBOX Get number of rows:C915(*;"lbEsfuerzo"))
							LISTBOX SELECT ROW:C912(*;"lbEsfuerzo";$l_fila)
					End case 
				Else 
					SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
					SET QUERY LIMIT:C395(1)
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=[xxSTR_EstilosEvaluacion:44]ID:1)
					KRL_RelateSelection (->[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5;->[Asignaturas:18]Numero:1)
					QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
					QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16=$y_indicadores->{$l_fila};*)
					QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21=$y_indicadores->{$l_fila};*)
					QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26=$y_indicadores->{$l_fila};*)
					QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31=$y_indicadores->{$l_fila};*)
					QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36=$y_indicadores->{$l_fila})
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					SET QUERY LIMIT:C395(0)
					If ($l_registros=0)
						LISTBOX DELETE ROWS:C914(*;"lbEsfuerzo";$l_fila)
						Case of 
							: (($l_fila-1)>0)
								LISTBOX SELECT ROW:C912(*;"lbEsfuerzo";$l_fila-1)
							: ($l_fila<=LISTBOX Get number of rows:C915(*;"lbEsfuerzo"))
								LISTBOX SELECT ROW:C912(*;"lbEsfuerzo";$l_fila)
						End case 
					End if 
			End case 
		End if 
End case 
EVS_FijaEstadoObjetosInterfaz 