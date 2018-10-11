  // [xxSTR_Materias].Input()
  // Por: Alberto Bachler K.: 16-05-14, 09:59:56
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_numeroNivel;$l_recNumArea)
C_POINTER:C301($y_nivelNombre;$y_nivelNumero;$y_pestaña;$y_Observacion;$y_ListaCategorias)


C_LONGINT:C283(hl_Niveles;hl_observaciones;vlSTR_UltimaPaginaMaterias)


$y_nivelNumero:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNumero")
$y_nivelNombre:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNombre")
$y_Observacion:=OBJECT Get pointer:C1124(Object named:K67:5;"observacion")
$y_ListaCategorias:=OBJECT Get pointer:C1124(Object named:K67:5;"listaCategorias")

Spell_CheckSpelling 
Case of 
	: ((Form event:C388=On Load:K2:1) | (Form event:C388=On Load Record:K2:38))
		$y_pestaña:=OBJECT Get pointer:C1124(Object named:K67:5;"Pestaña")
		HL_ClearList ($y_pestaña->)
		$y_pestaña->:=New list:C375
		APPEND TO LIST:C376($y_pestaña->;__ ("Propiedades");1)
		APPEND TO LIST:C376($y_pestaña->;__ ("Observaciones");2)
		APPEND TO LIST:C376($y_pestaña->;__ ("Competencias");3)
		
		READ ONLY:C145([xxSTR_Niveles:6])
		READ ONLY:C145([Asignaturas:18])
		If ([xxSTR_Materias:20]ID_Materia:16=0)
			[xxSTR_Materias:20]ID_Materia:16:=SQ_SeqNumber (->[xxSTR_Materias:20]ID_Materia:16)
			REDUCE SELECTION:C351([Asignaturas:18];0)
			vlSTR_UltimaPaginaMaterias:=1
		End if 
		
		QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesActivos)
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=[xxSTR_Materias:20]Materia:2)
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>)
		
		AT_DistinctsFieldValues (->[Asignaturas:18]Numero_del_Nivel:6;$y_nivelNumero)
		AT_RedimArrays (Size of array:C274($y_nivelNumero->);$y_nivelNombre)
		If (Size of array:C274($y_nivelNumero->)>0)
			For ($i;1;Size of array:C274($y_nivelNumero->))
				$l_numeroNivel:=$y_nivelNumero->{$i}
				$y_nivelNombre->{$i}:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_numeroNivel;->[xxSTR_Niveles:6]Nivel:1)
			End for 
			vlSTR_NivelSeleccionado:=$y_nivelNumero->{1}
			LISTBOX SELECT ROW:C912(*;"listbox.niveles";1)
		Else 
			vlSTR_NivelSeleccionado:=0
			vlSTR_UltimaPaginaMaterias:=1
		End if 
		(OBJECT Get pointer:C1124(Object named:K67:5;"nivelActual"))->:=String:C10(vlSTR_NivelSeleccionado)
		
		
		If (vlSTR_UltimaPaginaMaterias=0)
			vlSTR_UltimaPaginaMaterias:=1
		End if 
		SELECT LIST ITEMS BY REFERENCE:C630($y_pestaña->;vlSTR_UltimaPaginaMaterias)
		FORM GOTO PAGE:C247(vlSTR_UltimaPaginaMaterias)
		
		
		Case of 
			: (vlSTR_UltimaPaginaMaterias=2)
				CFGstr_LeeObsSubsectores 
				
			: (vlSTR_UltimaPaginaMaterias=3)
				MPA_Matrices 
		End case 
		
		
		$l_recNumArea:=Find in field:C653([MPA_DefinicionAreas:186]AreaAsignatura:4;[xxSTR_Materias:20]AreaMPA:4)
		Case of 
			: (Size of array:C274($y_nivelNumero->)=0)
				SET LIST ITEM PROPERTIES:C386($y_pestaña->;2;False:C215;Plain:K14:1;0)
				SET LIST ITEM PROPERTIES:C386($y_pestaña->;3;False:C215;Plain:K14:1;0)
				vlSTR_UltimaPaginaMaterias:=1
				
			: ($l_recNumArea=No current record:K29:2)
				SET LIST ITEM PROPERTIES:C386($y_pestaña->;3;False:C215;Plain:K14:1;0)
				If (vlSTR_UltimaPaginaMaterias=3)
					vlSTR_UltimaPaginaMaterias:=1
				End if 
		End case 
		
		$b_visible:=(vlSTR_UltimaPaginaMaterias>1)
		OBJECT SET VISIBLE:C603(*;"listbox.niveles";$b_visible)
		$b_visible:=OBJECT Get visible:C1075(*;"listbox.niveles")
		SET WINDOW TITLE:C213(__ ("Subsectores de aprendizaje: ^0";[xxSTR_Materias:20]Materia:2))
		
		$l_posicion:=Find in array:C230(<>at_SubjectStatsGroups;[xxSTR_Materias:20]Grupo_estadístico:19)
		If ($l_posicion>0)  //ABC 20180320//201134 //al entrar a la materia se debe ver el grupo asignado.
			<>at_SubjectStatsGroups:=$l_posicion
			<>at_SubjectStatsGroups{0}:=<>at_SubjectStatsGroups{$l_posicion}
		Else 
			<>at_SubjectStatsGroups:=0
			<>at_SubjectStatsGroups{0}:=""
		End if 
		
		
	: (Form event:C388=On Clicked:K2:4)
		If (FORM Get current page:C276=2)
			
		End if 
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		HL_ClearList (hl_Niveles)
		UNLOAD RECORD:C212([MPA_AsignaturasMatrices:189])
		READ ONLY:C145([MPA_AsignaturasMatrices:189])
End case 

If (Form event:C388#On Activate:K2:9)
	$b_visible:=(vlSTR_UltimaPaginaMaterias>1)
	OBJECT SET VISIBLE:C603(*;"listbox.niveles";$b_visible)
	$b_visible:=OBJECT Get visible:C1075(*;"listbox.niveles")
	
	OBJECT SET VISIBLE:C603(lbNiveles;$b_visible)
	$b_visible:=OBJECT Get visible:C1075(lbNiveles)
End if 


OBJECT SET ENABLED:C1123(*;"eliminaCategoria";$y_ListaCategorias->>0)
OBJECT SET ENABLED:C1123(*;"eliminaObservacion";$y_Observacion->>0)