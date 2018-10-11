//%attributes = {}
  //ACTpp_CreateObs

C_LONGINT:C283($0;$id;$vl_idApdo)
C_DATE:C307($vd_fechaObs)
C_TEXT:C284($vt_observacion)

$vl_idApdo:=$1
$vt_observacion:=$2
$vd_fechaObs:=$3
$vl_numeroTabla:=Table:C252(->[Personas:7])

$id:=ACTcc_CreateObs ($vl_idApdo;$vt_observacion;$vd_fechaObs;$vl_numeroTabla)

$0:=$id