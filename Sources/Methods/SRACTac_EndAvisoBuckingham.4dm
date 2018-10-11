//%attributes = {}
  //SRACTac_EndAvisoBuckingham

$aviso:=$1

$ptr:=Get pointer:C304("vAlumno"+String:C10($aviso))
$ptr->:=""

$ptr:=Get pointer:C304("vCodigo"+String:C10($aviso))
$ptr->:=""

$ptr:=Get pointer:C304("vCurso"+String:C10($aviso))
$ptr->:=""

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

$ptr:=Get pointer:C304("vMatricula"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vPapeleria"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vTextos"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vPension"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vTransporte"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vAlmuerzo"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vCafeteria"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vDeportes"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vEventos"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vSistematizacion"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vSistematIB"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vNotaC"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vNotaD"+String:C10($aviso))
$ptr->:=0

$ptr:=Get pointer:C304("vTotalMatricula"+String:C10($aviso)+"1")
$ptr->:=0
$ptr:=Get pointer:C304("vTotalPension"+String:C10($aviso)+"1")
$ptr->:=0
$ptr:=Get pointer:C304("vTotalBono"+String:C10($aviso)+"1")
$ptr->:=0
$ptr:=Get pointer:C304("vTotalIntereses"+String:C10($aviso)+"1")
$ptr->:=0

$ptr:=Get pointer:C304("vTotalMatricula"+String:C10($aviso)+"2")
$ptr->:=0
$ptr:=Get pointer:C304("vTotalPension"+String:C10($aviso)+"2")
$ptr->:=0
$ptr:=Get pointer:C304("vTotalBono"+String:C10($aviso)+"2")
$ptr->:=0
$ptr:=Get pointer:C304("vTotalIntereses"+String:C10($aviso)+"2")
$ptr->:=0

$ptr:=Get pointer:C304("vTotalMatricula"+String:C10($aviso)+"3")
$ptr->:=0
$ptr:=Get pointer:C304("vTotalPension"+String:C10($aviso)+"3")
$ptr->:=0
$ptr:=Get pointer:C304("vTotalBono"+String:C10($aviso)+"3")
$ptr->:=0
$ptr:=Get pointer:C304("vTotalIntereses"+String:C10($aviso)+"3")
$ptr->:=0

$ptr:=Get pointer:C304("vTotalMatricula"+String:C10($aviso)+"4")
$ptr->:=0
$ptr:=Get pointer:C304("vTotalPension"+String:C10($aviso)+"4")
$ptr->:=0
$ptr:=Get pointer:C304("vTotalBono"+String:C10($aviso)+"4")
$ptr->:=0
$ptr:=Get pointer:C304("vTotalIntereses"+String:C10($aviso)+"4")
$ptr->:=0