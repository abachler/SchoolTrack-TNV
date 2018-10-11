//%attributes = {}
  //ACTpgs_AsignaIDPagoEnTrans

C_TEXT:C284($vt_set;$1)
C_LONGINT:C283($vl_idPago;$2)
C_BOOLEAN:C305($ok)

$vt_set:=$1
$vl_idPago:=$2
USE SET:C118($vt_set)
ARRAY LONGINT:C221($al_recNumTransacciones;0)

  //20120831 RCH Se ordena para que siempre se asigne primero el num de bol a la trans del balanceo descuento... En la de pago con descuento se busca el balanceo.
ARRAY LONGINT:C221($DA_Return;0)
ARRAY TEXT:C222($atACT_glosa;0)
ARRAY LONGINT:C221($alACT_idsT;0)
ARRAY LONGINT:C221($alACT_idsT2;0)
  //ARRAY LONGINT($alACT_recNum;0)
SELECTION TO ARRAY:C260([ACT_Transacciones:178]Glosa:8;$atACT_glosa;[ACT_Transacciones:178]ID_Transaccion:1;$alACT_idsT;[ACT_Transacciones:178];$al_recNumTransacciones)
$atACT_glosa{0}:="Balanceo Descuento"
AT_SearchArray (->$atACT_glosa;"=";->$DA_Return)
For ($j;1;Size of array:C274($DA_Return))
	APPEND TO ARRAY:C911($alACT_idsT2;$alACT_idsT{$DA_Return{$j}})
End for 
$atACT_glosa{0}:="Pago con Descuento"
AT_SearchArray (->$atACT_glosa;"=";->$DA_Return)
For ($j;1;Size of array:C274($DA_Return))
	APPEND TO ARRAY:C911($alACT_idsT2;$alACT_idsT{$DA_Return{$j}})
End for 
AT_OrderArraysByArray (MAXLONG:K35:2;->$alACT_idsT2;->$alACT_idsT;->$al_recNumTransacciones)
  //LONGINT ARRAY FROM SELECTION([ACT_Transacciones];$al_recNumTransacciones;"")

For ($j;1;Size of array:C274($al_recNumTransacciones))
	READ WRITE:C146([ACT_Transacciones:178])
	GOTO RECORD:C242([ACT_Transacciones:178];$al_recNumTransacciones{$j})
	If ([ACT_Transacciones:178]ID_Pago:4=0)  //20180523 RCH Se estaban separando más de la cuenta las transacciones
		[ACT_Transacciones:178]ID_Pago:4:=$vl_idPago
		SAVE RECORD:C53([ACT_Transacciones:178])
		$ok:=ACTpgs_AsignaIdTransaccion ([ACT_Transacciones:178]ID_Transaccion:1)
		If (Not:C34($ok))
			BM_CreateRequest ("ACT_AsignaIDTransaccion";String:C10([ACT_Transacciones:178]ID_Transaccion:1);String:C10([ACT_Transacciones:178]ID_Transaccion:1))
		End if 
	End if 
	KRL_UnloadReadOnly (->[ACT_Transacciones:178])
End for 
SET_ClearSets ($vt_set)