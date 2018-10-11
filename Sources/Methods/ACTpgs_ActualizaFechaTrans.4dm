//%attributes = {}
  //ACTpgs_ActualizaFechaTrans

C_BOOLEAN:C305($0;$vb_retorno)
C_LONGINT:C283($vl_idPago;$1)

SET_ClearSets ("LockedSet")
$vl_idPago:=$1

READ ONLY:C145([ACT_Pagos:172])
REDUCE SELECTION:C351([ACT_Pagos:172];0)

KRL_FindAndLoadRecordByIndex (->[ACT_Pagos:172]ID:1;->$vl_idPago)
If (Records in selection:C76([ACT_Pagos:172])=1)
	READ WRITE:C146([ACT_Transacciones:178])
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1;*)
	QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Fecha:5#[ACT_Pagos:172]Fecha:2)
	APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5:=[ACT_Pagos:172]Fecha:2)
	KRL_UnloadReadOnly (->[ACT_Transacciones:178])
	If (Records in set:C195("LockedSet")>0)
		$vb_retorno:=False:C215
	Else 
		$vb_retorno:=True:C214
	End if 
Else 
	$vb_retorno:=True:C214
End if 
$0:=$vb_retorno