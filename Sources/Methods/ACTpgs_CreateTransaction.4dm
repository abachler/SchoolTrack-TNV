//%attributes = {}
  //ACTpgs_CreateTransaction

$idCta:=$1
$idItem:=$2
$fecha:=$3
$monto:=$4
$glosa:=$5
$idAviso:=$6
$idApdo:=$7
$ref:=$8
$set:=""
$idPago:=0
$noBoleta:=0
$vl_idCargoAsociado:=0

Case of 
	: (Count parameters:C259=9)
		$set:=$9
	: (Count parameters:C259=10)
		$set:=$9
		$idPago:=$10
	: (Count parameters:C259=11)
		$set:=$9
		$idPago:=$10
		$noBoleta:=$11
	: (Count parameters:C259=12)
		$set:=$9
		$idPago:=$10
		$noBoleta:=$11
		$vl_idCargoAsociado:=$12
End case 


CREATE RECORD:C68([ACT_Transacciones:178])
[ACT_Transacciones:178]ID_Transaccion:1:=SQ_SeqNumber (->[ACT_Transacciones:178]ID_Transaccion:1)
[ACT_Transacciones:178]ID_CuentaCorriente:2:=$idCta
[ACT_Transacciones:178]ID_Item:3:=$idItem
[ACT_Transacciones:178]Fecha:5:=$fecha
[ACT_Transacciones:178]Debito:6:=$monto
[ACT_Transacciones:178]Credito:7:=0
[ACT_Transacciones:178]Glosa:8:=$glosa
[ACT_Transacciones:178]No_Comprobante:10:=$idAviso
[ACT_Transacciones:178]ID_Apoderado:11:=$idApdo
[ACT_Transacciones:178]RefPeriodo:12:=$ref
[ACT_Transacciones:178]ID_Pago:4:=$idPago
[ACT_Transacciones:178]No_Boleta:9:=$noBoleta
[ACT_Transacciones:178]ID_Tercero:16:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$idItem;->[ACT_Cargos:173]ID_Tercero:54)
$vt_monedaNacional:=ST_GetWord (ACT_DivisaPais ;1;";")
$recNumCargo:=Record number:C243([ACT_Cargos:173])
REDUCE SELECTION:C351([ACT_Cargos:173];0)
$vt_moneda:=KRL_GetTextFieldData (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]Moneda:28)
REDUCE SELECTION:C351([ACT_Cargos:173];0)
$vb_emitidoSegunMonedaCargo:=KRL_GetBooleanFieldData (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
If ($vb_emitidoSegunMonedaCargo)
	[ACT_Transacciones:178]ValorMoneda:13:=ACTut_fValorDivisa ($vt_moneda;[ACT_Transacciones:178]Fecha:5)
	If ([ACT_Transacciones:178]Glosa:8="Pago con descuento")
		REDUCE SELECTION:C351([ACT_Cargos:173];0)
		If ($vl_idCargoAsociado=0)
			$vl_idCargoAsociado:=[ACT_Transacciones:178]ID_Item:3
		End if 
		
		REDUCE SELECTION:C351([ACT_Cargos:173];0)
		If (KRL_GetBooleanFieldData (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11))
			REDUCE SELECTION:C351([ACT_Cargos:173];0)
			$vt_moneda:=KRL_GetTextFieldData (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]Moneda:28)
		Else 
			$vt_moneda:=$vt_monedaNacional
		End if 
		[ACT_Transacciones:178]ValorMoneda:13:=ACTut_fValorDivisa ($vt_moneda;[ACT_Transacciones:178]Fecha:5)
		
		REDUCE SELECTION:C351([ACT_Cargos:173];0)
		$vt_monedaDcto:=KRL_GetTextFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargoAsociado;->[ACT_Cargos:173]Moneda:28)
		$vb_emitidoEnMoneda:=KRL_GetBooleanFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargoAsociado;->[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
		If (($vt_monedaDcto=ST_GetWord (ACT_DivisaPais ;1;";")) | (($vb_emitidoEnMoneda) & ($vt_monedaDcto=ST_GetWord (ACT_DivisaPais ;1;";"))) | (Not:C34($vb_emitidoEnMoneda)))
			[ACT_Transacciones:178]MontoMonedaPago:14:=[ACT_Transacciones:178]Debito:6
		Else 
			[ACT_Transacciones:178]MontoMonedaPago:14:=Round:C94([ACT_Transacciones:178]ValorMoneda:13*[ACT_Transacciones:178]Debito:6;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaNacional)))
		End if 
	Else 
		[ACT_Transacciones:178]MontoMonedaPago:14:=Round:C94([ACT_Transacciones:178]ValorMoneda:13*[ACT_Transacciones:178]Debito:6;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaNacional)))
	End if 
Else 
	[ACT_Transacciones:178]ValorMoneda:13:=1
	[ACT_Transacciones:178]MontoMonedaPago:14:=[ACT_Transacciones:178]Debito:6
End if 
GOTO RECORD:C242([ACT_Cargos:173];$recNumCargo)
SAVE RECORD:C53([ACT_Transacciones:178])

If ($set#"")
	ADD TO SET:C119([ACT_Transacciones:178];$set)
End if 