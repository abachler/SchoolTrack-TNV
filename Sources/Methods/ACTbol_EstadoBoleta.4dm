//%attributes = {}
  //ACTbol_EstadoBoleta

C_REAL:C285($pagos)
C_LONGINT:C283($1;$id_boleta)
ARRAY LONGINT:C221($al_recNum2;0)
$id_boleta:=$1
If ($id_boleta>0)
	READ ONLY:C145([ACT_Transacciones:178])
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=$id_boleta)
	QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
	ARRAY LONGINT:C221($al_recNum;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum;"")
	$pagos:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones:178]Debito:6)
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=$id_boleta)
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
	$vr_saldo:=Sum:C1([ACT_Cargos:173]Saldo:23)
	
	$vb_tieneDctoAsociado:=False:C215
	QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=$id_boleta;*)
	QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Nula:15=False:C215)
	If (Records in selection:C76([ACT_Boletas:181])>0)
		$vb_tieneDctoAsociado:=True:C214
		  //KRL_RelateSelection (->[ACT_Transacciones]ID_DctoRelacionado;->[ACT_Boletas]ID;"")
		KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8#"Pago con Nota de crédito")
		LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum;"")
		$vr_credito:=0
		For ($i;1;Size of array:C274($al_recNum))
			GOTO RECORD:C242([ACT_Transacciones:178];$al_recNum{$i})
			$vt_moneda:=ACTtra_RetornaInfo ("retornaMonedaT")
			If ($vt_moneda#"UF")
				$vr_credito:=$vr_credito+ACTtra_CalculaMontos ("fromCurrentRecord";->[ACT_Transacciones:178]Credito:7)
			Else 
				KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Transacciones:178]ID_Item:3;"")
				QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=-1)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum2;"")
				$vr_credito:=$vr_credito+ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum2;->[ACT_Transacciones:178]Debito:6)
			End if 
		End for 
		CREATE SELECTION FROM ARRAY:C640([ACT_Transacciones:178];$al_recNum;"")
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8="Pago con descuento")
		LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum2;"")
		$vr_debito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum2;->[ACT_Transacciones:178]Debito:6)
	End if 
	
	READ WRITE:C146([ACT_Boletas:181])
	QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=$id_boleta)
	Case of 
		: ([ACT_Boletas:181]ID_Estado:20=7)
			
		: ([ACT_Boletas:181]ID_DctoAsociado:19#0)
			[ACT_Boletas:181]ID_Estado:20:=5
		: ($vb_tieneDctoAsociado)
			$vr_monto:=$vr_credito+$vr_debito+$pagos
			Case of 
				: ($vr_monto>=[ACT_Boletas:181]Monto_Total:6)
					[ACT_Boletas:181]ID_Estado:20:=3
				: ($vr_monto=0)
					[ACT_Boletas:181]ID_Estado:20:=1
				: ($vr_monto<[ACT_Boletas:181]Monto_Total:6)
					[ACT_Boletas:181]ID_Estado:20:=2
			End case 
		: (($vr_saldo=0) & (Size of array:C274($al_recNum)>0))
			[ACT_Boletas:181]ID_Estado:20:=3
		: ([ACT_Boletas:181]Monto_Total:6=0)  //si el monto total es 0 se deja el estado en cancelado
			[ACT_Boletas:181]ID_Estado:20:=3
		: ($pagos=0)
			[ACT_Boletas:181]ID_Estado:20:=1
		: ($pagos<[ACT_Boletas:181]Monto_Total:6)
			[ACT_Boletas:181]ID_Estado:20:=2
		: ($pagos>=[ACT_Boletas:181]Monto_Total:6)
			[ACT_Boletas:181]ID_Estado:20:=3
	End case 
	[ACT_Boletas:181]Estado:2:=ACTbol_RetornaEstado ("RetornaEstadoTexto";->[ACT_Boletas:181]ID_Estado:20)
	SAVE RECORD:C53([ACT_Boletas:181])
	UNLOAD RECORD:C212([ACT_Boletas:181])
End if 