  // [BBL_Lectores].Selección.Botón1()
  // Por: Alberto Bachler: 12/11/13, 12:54:44
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_columna;$l_fila;$l_fila2;$l_registro)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_subformularioActual)


$y_tabla:=Table:C252(vl_tablaSubForm)
$t_subformularioActual:="subformulario"+String:C10(FORM Get current page:C276)
$l_fila:=Records in selection:C76($y_tabla->)
GOTO SELECTED RECORD:C245($y_tabla->;$l_fila)
OBJECT SET SCROLL POSITION:C906(*;$t_subformularioActual;$l_fila;1;*)
OBJECT GET SCROLL POSITION:C1114(*;$t_subformularioActual;$l_fila2;$l_columna)
$l_registro:=Selected record number:C246($y_tabla->)
GOTO OBJECT:C206(*;$t_subformularioActual)

