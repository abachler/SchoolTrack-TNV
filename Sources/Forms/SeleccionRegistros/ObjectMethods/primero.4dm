$y_tabla:=Table:C252(vl_tablaSubForm)
$t_subformularioActual:="subformulario"+String:C10(FORM Get current page:C276)
GOTO SELECTED RECORD:C245($y_tabla->;1)
OBJECT SET SCROLL POSITION:C906(*;$t_subformularioActual;1;1;*)
GOTO OBJECT:C206(*;$t_subformularioActual)