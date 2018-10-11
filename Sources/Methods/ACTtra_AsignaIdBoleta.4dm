//%attributes = {}
  //ACTtra_AsignaIdBoleta

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
	For ($i;1;Size of array:C274(al_idsTransacciones))
		$id_Transaccion:=al_idsTransacciones{$i}
		KRL_FindAndLoadRecordByIndex (->[ACT_Transacciones:178]ID_Transaccion:1;->$id_Transaccion;True:C214)
		If (ok=1)
			If ([ACT_Transacciones:178]No_Boleta:9<=0)  //20160819 RCH. En un caso se sobreescribio el numero, dejando nula la boleta anterior. Se agrega por precaución. Ticket 166316.
				$index:=Find in field:C653([ACT_Boletas:181]ID:1;id_boleta)
				If ($index#-1)
					[ACT_Transacciones:178]No_Boleta:9:=id_boleta
					SAVE RECORD:C53([ACT_Transacciones:178])
					$ok:=True:C214
				Else 
					$ok:=True:C214
				End if 
			Else 
				$ok:=False:C215
				$i:=Size of array:C274(al_idsTransacciones)
			End if 
		Else 
			$ok:=False:C215
			$i:=Size of array:C274(al_idsTransacciones)
		End if 
	End for 
	ACTbol_EstadoBoleta (id_boleta)
	KRL_UnloadReadOnly (->[ACT_Transacciones:178])
Else 
	$ok:=True:C214
End if 
If ($vb_cancelTransaction)
	If ($ok)
		VALIDATE TRANSACTION:C240
	Else 
		CANCEL TRANSACTION:C241
	End if 
End if 
REDUCE SELECTION:C351([ACT_Transacciones:178];0)
$0:=$ok