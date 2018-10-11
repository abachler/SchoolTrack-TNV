//%attributes = {}
  //20130701 RCH Metodo qu duplica transacciones cuando hay pagos parciales.

C_LONGINT:C283($vl_idTransaccion;$1;$l_idItem;$vl_idBoleta;$vl_idDctoASoc)
C_LONGINT:C283($index)
C_REAL:C285($vr_monto;$2)
C_REAL:C285($vr_credito;$vr_diferencia)
C_TEXT:C284($vt_glosa;$vt_monedaNacional)

$vl_idTransaccion:=$1
$vr_monto:=$2

KRL_FindAndLoadRecordByIndex (->[ACT_Transacciones:178]ID_Transaccion:1;->$vl_idTransaccion;True:C214)

$l_idItem:=[ACT_Transacciones:178]ID_Item:3
  //$vr_monto:=[ACT_Transacciones]Debito
$vl_idBoleta:=[ACT_Transacciones:178]No_Boleta:9
$vl_idDctoASoc:=[ACT_Transacciones:178]ID_DctoRelacionado:15
$vt_glosa:=[ACT_Transacciones:178]Glosa:8

READ WRITE:C146([ACT_Transacciones:178])
QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=$l_idItem;*)
QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
If (Records in selection:C76([ACT_Transacciones:178])>0)
	CREATE SET:C116([ACT_Transacciones:178];"TransaccionesTodas")
	If ($vt_glosa#"Balanceo Descuento")
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Credito:7=$vr_monto;*)
		QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_DctoRelacionado:15=0)
	Else 
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Debito:6=$vr_monto;*)
		QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_DctoRelacionado:15=0)
	End if 
	REDUCE SELECTION:C351([ACT_Transacciones:178];1)
	If (Records in selection:C76([ACT_Transacciones:178])=1)
		[ACT_Transacciones:178]No_Boleta:9:=$vl_idBoleta
		[ACT_Transacciones:178]ID_DctoRelacionado:15:=$vl_idDctoASoc
		SAVE RECORD:C53([ACT_Transacciones:178])
		$index:=Find in field:C653([ACT_Transacciones:178]ID_Transaccion:1;$vl_idTransaccion)
		GOTO RECORD:C242([ACT_Transacciones:178];$index)
		[ACT_Transacciones:178]No_Boleta:9:=0
		SAVE RECORD:C53([ACT_Transacciones:178])
	Else 
		USE SET:C118("TransaccionesTodas")
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Credito:7>$vr_monto;*)
		QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_DctoRelacionado:15=0)
		If (Records in selection:C76([ACT_Transacciones:178])>0)
			ORDER BY:C49([ACT_Transacciones:178];[ACT_Transacciones:178]Credito:7;<)
			[ACT_Transacciones:178]Credito:7:=[ACT_Transacciones:178]Credito:7-$vr_monto
			SAVE RECORD:C53([ACT_Transacciones:178])
			
			DUPLICATE RECORD:C225([ACT_Transacciones:178])
			[ACT_Transacciones:178]Credito:7:=$vr_monto
			[ACT_Transacciones:178]No_Boleta:9:=$vl_idBoleta
			[ACT_Transacciones:178]ID_DctoRelacionado:15:=$vl_idDctoASoc
			[ACT_Transacciones:178]ID_Transaccion:1:=SQ_SeqNumber (->[ACT_Transacciones:178]ID_Transaccion:1)
			[ACT_Transacciones:178]Auto_UUID:17:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
			SAVE RECORD:C53([ACT_Transacciones:178])
			
			$index:=Find in field:C653([ACT_Transacciones:178]ID_Transaccion:1;$vl_idTransaccion)
			GOTO RECORD:C242([ACT_Transacciones:178];$index)
			[ACT_Transacciones:178]No_Boleta:9:=0
			SAVE RECORD:C53([ACT_Transacciones:178])
		Else 
			USE SET:C118("TransaccionesTodas")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Credito:7<$vr_monto;*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_DctoRelacionado:15=0)
			If (Records in selection:C76([ACT_Transacciones:178])>0)
				ORDER BY:C49([ACT_Transacciones:178];[ACT_Transacciones:178]Credito:7;<)
				$vr_credito:=[ACT_Transacciones:178]Credito:7
				$vr_diferencia:=$vr_monto-$vr_credito
				[ACT_Transacciones:178]No_Boleta:9:=$vl_idBoleta
				[ACT_Transacciones:178]ID_DctoRelacionado:15:=$vl_idDctoASoc
				SAVE RECORD:C53([ACT_Transacciones:178])
				
				$index:=Find in field:C653([ACT_Transacciones:178]ID_Transaccion:1;$vl_idTransaccion)
				GOTO RECORD:C242([ACT_Transacciones:178];$index)
				[ACT_Transacciones:178]Debito:6:=$vr_diferencia
				[ACT_Transacciones:178]MontoMonedaPago:14:=[ACT_Transacciones:178]Debito:6
				
				  //20120829 RCH...
				[ACT_Transacciones:178]MontoMonedaPago:14:=Round:C94([ACT_Transacciones:178]ValorMoneda:13*[ACT_Transacciones:178]Debito:6;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaNacional)))
				
				SAVE RECORD:C53([ACT_Transacciones:178])
				
			End if 
		End if 
	End if 
	CLEAR SET:C117("TransaccionesTodas")
