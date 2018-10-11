//%attributes = {}
  //ACTcc_BorrarTransaccion

$idTransaccion:=Num:C11($1)
$0:=True:C214

READ WRITE:C146([ACT_Transacciones:178])
QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Transaccion:1=$idTransaccion)
If (Not:C34(Locked:C147([ACT_Transacciones:178])))
	DELETE RECORD:C58([ACT_Transacciones:178])
Else 
	$0:=False:C215
End if 
UNLOAD RECORD:C212([ACT_Transacciones:178])
READ ONLY:C145([ACT_Transacciones:178])