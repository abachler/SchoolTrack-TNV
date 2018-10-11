  // [BBL_Préstamos].OpcionesConsola.$t_servidorCorreo()
  // Por: Alberto Bachler: 15/10/13, 10:15:41
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($y_objeto)
C_TEXT:C284($t_nombreObjeto;$t_valor)


$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
$y_objeto:=OBJECT Get pointer:C1124(Object current:K67:2)
$t_valor:=$y_objeto->
OT PutVariable (vl_refObjectoPreferencias_BBLci;$t_nombreObjeto;->$t_valor)