End if 

KRL_UnloadReadOnly (->[ACT_Transacciones:178])

ACTbol_EstadoBoleta ($vl_idBoleta)


  //READ WRITE([ACT_Transacciones])
  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Item=[ACT_Transacciones]ID_Item;*)
  //QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]No_Boleta=0)
  //If (Records in selection([ACT_Transacciones])>0)
  //CREATE SET([ACT_Transacciones];"TransaccionesTodas")
  //If ($vt_glosa#"Balanceo Descuento")
  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]Credito=$vr_monto;*)
  //QUERY SELECTION([ACT_Transacciones]; & ;[ACT_Transacciones]ID_DctoRelacionado=0)
  //Else 
  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]Debito=$vr_monto;*)
  //QUERY SELECTION([ACT_Transacciones]; & ;[ACT_Transacciones]ID_DctoRelacionado=0)
  //End if 
  //REDUCE SELECTION([ACT_Transacciones];1)
  //If (Records in selection([ACT_Transacciones])=1)
  //[ACT_Transacciones]No_Boleta:=$vl_idBoleta
  //[ACT_Transacciones]ID_DctoRelacionado:=$vl_idDctoASoc
  //SAVE RECORD([ACT_Transacciones])
  //$index:=Find in field([ACT_Transacciones]ID_Transaccion;$vl_idTransaccion)
  //GOTO RECORD([ACT_Transacciones];$index)
  //[ACT_Transacciones]No_Boleta:=0
  //SAVE RECORD([ACT_Transacciones])
  //Else 
  //USE SET("TransaccionesTodas")
  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]Credito>$vr_monto;*)
  //QUERY SELECTION([ACT_Transacciones]; & ;[ACT_Transacciones]ID_DctoRelacionado=0)
  //If (Records in selection([ACT_Transacciones])>0)
  //ORDER BY([ACT_Transacciones];[ACT_Transacciones]Credito;<)
  //[ACT_Transacciones]Credito:=[ACT_Transacciones]Credito-$vr_monto
  //SAVE RECORD([ACT_Transacciones])
  //
  //DUPLICATE RECORD([ACT_Transacciones])
  //[ACT_Transacciones]Credito:=$vr_monto
  //[ACT_Transacciones]No_Boleta:=$vl_idBoleta
  //[ACT_Transacciones]ID_DctoRelacionado:=$vl_idDctoASoc
  //[ACT_Transacciones]ID_Transaccion:=SQ_SeqNumber (->[ACT_Transacciones]ID_Transaccion)
  //SAVE RECORD([ACT_Transacciones])
  //
  //$index:=Find in field([ACT_Transacciones]ID_Transaccion;$vl_idTransaccion)
  //GOTO RECORD([ACT_Transacciones];$index)
  //[ACT_Transacciones]No_Boleta:=0
  //SAVE RECORD([ACT_Transacciones])
  //Else 
  //USE SET("TransaccionesTodas")
  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]Credito<$vr_monto;*)
  //QUERY SELECTION([ACT_Transacciones]; & ;[ACT_Transacciones]ID_DctoRelacionado=0)
  //If (Records in selection([ACT_Transacciones])>0)
  //ORDER BY([ACT_Transacciones];[ACT_Transacciones]Credito;<)
  //$vr_credito:=[ACT_Transacciones]Credito
  //$vr_diferencia:=$vr_monto-$vr_credito
  //[ACT_Transacciones]No_Boleta:=$vl_idBoleta
  //[ACT_Transacciones]ID_DctoRelacionado:=$vl_idDctoASoc
  //SAVE RECORD([ACT_Transacciones])
  //
  //$index:=Find in field([ACT_Transacciones]ID_Transaccion;$vl_idTransaccion)
  //GOTO RECORD([ACT_Transacciones];$index)
  //[ACT_Transacciones]Debito:=$vr_diferencia
  //[ACT_Transacciones]MontoMonedaPago:=[ACT_Transacciones]Debito
  //
  //  //20120829 RCH...
  //[ACT_Transacciones]MontoMonedaPago:=Round([ACT_Transacciones]ValorMoneda*[ACT_Transacciones]Debito;Num(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaNacional)))
  //
  //SAVE RECORD([ACT_Transacciones])
  //
  //ACTpgs_IdsBoletas ("desasignaId";->$vl_idTransaccion)
  //End if 
  //End if 
  //End if 
  //CLEAR SET("TransaccionesTodas")
  //End if 
  //ACTbol_EstadoBoleta ($vl_idBoleta)