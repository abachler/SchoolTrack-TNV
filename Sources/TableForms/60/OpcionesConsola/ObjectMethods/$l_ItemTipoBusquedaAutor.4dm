  // [BBL_Préstamos].OpcionesConsola.$l_ItemTipoBusquedaAutor()
  // Por: Alberto Bachler: 10/10/13, 19:41:02
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_valorPreferencia)
C_POINTER:C301($y_objeto)
C_TEXT:C284($t_nombreObjeto)

ARRAY LONGINT:C221($al_refModoComparacion;0)
ARRAY TEXT:C222($at_modoComparacion;0)

QRY_ModosBusquedaPalabrasClave (->$at_modoComparacion;->$al_refModoComparacion)
$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
$y_objeto:=OBJECT Get pointer:C1124(Object current:K67:2)
$l_valorPreferencia:=$al_refModoComparacion{$y_objeto->}
OT PutVariable (vl_refObjectoPreferencias_BBLci;$t_nombreObjeto;->$l_valorPreferencia)

