//%attributes = {}
  //ACTpgs_ReempCarteraAnulaDocPago

C_LONGINT:C283($vl_idDocPago;$vl_idDocCartera)

$vl_idDocPago:=$1->
$vl_idDocCartera:=$2->

$vl_recNumDP:=KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Pago:176]ID:1;->$vl_idDocPago;True:C214)
$vl_recNumDC:=KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_en_Cartera:182]ID:1;->$vl_idDocCartera;True:C214)
$IDDocPago:=$vl_idDocPago
[ACT_Documentos_de_Pago:176]Nulo:37:=True:C214
[ACT_Documentos_en_Cartera:182]Reemplazado:14:=True:C214
  //[ACT_Documentos_en_Cartera]ID_DocdePago:=[ACT_Documentos_de_Pago]ID*-1
vl_idDctoCargoOld:=ACTdp_OpcionesHistorialReemplaz ("AsignaID_DctoReemplazado")
[ACT_Documentos_en_Cartera:182]ID_DocdePago:3:=vl_idDctoCargoOld

  //en ACTdp_fSave se actualiza el documento en cartera...
[ACT_Documentos_de_Pago:176]id_estado:53:=alACT_estadosIDReemp{atACT_estadosReemp}
[ACT_Documentos_de_Pago:176]Estado:14:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Documentos_de_Pago:176]id_estado:53)

  //20130805 RCH REEMPLAZO POR OPCION 1
$vl_idReemp:=ACTreemp_CreaRegistro ([ACT_Documentos_de_Pago:176]ID_Apoderado:2;[ACT_Documentos_de_Pago:176]ID_Tercero:48;[ACT_Documentos_de_Pago:176]MontoPago:6;Current date:C33(*);vlACTreemp_Modo;[ACT_Documentos_en_Cartera:182]ID:1)
[ACT_Documentos_de_Pago:176]id_reemplazado:62:=$vl_idReemp

SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
  //SAVE RECORD([ACT_Documentos_de_Pago])
ACTdp_fSave 

  //KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera])
  //KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago])
KRL_GotoRecord (->[ACT_Documentos_de_Pago:176];$vl_recNumDP)
KRL_GotoRecord (->[ACT_Documentos_en_Cartera:182];$vl_recNumDC)

  //20130805 RCH REEMPLAZO POR OPCION 1
  //$0:=$vl_idDocPago
$0:=$vl_idReemp