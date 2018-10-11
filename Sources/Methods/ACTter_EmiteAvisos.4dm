//%attributes = {}
  //ACTter_EmiteAvisos

$vl_idApdo:=$1
$vl_mes:=$2
$vl_year:=$3

$date:=$4
$fechaVenc:=$5
$fechaVenc2:=$6
$fechaVenc3:=$7
$fechaVenc4:=$8
$vl_idCtaCte:=$9
$opcion:=$10
$vtACT_CurrentUser:=$11

  //$opcion:=$9

ARRAY LONGINT:C221($al_idsAvisos2Recalc;0)

READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([ACT_Terceros:138])
READ ONLY:C145([ACT_Terceros_Pactado:139])

QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=$vl_idApdo)
KRL_RelateSelection (->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;->[ACT_CuentasCorrientes:175]ID:1;"")
KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Terceros_Pactado:139]Id_Tercero:2;"")

ARRAY LONGINT:C221($al_idTerceros;0)
LONGINT ARRAY FROM SELECTION:C647([ACT_Terceros:138];$al_idTerceros;"")

For ($i;1;Size of array:C274($al_idTerceros))
	ARRAY LONGINT:C221($al_recNumDocsCargo;0)
	$recNumTercero:=$al_idTerceros{$i}
	GOTO RECORD:C242([ACT_Terceros:138];$recNumTercero)
	QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Tercero:24=[ACT_Terceros:138]Id:1;*)
	QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]Mes:13=$vl_mes;*)
	QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]Año:14=$vl_year;*)
	QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]FechaEmision:21=!00-00-00!;*)
	QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]ID_Apoderado:12=$vl_idApdo)
	If (Records in selection:C76([ACT_Documentos_de_Cargo:174])>0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Documentos_de_Cargo:174];$al_recNumDocsCargo;"")
		If (mAvisoAlumno=1)
			CREATE SELECTION FROM ARRAY:C640([ACT_Documentos_de_Cargo:174];$al_recNumDocsCargo)
			QUERY SELECTION:C341([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6=$vl_idCtaCte)
		End if 
		ARRAY LONGINT:C221($aDocCargo;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Documentos_de_Cargo:174];$aDocCargo;"")
		If (Records in selection:C76([ACT_Documentos_de_Cargo:174])>0)
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6)
			ACTac_CreaAviso ($date;$fechaVenc;$fechaVenc2;$fechaVenc3;$fechaVenc4;$vl_idApdo;[ACT_Terceros:138]Id:1;$vl_idCtaCte;$vl_mes;$vl_year;$vtACT_CurrentUser)
			$recNumAviso:=Record number:C243([ACT_Avisos_de_Cobranza:124])
			If ($opcion=1)
				INSERT IN ARRAY:C227(alACT_AvisosImprimir;Size of array:C274(alACT_AvisosImprimir)+1)
				alACT_AvisosImprimir{Size of array:C274(alACT_AvisosImprimir)}:=Record number:C243([ACT_Avisos_de_Cobranza:124])
			End if 
			
			  // asignacion de fecha de emision a los cargos  y documentos existentes en el período
			  //y asignación de No_comprobante a transacciones y docs de cargo
			
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			READ ONLY:C145([ACT_Transacciones:178])
			CREATE SELECTION FROM ARRAY:C640([ACT_Documentos_de_Cargo:174];$aDocCargo)
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			$setCargosInvolucrados:="CargosInvolucrados"
			CREATE SET:C116([ACT_Cargos:173];$setCargosInvolucrados)
			SELECTION TO ARRAY:C260([ACT_Cargos:173]Monto_Neto:5;$aNeto;[ACT_Cargos:173]MontosPagados:8;$aPagados)
			ARRAY REAL:C219(aSaldo;Size of array:C274($aNeto))
			
			For ($Cargo;1;Size of array:C274($aNeto))
				aSaldo{$Cargo}:=$aPagados{$Cargo}-$aNeto{$Cargo}
			End for 
			
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			CREATE SET:C116([ACT_Documentos_de_Cargo:174];"DocsdeCargo")
			
			ARRAY DATE:C224(aDate1;Records in selection:C76([ACT_Cargos:173]))
			ARRAY DATE:C224(aDate2;Records in selection:C76([ACT_Documentos_de_Cargo:174]))
			ARRAY DATE:C224(aDate3;Records in selection:C76([ACT_Cargos:173]))
			ARRAY DATE:C224(aDate4;Records in selection:C76([ACT_Documentos_de_Cargo:174]))
			ARRAY LONGINT:C221(aLongInt1;Records in selection:C76([ACT_Transacciones:178]))
			ARRAY LONGINT:C221(aLongInt2;Records in selection:C76([ACT_Documentos_de_Cargo:174]))
			
			AT_Populate (->aDate1;->[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)
			AT_Populate (->aDate2;->[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)
			AT_Populate (->aDate3;->[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
			AT_Populate (->aDate4;->[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
			AT_Populate (->aLongInt1;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
			AT_Populate (->aLongInt2;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
			
			ARRAY LONGINT:C221($aRNT;0)
			ARRAY LONGINT:C221($aRNDC;0)
			ARRAY LONGINT:C221($aRNC;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$aRNT;"")
			LONGINT ARRAY FROM SELECTION:C647([ACT_Documentos_de_Cargo:174];$aRNDC;"")
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRNC;"")
			
			For ($tt;1;Size of array:C274($aRNT))
				READ WRITE:C146([ACT_Transacciones:178])
				GOTO RECORD:C242([ACT_Transacciones:178];$aRNT{$tt})
				$readOnlyState:=KRL_ReadWrite (->[ACT_Transacciones:178])
				If (Not:C34($readOnlyState))
					[ACT_Transacciones:178]No_Comprobante:10:=aLongInt1{$tt}
					SAVE RECORD:C53([ACT_Transacciones:178])
				Else 
					$params:=String:C10([ACT_Transacciones:178]ID_Transaccion:1)+";"+String:C10(aLongInt1{$tt})
					BM_CreateRequest ("ACT_EmiteTransaccion";$params)
				End if 
			End for 
			
			For ($tt;1;Size of array:C274($aRNDC))
				READ WRITE:C146([ACT_Documentos_de_Cargo:174])
				GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];$aRNDC{$tt})
				$readOnlyState:=KRL_ReadWrite (->[ACT_Documentos_de_Cargo:174])
				If (Not:C34($readOnlyState))
					[ACT_Documentos_de_Cargo:174]FechaEmision:21:=aDate2{$tt}
					[ACT_Documentos_de_Cargo:174]Fecha_Vencimiento:20:=aDate4{$tt}
					[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15:=aLongInt2{$tt}
					SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
				Else 
					$params:=String:C10([ACT_Documentos_de_Cargo:174]ID_Documento:1)+";"+String:C10(aDate2{$tt})+";"+String:C10(aDate4{$tt})+";"+String:C10(aLongInt2{$tt})
					BM_CreateRequest ("ACT_EmiteDoc";$params)
				End if 
			End for 
			For ($tt;1;Size of array:C274($aRNC))
				READ WRITE:C146([ACT_Cargos:173])
				GOTO RECORD:C242([ACT_Cargos:173];$aRNC{$tt})
				$readOnlyState:=KRL_ReadWrite (->[ACT_Cargos:173])
				If (Not:C34($readOnlyState))
					[ACT_Cargos:173]FechaEmision:22:=aDate1{$tt}
					[ACT_Cargos:173]Fecha_de_Vencimiento:7:=aDate3{$tt}
					  //[ACT_Cargos]LastInterestsUpdate:=aDate3{$tt}
					[ACT_Cargos:173]LastInterestsUpdate:42:=ACTcar_FechaCalculoIntereses ("ObtieneFecha";->[ACT_Cargos:173]FechaEmision:22;->[ACT_Cargos:173]Fecha_de_Vencimiento:7)  //20140825 RCH Intereses
					[ACT_Cargos:173]Saldo:23:=aSaldo{$tt}
					SAVE RECORD:C53([ACT_Cargos:173])
					ACTcfg_ItemsMatricula ("AgregaElementoArreglo")
				Else 
					$params:=String:C10([ACT_Cargos:173]ID:1)+";"+String:C10(aDate1{$tt})+";"+String:C10(aDate3{$tt})+";"+String:C10(aSaldo{$tt})
					BM_CreateRequest ("ACT_EmiteCargo";$params)
				End if 
			End for 
			
			USE SET:C118("DocsdeCargo")
			FIRST RECORD:C50([ACT_Documentos_de_Cargo:174])
			
			For ($i;1;Records in selection:C76([ACT_Documentos_de_Cargo:174]))
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=[ACT_Documentos_de_Cargo:174]ID_Documento:1)
				[ACT_Documentos_de_Cargo:174]Saldo:10:=Sum:C1([ACT_Cargos:173]Saldo:23)
				$set2ReCalc:="set2Recalc"
				CREATE SET:C116([ACT_Cargos:173];$set2ReCalc)
				[ACT_Documentos_de_Cargo:174]Saldo:10:=ACTcar_CalculaMontos ("calcMontoFromSetMCobro";->$set2ReCalc;->[ACT_Cargos:173]Saldo:23;vdACT_FechaUFSel)
				SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
				NEXT RECORD:C51([ACT_Documentos_de_Cargo:174])
			End for 
			
			CLEAR SET:C117("DocsdeCargo")
			
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
			KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
			KRL_UnloadReadOnly (->[ACT_Transacciones:178])
			
			AT_Initialize (->aDate1;->aDate2;->aDate3;->aDate4;->aLongInt1;->aLongInt2;->aSaldo)
			
			USE SET:C118($setCargosInvolucrados)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16#-2)
			CREATE SET:C116([ACT_Cargos:173];$setCargosInvolucrados)
			$vl_idAviso:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
			BLOB_Variables2Blob (->$xBlob;0;->$vl_idAviso;->vdACT_FechaUFSel)
			$done:=ACTac_CalculaMontos ($xBlob)
			If (Not:C34($done))
				BM_CreateRequest ("calculaMontosAvisos";"";String:C10($vl_idAviso);$xBlob)
			End if 
			CLEAR SET:C117($setCargosInvolucrados)
			
			If (mAvisoApoderado=1)
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=$vl_idApdo;*)
			Else 
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$vl_idCtaCte;*)
			End if 
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22#!00-00-00!;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7#!00-00-00!;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$date;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7<Current date:C33(*);*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
			CREATE SET:C116([ACT_Cargos:173];"CargosVencImpagos")
			SELECTION TO ARRAY:C260([ACT_Cargos:173];$aRecNumCargos)
			
			READ WRITE:C146([ACT_Cargos:173])
			For ($i_Cargos;1;Size of array:C274($aRecNumCargos))
				GOTO RECORD:C242([ACT_Cargos:173];$aRecNumCargos{$i_Cargos})
				If (([ACT_Cargos:173]Ref_Item:16#-2) & ([ACT_Cargos:173]Saldo:23#0))
					[ACT_Cargos:173]Monto_Vencido:30:=(Abs:C99([ACT_Cargos:173]Monto_Neto:5)-[ACT_Cargos:173]MontosPagados:8)*-1
					SAVE RECORD:C53([ACT_Cargos:173])
				End if 
			End for 
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
			REDUCE SELECTION:C351([ACT_Documentos_de_Cargo:174];0)
			CLEAR SET:C117("CargosVencImpagos")
			GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$recNumAviso)
			[ACT_Avisos_de_Cobranza:124]Monto_A_Pagar_Moneda:16:=ACTut_retornaMontoEnMoneda ([ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;[ACT_Avisos_de_Cobranza:124]Moneda:17;Current date:C33(*);ST_GetWord (ACT_DivisaPais ;1;";"))
			APPEND TO ARRAY:C911($al_idsAvisos2Recalc;Record number:C243([ACT_Avisos_de_Cobranza:124]))
			SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
			
			KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
		End if 
	End if 
	ACTmnu_RecalcularSaldosAvisos (->$al_idsAvisos2Recalc;vdACT_FechaUFSel)  //RCH
End for 