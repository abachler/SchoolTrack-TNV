  // [BBL_Préstamos].OpcionesConsola.$l_LectorModoBusqueda()
  // Por: Alberto Bachler: 10/10/13, 18:38:17
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_indice;$l_ItemModoBusqueda;$l_valor;$l_valorPreferencia)
C_POINTER:C301($y_objeto)
C_TEXT:C284($t_nombreObjeto)


$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
$y_objeto:=OBJECT Get pointer:C1124(Object current:K67:2)
$l_valor:=$y_objeto->
BBLci_ModosBusquedaObjeto ("L")
$l_valorPreferencia:=al_refModoBusquedaObjeto{$l_valor}
OT PutVariable (vl_refObjectoPreferencias_BBLci;$t_nombreObjeto;->$l_valorPreferencia)
