//%attributes = {}
  //dbuACT_ValidaDescuentoEnCaja

C_LONGINT:C283($1)

READ ONLY:C145([ACT_Cargos:173])

ARRAY LONGINT:C221($al_idsCargos;0)

If (Count parameters:C259=0)
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=!2008-01-01!)
	SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$al_idsCargos)
End if 
If (Count parameters:C259>=1)
	APPEND TO ARRAY:C911($al_idsCargos;$1)
End if 
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ (""))
For ($x;1;Size of array:C274($al_idsCargos))
	ARRAY LONGINT:C221($al_recNum;0)
	$montosPagadosT:=0
	$montosPagadosC:=0
	$montosPagadosMP:=0
	$vt_monedaCargo:=""
	$vl_decimalesCargo:=0
	$vr_montosPagadosCargoMP:=0
	$vr_valorMoneda:=0
	$montosPagadosMonedaCargo:=0
	
	$vl_idItem:=$al_idsCargos{$x}
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_Transacciones:178])
	KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->$vl_idItem;True:C214)
	If (ok=1)
		If ([ACT_Cargos:173]Monto_Neto:5>0)
			$vt_monedaCargo:=[ACT_Cargos:173]Moneda:28
			$vl_decimalesCargo:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo))
			$montosPagadosC:=[ACT_Cargos:173]MontosPagados:8
			$vr_montosPagadosCargoMP:=[ACT_Cargos:173]MontosPagadosMPago:52
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
			ARRAY LONGINT:C221($al_recNum;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum)
			If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
				QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8#"Pago con descuento";*)
				QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Balanceo descuento")
				CREATE SET:C116([ACT_Transacciones:178];"dbuACT_ValidaDctoCaja")
				For ($i;1;Size of array:C274($al_recNum))
					GOTO RECORD:C242([ACT_Transacciones:178];$al_recNum{$i})
					USE SET:C118("dbuACT_ValidaDctoCaja")
					QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0;*)
					QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5=[ACT_Transacciones:178]Fecha:5)
					$vr_valorMoneda:=[ACT_Transacciones:178]ValorMoneda:13
					GOTO RECORD:C242([ACT_Transacciones:178];$al_recNum{$i})
					If ([ACT_Transacciones:178]ValorMoneda:13#0)
						$montosPagadosT:=$montosPagadosT+Round:C94([ACT_Transacciones:178]MontoMonedaPago:14/$vr_valorMoneda;$vl_decimalesCargo)
						$montosPagadosMP:=$montosPagadosMP+[ACT_Transacciones:178]MontoMonedaPago:14
					Else 
						$montosPagadosT:=$montosPagadosT+[ACT_Transacciones:178]Debito:6
						$montosPagadosMP:=$montosPagadosMP+[ACT_Transacciones:178]Debito:6
					End if 
				End for 
				CLEAR SET:C117("dbuACT_ValidaDctoCaja")
				If ($vr_valorMoneda=0)
					$vr_valorMoneda:=ACTut_fValorDivisa ($vt_monedaCargo;Current date:C33(*))
				End if 
				$montosPagadosMonedaCargo:=$montosPagadosT
				$montosPagadosT:=Round:C94($montosPagadosT*$vr_valorMoneda;0)
				$montosPagadosC:=Round:C94($montosPagadosC*$vr_valorMoneda;0)
			Else 
				$montosPagadosT:=$montosPagadosT+Sum:C1([ACT_Transacciones:178]Debito:6)
				$montosPagadosMP:=$montosPagadosMP+Sum:C1([ACT_Transacciones:178]Debito:6)
			End if 
			If ($montosPagadosT#$montosPagadosC)
				If ($montosPagadosMP=$vr_montosPagadosCargoMP)
					[ACT_Cargos:173]MontosPagados:8:=$montosPagadosMonedaCargo
					[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]MontosPagados:8
					SAVE RECORD:C53([ACT_Cargos:173])
					ARRAY LONGINT:C221($al_idsAvisos;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum;"")
					AT_DistinctsFieldValues (->[ACT_Transacciones:178]No_Comprobante:10;->$al_idsAvisos)
					For ($j;1;Size of array:C274($al_idsAvisos))
						$vl_idAviso:=$al_idsAvisos{$j}
						READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
						KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$vl_idAviso)
						ACTac_Recalcular (Record number:C243([ACT_Avisos_de_Cobranza:124]))
					End for 
				End if 
			End if 
		End if 
	End if 
	KRL_UnloadReadOnly (->[ACT_Cargos:173])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$x/Size of array:C274($al_idsCargos);__ (""))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)