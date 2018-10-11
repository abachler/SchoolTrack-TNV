//%attributes = {}
  //ACTpgs_CalculaDesctoRXA

C_TEXT:C284($1;$vt_accion)
C_REAL:C285($vr_montoDcto;$vr_montoNeto;$0;$vr_retorno)
C_LONGINT:C283($vl_idAviso)
C_DATE:C307($vd_date;$fechaPago2;$fechaPago3;$fechaPago4)
C_POINTER:C301($ptr;$ptr1;$ptr2;$ptr3)

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

Case of 
	: ($vt_accion="CalculaDescto")
		ACTcfg_LoadCargosEspeciales (2)
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		READ ONLY:C145([ACT_Documentos_de_Cargo:174])
		If (Size of array:C274(alACT_CRefs)>0)
			alACT_CRefs{0}:=vl_idIE  //el id del ítem de recargo por adelantado cargado en ACTpgs_LoadCargosEspeciales(2)
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->alACT_CRefs;"=";->$DA_Return)
			For ($i;1;Size of array:C274($DA_Return))
				$vl_index:=$DA_Return{$i}
				ACTpgs_CalculaDesctoRXA ("CalculaDctoEnArreglos";->$vl_index;$ptr1)
			End for 
		End if 
		
	: ($vt_accion="CalculaDctoEnArreglos")
		$vl_idCargo:=alACT_CIdsCargos{$ptr1->}
		$vr_montoDcto:=ACTpgs_CalculaDesctoRXA ("RetornaDescuento";->$vl_idCargo;$ptr2)
		$vr_montoNeto:=arACT_CMontoNeto{$ptr1->}
		$vr_MontoMoneda:=arACT_CMontoNeto{$ptr1->}
		$vr_saldo:=Abs:C99(arACT_CSaldo{$ptr1->})
		arACT_CMontoNeto{$ptr1->}:=ACTut_retornaMontoEnMoneda (arACT_CMontoNeto{$ptr1->};atACT_MonedaCargo{$ptr1->};$vd_date;ST_GetWord (ACT_DivisaPais ;1;";"))-$vr_montoDcto
		arACT_MontoMoneda{$ptr1->}:=arACT_CMontoNeto{$ptr1->}
		arACT_CSaldo{$ptr1->}:=(arACT_CMontoNeto{$ptr1->}-arACT_MontoPagado{$ptr1->})*-1
		ACTpgs_SimboloMoneda 
		$el:=Find in array:C230(alACT_AIDAviso;alACT_CIdsAvisos{$ptr1->})
		If ($el>0)
			arACT_AMontoNeto{$el}:=(arACT_AMontoNeto{$el}-$vr_montoNeto)+arACT_CMontoNeto{$ptr1->}
			arACT_AMontoMoneda{$el}:=(arACT_AMontoMoneda{$el}-$vr_MontoMoneda)+arACT_MontoMoneda{$ptr1->}
			arACT_AMontoaPagar{$el}:=(arACT_AMontoaPagar{$el}-$vr_saldo)+Abs:C99(arACT_CSaldo{$ptr1->})
		End if 
		
	: ($vt_accion="RetornaDescuento")
		C_LONGINT:C283($vl_idItem)
		ACTcfg_pctsXFechaPago (2)
		$vl_idItem:=$ptr1->
		$vl_idAviso:=KRL_GetNumericFieldData (->[ACT_Transacciones:178]ID_Item:3;->$vl_idItem;->[ACT_Transacciones:178]No_Comprobante:10)
		$fechaVencimiento:=KRL_GetDateFieldData (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$vl_idAviso;->[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
		$fechaPago2:=KRL_GetDateFieldData (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$vl_idAviso;->[ACT_Avisos_de_Cobranza:124]Fecha_Pago2:18)
		$fechaPago3:=KRL_GetDateFieldData (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$vl_idAviso;->[ACT_Avisos_de_Cobranza:124]Fecha_Pago3:19)
		$fechaPago4:=KRL_GetDateFieldData (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$vl_idAviso;->[ACT_Avisos_de_Cobranza:124]Fecha_Pago4:20)
		
		vr_pctXDefecto:=0
		Case of 
			: ($ptr2-><=$fechaVencimiento)
				$ptr:=->vr_pctXFechaPago1
			: ($ptr2-><=$fechaPago2)
				$ptr:=->vr_pctXFechaPago2
			: ($ptr2-><=$fechaPago3)
				$ptr:=->vr_pctXFechaPago3
			: ($ptr2-><=$fechaPago4)
				$ptr:=->vr_pctXFechaPago4
			Else 
				$ptr:=->vr_pctXDefecto
		End case 
		$vt_monedaCargo:=KRL_GetTextFieldData (->[ACT_Cargos:173]ID:1;->$vl_idItem;->[ACT_Cargos:173]Moneda:28)
		$vr_montoNeto:=ACTut_retornaMontoEnMoneda (KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$vl_idItem;->[ACT_Cargos:173]Monto_Neto:5);$vt_monedaCargo;$ptr2->;ST_GetWord (ACT_DivisaPais ;1;";"))
		$vr_montoDcto:=$vr_montoNeto*($ptr->/100)
		$vr_retorno:=Round:C94($vr_montoDcto;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
		
	: ($vt_accion="ActualizaRegistrosAntesDelPago")
		ACTcfg_LoadCargosEspeciales (2)
		READ WRITE:C146([ACT_Cargos:173])
		GOTO RECORD:C242([ACT_Cargos:173];$ptr1->)
		If ([ACT_Cargos:173]Ref_Item:16=vl_idIE)
			$vr_montoDcto:=ACTpgs_CalculaDesctoRXA ("RetornaDescuento";->[ACT_Cargos:173]ID:1;$ptr2)
			READ WRITE:C146([ACT_Cargos:173])
			GOTO RECORD:C242([ACT_Cargos:173];$ptr1->)
			[ACT_Cargos:173]Monto_Neto:5:=[ACT_Cargos:173]Monto_Neto:5-$vr_montoDcto
			[ACT_Cargos:173]Monto_Moneda:9:=[ACT_Cargos:173]Monto_Neto:5
			[ACT_Cargos:173]Saldo:23:=([ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]MontosPagados:8)*-1
			[ACT_Cargos:173]Total_Desctos:45:=$vr_montoDcto
			SAVE RECORD:C53([ACT_Cargos:173])
		End if 
		KRL_UnloadReadOnly (->[ACT_Cargos:173])
		
	: ($vt_accion="ActualizaRegistrosDespuesDelPago")
		ACTcfg_LoadCargosEspeciales (2)
		READ WRITE:C146([ACT_Cargos:173])
		GOTO RECORD:C242([ACT_Cargos:173];$ptr1->)
		If ([ACT_Cargos:173]Ref_Item:16=vl_idIE)
			If ([ACT_Cargos:173]Saldo:23#0)
				[ACT_Cargos:173]Monto_Neto:5:=[ACT_Cargos:173]Monto_Neto:5+[ACT_Cargos:173]Total_Desctos:45
				[ACT_Cargos:173]Monto_Moneda:9:=[ACT_Cargos:173]Monto_Neto:5
				[ACT_Cargos:173]Saldo:23:=([ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]MontosPagados:8)*-1
				[ACT_Cargos:173]Total_Desctos:45:=0
				SAVE RECORD:C53([ACT_Cargos:173])
			End if 
		End if 
		KRL_UnloadReadOnly (->[ACT_Cargos:173])
		
	: ($vt_accion="EliminaPago")
		KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;$ptr1;True:C214)
		If (ok=1)
			ACTcfg_LoadCargosEspeciales (2)
			If ([ACT_Cargos:173]Ref_Item:16=vl_idIE)
				C_LONGINT:C283($vl_var1)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_var1)
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
				QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9#0)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($vl_var1=0)
					[ACT_Cargos:173]Monto_Neto:5:=[ACT_Cargos:173]Monto_Neto:5+[ACT_Cargos:173]Total_Desctos:45
					[ACT_Cargos:173]Saldo:23:=([ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]MontosPagados:8)*-1
					[ACT_Cargos:173]Total_Desctos:45:=0
					SAVE RECORD:C53([ACT_Cargos:173])
				End if 
			End if 
		End if 
		KRL_UnloadReadOnly (->[ACT_Cargos:173])
		$vr_retorno:=ok
		
	: ($vt_accion="ActualizaRegistrosDespuesDelPagoSinSaldo")
		For ($i;$ptr2->+1;Size of array:C274($ptr1->))
			ACTcfg_LoadCargosEspeciales (2)
			READ WRITE:C146([ACT_Cargos:173])
			GOTO RECORD:C242([ACT_Cargos:173];$ptr1->{$i})
			If ([ACT_Cargos:173]Ref_Item:16=vl_idIE)
				$vr_montoDcto:=ACTpgs_CalculaDesctoRXA ("RetornaDescuento";->[ACT_Cargos:173]ID:1;$ptr3)
				READ WRITE:C146([ACT_Cargos:173])
				GOTO RECORD:C242([ACT_Cargos:173];$ptr1->{$i})
				If (([ACT_Cargos:173]Monto_Neto:5-$vr_montoDcto)=0)
					[ACT_Cargos:173]Monto_Neto:5:=[ACT_Cargos:173]Monto_Neto:5-$vr_montoDcto
					[ACT_Cargos:173]Monto_Moneda:9:=[ACT_Cargos:173]Monto_Neto:5
					[ACT_Cargos:173]Saldo:23:=([ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]MontosPagados:8)*-1
					[ACT_Cargos:173]Total_Desctos:45:=$vr_montoDcto
					SAVE RECORD:C53([ACT_Cargos:173])
				End if 
			End if 
			If ([ACT_Cargos:173]Saldo:23#0)
				$i:=Size of array:C274($ptr1->)
			End if 
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
		End for 
		
	: ($vt_accion="ValidaMontoRXA")
		C_LONGINT:C283($vl_registros)
		ACTcfg_LoadCargosEspeciales (2)
		READ ONLY:C145([ACT_Documentos_de_Cargo:174])
		READ ONLY:C145([ACT_Cargos:173])
		QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=$ptr1->)
		KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_registros)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=vl_idIE)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($vl_registros>0)
			$vr_montoPagado:=Sum:C1([ACT_Cargos:173]MontosPagados:8)
			If ($vr_montoPagado=0)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=vl_idIE)
				ARRAY LONGINT:C221($al_idsCargos;0)
				SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$al_idsCargos)
				For ($i;1;Size of array:C274($al_idsCargos))
					$vl_idCargo:=$al_idsCargos{$i}
					$vr_retorno:=ACTpgs_CalculaDesctoRXA ("EliminaPago";->$vl_idCargo)
				End for 
			End if 
		End if 
		
End case 

$0:=$vr_retorno