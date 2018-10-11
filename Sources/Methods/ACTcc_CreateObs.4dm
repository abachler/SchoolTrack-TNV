//%attributes = {}
  //ACTcc_CreateObs

C_LONGINT:C283($0;$id;$vl_idApdo;$vl_numeroTabla)
C_DATE:C307($vd_fechaObs)
C_TEXT:C284($vt_observacion)

$vl_idApdo:=$1
$vt_observacion:=$2
$vd_fechaObs:=$3
$vl_numeroTabla:=$4

CREATE RECORD:C68([ACT_Cuentas_Observaciones:102])
[ACT_Cuentas_Observaciones:102]ID:1:=SQ_SeqNumber (->[ACT_Cuentas_Observaciones:102]ID:1)
$id:=[ACT_Cuentas_Observaciones:102]ID:1
[ACT_Cuentas_Observaciones:102]ID_Registro:2:=$vl_idApdo
[ACT_Cuentas_Observaciones:102]Observacion:4:=$vt_observacion
[ACT_Cuentas_Observaciones:102]Fecha:3:=$vd_fechaObs
[ACT_Cuentas_Observaciones:102]Numero_Tabla_Asoc:10:=$vl_numeroTabla
SAVE RECORD:C53([ACT_Cuentas_Observaciones:102])
KRL_UnloadReadOnly (->[ACT_Cuentas_Observaciones:102])
$0:=$id

