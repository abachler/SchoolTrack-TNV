//%attributes = {}
  //dbuACT_VerificaCamposNuevosT

  //Método que verifica que las transacciones para los pagos asociados a cargos emitidos según moneda tengan los campos con los valores correctos

ARRAY LONGINT:C221($al_recNum;0)
C_LONGINT:C283($proc;$vl_long1)
C_REAL:C285($vr_valorMoneda)
C_BOOLEAN:C305($vb_continuar)

$proc:=IT_UThermometer (1;0;__ ("Verificando campo en transacciones."))
If (Not:C34(In transaction:C397))
	START TRANSACTION:C239
	READ ONLY:C145([ACT_Cargos:173])
	READ WRITE:C146([ACT_Transacciones:178])
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214)
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
	QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0;*)
	QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ValorMoneda:13=0)
	ARRAY LONGINT:C221(aQR_Longint1;0)
	SELECTION TO ARRAY:C260([ACT_Transacciones:178]ID_Pago:4;aQR_Longint1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
	LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNum)
	For ($i;1;Size of array:C274($al_recNum))
		$vb_continuar:=True:C214
		REDUCE SELECTION:C351([ACT_Cargos:173];0)
		KRL_GotoRecord (->[ACT_Cargos:173];$al_recNum{$i})
		READ WRITE:C146([ACT_Transacciones:178])
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Balanceo Descuento")
		$vl_long1:=0
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_long1)
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8="Pago con descuento")
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		Case of 
			: ([ACT_Cargos:173]Moneda:28=ST_GetWord (ACT_DivisaPais ;1;";"))
				$vr_valorMoneda:=1
				
			: ([ACT_Cargos:173]Moneda:28="UF")
				ARRAY LONGINT:C221($al_recNum2;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum2)
				For ($j;1;Size of array:C274($al_recNum2))
					REDUCE SELECTION:C351([ACT_Transacciones:178];0)
					KRL_GotoRecord (->[ACT_Transacciones:178];$al_recNum2{$j};True:C214)
					[ACT_Transacciones:178]ValorMoneda:13:=ACTut_fValorDivisa ([ACT_Cargos:173]Moneda:28;[ACT_Transacciones:178]Fecha:5)
					If ([ACT_Transacciones:178]Glosa:8="Pago con descuento")
						[ACT_Transacciones:178]MontoMonedaPago:14:=[ACT_Transacciones:178]Debito:6
					Else 
						[ACT_Transacciones:178]MontoMonedaPago:14:=Round:C94([ACT_Transacciones:178]ValorMoneda:13*[ACT_Transacciones:178]Debito:6;<>vlACT_Decimales)
					End if 
					SAVE RECORD:C53([ACT_Transacciones:178])
					KRL_UnloadReadOnly (->[ACT_Transacciones:178])
				End for 
				$vb_continuar:=False:C215
			Else 
				If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
					If ($vl_long1=0)
						$vr_valorMoneda:=Round:C94([ACT_Cargos:173]MontosPagadosMPago:52/Sum:C1([ACT_Transacciones:178]Debito:6);2)
					Else 
						ARRAY LONGINT:C221($al_recNum2;0)
						LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum2)
						For ($j;1;Size of array:C274($al_recNum2))
							REDUCE SELECTION:C351([ACT_Transacciones:178];0)
							KRL_GotoRecord (->[ACT_Transacciones:178];$al_recNum2{$j};True:C214)
							[ACT_Transacciones:178]ValorMoneda:13:=Round:C94([ACT_Cargos:173]MontosPagadosMPago:52/[ACT_Cargos:173]MontosPagados:8;2)
							If ([ACT_Transacciones:178]Glosa:8="Pago con descuento")
								[ACT_Transacciones:178]MontoMonedaPago:14:=[ACT_Transacciones:178]Debito:6
							Else 
								[ACT_Transacciones:178]MontoMonedaPago:14:=Round:C94([ACT_Transacciones:178]ValorMoneda:13*[ACT_Transacciones:178]Debito:6;<>vlACT_Decimales)
							End if 
							SAVE RECORD:C53([ACT_Transacciones:178])
							KRL_UnloadReadOnly (->[ACT_Transacciones:178])
						End for 
						$vb_continuar:=False:C215
					End if 
				Else 
					$vr_valorMoneda:=1
				End if 
		End case 
		If ($vb_continuar)
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ValorMoneda:13=0)
			APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]ValorMoneda:13:=$vr_valorMoneda)
			APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]MontoMonedaPago:14:=Round:C94([ACT_Transacciones:178]ValorMoneda:13*[ACT_Transacciones:178]Debito:6;<>vlACT_Decimales))
		End if 
		KRL_UnloadReadOnly (->[ACT_Transacciones:178])
	End for 
	
	C_LONGINT:C283($i)
	ARRAY LONGINT:C221(aQR_Longint3;0)
	AT_DistinctsArrayValues (->aQR_Longint1)
	For ($i;1;Size of array:C274(aQR_Longint1))
		READ ONLY:C145([ACT_Pagos:172])
		$vl_idPago:=aQR_Longint1{$i}
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$vl_idPago)
		ARRAY LONGINT:C221(aQR_Longint2;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];aQR_Longint2;"")
		$vr_monto:=ACTtra_CalculaMontos ("calculaFromRecNum";->aQR_Longint2;->[ACT_Transacciones:178]Debito:6)
		KRL_FindAndLoadRecordByIndex (->[ACT_Pagos:172]ID:1;->$vl_idPago)
		If ([ACT_Pagos:172]Monto_Pagado:5#([ACT_Pagos:172]Saldo:15+$vr_monto))
			APPEND TO ARRAY:C911(aQR_Longint3;0)
		End if 
	End for 
	If (Size of array:C274(aQR_Longint3)=0)
		VALIDATE TRANSACTION:C240
	Else 
		CANCEL TRANSACTION:C241
		CD_Dlog (0;__ ("Hay problemas de integridad en los datos de pagos. Por favor contactese con soporte."))
	End if 
	IT_UThermometer (-2;$proc)
Else 
	CD_Dlog (0;__ ("Por favor, ejecute el comando en otro momento."))
End if 