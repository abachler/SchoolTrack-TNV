  // [xxSTR_Materias].Input.listaCategorias()
  //
  //
  // creado por: Alberto Bachler Klein: 02-12-15, 10:21:56
  // -----------------------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($i)
C_POINTER:C301($y_categoria_actual;$y_listaCategorias;$y_objeto_categorias;$y_objeto_observaciones)
C_TEXT:C284($t_categoria;$t_categoriaActual)

$y_objeto_categorias:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Categorias")
$y_objeto_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Observaciones")
$y_categoria_actual:=OBJECT Get pointer:C1124(Object named:K67:5;"categoriaActual")
$y_listaCategorias:=OBJECT Get pointer:C1124(Object named:K67:5;"listaCategorias")

Case of 
	: (Form event:C388=On Clicked:K2:4)
		$y_categoria_actual->:=$y_listaCategorias->{$y_listaCategorias->}
	: (Form event:C388=On Before Data Entry:K2:39)
		$t_categoriaActual:=$y_listaCategorias->{$y_listaCategorias->}
		If ($t_categoriaActual=__ ("[sin categoría]"))
			$0:=-1
		End if 
		
	: (Form event:C388=On Data Change:K2:15)
		  //MONO 213584
		$y_arrayNiveles:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNumero")
		
		READ ONLY:C145([Asignaturas:18])
		READ ONLY:C145([Alumnos_ObservacionesEvaluacion:30])
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Materia_UUID:46=[xxSTR_Materias:20]Auto_UUID:21;*)
		QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6=$y_arrayNiveles->{$y_arrayNiveles->})
		KRL_RelateSelection (->[Alumnos_ObservacionesEvaluacion:30]ID_Asignatura:2;->[Asignaturas:18]Numero:1;"")
		QUERY SELECTION:C341([Alumnos_ObservacionesEvaluacion:30];[Alumnos_ObservacionesEvaluacion:30]Categoría:4=$y_categoria_actual->)
		$l_ris:=Records in selection:C76([Alumnos_ObservacionesEvaluacion:30])
		REDUCE SELECTION:C351([Asignaturas:18];0)
		REDUCE SELECTION:C351([Alumnos_ObservacionesEvaluacion:30];0)
		
		Case of 
			: ($l_ris>0)
				ModernUI_Notificacion (__ ("Edición de categoría de observación");__ ("La categoría ya tiene observaciones registradas (^0).";String:C10($l_ris));"OK")
				$y_listaCategorias->{$y_listaCategorias->}:=$y_categoria_actual->
			: (Find in array:C230($y_objeto_categorias->;$t_categoria)>0)
				$y_listaCategorias->{$y_listaCategorias->}:=$y_categoria_actual->
				ModernUI_Notificacion (__ ("Edición de categoría de observación");__ ("Ya existe una categoría con el mismo nombre");"OK")
			Else 
				If ($y_categoria_actual->#$y_listaCategorias->{$y_listaCategorias->})
					For ($i;1;Size of array:C274($y_objeto_categorias->))
						$y_objeto_categorias->{$i}:=Replace string:C233($y_objeto_categorias->{$i};$y_listaCategorias->{0};$y_listaCategorias->{$y_listaCategorias->})
					End for 
					$y_categoria_actual->:=$y_listaCategorias->{$y_listaCategorias->}
					AT_MultiLevelSort (">>";$y_objeto_categorias;$y_objeto_observaciones)
					CFGstr_GuardaObsSubsectores 
				End if 
		End case 
		
		  //If (Find in array($y_objeto_categorias->;$t_categoria)>0)
		  //$y_listaCategorias->{$y_listaCategorias->}:=$y_categoria_actual->
		  //ModernUI_Notificacion (__ ("Edición de categoría de observación");__ ("Ya existe una categoría con el mismo nombre");"OK")
		  //Else 
		  //If ($y_categoria_actual->#$y_listaCategorias->{$y_listaCategorias->})
		  //For ($i;1;Size of array($y_objeto_categorias->))
		  //$y_objeto_categorias->{$i}:=Replace string($y_objeto_categorias->{$i};$y_listaCategorias->{0};$y_listaCategorias->{$y_listaCategorias->})
		  //End for 
		  //$y_categoria_actual->:=$y_listaCategorias->{$y_listaCategorias->}
		  //AT_MultiLevelSort (">>";$y_objeto_categorias;$y_objeto_observaciones)
		  //CFGstr_GuardaObsSubsectores 
		  //End if 
		  //End if 
End case 


