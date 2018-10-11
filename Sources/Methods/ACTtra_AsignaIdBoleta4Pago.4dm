//%attributes = {}
  //ACTtra_AsignaIdBoleta4Pago

C_BOOLEAN:C305($ok;$0;$vb_cancelTransaction)
C_BLOB:C604($1;$xBlob)
C_LONGINT:C283($id_Transaccion;$i;id_boleta;$index)
ARRAY LONGINT:C221(al_idsTransacciones;0)

id_boleta:=0

$xBlob:=$1
BLOB_Blob2Vars (->$xBlob;0;->id_boleta;->al_idsTransacciones)
If ((id_boleta>0) & (Size of array:C274(al_idsTransacciones)>0))
	If (In transaction:C397)
		$vb_cancelTransaction:=False:C215
	Else 
		START TRANSACTION:C239
		$vb_cancelTransaction:=True:C214
	End if 
	
	  //20130513 RCH Primero proceso los descuentos para asignar correctamente los ids de boletas... Ticket 121172.
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_Transacciones:178])
	QUERY WITH ARRAY:C644([ACT_Transacciones:178]ID_Transaccion:1;al_idsTransacciones)
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5<0)
	If (Records in selection:C76([ACT_Cargos:173])>0)
		ARRAY LONGINT:C221($al_idsTransacciones;0)
		ARRAY LONGINT:C221($al_idsTransacciones2;0)
		ARRAY LONGINT:C221($al_idsTransacciones3;0)
		KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
		SELECTION TO ARRAY:C260([ACT_Transacciones:178]ID_Transaccion:1;$al_idsTransacciones)
		  //para primero procesar las asociadas a descuentos
		AT_intersect (->al_idsTransacciones;->$al_idsTransacciones;->$al_idsTransacciones2)
		  //para procesar las demás
		AT_Difference (->al_idsTransacciones;->$al_idsTransacciones2;->$al_idsTransacciones3)
		COPY ARRAY:C226($al_idsTransacciones3;al_idsTransacciones)
		For ($j;1;Size of array:C274($al_idsTransacciones2))
			$ok:=ACTpgs_AsignaIdTransaccion ($al_idsTransacciones2{$j})
			If (Not:C34($ok))
				BM_CreateRequest ("ACT_AsignaIDTransaccion";String:C10([ACT_Transacciones:178]ID_Transaccion:1);String:C10([ACT_Transacciones:178]ID_Transaccion:1))
			End if 
		End for 
	End if 
	
	For ($j;1;Size of array:C274(al_idsTransacciones))
		$ok:=ACTpgs_AsignaIdTransaccion (al_idsTransacciones{$j})
		If (Not:C34($ok))
			BM_CreateRequest ("ACT_AsignaIDTransaccion";String:C10([ACT_Transacciones:178]ID_Transaccion:1);String:C10([ACT_Transacciones:178]ID_Transaccion:1))
		End if 
	End for 
	  // Modificado por: Saul Ponce (02-05-2018) Ticket 204259, una vez que se hayan procesado todas las transacciones de pago determinar el estado del documento.
	ACTbol_EstadoBoleta (id_boleta)
	$ok:=True:C214
Else 
	$ok:=True:C214
End if 
If ($vb_cancelTransaction)
	If ($ok)
		VALIDATE TRANSACTION:C240
		ACTbol_EstadoBoleta (id_boleta)
	Else 
		CANCEL TRANSACTION:C241
	End if 
End if 
REDUCE SELECTION:C351([ACT_Transacciones:178];0)
$0:=$ok
AT_Initialize (->al_idsTransacciones)

  //C_BOOLEAN($ok;$0;$vb_cancelTransaction)
  //C_BLOB($1;$xBlob)
  //C_LONGINT($id_Transaccion;$i;id_boleta;$index)
  //ARRAY LONGINT(al_idsTransacciones;0)
  //
  //id_boleta:=0
  //
  //$xBlob:=$1
  //BLOB_Blob2Vars (->$xBlob;0;->id_boleta;->al_idsTransacciones)
  //If ((id_boleta>0) & (Size of array(al_idsTransacciones)>0))
  //If (In transaction)
  //$vb_cancelTransaction:=False
  //Else 
  //START TRANSACTION
  //$vb_cancelTransaction:=True
  //End if 
  //
  //For ($j;1;Size of array(al_idsTransacciones))
  //$idTransaccion:=al_idsTransacciones{$j}
  //KRL_FindAndLoadRecordByIndex (->[ACT_Transacciones]ID_Transaccion;->$idTransaccion;True)
  //If (ok=1)
  //$ok:=True
  //[ACT_Transacciones]No_Boleta:=id_boleta
  //SAVE RECORD([ACT_Transacciones])
  //QUERY([ACT_Cargos];[ACT_Cargos]ID=[ACT_Transacciones]ID_Item)
  //If ([ACT_Cargos]Saldo=0)
  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Item=[ACT_Cargos]ID;*)
  //QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]ID_Pago=0;*)
  //QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]No_Boleta#0)
  //APPLY TO SELECTION([ACT_Transacciones];[ACT_Transacciones]No_Boleta:=0)
  //If (Records in set("LockedSet")>0)
  //$ok:=False
  //$i:=Size of array(al_idsTransacciones)
  //End if 
  //End if 
  //Else 
  //$ok:=False
  //$i:=Size of array(al_idsTransacciones)
  //End if 
  //End for 
  //KRL_UnloadReadOnly (->[ACT_Transacciones])
  //Else 
  //$ok:=True
  //End if 
  //If ($vb_cancelTransaction)
  //If ($ok)
  //VALIDATE TRANSACTION
  //ACTbol_EstadoBoleta (id_boleta)
  //Else 
  //CANCEL TRANSACTION
  //End if 
  //End if 
  //REDUCE SELECTION([ACT_Transacciones];0)
  //$0:=$ok
  //AT_Initialize (->al_idsTransacciones)