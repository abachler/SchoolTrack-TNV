//%attributes = {}
  //SRACTac_EndAvisoLFrances

$aviso:=$1

$ptr:=Get pointer:C304("vAlumno"+String:C10($aviso))
$ptr->:=""
$ptr:=Get pointer:C304("vCodigo"+String:C10($aviso))
$ptr->:=""
$ptr:=Get pointer:C304("vMesPension"+String:C10($aviso))
$ptr->:=""
$ptr:=Get pointer:C304("vMatricula"+String:C10($aviso))
$ptr->:=0
$ptr:=Get pointer:C304("vSeguro"+String:C10($aviso))
$ptr->:=0
$ptr:=Get pointer:C304("vSolidaridad"+String:C10($aviso))
$ptr->:=0
$ptr:=Get pointer:C304("vCoop"+String:C10($aviso))
$ptr->:=0
$ptr:=Get pointer:C304("vAPA"+String:C10($aviso))
$ptr->:=0
$ptr:=Get pointer:C304("vOtros"+String:C10($aviso))
$ptr->:=0
$ptr:=Get pointer:C304("vPension"+String:C10($aviso))
$ptr->:=0
$ptr:=Get pointer:C304("vCafeteria"+String:C10($aviso))
$ptr->:=0
$ptr:=Get pointer:C304("vRefri"+String:C10($aviso))
$ptr->:=0
$ptr:=Get pointer:C304("vTotal"+String:C10($aviso)+"1")
$ptr->:=0
$ptr:=Get pointer:C304("vTotal"+String:C10($aviso)+"2")
$ptr->:=0
$ptr:=Get pointer:C304("vTotal"+String:C10($aviso))
$ptr->:=0