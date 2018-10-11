//%attributes = {}
  //ACTpgs_IdsBoletas

C_TEXT:C284($vt_accion;$1)
C_POINTER:C301($2;$ptr1)
C_LONGINT:C283($vl_idBoleta;$vl_idTransaccion;$index)
C_REAL:C285($vr_monto;$vr_credito;$vr_diferencia)
C_POINTER:C301($ptrField)
C_BOOLEAN:C305($0)
C_TEXT:C284($vt_monedaNacional)
C_LONGINT:C283($l_idItem)

$0:=True:C214

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

  //20120829 RCH
$vt_monedaNacional:=ST_GetWord (ACT_DivisaPais ;1;";")

Case of 
	: ($vt_accion="asignaId")
		$vl_idTransaccion:=$ptr1->
		KRL_FindAndLoadRecordByIndex (->[ACT_Transacciones:178]ID_Transaccion:1;->$vl_idTransaccion;True:C214)
		$vr_monto:=[ACT_Transacciones:178]Debito:6
		$vt_glosa:=[ACT_Transacciones:178]Glosa:8
		$vl_idPago:=[ACT_Transacciones:178]ID_Pago:4
		$vl_noComprobante:=[ACT_Transacciones:178]No_Comprobante:10
		  //20130513 RCH
		$l_idItem:=[ACT_Transacciones:178]ID_Item:3
		
		If ($vt_glosa="Balanceo descuento")
			$ptrField:=->[ACT_Transacciones:178]Debito:6
		Else 
			$ptrField:=->[ACT_Transacciones:178]Credito:7
		End if 
		READ WRITE:C146([ACT_Transacciones:178])
		
		If ($vt_glosa="Pago con Descuento")
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=$vl_noComprobante;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=$vl_idPago;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8="Balanceo descuento";*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Debito:6=$vr_monto)
			
			REDUCE SELECTION:C351([ACT_Transacciones:178];1)  //20140605 RCH Se deja 1 registro por si se encuentran 2 ya que no se asignaban correctamente cuando había más de uno…
			
			If (Records in selection:C76([ACT_Transacciones:178])=1)
				$vl_idBoleta:=[ACT_Transacciones:178]No_Boleta:9
				
				  //[ACT_Transacciones]No_Boleta:=0
				  //SAVE RECORD([ACT_Transacciones])
				
				$index:=Find in field:C653([ACT_Transacciones:178]ID_Transaccion:1;$vl_idTransaccion)
				GOTO RECORD:C242([ACT_Transacciones:178];$index)
				If (Not:C34(Locked:C147([ACT_Transacciones:178])))
					[ACT_Transacciones:178]No_Boleta:9:=$vl_idBoleta
					SAVE RECORD:C53([ACT_Transacciones:178])
					
					  // Modificado por: Saúl Ponce (20-07-2018) - Ticket Nº 211546, filtro para evitar asignar -1 a un registro incorrecto
					  // 20130513 RCH e quitara el id boleta de la transaccion de credito asociada
					  // QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Item=$l_idItem;*)
					  // QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]No_Boleta#0;*)  //20140605 RCH para quitar el id a una sola
					  // QUERY([ACT_Transacciones]; & ;$ptrField->#0)
					
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=$l_idItem;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9>0;*)
					QUERY:C277([ACT_Transacciones:178]; & ;$ptrField->#0)
					If (Records in selection:C76([ACT_Transacciones:178])>0)
						CREATE SET:C116([ACT_Transacciones:178];"TransaccionesTodas")
						
						SET QUERY LIMIT:C395(1)  //20140605 RCH para quitar el id a una sola
						QUERY SELECTION:C341([ACT_Transacciones:178];$ptrField->=$vr_monto)
						SET QUERY LIMIT:C395(0)
						If (Records in selection:C76([ACT_Transacciones:178])=1)
							[ACT_Transacciones:178]No_Boleta:9:=0
							SAVE RECORD:C53([ACT_Transacciones:178])
						Else 
							USE SET:C118("TransaccionesTodas")
							QUERY SELECTION:C341([ACT_Transacciones:178];$ptrField->>$vr_monto)
							If (Records in selection:C76([ACT_Transacciones:178])>0)
								ORDER BY:C49([ACT_Transacciones:178];$ptrField->;<)
								If (Not:C34(Locked:C147([ACT_Transacciones:178])))
									$vl_idBoleta:=[ACT_Transacciones:178]No_Boleta:9
									$ptrField->:=$ptrField->-$vr_monto
									SAVE RECORD:C53([ACT_Transacciones:178])
									
									DUPLICATE RECORD:C225([ACT_Transacciones:178])
									$ptrField->:=$vr_monto
									[ACT_Transacciones:178]No_Boleta:9:=0
									[ACT_Transacciones:178]ID_Transaccion:1:=SQ_SeqNumber (->[ACT_Transacciones:178]ID_Transaccion:1)
									[ACT_Transacciones:178]Auto_UUID:17:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
									SAVE RECORD:C53([ACT_Transacciones:178])
								Else 
									$0:=False:C215
								End if 
							Else 
								QUERY SELECTION:C341([ACT_Transacciones:178];$ptrField-><$vr_monto)
								If (Records in selection:C76([ACT_Transacciones:178])>0)
									ORDER BY:C49([ACT_Transacciones:178];$ptrField->;<)
									If (Not:C34(Locked:C147([ACT_Transacciones:178])))
										
									Else 
										$0:=False:C215
									End if 
								End if 
								
							End if 
						End if 
						SET_ClearSets ("TransaccionesTodas")
					End if 
					
				Else 
					$0:=False:C215
				End if 
			End if 
		Else 
			
			  // Modificado por: Saúl Ponce (20-07-2018) - Ticket Nº 211546, filtro para evitar asignar -1 a un registro incorrecto
			  // QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Item=[ACT_Transacciones]ID_Item;*)
			  // QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]ID_Pago=0;*)
			  // QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]No_Boleta#0)
			
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Transacciones:178]ID_Item:3;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9>0)
			
			If (Records in selection:C76([ACT_Transacciones:178])>0)
				CREATE SET:C116([ACT_Transacciones:178];"TransaccionesTodas")
				QUERY SELECTION:C341([ACT_Transacciones:178];$ptrField->=$vr_monto)
				REDUCE SELECTION:C351([ACT_Transacciones:178];1)
				If (Records in selection:C76([ACT_Transacciones:178])=1)
					If (Not:C34(Locked:C147([ACT_Transacciones:178])))
						$vl_idBoleta:=[ACT_Transacciones:178]No_Boleta:9
						[ACT_Transacciones:178]No_Boleta:9:=0
						SAVE RECORD:C53([ACT_Transacciones:178])
						$index:=Find in field:C653([ACT_Transacciones:178]ID_Transaccion:1;$vl_idTransaccion)
						GOTO RECORD:C242([ACT_Transacciones:178];$index)
						[ACT_Transacciones:178]No_Boleta:9:=$vl_idBoleta
						SAVE RECORD:C53([ACT_Transacciones:178])
						
					Else 
						$0:=False:C215
					End if 
				Else 
					USE SET:C118("TransaccionesTodas")
					  //20130403 RCH Cuando era descuento por item no se actualizaba correctamente el monto de la transaccion
					  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]Credito>$vr_monto)
					QUERY SELECTION:C341([ACT_Transacciones:178];$ptrField->>$vr_monto)
					If (Records in selection:C76([ACT_Transacciones:178])>0)
						  //20130403 RCH Cuando era descuento por item no se actualizaba correctamente el monto de la transaccion
						  //ORDER BY([ACT_Transacciones];[ACT_Transacciones]Credito;<)
						ORDER BY:C49([ACT_Transacciones:178];$ptrField->;<)
						If (Not:C34(Locked:C147([ACT_Transacciones:178])))
							$vl_idBoleta:=[ACT_Transacciones:178]No_Boleta:9
							  //20130403 RCH Cuando era descuento por item no se actualizaba correctamente el monto de la transaccion
							  //[ACT_Transacciones]Credito:=[ACT_Transacciones]Credito-$vr_monto
							$ptrField->:=$ptrField->-$vr_monto
							SAVE RECORD:C53([ACT_Transacciones:178])
							
							DUPLICATE RECORD:C225([ACT_Transacciones:178])
							  //20130403 RCH Cuando era descuento por item no se actualizaba correctamente el monto de la transaccion
							  //[ACT_Transacciones]Credito:=$vr_monto
							$ptrField->:=$vr_monto
							[ACT_Transacciones:178]No_Boleta:9:=0
							[ACT_Transacciones:178]ID_Transaccion:1:=SQ_SeqNumber (->[ACT_Transacciones:178]ID_Transaccion:1)
							[ACT_Transacciones:178]Auto_UUID:17:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
							SAVE RECORD:C53([ACT_Transacciones:178])
							
							$index:=Find in field:C653([ACT_Transacciones:178]ID_Transaccion:1;$vl_idTransaccion)
							GOTO RECORD:C242([ACT_Transacciones:178];$index)
							[ACT_Transacciones:178]No_Boleta:9:=$vl_idBoleta
							SAVE RECORD:C53([ACT_Transacciones:178])
						Else 
							$0:=False:C215
						End if 
					Else 
						USE SET:C118("TransaccionesTodas")
						  //20130403 RCH Cuando era descuento por item no se actualizaba correctamente el monto de la transaccion
						  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]Credito<$vr_monto)
						QUERY SELECTION:C341([ACT_Transacciones:178];$ptrField-><$vr_monto)
						If (Records in selection:C76([ACT_Transacciones:178])>0)
							  //20130403 RCH Cuando era descuento por item no se actualizaba correctamente el monto de la transaccion
							  //ORDER BY([ACT_Transacciones];[ACT_Transacciones]Credito;<)
							ORDER BY:C49([ACT_Transacciones:178];$ptrField->;<)
							If (Not:C34(Locked:C147([ACT_Transacciones:178])))
								  //20130403 RCH Cuando era descuento por item no se actualizaba correctamente el monto de la transaccion
								  //$vr_credito:=[ACT_Transacciones]Credito
								$vr_credito:=$ptrField->
								$vl_idBoleta:=[ACT_Transacciones:178]No_Boleta:9
								$vr_diferencia:=$vr_monto-$vr_credito
								
								[ACT_Transacciones:178]No_Boleta:9:=0
								SAVE RECORD:C53([ACT_Transacciones:178])
								
								$index:=Find in field:C653([ACT_Transacciones:178]ID_Transaccion:1;$vl_idTransaccion)
								GOTO RECORD:C242([ACT_Transacciones:178];$index)
								[ACT_Transacciones:178]Debito:6:=$vr_diferencia
								
								  //20120829 RCH...
								$vr_montoMonedaPago:=[ACT_Transacciones:178]MontoMonedaPago:14
								[ACT_Transacciones:178]MontoMonedaPago:14:=[ACT_Transacciones:178]Debito:6
								[ACT_Transacciones:178]MontoMonedaPago:14:=Round:C94([ACT_Transacciones:178]ValorMoneda:13*[ACT_Transacciones:178]Debito:6;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaNacional)))
								$vr_montoMonedaPago2:=[ACT_Transacciones:178]MontoMonedaPago:14
								
								SAVE RECORD:C53([ACT_Transacciones:178])
								
								DUPLICATE RECORD:C225([ACT_Transacciones:178])
								[ACT_Transacciones:178]Debito:6:=$vr_credito
								  //[ACT_Transacciones]MontoMonedaPago:=[ACT_Transacciones]Debito
								  //20120829 RCH...
								[ACT_Transacciones:178]MontoMonedaPago:14:=Round:C94($vr_montoMonedaPago-$vr_montoMonedaPago2;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaNacional)))
								[ACT_Transacciones:178]Auto_UUID:17:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
								[ACT_Transacciones:178]No_Boleta:9:=$vl_idBoleta
								[ACT_Transacciones:178]ID_Transaccion:1:=SQ_SeqNumber (->[ACT_Transacciones:178]ID_Transaccion:1)
								SAVE RECORD:C53([ACT_Transacciones:178])
								$0:=ACTpgs_IdsBoletas ("asignaId";->$vl_idTransaccion)
							Else 
								$0:=False:C215
							End if 
						End if 
					End if 
				End if 
				
				ACTbol_EstadoBoleta ($vl_idBoleta)
				CLEAR SET:C117("TransaccionesTodas")
			End if 
			
		End if 
		KRL_UnloadReadOnly (->[ACT_Transacciones:178])
		
	: ($vt_accion="desasignaId")
		$vl_idTransaccion:=$ptr1->
		KRL_FindAndLoadRecordByIndex (->[ACT_Transacciones:178]ID_Transaccion:1;->$vl_idTransaccion;True:C214)
		
		If (([ACT_Transacciones:178]No_Boleta:9#0) & ([ACT_Transacciones:178]Glosa:8#"Pago con Descuento"))
			ACTtra_DuplicaT ($vl_idTransaccion;[ACT_Transacciones:178]Debito:6)
		End if 
		KRL_UnloadReadOnly (->[ACT_Transacciones:178])
End case 