//%attributes = {}
  //ACTit_CreaRegistro
C_LONGINT:C283($vl_idItem;$vl_desde;$vl_hasta)
C_BOOLEAN:C305($vb_esMontoFijo)
C_REAL:C285($vr_valor)

$vl_idItem:=$1
$vl_desde:=$2
$vl_hasta:=$3
$vb_esMontoFijo:=$4
$vr_valor:=$5

CREATE RECORD:C68([xxACT_ItemsTramos:291])
[xxACT_ItemsTramos:291]id:1:=SQ_SeqNumber (->[xxACT_ItemsTramos:291]id:1)
[xxACT_ItemsTramos:291]id_item_de_cargo:2:=$vl_idItem
[xxACT_ItemsTramos:291]dia_tramo_desde:3:=$vl_desde
[xxACT_ItemsTramos:291]dia_tramo_hasta:4:=$vl_hasta
[xxACT_ItemsTramos:291]es_monto_fijo:5:=$vb_esMontoFijo
[xxACT_ItemsTramos:291]valor:6:=$vr_valor

SAVE RECORD:C53([xxACT_ItemsTramos:291])

ACTcfgit_OpcionesGenerales ("ValidaTramos";->$vl_idItem)

KRL_UnloadReadOnly (->[xxACT_ItemsTramos:291])