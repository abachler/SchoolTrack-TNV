//%attributes = {}
  //ACTbol_AnulaDocumentos

$idBol:=Num:C11($1)
$0:=True:C214

READ WRITE:C146([ACT_Boletas:181])
QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=$idBol)
If (Not:C34(Locked:C147([ACT_Boletas:181])))
	READ WRITE:C146([ACT_Transacciones:178])
	  //20130628 RCH Podia producir problemas si la boleta habia sido eliminada.
	  //QUERY([ACT_Transacciones];[ACT_Transacciones]No_Boleta=[ACT_Boletas]ID)
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=$idBol)
	APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9:=0)
	If (Records in set:C195("LockedSet")>0)
		$0:=False:C215
	Else 
		LOG_RegisterEvt ("Anulación de Documento Tributario tipo "+[ACT_Boletas:181]TipoDocumento:7+" N° "+String:C10([ACT_Boletas:181]Numero:11))
	End if 
Else 
	$0:=False:C215
End if 
KRL_UnloadReadOnly (->[ACT_Boletas:181])
KRL_UnloadReadOnly (->[ACT_Transacciones:178])