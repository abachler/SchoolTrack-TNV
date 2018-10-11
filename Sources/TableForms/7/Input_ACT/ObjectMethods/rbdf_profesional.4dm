C_POINTER:C301($y_persona;$y_profesional;$y_otra;$y_ec)
$y_persona:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_personal")
$y_profesional:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_profesional")
$y_otra:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_otra")
$y_ec:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_ec")

$y_persona->:=0
$y_ec->:=0
$y_otra->:=0

ACTpp_DireccionDeFacturacion ("GuardaDesdeInput")  //20180310 RCH