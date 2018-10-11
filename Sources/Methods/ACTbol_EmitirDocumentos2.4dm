//%attributes = {}
  //ACTbol_EmitirDocumentos2

$SetdeAvisos:=$1
$DocAfecto:=$2
$DocExcento:=$3
$proximaAfecta:=$4
$proximaExcenta:=$5
$IndexAfecto:=$6
$IndexExcento:=$7
$setAfecto:=$8
$setExcento:=$9
$IDCat:=$10

$idAfecto:=alACT_IDCat{$IndexAfecto}
$idExento:=alACT_IDCat{$IndexExcento}
$emitidas:=0

USE SET:C118($SetdeAvisos)
ARRAY LONGINT:C221($aRecNumAvisos;0)
LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$aRecNumAvisos)
$montoAfectoTotal:=0
$montoNoAfectoTotal:=0
ARRAY LONGINT:C221($aCargosAfectos;0)
ARRAY LONGINT:C221($aTransaccionesAfectas;0)
ARRAY LONGINT:C221($aCargosExentos;0)
ARRAY LONGINT:C221($aTransaccionesExentas;0)
For ($i;1;Size of array:C274($aRecNumAvisos))
	GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$aRecNumAvisos{$i})
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRecNumCargos)
	For ($j;1;Size of array:C274($aRecNumCargos))
		GOTO RECORD:C242([ACT_Cargos:173];$aRecNumCargos{$j})
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
		$credito:=Sum:C1([ACT_Transacciones:178]Credito:7)
		$debito:=Sum:C1([ACT_Transacciones:178]Debito:6)
		$sinPago:=$credito-$debito
		$recNumTrans:=Record number:C243([ACT_Transacciones:178])
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
		$pagos:=Sum:C1([ACT_Transacciones:178]Debito:6)
		If ([ACT_Cargos:173]TasaIVA:21>0)
			$montoAfectoTotal:=$montoAfectoTotal+($SinPago-$pagos)
			INSERT IN ARRAY:C227($aCargosAfectos;Size of array:C274($aCargosAfectos)+1;1)
			INSERT IN ARRAY:C227($aTransaccionesAfectas;Size of array:C274($aTransaccionesAfectas)+1;1)
			$aCargosAfectos{Size of array:C274($aCargosAfectos)}:=Record number:C243([ACT_Cargos:173])
			$aTransaccionesAfectas{Size of array:C274($aTransaccionesAfectas)}:=$recNumTrans
		Else 
			$montoNoAfectoTotal:=$montoNoAfectoTotal+($SinPago-$pagos)
			INSERT IN ARRAY:C227($aCargosExentos;Size of array:C274($aCargosExentos)+1;1)
			INSERT IN ARRAY:C227($aTransaccionesExentas;Size of array:C274($aTransaccionesExentas)+1;1)
			$aCargosExentos{Size of array:C274($aCargosExentos)}:=Record number:C243([ACT_Cargos:173])
			$aTransaccionesExentas{Size of array:C274($aTransaccionesExentas)}:=$recNumTrans
		End if 
	End for 
End for 
UNLOAD RECORD:C212([ACT_Cargos:173])

