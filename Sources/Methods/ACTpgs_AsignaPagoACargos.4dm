//%attributes = {}
  //ACTpgs_AsignaPagoACargos

  //REGISTRO DE CAMBIOS. 
  //RCH 20080328 CUANDO SE TERMINABA EL MONTO DEL PAGO EL MÉTODO CONTINUABA PAGANDO CON LOS DESCUENTOS DE TODO EL AÑO.
  //SE MODIFICA MÉTODO PARA QUE SI SE ACABA EL MONTO DEL PAGO NO SIGA UTILIZANDO DESCUENTOS. 
  //ADEMÁS SE MODIFICA LA FORMA DE SUMAR LOS DESCUENTOS. ANTES SE CONSIDERABA EL MONTO NETO, AHORA SE CONSIDERARÁ EL SALDO DEBIDO A QUE UN DESCUENTO SE PODRÍA LLEGAR A UTILIZAR PARCIALMENTE.

  //RCH 20080905 SE RECIBEN PARÁMETROS OPCIONALES PARA HACER COMPATIBLE ESTE MÉTODO CON EL LLAMADO DESDE EL MÉTODO PREPAGAR
  //RCH 20090326 SE QUITA CÓDIGO QUE LLENABA ARREGLOS NO UTILIZADOS (MARCAS)
  //RCH 20090326 SE ELIMINAN CARGOS DESCUENTO EN EL MISMO FOR DE LLENADO DE ARREGLO $alACT_RecNumsDsctos
  //RCH 20090326 SE QUITA LLAMADO A MÉTODO ACTinit_LoadPrefs
  //RCH 20090406 Al terminar de utilizar un descuento se se elimina del arreglo del los descuentos.
  //RCH 20090406 Si se acaba el monto del pago se valida que no queden descuentos. Si quedan descuentos se eliminan los que estén asociados a avisos de cobranza que no fueron pagados.

  //ACTac_AjustaSaldo ("validaMontos";->vrACT_MontoPago;->vl_idAviso;->vdACT_FechaPago)

C_TEXT:C284($set)
C_LONGINT:C283($vl_idPago)
C_REAL:C285($MontoPagado)
If (Count parameters:C259=3)
	$set:=$1
	$vl_idPago:=$2
	$MontoPagado:=$3
Else 
	$set:="FaltaIDPago"
	$vl_idPago:=0
	$MontoPagado:=vrACT_MontoPago
End if 
CREATE EMPTY SET:C140([ACT_Transacciones:178];$set)

ARRAY LONGINT:C221(alACTpgs_Avisos2Recalc;0)

C_REAL:C285($montoTransaccion)
C_LONGINT:C283($i_FechasVenc)

ARRAY LONGINT:C221($alACT_RecNumsDsctos;0)
ARRAY LONGINT:C221($al_recNumDocCargo;0)

  //$MontoDesctos:=0

For ($i;Size of array:C274(alACT_RecNumsCargos);1;-1)
	If (arACT_CMontoNeto{$i}<0)
		INSERT IN ARRAY:C227($alACT_RecNumsDsctos;Size of array:C274($alACT_RecNumsDsctos)+1;1)
		$alACT_RecNumsDsctos{Size of array:C274($alACT_RecNumsDsctos)}:=alACT_RecNumsCargos{$i}
		AT_Delete ($i;1;->alACT_RecNumsCargos)
	End if 
End for 
  //$MontoDesctos:=ACTcar_CalculaMontos ("calcMontoFromRecNumArrayMCobro";->$alACT_RecNumsDsctos;->[ACT_Cargos]Saldo;vdACT_FechaUF)
