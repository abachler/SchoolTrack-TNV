  // SeleccionRegistros.paginaArriba()
  // Por: Alberto Bachler: 12/11/13, 16:59:32
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$y_tabla:=Table:C252(vl_tablaSubForm)
$t_subformularioActual:="subformulario"+String:C10(FORM Get current page:C276)
$l_altoSubformulario:=IT_Objeto_Alto ($t_subformularioActual)
$l_ObjetosPorPagina:=Round:C94($l_altoSubformulario/vl_altoSubForm;0)
$l_registroSeleccionado:=Selected record number:C246($y_tabla->)

If ($l_registroSeleccionado=0)
	$l_registroSeleccionado:=1
End if 
$l_registroSeleccionado:=$l_registroSeleccionado-($l_ObjetosPorPagina-1)
If ($l_registroSeleccionado<1)
	$l_registroSeleccionado:=1
End if 



GOTO SELECTED RECORD:C245($y_tabla->;$l_registroSeleccionado)
OBJECT SET SCROLL POSITION:C906(*;$t_subformularioActual;$l_registroSeleccionado;1;*)
$l_registro:=Selected record number:C246($y_tabla->)
GOTO OBJECT:C206(*;$t_subformularioActual)
