//%attributes = {}
  //dbuACT_VerificaTransXPagos

C_LONGINT:C283($vl_idTansaccion)
If (Count parameters:C259=1)
	$vl_idTansaccion:=$1
End if 

If (Not:C34(In transaction:C397))
	START TRANSACTION:C239
	C_BOOLEAN:C305($lockedCargos;$vb_retorno;$vb_mostrarAlert)
	C_LONGINT:C283($tomadosTransacciones;$vQR_Long1;$DocenCartera;$proc)
	ARRAY LONGINT:C221(aQR_Longint2;0)
	ARRAY LONGINT:C221(aQR_Longint1;0)
	ARRAY LONGINT:C221(aQR_Longint3;0)
	$proc:=IT_UThermometer (1;0;__ ("Ejecutando script..."))
	MESSAGES OFF:C175
	READ WRITE:C146([ACT_Transacciones:178])
	If ($vl_idTansaccion>0)
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Transaccion:1>=$vl_idTansaccion;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Debito:6>0;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0)
	Else 
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]Debito:6>0;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0)
	End if 
	ARRAY LONGINT:C221(aQR_Longint1;0)
	ARRAY LONGINT:C221(aEnBoleta;0)
	SELECTION TO ARRAY:C260([ACT_Transacciones:178];aQR_Longint1;[ACT_Transacciones:178]No_Boleta:9;aEnBoleta;[ACT_Transacciones:178]ID_Apoderado:11;aQR_Longint3)
	$lockedCargos:=ACTpgs_EliminaPagoEnTrans (->aQR_Longint1;->aQR_Longint2)
	If (Not:C34($lockedCargos))
		READ WRITE:C146([ACT_Documentos_en_Cartera:182])
		$DocenCartera:=Find in field:C653([ACT_Documentos_en_Cartera:182]ID_DocdePago:3;[ACT_Documentos_de_Pago:176]ID:1)
		If ($DocenCartera#-1)
			GOTO RECORD:C242([ACT_Documentos_en_Cartera:182];$DocenCartera)
			DELETE RECORD:C58([ACT_Documentos_en_Cartera:182])
		End if 
		$tomadosTransacciones:=ACTpgs_DesasignaIdTransaccion (->aQR_Longint1)
		If ($tomadosTransacciones=0)
			For ($vQR_Long1;1;Size of array:C274(aQR_Longint2))
				ACTac_Recalcular (aQR_Longint2{$vQR_Long1};Current date:C33(*))
			End for 
			KRL_UnloadReadOnly (->[ACT_Transacciones:178])
			KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
			AT_DistinctsArrayValues (->aQR_Longint3)
			For (vQR_Long1;1;Size of array:C274(aQR_Longint3))
				vQR_long2:=aQR_Longint3{vQR_Long1}
				KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->vQR_long2)
				ACTpp_RecalculaSaldoApdo (Record number:C243([Personas:7]))
			End for 
		Else 
			$vb_mostrarAlert:=True:C214
		End if 
	Else 
		$vb_mostrarAlert:=True:C214
	End if 
	ARRAY LONGINT:C221(aQR_Longint2;0)
	ARRAY LONGINT:C221(aQR_Longint1;0)
	ARRAY LONGINT:C221(aQR_Longint3;0)
	ARRAY LONGINT:C221(aQR_Longint1;0)
	ARRAY LONGINT:C221(aEnBoleta;0)
	IT_UThermometer (-2;$proc)
	If ($vb_mostrarAlert)
		CANCEL TRANSACTION:C241
		CD_Dlog (0;__ ("Actualmente existen registros en uso. El proceso no pudo ser terminado."))
	Else 
		VALIDATE TRANSACTION:C240
		CD_Dlog (0;__ ("El proceso se ejecutó correctamente"))
	End if 
End if 