For ($i_Cargos;1;Size of array:C274(alACT_RecNumsCargos))
	$pagadoMonedaCargo:=0
	$vl_recNumCargo:=alACT_RecNumsCargos{$i_Cargos}
	ACTpgs_CalculaDesctoRXA ("ActualizaRegistrosAntesDelPago";->$vl_recNumCargo;->vdACT_FechaPago)
	READ WRITE:C146([ACT_Cargos:173])
	READ WRITE:C146([ACT_Documentos_de_Cargo:174])
	READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
	GOTO RECORD:C242([ACT_Cargos:173];alACT_RecNumsCargos{$i_Cargos})
	QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
	QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
	$rnDC:=Record number:C243([ACT_Documentos_de_Cargo:174])
	$rnAC:=Record number:C243([ACT_Avisos_de_Cobranza:124])
	
	$pagadoDocumento:=ACTac_UtilizaDescuentos ($vl_recNumCargo;$set;$vl_idPago;->$alACT_RecNumsDsctos)
	
	READ WRITE:C146([ACT_Cargos:173])
	READ WRITE:C146([ACT_Documentos_de_Cargo:174])
	READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
	GOTO RECORD:C242([ACT_Cargos:173];alACT_RecNumsCargos{$i_Cargos})
	GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];$rnDC)
	GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$rnAC)
	[ACT_Documentos_de_Cargo:174]Pagos:9:=$pagadoDocumento
	SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
	
	If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214)
		$saldoCargoMoneda:=ACTcar_CalculaSaldo ("retornaSaldoMonedaPago";vdACT_FechaUF;->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Moneda:28)
	Else 
		$saldoCargoMoneda:=[ACT_Cargos:173]Saldo:23
	End if 
	Case of 
		: (Abs:C99($saldoCargoMoneda)>$MontoPagado)
			If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214)
				$pagadoMonedaCargo:=ACTcar_CalculaSaldo ("retornaPagoMonedaCargo";vdACT_FechaUF;->$MontoPagado;->[ACT_Cargos:173]Moneda:28)
			Else 
				$pagadoMonedaCargo:=$MontoPagado
			End if 
			$pagadoMonedaEmision:=ACTcar_CalculaSaldo ("retornaPagoMonedaEmision";vdACT_FechaUF;->$MontoPagado)
			[ACT_Documentos_de_Cargo:174]Pagos:9:=[ACT_Documentos_de_Cargo:174]Pagos:9+$MontoPagado
			[ACT_Cargos:173]MontosPagados:8:=[ACT_Cargos:173]MontosPagados:8+$pagadoMonedaCargo
			[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14:=[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14-$pagadoMonedaEmision
			[ACT_Avisos_de_Cobranza:124]Monto_A_Pagar_Moneda:16:=[ACT_Avisos_de_Cobranza:124]Monto_A_Pagar_Moneda:16-$MontoPagado
			$MontoTransaccion:=$pagadoMonedaCargo
			[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]Saldo:23+$pagadoMonedaCargo
			[ACT_Cargos:173]MontosPagadosMPago:52:=[ACT_Cargos:173]MontosPagadosMPago:52+$MontoPagado
			$MontoPagado:=0
		: (Abs:C99($saldoCargoMoneda)<=$MontoPagado)
			$vr_montoPagado:=Abs:C99($saldoCargoMoneda)
			$pagadoMonedaPago:=$vr_montoPagado
			$pagadoMonedaCargo:=Abs:C99([ACT_Cargos:173]Saldo:23)
			  //If ([ACT_Cargos]EmitidoSegúnMonedaCargo=True)
			$pagadoMonedaEmision:=ACTcar_CalculaSaldo ("retornaPagoMonedaEmision";vdACT_FechaUF;->$vr_montoPagado)
			  //Else 
			  //$pagadoMonedaEmision:=$vr_montoPagado
			  //End if 
			[ACT_Documentos_de_Cargo:174]Pagos:9:=[ACT_Documentos_de_Cargo:174]Pagos:9+$pagadoMonedaPago
			[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14:=[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14-$pagadoMonedaEmision
			[ACT_Avisos_de_Cobranza:124]Monto_A_Pagar_Moneda:16:=[ACT_Avisos_de_Cobranza:124]Monto_A_Pagar_Moneda:16-$pagadoMonedaPago
			[ACT_Cargos:173]MontosPagados:8:=[ACT_Cargos:173]MontosPagados:8+$pagadoMonedaCargo
			$MontoTransaccion:=$pagadoMonedaCargo
			$MontoPagado:=$MontoPagado-$pagadoMonedaPago
			[ACT_Cargos:173]Saldo:23:=0
			[ACT_Cargos:173]MontosPagadosMPago:52:=[ACT_Cargos:173]MontosPagadosMPago:52+$pagadoMonedaPago
	End case 
	[ACT_Cargos:173]Monto_Vencido:30:=Round:C94((Abs:C99([ACT_Cargos:173]Monto_Neto:5)-[ACT_Cargos:173]MontosPagados:8)*-1;11)
	[ACT_Documentos_de_Cargo:174]Saldo:10:=[ACT_Documentos_de_Cargo:174]Pagos:9-[ACT_Documentos_de_Cargo:174]Monto_Neto:4
	If (Find in array:C230(alACTpgs_Avisos2Recalc;Record number:C243([ACT_Avisos_de_Cobranza:124]))=-1)
		APPEND TO ARRAY:C911(alACTpgs_Avisos2Recalc;Record number:C243([ACT_Avisos_de_Cobranza:124]))
	End if 
	SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
	SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
	SAVE RECORD:C53([ACT_Cargos:173])
	$recNumCargo:=Record number:C243([ACT_Cargos:173])
	  //Creacion de la transaccion
	If ($MontoTransaccion>0)
		ACTpgs_CreateTransaction ([ACT_Cargos:173]ID_CuentaCorriente:2;[ACT_Cargos:173]ID:1;vdACT_FechaUF;$MontoTransaccion;"Pago con "+vsACT_FormasdePago;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;[ACT_Cargos:173]ID_Apoderado:18;String:C10([ACT_Cargos:173]Mes:13;"00")+String:C10([ACT_Cargos:173]Año:14;"0000");$set;$vl_idPago)
	End if 
	
	GOTO RECORD:C242([ACT_Cargos:173];$recNumCargo)
	ACTcfg_ItemsMatricula ("AgregaElementoArreglo")
	
	KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
	KRL_UnloadReadOnly (->[ACT_Transacciones:178])
	KRL_UnloadReadOnly (->[ACT_Cargos:173])
	  //If (($MontoPagado=0) & ($MontoDesctos=0))  `los descuentos se utilizaban todos y quedaban asociados al pago 
	ACTpgs_CalculaDesctoRXA ("ActualizaRegistrosDespuesDelPago";->$vl_recNumCargo)
	If ($MontoPagado=0)  // aveces los cargos por descuento no se alcanzan a utilizar todos
		$vb_salir:=True:C214
		If (Size of array:C274($alACT_RecNumsDsctos)>0)
			ARRAY LONGINT:C221($al_idsDocsCargo;0)
			For ($i;Size of array:C274($alACT_RecNumsDsctos);1;-1)
				GOTO RECORD:C242([ACT_Cargos:173];$alACT_RecNumsDsctos{$i})
				REDUCE SELECTION:C351([ACT_Avisos_de_Cobranza:124];0)
				REDUCE SELECTION:C351([ACT_Documentos_de_Cargo:174];0)
				KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3)
				KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
				If (Find in array:C230(alACTpgs_Avisos2Recalc;Record number:C243([ACT_Avisos_de_Cobranza:124]))=-1)
					AT_Delete ($i;1;->$alACT_RecNumsDsctos)
				End if 
				$vb_salir:=False:C215
			End for 
		End if 
		If ($vb_salir)
			ACTpgs_CalculaDesctoRXA ("ActualizaRegistrosDespuesDelPagoSinSaldo";->alACT_RecNumsCargos;->$i_Cargos;->vdACT_FechaPago)
			$i_Cargos:=Size of array:C274(alACT_RecNumsCargos)+1
		End if 
	End if 
End for 
$0:=Round:C94($MontoPagado;<>vlACT_Decimales)

