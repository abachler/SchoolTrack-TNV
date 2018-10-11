//%attributes = {}
  //ACTpgs_ValidaEliminacion

C_BOOLEAN:C305($0;$go;vbACT_SaltarValidacion)
C_LONGINT:C283($trans;$vl_idPago)

$vl_idPago:=[ACT_Pagos:172]ID:1
If (Not:C34(vbACT_SaltarValidacion))
	If (cb_EliminarPagosAsociados=0)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$trans)
		SET QUERY LIMIT:C395(1)
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$vl_idPago;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9#0)
		SET QUERY LIMIT:C395(0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		$go:=($trans=0)
	Else 
		$go:=ACTbol_ValidaDeleteDesdePagos ($vl_idPago)
	End if 
Else 
	$go:=True:C214
	vbACT_SaltarValidacion:=False:C215
End if 
If ($vl_idPago<=0)
	$go:=False:C215
End if 
$0:=$go