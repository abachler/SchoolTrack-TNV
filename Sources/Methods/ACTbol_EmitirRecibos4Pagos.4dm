//%attributes = {}
  //ACTbol_EmitirRecibos4Pagos

$SetdePagos:=$1
$ID_ModeloRecibo:=$2
$set:=$3
$montoRecibo:=0
USE SET:C118($SetdePagos)
ARRAY LONGINT:C221($aTransaccionesRecibo;0)
ARRAY LONGINT:C221($aRecNumPagos;0)
LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$aRecNumPagos)
For ($i;1;Size of array:C274($aRecNumPagos))
	GOTO RECORD:C242([ACT_Pagos:172];$aRecNumPagos{$i})
	$idApdo:=[ACT_Pagos:172]ID_Apoderado:3
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
	ARRAY LONGINT:C221($aRecNumCargos;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRecNumCargos;"")
	For ($j;1;Size of array:C274($aRecNumCargos))
		GOTO RECORD:C242([ACT_Cargos:173];$aRecNumCargos{$j})
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
		If (Records in selection:C76([ACT_Transacciones:178])=1)
			$credito:=Sum:C1([ACT_Transacciones:178]Credito:7)
			$debito:=Sum:C1([ACT_Transacciones:178]Debito:6)
			$montoRecibo:=$montoRecibo+$debito
			$recNumTrans:=Record number:C243([ACT_Transacciones:178])
			INSERT IN ARRAY:C227($aTransaccionesRecibo;Size of array:C274($aTransaccionesRecibo)+1;1)
			$aTransaccionesRecibo{Size of array:C274($aTransaccionesRecibo)}:=$recNumTrans
		End if 
	End for 
End for 
UNLOAD RECORD:C212([ACT_Cargos:173])
If (cb_GenerarBoletaCero=1)
	$cond:=($montoRecibo>=0)
Else 
	$cond:=($montoRecibo>0)
End if 
If ($cond)
	CREATE RECORD:C68([ACT_Boletas:181])
	[ACT_Boletas:181]ID:1:=SQ_SeqNumber (->[ACT_Boletas:181]ID:1)
	[ACT_Boletas:181]EmitidoPor:17:=<>tUSR_RelatedTableUserName
	[ACT_Boletas:181]FechaEmision:3:=vdACT_FEmisionBol
	[ACT_Boletas:181]AfectaIVA:9:=False:C215
	[ACT_Boletas:181]Monto_Total:6:=$montoRecibo
	[ACT_Boletas:181]Monto_Afecto:4:=0
	[ACT_Boletas:181]Monto_IVA:5:=0
	[ACT_Boletas:181]ID_Estado:20:=1
	[ACT_Boletas:181]Estado:2:=ACTbol_RetornaEstado ("RetornaEstadoTexto";->[ACT_Boletas:181]ID_Estado:20)
	[ACT_Boletas:181]ID_Categoria:12:=-100
	[ACT_Boletas:181]ID_Documento:13:=$ID_ModeloRecibo
	[ACT_Boletas:181]TipoDocumento:7:="Recibo"
	[ACT_Boletas:181]ID_Apoderado:14:=$idApdo
	$idBoleta:=[ACT_Boletas:181]ID:1
	[ACT_Boletas:181]Numero:11:=vlACT_NextRecibo
	vlACT_NextRecibo:=vlACT_NextRecibo+1
	ACTcfg_SaveConfig (8)
	SAVE RECORD:C53([ACT_Boletas:181])
	ADD TO SET:C119([ACT_Boletas:181];$set)
	KRL_UnloadReadOnly (->[ACT_Boletas:181])
	READ WRITE:C146([ACT_Transacciones:178])
	For ($u;1;Size of array:C274($aTransaccionesRecibo))
		GOTO RECORD:C242([ACT_Transacciones:178];$aTransaccionesRecibo{$u})
		[ACT_Transacciones:178]No_Boleta:9:=$idBoleta
		SAVE RECORD:C53([ACT_Transacciones:178])
	End for 
	REDUCE SELECTION:C351([ACT_Transacciones:178];0)
	KRL_UnloadReadOnly (->[ACT_Transacciones:178])
	ACTbol_EstadoBoleta ($idBoleta)
End if 