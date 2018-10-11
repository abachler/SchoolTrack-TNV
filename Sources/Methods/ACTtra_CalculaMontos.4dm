//%attributes = {}
  //ACTtra_CalculaMontos

C_TEXT:C284($vt_accion)
C_REAL:C285($0;$vr_monto)
C_LONGINT:C283($vl_idCargo)
C_POINTER:C301($ptr1;$ptr2;$ptr3;$ptr4)
C_TEXT:C284($vt_moneda)
C_REAL:C285($vr_montoTransaccion)
C_LONGINT:C283($vl_idTransaccion)
C_LONGINT:C283($vl_idCargo;$vl_idDctoAsoc)
C_TEXT:C284($vt_set)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 

If (Count parameters:C259>=4)
	$ptr3:=$4
End if 

If (Count parameters:C259>=5)
	$ptr4:=$5
End if 

READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Transacciones:178])
$popRecord:=False:C215

$vr_monto:=0
Case of 
	: ($vt_accion="DebitoMonedaCargoFromRecNum")
		$vt_monedaCargo:=[ACT_Cargos:173]Moneda:28
		$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo))
		For ($x;1;Size of array:C274($ptr1->))
			KRL_GotoRecord (->[ACT_Transacciones:178];$ptr1->{$x})
			If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
				If ([ACT_Transacciones:178]Glosa:8="Pago con descuento")
					$vr_monto:=$vr_monto+Round:C94($ptr2->/[ACT_Transacciones:178]ValorMoneda:13;$vl_decimales)
				Else 
					$vr_monto:=$vr_monto+$ptr2->
				End if 
			Else 
				$vr_monto:=$vr_monto+$ptr2->
			End if 
		End for 
		
	: ($vt_accion="calculoMontos")
		REDUCE SELECTION:C351([ACT_Transacciones:178];0)
		KRL_FindAndLoadRecordByIndex (->[ACT_Transacciones:178]ID_Transaccion:1;$ptr1)
		If (Not:C34(Is nil pointer:C315($ptr3)))
			If ((KRL_isSameField (->[ACT_Transacciones:178]Debito:6;$ptr2)) & ([ACT_Transacciones:178]ValorMoneda:13#0) & (Not:C34($ptr3->)))
				$vr_montoTransaccion:=[ACT_Transacciones:178]MontoMonedaPago:14
			Else 
				$vr_montoTransaccion:=$ptr2->
			End if 
		Else 
			If ((KRL_isSameField (->[ACT_Transacciones:178]Debito:6;$ptr2)) & ([ACT_Transacciones:178]ValorMoneda:13#0))
				$vr_montoTransaccion:=[ACT_Transacciones:178]MontoMonedaPago:14
			Else 
				$vr_montoTransaccion:=$ptr2->
			End if 
			
		End if 
		If ([ACT_Transacciones:178]Glosa:8="Balanceo Descuento")
			$vr_monto:=$vr_monto-$vr_montoTransaccion
		Else 
			$vr_monto:=$vr_monto+$vr_montoTransaccion
		End if 
		
	: ($vt_accion="calculaFromRecNum")
		For ($x;1;Size of array:C274($ptr1->))
			KRL_GotoRecord (->[ACT_Transacciones:178];$ptr1->{$x})
			If (Is nil pointer:C315($ptr3))
				$vr_monto:=$vr_monto+ACTtra_CalculaMontos ("fromCurrentRecord";$ptr2)
			Else 
				$vr_monto:=$vr_monto+ACTtra_CalculaMontos ("fromCurrentRecord";$ptr2;$ptr3)
			End if 
		End for 
		  //
	: ($vt_accion="fromCurrentRecord")
		$vl_idTransaccion:=[ACT_Transacciones:178]ID_Transaccion:1
		  //$vr_monto:=ACTtra_CalculaMontos ("calculoMontos";->$vl_idTransaccion;$ptr1)
		If (Not:C34(Is nil pointer:C315($ptr2)))
			$vr_monto:=ACTtra_CalculaMontos ("calculoMontos";->$vl_idTransaccion;$ptr1;$ptr2)
		Else 
			$vr_monto:=ACTtra_CalculaMontos ("calculoMontos";->$vl_idTransaccion;$ptr1)
		End if 
	: ($vt_accion="CalculaMontoEnDctoTribAsociado")
		$vr_credito:=0
		$vr_dedito:=0
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=$ptr1->)
		KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=$ptr2->)
		If (Records in selection:C76([ACT_Transacciones:178])>0)
			ARRAY LONGINT:C221($al_recNumsT;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumsT;"")
			$vr_credito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumsT;->[ACT_Transacciones:178]Credito:7)
			$vr_dedito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumsT;->[ACT_Transacciones:178]Debito:6)
		End if 
		$vr_monto:=$vr_credito+$vr_dedito
		
	: ($vt_accion="CalculaDesctoAsociado")
		USE SET:C118($ptr1->)
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=$ptr2->;*)
		QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8="Pago con Descuento")
		If (Records in selection:C76([ACT_Transacciones:178])>0)  //20180528 RCH Ticket 203744
			ARRAY LONGINT:C221($aQR_Longint1;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$aQR_Longint1;"")
			  //If (Nil($ptr2))
			  //$vr_monto:=ACTtra_CalculaMontos ("calculaFromRecNum";->$aQR_Longint1;->[ACT_Transacciones]Debito)
			  //Else 
			  //  //$vr_monto:=ACTtra_CalculaMontos ("calculaFromRecNum";->$aQR_Longint1;->[ACT_Transacciones]Debito;$ptr1)
			  //If (Nil($ptr3))
			  //$vr_monto:=ACTtra_CalculaMontos ("calculaFromRecNum";->$aQR_Longint1;->[ACT_Transacciones]Debito)
			  //Else 
			$vr_monto:=ACTtra_CalculaMontos ("calculaFromRecNum";->$aQR_Longint1;->[ACT_Transacciones:178]Debito:6;$ptr3)  //20161025 RCH
			  //End if 
			  //End if 
		Else 
			$b_readOnly:=Read only state:C362([ACT_Cargos:173])
			$l_recNumCargo:=Record number:C243([ACT_Cargos:173])
			
			READ ONLY:C145([ACT_Cargos:173])
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$ptr2->;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Monto_Neto:5<0)
			$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
			
			KRL_ResetPreviousRWMode (->[ACT_Cargos:173];$b_readOnly)
			
		End if 
	: ($vt_accion="CalculaMontosDescontados")
		  // //20161025 RCH Según revisión, no se usa.
		  //$vl_idCargo:=$ptr1->
		  //$vt_set:=$ptr2->
		  //$vl_idDctoAsoc:=$ptr3->
		  //$vr_monto:=ACTtra_CalculaMontos ("CalculaDesctoAsociado";->$vt_set;->$vl_idCargo)
		  //$vr_monto:=$vr_monto+ACTtra_CalculaMontos ("CalculaMontoEnDctoTribAsociado";->$vl_idDctoAsoc;->$vl_idCargo)
		
	: ($vt_accion="sumaFromRecNumXMoneda")
		ARRAY TEXT:C222($at_monedaTransacciones;0)
		ARRAY TEXT:C222($at_monedaTransacciones2;0)
		ARRAY REAL:C219($ar_debito;0)
		ARRAY REAL:C219($ar_credito;0)
		ARRAY REAL:C219($ar_debito2;0)
		ARRAY REAL:C219($ar_credito2;0)
		ARRAY LONGINT:C221($al_recNum;0)
		
		For ($i;1;Size of array:C274($ptr1->))
			KRL_GotoRecord (->[ACT_Transacciones:178];$ptr1->{$i})
			APPEND TO ARRAY:C911($at_monedaTransacciones;KRL_GetTextFieldData (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]Moneda:28))
			APPEND TO ARRAY:C911($ar_debito;[ACT_Transacciones:178]Debito:6)
			APPEND TO ARRAY:C911($ar_credito;[ACT_Transacciones:178]Credito:7)
		End for 
		COPY ARRAY:C226($at_monedaTransacciones;$at_monedaTransacciones2)
		AT_DistinctsArrayValues (->$at_monedaTransacciones2)
		AT_Initialize ($ptr3;$ptr4)
		For ($i;1;Size of array:C274($at_monedaTransacciones2))
			AT_Initialize (->$al_recNum;->$ar_debito2;->$ar_credito2)
			$at_monedaTransacciones{0}:=$at_monedaTransacciones2{$i}
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->$at_monedaTransacciones;"=";->$DA_Return)
			For ($j;1;Size of array:C274($DA_Return))
				APPEND TO ARRAY:C911($al_recNum;$ptr1->{$DA_Return{$j}})
				APPEND TO ARRAY:C911($ar_debito2;$ar_debito{$DA_Return{$j}})
				APPEND TO ARRAY:C911($ar_credito2;$ar_credito{$DA_Return{$j}})
			End for 
			APPEND TO ARRAY:C911($ptr2->;$at_monedaTransacciones2{$i})
			APPEND TO ARRAY:C911($ptr3->;AT_GetSumArray (->$ar_debito2))
			APPEND TO ARRAY:C911($ptr4->;AT_GetSumArray (->$ar_credito2))
		End for 
		
		
End case 
$0:=$vr_monto