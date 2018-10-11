//%attributes = {}
  //ACTbol_EmitirRecibos

$SetdeAvisos:=$1
$ID_ModeloRecibo:=$2
$set:=$3
$montoRecibo:=0
USE SET:C118($SetdeAvisos)
$pagoSinBoleta:=0
ARRAY LONGINT:C221($aPagosaBoleta;0)
ARRAY LONGINT:C221($aPagosaBoletaExenta;0)
ARRAY LONGINT:C221($aRecNumAvisos;0)
LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$aRecNumAvisos)
CREATE EMPTY SET:C140([ACT_Transacciones:178];"IDBoleta")
For ($i;1;Size of array:C274($aRecNumAvisos))
	GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$aRecNumAvisos{$i})
	$idApdo:=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
	If (i1=1)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
	End if 
	ARRAY LONGINT:C221($aRecNumCargos;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRecNumCargos;"")
	For ($j;1;Size of array:C274($aRecNumCargos))
		GOTO RECORD:C242([ACT_Cargos:173];$aRecNumCargos{$j})
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
		$sinPago:=Sum:C1([ACT_Transacciones:178]Credito:7)-Sum:C1([ACT_Transacciones:178]Debito:6)
		CREATE SET:C116([ACT_Transacciones:178];"SinPago")
		
		ARRAY LONGINT:C221($al_transacciones;0)
		SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_transacciones)
		$credito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_transacciones;->[ACT_Transacciones:178]Credito:7)
		$debito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_transacciones;->[ACT_Transacciones:178]Debito:6)
		$sinPago:=$credito-$debito
		
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
		$pagos:=Sum:C1([ACT_Transacciones:178]Debito:6)
		CREATE SET:C116([ACT_Transacciones:178];"Pagos")
		
		ARRAY LONGINT:C221($al_transacciones;0)
		SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_transacciones)
		$pagos:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_transacciones;->[ACT_Transacciones:178]Debito:6)
		
		
		If (i2=1)
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
			ARRAY LONGINT:C221($aPagosaBoletaTemp;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$aPagosaBoletaTemp;"")
			$pagoSinBoleta:=Sum:C1([ACT_Transacciones:178]Debito:6)
			$pagoSinBoleta:=0
			For ($w;1;Size of array:C274($aPagosaBoletaTemp))
				
				$id:=$aPagosaBoletaTemp{$w}
				KRL_FindAndLoadRecordByIndex (->[ACT_Transacciones:178]ID_Transaccion:1;->$id)
				$pagoSinBoleta:=$pagoSinBoleta+ACTtra_CalculaMontos ("FromCurrentRecord";->[ACT_Transacciones:178]Credito:7)
				
				INSERT IN ARRAY:C227($aPagosaBoleta;Size of array:C274($aPagosaBoleta)+1;1)
				$aPagosaBoleta{Size of array:C274($aPagosaBoleta)}:=$aPagosaBoletaTemp{$w}
			End for 
		End if 
		$montoRecibo:=$montoRecibo+($sinPago-$pagos)+$pagoSinBoleta
		UNION:C120("IDBoleta";"SinPago";"IDBoleta")
	End for 
End for 
UNLOAD RECORD:C212([ACT_Cargos:173])
$0:=0
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
	[ACT_Boletas:181]ID_Categoria:12:=-100
	[ACT_Boletas:181]ID_Documento:13:=$ID_ModeloRecibo
	[ACT_Boletas:181]TipoDocumento:7:="Recibo"
	$idBoleta:=[ACT_Boletas:181]ID:1
	[ACT_Boletas:181]Numero:11:=vlACT_NextRecibo
	[ACT_Boletas:181]ID_Apoderado:14:=$idApdo
	vlACT_NextRecibo:=vlACT_NextRecibo+1
	ACTcfg_SaveConfig (8)
	SAVE RECORD:C53([ACT_Boletas:181])
	ADD TO SET:C119([ACT_Boletas:181];$set)
	KRL_UnloadReadOnly (->[ACT_Boletas:181])
	READ WRITE:C146([ACT_Transacciones:178])
	USE SET:C118("IDBoleta")
	APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9:=$idBoleta)
	SET_ClearSets ("SinPago";"Pagos";"IDBoleta")
	For ($j;1;Size of array:C274($aPagosaBoleta))
		GOTO RECORD:C242([ACT_Transacciones:178];$aPagosaBoleta{$j})
		[ACT_Transacciones:178]No_Boleta:9:=$idBoleta
		SAVE RECORD:C53([ACT_Transacciones:178])
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=[ACT_Transacciones:178]ID_Item:3)
		If ([ACT_Cargos:173]Saldo:23=0)
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9#0)
			APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9:=0)
		End if 
	End for 
	REDUCE SELECTION:C351([ACT_Transacciones:178];0)
	KRL_UnloadReadOnly (->[ACT_Transacciones:178])
	ACTbol_EstadoBoleta ($idBoleta)
	$0:=1
End if 