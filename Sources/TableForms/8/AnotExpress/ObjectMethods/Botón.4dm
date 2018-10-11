  // [Alumnos_Conducta].AnotExpress.Botón()
  // Por: Alberto Bachler K.: 08-05-14, 18:16:28
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$y_fechaAnotacion:=OBJECT Get pointer:C1124(Object named:K67:5;"fecha")
$y_curso:=OBJECT Get pointer:C1124(Object named:K67:5;"curso")


$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (-><>aCursos)
If ($l_itemSeleccionado>0)
	$y_curso->:=<>aCursos{$l_itemSeleccionado}
	$l_nivelCurso:=<>aCUNivNo{$l_itemSeleccionado}
	PERIODOS_LoadData ($l_nivelCurso)
	If (Not:C34(DateIsValid ($y_fechaAnotacion->;0)))
		$y_fechaAnotacion->:=!00-00-00!
	End if 
End if 

If ($y_fechaAnotacion->=!00-00-00!)
	OBJECT GET COORDINATES:C663(*;"calendario";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
	POST CLICK:C466($l_izquierda;$l_arriba)
End if 

If ($y_curso->#"")
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20;=;$y_curso->)
	CREATE SET:C116([Alumnos:2];"$alumnosDelCurso")
	If (FORM Get current page:C276=2)
		POST KEY:C465(Character code:C91("+"))
	End if 
End if 


