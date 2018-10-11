//%attributes = {}
  //ACTpgs_AsignaIdTransaccion

C_LONGINT:C283($1;$vl_idTransaccion)
C_BOOLEAN:C305($done;$0)

$vl_idTransaccion:=$1
$done:=True:C214
KRL_FindAndLoadRecordByIndex (->[ACT_Transacciones:178]ID_Transaccion:1;->$vl_idTransaccion;True:C214)
If (ok=1)
	$done:=ACTpgs_IdsBoletas ("asignaId";->[ACT_Transacciones:178]ID_Transaccion:1)
Else 
	$done:=False:C215
End if 
$0:=$done