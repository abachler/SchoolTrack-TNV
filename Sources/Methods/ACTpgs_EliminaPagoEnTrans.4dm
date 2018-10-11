//%attributes = {}
  //ACTpgs_EliminaPagoEnTrans

C_BOOLEAN:C305($0;$locked)
ARRAY LONGINT:C221($al_posAEliminar;0)  //20130904 RCH Cuando hay anulacion de pago, se eliminan una transaccion...

$vp_transacciones:=$1
$ptr1:=$2

READ WRITE:C146([ACT_Cargos:173])
KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]ID:1:=[ACT_Cargos:173]ID:1)
If (Records in set:C195("LockedSet")=0)
	For ($i;1;Size of array:C274($vp_transacciones->))
		  //20130904 RCH
		  //GOTO RECORD([ACT_Transacciones];$vp_transacciones->{$i})
		REDUCE SELECTION:C351([ACT_Transacciones:178];0)
		KRL_GotoRecord (->[ACT_Transacciones:178];$vp_transacciones->{$i})
		If (Records in selection:C76([ACT_Transacciones:178])=1)
			REDUCE SELECTION:C351([ACT_Cargos:173];0)
			KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;True:C214)
			If (ok=1)
				$vl_idCargo:=[ACT_Cargos:173]ID:1
				ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";->[ACT_Cargos:173]ID_Apoderado:18)
				$locked:=False:C215
				If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214)
					$debitoEnMonedaPago:=[ACT_Transacciones:178]MontoMonedaPago:14
					$creditoEnMonedaPago:=0
					If ([ACT_Transacciones:178]Glosa:8="Pago con Descuento")
						$vt_monedaConv:=KRL_GetTextFieldData (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]Moneda:28)
						$vr_valorMonedaConv:=[ACT_Transacciones:178]ValorMoneda:13
					Else 
						$vt_monedaConv:=[ACT_Cargos:173]Moneda:28
						$vr_valorMonedaConv:=[ACT_Transacciones:178]ValorMoneda:13
					End if 
					$debitoMonedaEmision:=[ACT_Transacciones:178]MontoMonedaPago:14
					$creditoMonedaEmision:=0
					If ($vr_valorMonedaConv=0)
						$vr_montoMonedaPago:=[ACT_Transacciones:178]Debito:6
						$debitoEnMonedaCargo:=$vr_montoMonedaPago
					Else 
						$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaConv))
						$vr_montoMonedaPago:=[ACT_Transacciones:178]MontoMonedaPago:14
						$debitoEnMonedaCargo:=Round:C94([ACT_Transacciones:178]MontoMonedaPago:14/$vr_valorMonedaConv;$vl_decimales)
					End if 
					$creditoEnMonedaCargo:=0
				Else 
					$debitoEnMonedaPago:=[ACT_Transacciones:178]Debito:6
					$creditoEnMonedaPago:=[ACT_Transacciones:178]Credito:7
					$debitoMonedaEmision:=[ACT_Transacciones:178]Debito:6
					$creditoMonedaEmision:=[ACT_Transacciones:178]Credito:7
					$debitoEnMonedaCargo:=[ACT_Transacciones:178]Debito:6
					$creditoEnMonedaCargo:=[ACT_Transacciones:178]Credito:7
				End if 
				If ([ACT_Cargos:173]Monto_Neto:5<0)
					[ACT_Cargos:173]MontosPagadosMPago:52:=[ACT_Cargos:173]MontosPagadosMPago:52+($creditoEnMonedaPago+$debitoEnMonedaPago)
					[ACT_Cargos:173]MontosPagados:8:=Round:C94([ACT_Cargos:173]MontosPagados:8+$creditoEnMonedaCargo+$debitoEnMonedaCargo;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->[ACT_Cargos:173]Moneda:28)))
				Else 
					[ACT_Cargos:173]MontosPagadosMPago:52:=[ACT_Cargos:173]MontosPagadosMPago:52-($debitoEnMonedaPago-$creditoEnMonedaPago)
					[ACT_Cargos:173]MontosPagados:8:=Round:C94([ACT_Cargos:173]MontosPagados:8-$debitoEnMonedaCargo-$creditoEnMonedaCargo;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->[ACT_Cargos:173]Moneda:28)))
				End if 
				If ([ACT_Cargos:173]MontosPagadosMPago:52=0)
					[ACT_Cargos:173]MontosPagados:8:=0
				End if 
				[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
				SAVE RECORD:C53([ACT_Cargos:173])
				
				GOTO RECORD:C242([ACT_Transacciones:178];$vp_transacciones->{$i})
				KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;True:C214)
				If (ok=1)
					$locked:=False:C215
					If ([ACT_Cargos:173]Monto_Neto:5<0)
						[ACT_Documentos_de_Cargo:174]Pagos:9:=[ACT_Documentos_de_Cargo:174]Pagos:9+($creditoEnMonedaPago+$debitoEnMonedaPago)
					Else 
						[ACT_Documentos_de_Cargo:174]Pagos:9:=[ACT_Documentos_de_Cargo:174]Pagos:9-($debitoEnMonedaPago-$creditoEnMonedaPago)
					End if 
					[ACT_Documentos_de_Cargo:174]Saldo:10:=[ACT_Documentos_de_Cargo:174]Pagos:9-[ACT_Documentos_de_Cargo:174]Monto_Neto:4
					SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
					$Aviso:=Find in field:C653([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
					If ($Aviso#-1)
						If (Find in array:C230($ptr1->;$Aviso)=-1)
							APPEND TO ARRAY:C911($ptr1->;$Aviso)
						End if 
					End if 
				Else 
					$i:=Size of array:C274($vp_transacciones->)
					$locked:=True:C214
				End if 
				ok:=ACTpgs_CalculaDesctoRXA ("EliminaPago";->$vl_idCargo)
				If (ok=0)
					$i:=Size of array:C274($vp_transacciones->)
					$locked:=True:C214
				End if 
			Else 
				If (Records in selection:C76([ACT_Cargos:173])>0)
					$i:=Size of array:C274($vp_transacciones->)
					$locked:=True:C214
				End if 
			End if 
		Else 
			APPEND TO ARRAY:C911($al_posAEliminar;$i)
		End if 
	End for 
Else 
	$locked:=True:C214
End if 
KRL_UnloadReadOnly (->[ACT_Cargos:173])
KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])

For ($i;Size of array:C274($al_posAEliminar);1;-1)
	AT_Delete ($al_posAEliminar{$i};1;$vp_transacciones)
End for 

$0:=$locked