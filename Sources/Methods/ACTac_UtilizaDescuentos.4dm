//%attributes = {}
  //ACTac_UtilizaDescuentos

C_POINTER:C301($alACT_RecNumsDsctos)
C_REAL:C285($pagadoDocumento)
C_LONGINT:C283($l_idResponsable)  //20170714 RCH

$recNumCargo:=$1
$set:=$2
$vl_idPago:=$3
$alACT_RecNumsDsctos:=$4

If (Size of array:C274($alACT_RecNumsDsctos->)>0)
	READ WRITE:C146([ACT_Cargos:173])
	READ WRITE:C146([ACT_Documentos_de_Cargo:174])
	READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
	
	GOTO RECORD:C242([ACT_Cargos:173];$recNumCargo)
	
	$l_idResponsable:=OB Get:C1224(ACTcc_DividirEmision ("ObtieneIdResponsableDesdeCargo";->[ACT_Cargos:173]ID:1);"id_responsable")
	
	QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
	QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
	If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214)
		$saldoCargo:=Abs:C99(ACTcar_CalculaSaldo ("retornaSaldoMonedaPago";vdACT_FechaUF;->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Moneda:28))
		$monedaCargo:=[ACT_Cargos:173]Moneda:28
	Else 
		$saldoCargo:=Abs:C99([ACT_Cargos:173]Saldo:23)
		$monedaCargo:=ST_GetWord (ACT_DivisaPais ;1;";")
	End if 
	
	$rnDC:=Record number:C243([ACT_Documentos_de_Cargo:174])
	$rnAC:=Record number:C243([ACT_Avisos_de_Cobranza:124])
	
	$iD_CtaCteCargo:=[ACT_Cargos:173]ID_CuentaCorriente:2
	$pagadoDocumento:=[ACT_Documentos_de_Cargo:174]Pagos:9
	$pagadoConDscto:=0
	$ID_CargoPagado:=[ACT_Cargos:173]ID:1
	$iD_ApdoCargo:=[ACT_Cargos:173]ID_Apoderado:18
	$refPeriodo:=String:C10([ACT_Cargos:173]Mes:13;"00")+String:C10([ACT_Cargos:173]Año:14;"0000")
	$iva:=[ACT_Cargos:173]TasaIVA:21
	
	CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$alACT_RecNumsDsctos->)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$iD_CtaCteCargo;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
	
	If (Records in selection:C76([ACT_Cargos:173])>0)
		CREATE SET:C116([ACT_Cargos:173];"a")
		KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
		QUERY SELECTION:C341([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
		KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
		CREATE SET:C116([ACT_Cargos:173];"b")
		INTERSECTION:C121("a";"b";"a")
		USE SET:C118("a")
		SET_ClearSets ("a";"b")
		If ($iva=0)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21=0;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
		Else 
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21#0;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
		End if 
		CREATE SET:C116([ACT_Cargos:173];"desctos")
		APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]Monto_Vencido:30:=0)
		READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
		READ WRITE:C146([ACT_Documentos_de_Cargo:174])
		READ WRITE:C146([ACT_Cargos:173])
		GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];$rnDC)
		GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$rnAC)
		USE SET:C118("desctos")
		If (Records in selection:C76([ACT_Cargos:173])>0)
			ARRAY LONGINT:C221($al_recNum;0)
			ARRAY LONGINT:C221($alACT_ArrayOrden;0)
			ARRAY LONGINT:C221($alACT_idCargoAsoc;0)
			APPEND TO ARRAY:C911($alACT_ArrayOrden;$ID_CargoPagado)
			SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_recNum;[ACT_Cargos:173]ID_CargoRelacionado:47;$alACT_idCargoAsoc)
			AT_OrderArraysByArray (MAXLONG:K35:2;->$alACT_ArrayOrden;->$alACT_idCargoAsoc;->$al_recNum)
			For ($x;1;Size of array:C274($al_recNum))
				GOTO RECORD:C242([ACT_Cargos:173];$al_recNum{$x})
				
				If (([ACT_Cargos:173]ID_CargoRelacionado:47=0) | ([ACT_Cargos:173]ID_CargoRelacionado:47=$ID_CargoPagado))
					
					$vr_montoDcto:=Abs:C99([ACT_Cargos:173]Saldo:23)
					If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214)
						$saldoDscto:=ACTcar_CalculaSaldo ("retornaSaldoMonedaPago";vdACT_FechaUF;->$vr_montoDcto;->[ACT_Cargos:173]Moneda:28)
					Else 
						$saldoDscto:=$vr_montoDcto
					End if 
					Case of 
						: ($saldoDscto>$saldoCargo)
							  //If ([ACT_Cargos]EmitidoSegúnMonedaCargo)
							If (([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11) & ([ACT_Cargos:173]Moneda:28#ST_GetWord (ACT_DivisaPais ;1;";")))
								$pago:=ACTcar_CalculaSaldo ("retornaPagoMonedaCargo";vdACT_FechaUF;->$saldoCargo;->$monedaCargo)  //el pago no puede ser superior al monto máximo de saldo del cargo.... (incidente 79160)
								  //$pago:=ACTcar_CalculaSaldo ("retornaPagoMonedaCargo";vdACT_FechaUF;->$saldoDscto;->$monedaCargo)
								$pagoEnMonedaPago:=ACTcar_CalculaSaldo ("retornaSaldoMonedaPago";vdACT_FechaUF;->$pago;->$monedaCargo)
								$pagoEnMonedaCargo:=ACTcar_CalculaSaldo ("retornaPagoMonedaCargo";vdACT_FechaUF;->$pagoEnMonedaPago;->[ACT_Cargos:173]Moneda:28)
							Else 
								$pago:=$saldoCargo
								$pagoEnMonedaPago:=$pago
								$pagoEnMonedaCargo:=$pago
							End if 
							$pagadoDocumento:=$pagadoDocumento+$pagoEnMonedaPago
							[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]Saldo:23-$pagoEnMonedaCargo
							[ACT_Cargos:173]MontosPagados:8:=[ACT_Cargos:173]MontosPagados:8+(Abs:C99($pagoEnMonedaCargo)*-1)
							[ACT_Cargos:173]MontosPagadosMPago:52:=[ACT_Cargos:173]MontosPagadosMPago:52+(Abs:C99($pagoEnMonedaPago)*-1)
							$saldoCargo:=0
							  //$pagadoConDscto:=$pagadoConDscto+$pago
							$pagadoConDscto:=$pagadoConDscto+$pagoEnMonedaPago
						: ($saldoDscto=$saldoCargo)
							  //If ([ACT_Cargos]EmitidoSegúnMonedaCargo)
							If (([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11) & ([ACT_Cargos:173]Moneda:28#ST_GetWord (ACT_DivisaPais ;1;";")))
								$pago:=ACTcar_CalculaSaldo ("retornaPagoMonedaCargo";vdACT_FechaUF;->$saldoDscto;->$monedaCargo)
								$pagoEnMonedaPago:=ACTcar_CalculaSaldo ("retornaSaldoMonedaPago";vdACT_FechaUF;->$pago;->$monedaCargo)
								$pagoEnMonedaCargo:=ACTcar_CalculaSaldo ("retornaPagoMonedaCargo";vdACT_FechaUF;->$pagoEnMonedaPago;->[ACT_Cargos:173]Moneda:28)
							Else 
								$pago:=$saldoDscto
								$pagoEnMonedaPago:=$pago
								$pagoEnMonedaCargo:=$pagoEnMonedaPago
							End if 
							$pagadoDocumento:=$pagadoDocumento+$saldoDscto
							$saldoCargo:=0
							[ACT_Cargos:173]Saldo:23:=0
							[ACT_Cargos:173]MontosPagados:8:=[ACT_Cargos:173]MontosPagados:8+(Abs:C99($vr_montoDcto)*-1)
							[ACT_Cargos:173]MontosPagadosMPago:52:=[ACT_Cargos:173]MontosPagadosMPago:52+(Abs:C99($pagoEnMonedaPago)*-1)
							$pagadoConDscto:=$pagadoConDscto+$pagoEnMonedaPago
							$recNum:=Record number:C243([ACT_Cargos:173])
							$index:=Find in array:C230($alACT_RecNumsDsctos->;$recNum)
							If ($index#-1)
								AT_Delete ($index;1;$alACT_RecNumsDsctos)
							End if 
						: ($saldoDscto<$saldoCargo)
							  //If ([ACT_Cargos]EmitidoSegúnMonedaCargo)
							If (([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11) & ([ACT_Cargos:173]Moneda:28#ST_GetWord (ACT_DivisaPais ;1;";")))
								$pago:=ACTcar_CalculaSaldo ("retornaPagoMonedaCargo";vdACT_FechaUF;->$saldoDscto;->$monedaCargo)
								$pagoEnMonedaPago:=ACTcar_CalculaSaldo ("retornaSaldoMonedaPago";vdACT_FechaUF;->$pago;->$monedaCargo)
								$pagoEnMonedaCargo:=ACTcar_CalculaSaldo ("retornaPagoMonedaCargo";vdACT_FechaUF;->$pagoEnMonedaPago;->[ACT_Cargos:173]Moneda:28)
							Else 
								$pago:=$saldoDscto
								$pagoEnMonedaPago:=$pago
								$pagoEnMonedaCargo:=$pagoEnMonedaPago
							End if 
							$pagadoDocumento:=$pagadoDocumento+$saldoDscto
							$saldoCargo:=$saldoCargo-$saldoDscto
							[ACT_Cargos:173]Saldo:23:=0
							$pagadoConDscto:=$pagadoConDscto+$pagoEnMonedaPago
							[ACT_Cargos:173]MontosPagados:8:=[ACT_Cargos:173]MontosPagados:8+(Abs:C99($vr_montoDcto)*-1)
							[ACT_Cargos:173]MontosPagadosMPago:52:=[ACT_Cargos:173]MontosPagadosMPago:52+(Abs:C99($pagoEnMonedaPago)*-1)
							$recNum:=Record number:C243([ACT_Cargos:173])
							$index:=Find in array:C230($alACT_RecNumsDsctos->;$recNum)
							If ($index#-1)
								AT_Delete ($index;1;$alACT_RecNumsDsctos)
							End if 
							
					End case 
					
					OB SET:C1220([ACT_Cargos:173]OB_Responsable:70;"id_responsable";$l_idResponsable)
					
					SAVE RECORD:C53([ACT_Cargos:173])
					  // Modificado por: Saúl Ponce (14-02-2017) - Ticket N° 175102
					  // Almaceno en el set las transacciones con glosa 'Pago con Descuento' y 'Balanceo Descuento'
					ACTpgs_CreateTransaction ($iD_CtaCteCargo;$ID_CargoPagado;vdACT_FechaUF;$pago;"Pago con Descuento";[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$iD_ApdoCargo;$refPeriodo;$set;$vl_idPago;0;[ACT_Cargos:173]ID:1)
					If (Current process name:C1392="Ingreso de Pagos") | (Current process name:C1392="Documentar Deudas")
						ADD TO SET:C119([ACT_Transacciones:178];"ACT_transDeUtilizacionDesctos")
					End if 
					ACTpgs_CreateTransaction ([ACT_Cargos:173]ID_CuentaCorriente:2;[ACT_Cargos:173]ID:1;vdACT_FechaUF;$pagoEnMonedaCargo;"Balanceo Descuento";[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;[ACT_Cargos:173]ID_Apoderado:18;String:C10([ACT_Cargos:173]Mes:13;"00")+String:C10([ACT_Cargos:173]Año:14;"0000");$set;$vl_idPago)
					If (Current process name:C1392="Ingreso de Pagos") | (Current process name:C1392="Documentar Deudas")
						ADD TO SET:C119([ACT_Transacciones:178];"ACT_transDeUtilizacionDesctos")
					End if 
					
					If ($saldoCargo<=0)
						$x:=Size of array:C274($al_recNum)
					End if 
				End if 
			End for 
			USE SET:C118("desctos")
			CLEAR SET:C117("desctos")
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
			SELECTION TO ARRAY:C260([ACT_Documentos_de_Cargo:174];$al_recNumDocCargo)
			For ($i;1;Size of array:C274($al_recNumDocCargo))
				ACTcc_CalculaDocumentoCargo ($al_recNumDocCargo{$i})
			End for 
			READ WRITE:C146([ACT_Cargos:173])
			GOTO RECORD:C242([ACT_Cargos:173];$recNumCargo)
			If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
				$pago2:=ACTut_retornaMontoEnMoneda ($pagadoConDscto;ST_GetWord (ACT_DivisaPais ;1;";");vdACT_FechaUF;[ACT_Cargos:173]Moneda:28)
			Else 
				$pago2:=$pagadoConDscto
			End if 
			$pago3:=ACTut_retornaMontoEnMoneda ($pagadoConDscto;ST_GetWord (ACT_DivisaPais ;1;";");vdACT_FechaUF)
			
			$vr_montoDcto:=Abs:C99([ACT_Cargos:173]Saldo:23)
			If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
				$saldoDscto:=ACTcar_CalculaSaldo ("retornaSaldoMonedaPago";vdACT_FechaUF;->$vr_montoDcto;->[ACT_Cargos:173]Moneda:28)
			Else 
				$saldoDscto:=$vr_montoDcto
			End if 
			If ($saldoDscto=$pagadoConDscto)
				[ACT_Cargos:173]Saldo:23:=0
				[ACT_Cargos:173]MontosPagados:8:=[ACT_Cargos:173]MontosPagados:8+$pago2
				[ACT_Cargos:173]MontosPagadosMPago:52:=[ACT_Cargos:173]MontosPagadosMPago:52+$pagadoConDscto
			Else 
				[ACT_Cargos:173]Saldo:23:=(Abs:C99([ACT_Cargos:173]Saldo:23)-$pago2)*-1
				[ACT_Cargos:173]MontosPagados:8:=[ACT_Cargos:173]MontosPagados:8+$pago2
				[ACT_Cargos:173]MontosPagadosMPago:52:=[ACT_Cargos:173]MontosPagadosMPago:52+$pagadoConDscto
				  //[ACT_Avisos_de_Cobranza]Monto_a_Pagar:=[ACT_Avisos_de_Cobranza]Monto_a_Pagar-$pago3 `cuando son dctos los montos no son considerados en el monto del aviso.
			End if 
			
			OB SET:C1220([ACT_Cargos:173]OB_Responsable:70;"id_responsable";$l_idResponsable)
			
			SAVE RECORD:C53([ACT_Cargos:173])
			SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
		End if 
	End if 
	KRL_UnloadReadOnly (->[ACT_Cargos:173])
	KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
	KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
End if 
$0:=$pagadoDocumento