If ($montoAfectoTotal>0)
	CREATE RECORD:C68([ACT_Boletas:181])
	$emitidas:=$emitidas+1
	[ACT_Boletas:181]ID:1:=SQ_SeqNumber (->[ACT_Boletas:181]ID:1)
	[ACT_Boletas:181]EmitidoPor:17:=<>tUSR_RelatedTableUserName
	[ACT_Boletas:181]FechaEmision:3:=Current date:C33(*)
	[ACT_Boletas:181]AfectaIVA:9:=True:C214
	[ACT_Boletas:181]Monto_Total:6:=$montoAfectoTotal
	[ACT_Boletas:181]Monto_Afecto:4:=Round:C94([ACT_Boletas:181]Monto_Total:6/<>vrACT_FactorIVA;0)
	[ACT_Boletas:181]Monto_IVA:5:=[ACT_Boletas:181]Monto_Total:6-[ACT_Boletas:181]Monto_Afecto:4
	[ACT_Boletas:181]ID_Estado:20:=1
	[ACT_Boletas:181]Estado:2:=ACTbol_RetornaEstado ("RetornaEstadoTexto";->[ACT_Boletas:181]ID_Estado:20)
	[ACT_Boletas:181]ID_Categoria:12:=$IDCat
	[ACT_Boletas:181]ID_Documento:13:=$idAfecto
	[ACT_Boletas:181]TipoDocumento:7:=$DocAfecto
	[ACT_Boletas:181]Numero:11:=$proximaAfecta
	$proximaAfecta:=$proximaAfecta+1
	alACT_Proxima{$IndexAfecto}:=$proximaAfecta
	ACTcfg_SaveConfig (8)
	$idBoleta:=[ACT_Boletas:181]ID:1
	SAVE RECORD:C53([ACT_Boletas:181])
	ADD TO SET:C119([ACT_Boletas:181];$setAfecto)
	UNLOAD RECORD:C212([ACT_Boletas:181])
	READ ONLY:C145([ACT_Boletas:181])
	READ WRITE:C146([ACT_Transacciones:178])
	For ($j;1;Size of array:C274($aTransaccionesAfectas))
		GOTO RECORD:C242([ACT_Transacciones:178];$aTransaccionesAfectas{$j})
		[ACT_Transacciones:178]No_Boleta:9:=$idBoleta
		SAVE RECORD:C53([ACT_Transacciones:178])
	End for 
	UNLOAD RECORD:C212([ACT_Transacciones:178])
	REDUCE SELECTION:C351([ACT_Transacciones:178];0)
	READ ONLY:C145([ACT_Transacciones:178])
End if 
If ($montoNoAfectoTotal>0)
	CREATE RECORD:C68([ACT_Boletas:181])
	$emitidas:=$emitidas+2
	[ACT_Boletas:181]ID:1:=SQ_SeqNumber (->[ACT_Boletas:181]ID:1)
	[ACT_Boletas:181]EmitidoPor:17:=<>tUSR_RelatedTableUserName
	[ACT_Boletas:181]FechaEmision:3:=Current date:C33(*)
	[ACT_Boletas:181]AfectaIVA:9:=False:C215
	[ACT_Boletas:181]Monto_Total:6:=$montoNoAfectoTotal
	[ACT_Boletas:181]Monto_Afecto:4:=0
	[ACT_Boletas:181]Monto_IVA:5:=0
	[ACT_Boletas:181]ID_Estado:20:=1
	[ACT_Boletas:181]Estado:2:=ACTbol_RetornaEstado ("RetornaEstadoTexto";->[ACT_Boletas:181]ID_Estado:20)
	[ACT_Boletas:181]ID_Categoria:12:=$IDCat
	[ACT_Boletas:181]ID_Documento:13:=$idExento
	[ACT_Boletas:181]TipoDocumento:7:=$DocExcento
	[ACT_Boletas:181]Numero:11:=$proximaExcenta
	$proximaExcenta:=$proximaExcenta+1
	alACT_Proxima{$IndexExcento}:=$proximaExcenta
	ACTcfg_SaveConfig (8)
	$idBoleta:=[ACT_Boletas:181]ID:1
	SAVE RECORD:C53([ACT_Boletas:181])
	ADD TO SET:C119([ACT_Boletas:181];$setExcento)
	UNLOAD RECORD:C212([ACT_Boletas:181])
	READ ONLY:C145([ACT_Boletas:181])
	READ WRITE:C146([ACT_Transacciones:178])
	For ($j;1;Size of array:C274($aTransaccionesExentas))
		GOTO RECORD:C242([ACT_Transacciones:178];$aTransaccionesExentas{$j})
		[ACT_Transacciones:178]No_Boleta:9:=$idBoleta
		SAVE RECORD:C53([ACT_Transacciones:178])
	End for 
	UNLOAD RECORD:C212([ACT_Transacciones:178])
	REDUCE SELECTION:C351([ACT_Transacciones:178];0)
	READ ONLY:C145([ACT_Transacciones:178])
End if 

$0:=$emitidas