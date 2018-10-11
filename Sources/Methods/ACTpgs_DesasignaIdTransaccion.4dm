//%attributes = {}
  //ACTpgs_DesasignaIdTransaccion

C_POINTER:C301($ptr)
C_LONGINT:C283($idItem;$trans;$idBoleta;$vl_tomadosTransacciones;$0)
$ptr:=$1
For ($trans;1;Size of array:C274($ptr->))
	REDUCE SELECTION:C351([ACT_Transacciones:178];0)
	KRL_GotoRecord (->[ACT_Transacciones:178];$ptr->{$trans};True:C214)
	If (ok=1)
		ACTpgs_IdsBoletas ("desasignaId";->[ACT_Transacciones:178]ID_Transaccion:1)
	Else 
		$vl_tomadosTransacciones:=$vl_tomadosTransacciones+1
	End if 
End for 
If ($vl_tomadosTransacciones=0)
	ARRAY LONGINT:C221(aEnBoleta;0)
	READ WRITE:C146([ACT_Transacciones:178])
	CREATE SELECTION FROM ARRAY:C640([ACT_Transacciones:178];$ptr->;"")
	AT_DistinctsFieldValues (->[ACT_Transacciones:178]No_Boleta:9;->aEnBoleta)
	DELETE SELECTION:C66([ACT_Transacciones:178])
	$vl_tomadosTransacciones:=Records in set:C195("LockedSet")
	For ($boletas;1;Size of array:C274(aEnBoleta))
		ACTbol_EstadoBoleta (aEnBoleta{$boletas})
	End for 
End if 

$0:=$vl_tomadosTransacciones