//%attributes = {}
  //ACTac_EmiteTransaccion

C_LONGINT:C283($idTrans;$idAviso)

$idTrans:=Num:C11(ST_GetWord ($1;1;";"))
$idAviso:=Num:C11(ST_GetWord ($1;2;";"))
$0:=True:C214

READ WRITE:C146([ACT_Transacciones:178])
QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Transaccion:1=$idTrans)
If (Records in selection:C76([ACT_Transacciones:178])=1)
	If (Not:C34(Locked:C147([ACT_Transacciones:178])))
		[ACT_Transacciones:178]No_Comprobante:10:=$idAviso
		SAVE RECORD:C53([ACT_Transacciones:178])
	Else 
		$0:=False:C215
	End if 
End if 
UNLOAD RECORD:C212([ACT_Transacciones:178])
READ ONLY:C145([ACT_Transacciones:178])