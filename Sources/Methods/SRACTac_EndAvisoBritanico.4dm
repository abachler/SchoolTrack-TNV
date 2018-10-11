//%attributes = {}
  //SRACTac_EndAvisoBritanico

$aviso:=$1

$ptr:=Get pointer:C304("vAlumno"+String:C10($aviso))
$ptr->:=""

$ptr:=Get pointer:C304("vCodigo"+String:C10($aviso))
$ptr->:=""

$ptr:=Get pointer:C304("vCurso"+String:C10($aviso))
$ptr->:=""

$ptr:=Get pointer:C304("vRuta"+String:C10($aviso))
$ptr->:=""

$ptr:=Get pointer:C304("vIDAviso"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vMesAviso"+String:C10($aviso))
$ptr->:=""

$ptr:=Get pointer:C304("vSaldo"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vFechaV"+String:C10($aviso)+"1")
$ptr->:=!00-00-00!

$ptr:=Get pointer:C304("vFechaV"+String:C10($aviso)+"2")
$ptr->:=!00-00-00!

$ptr:=Get pointer:C304("vFechaV"+String:C10($aviso)+"3")
$ptr->:=!00-00-00!

$ptr:=Get pointer:C304("vFechaV"+String:C10($aviso)+"4")
$ptr->:=!00-00-00!

$ptr:=Get pointer:C304("vPension"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vTransporte"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vAlimentacion"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vOtros"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vTotal"+String:C10($aviso)+"1")
$ptr->:=0

$ptr:=Get pointer:C304("vTotal"+String:C10($aviso)+"2")
$ptr->:=0

$ptr:=Get pointer:C304("vTotal"+String:C10($aviso)+"3")
$ptr->:=0

$ptr:=Get pointer:C304("vTotal"+String:C10($aviso)+"4")
$ptr->:=0