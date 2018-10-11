//%attributes = {}
  //ACTmnu_calculaMontoRecargoXA

  //$1 fecha
  //$2 calcular al entrar TRUE-> SI; FALSE -> NO
C_BOOLEAN:C305($2;$vb_entrandoAPagos)
C_DATE:C307($1;$vd_date;$fechaVencimiento;$fechaPago2;$fechaPago3;$fechaPago4)
C_LONGINT:C283($vl_rNDctoCargo;$rnAviso)
$vd_date:=$1
$vb_entrandoAPagos:=$2
ACTcfg_LoadConfigData (1)
ACTcfg_pctsXFechaPago (2)
ACTcfg_LoadCargosEspeciales (2)

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([ACT_Documentos_de_Cargo:174])

ARRAY LONGINT:C221(al_rNCargosRA;0)
ARRAY LONGINT:C221(al_idRefItemRA;0)

$set:="$RecordSet_Table"+String:C10(Table:C252(->[ACT_Avisos_de_Cobranza:124]))

Case of 
	: ($vb_entrandoAPagos)
		If (Records in set:C195($set)>0)
			USE SET:C118($set)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];$set+"_TempIE")
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
			SELECTION TO ARRAY:C260([ACT_Cargos:173];al_rNCargosRA;[ACT_Cargos:173]Ref_Item:16;al_idRefItemRA)
			
			al_idRefItemRA{0}:=vl_idIE  //el id del ítem de recargo por adelantado cargado en ACTpgs_LoadCargosEspeciales(2)
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->al_idRefItemRA;"=";->$DA_Return)
			For ($i;1;Size of array:C274($DA_Return))
				READ WRITE:C146([ACT_Cargos:173])
				GOTO RECORD:C242([ACT_Cargos:173];al_rNCargosRA{$DA_Return{$i}})
				  //If ([ACT_Cargos]Monto_Neto=vr_montoIE)
				  //If ([ACT_Cargos]Monto_Neto=Abs([ACT_Cargos]Saldo))
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
				$vl_rNDctoCargo:=Record number:C243([ACT_Documentos_de_Cargo:174])
				QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
				$rnAviso:=Record number:C243([ACT_Avisos_de_Cobranza:124])
				$fechaVencimiento:=[ACT_Cargos:173]Fecha_de_Vencimiento:7
				$fechaPago2:=ACTut_fFechaValida ($fechaVencimiento+viACT_DiaVencimiento2)
				$fechaPago3:=ACTut_fFechaValida ($fechaPago2+viACT_DiaVencimiento3)
				$fechaPago4:=ACTut_fFechaValida ($fechaPago3+viACT_DiaVencimiento4)
				Case of 
					: ($vd_date<=$fechaVencimiento)
						[ACT_Cargos:173]Monto_Neto:5:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)*(vr_pctXFechaPago1/100))
						[ACT_Cargos:173]Monto_Bruto:24:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)*(vr_pctXFechaPago1/100))
						[ACT_Cargos:173]Monto_Moneda:9:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)*(vr_pctXFechaPago1/100))
						[ACT_Cargos:173]Saldo:23:=([ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]MontosPagados:8)*-1
						[ACT_Cargos:173]MontosPagados:8:=[ACT_Cargos:173]MontosPagados:8
					: ($vd_date<=$fechaPago2)
						[ACT_Cargos:173]Monto_Neto:5:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)*(vr_pctXFechaPago2/100))
						[ACT_Cargos:173]Monto_Bruto:24:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)*(vr_pctXFechaPago2/100))
						[ACT_Cargos:173]Monto_Moneda:9:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)*(vr_pctXFechaPago2/100))
						[ACT_Cargos:173]Saldo:23:=([ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]MontosPagados:8)*-1
						[ACT_Cargos:173]MontosPagados:8:=[ACT_Cargos:173]MontosPagados:8
					: ($vd_date<=$fechaPago3)
						[ACT_Cargos:173]Monto_Neto:5:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)*(vr_pctXFechaPago3/100))
						[ACT_Cargos:173]Monto_Bruto:24:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)*(vr_pctXFechaPago3/100))
						[ACT_Cargos:173]Monto_Moneda:9:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)*(vr_pctXFechaPago3/100))
						[ACT_Cargos:173]Saldo:23:=([ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]MontosPagados:8)*-1
						[ACT_Cargos:173]MontosPagados:8:=[ACT_Cargos:173]MontosPagados:8
					: ($vd_date<=$fechaPago4)
						[ACT_Cargos:173]Monto_Neto:5:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)*(vr_pctXFechaPago4/100))
						[ACT_Cargos:173]Monto_Bruto:24:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)*(vr_pctXFechaPago4/100))
						[ACT_Cargos:173]Monto_Moneda:9:=ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)-(ACTut_retornaValorEnMoneda (1;[ACT_Cargos:173]Monto_Moneda:9;[ACT_Cargos:173]Moneda:28;$vd_date)*(vr_pctXFechaPago4/100))
						[ACT_Cargos:173]Saldo:23:=([ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]MontosPagados:8)*-1
						[ACT_Cargos:173]MontosPagados:8:=[ACT_Cargos:173]MontosPagados:8
					Else   //no se descuenta si paga después de la última fecha 
						
				End case 
				SAVE RECORD:C53([ACT_Cargos:173])
				$el:=ACTcc_CalculaDocumentoCargo ($vl_rNDctoCargo)
				ACTac_Recalcular ($rnAviso)
				  //End if 
			End for 
		End if 
		
	: (Not:C34($vb_entrandoAPagos))
		If (Records in set:C195($set+"_TempIE")>0)
			USE SET:C118($set+"_TempIE")
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Saldo#0)
			SELECTION TO ARRAY:C260([ACT_Cargos:173];al_rNCargosRA;[ACT_Cargos:173]Ref_Item:16;al_idRefItemRA)
			
			al_idRefItemRA{0}:=vl_idIE  //el id del ítem de recargo por adelantado cargado en ACTpgs_LoadCargosEspeciales(2)
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->al_idRefItemRA;"=";->$DA_Return)
			For ($i;1;Size of array:C274($DA_Return))
				READ WRITE:C146([ACT_Cargos:173])
				GOTO RECORD:C242([ACT_Cargos:173];al_rNCargosRA{$DA_Return{$i}})
				If ([ACT_Cargos:173]Monto_Neto:5#vr_montoIE)
					QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
					$vl_rNDctoCargo:=Record number:C243([ACT_Documentos_de_Cargo:174])
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
					$rnAviso:=Record number:C243([ACT_Avisos_de_Cobranza:124])
					[ACT_Cargos:173]Monto_Neto:5:=ACTut_retornaValorEnMoneda (1;vr_montoIE;[ACT_Cargos:173]Moneda:28;$vd_date)
					[ACT_Cargos:173]Monto_Bruto:24:=ACTut_retornaValorEnMoneda (1;vr_montoIE;[ACT_Cargos:173]Moneda:28;$vd_date)
					[ACT_Cargos:173]Monto_Moneda:9:=vr_montoIE
					[ACT_Cargos:173]Saldo:23:=([ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]MontosPagados:8)*-1
					[ACT_Cargos:173]MontosPagados:8:=[ACT_Cargos:173]MontosPagados:8
					
					SAVE RECORD:C53([ACT_Cargos:173])
					$el:=ACTcc_CalculaDocumentoCargo ($vl_rNDctoCargo)
					ACTac_Recalcular ($rnAviso)
				End if 
			End for 
			CLEAR SET:C117($set+"_TempIE")
		End if 
End case 
AT_Initialize (->al_rNCargosRA;->al_idRefItemRA)
KRL_UnloadReadOnly (->[ACT_Cargos:173])