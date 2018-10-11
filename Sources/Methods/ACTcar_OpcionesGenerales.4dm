//%attributes = {}
  //ACTcar_OpcionesGenerales

C_TEXT:C284($vt_accion;$1;$0;$vt_retorno)
C_POINTER:C301(${2})
C_POINTER:C301($ptr1;$ptr2;$ptr3;$ptr4)


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


Case of 
	: ($vt_accion="numeroDecimales")
		Case of 
			: ($ptr1->="UF@")
				$vt_retorno:="11"
			: ($ptr1->#ST_GetWord (ACT_DivisaPais ;1;";"))
				  //$vt_retorno:="4" `producia problemas en en pagos distintos a moneda del colegio y uf, ejemplo pierre faure
				$vt_retorno:="11"
			Else 
				$ignore:=ACTutl_GetDecimalFormat ("Despliegue_ACT")
				$vt_retorno:=String:C10(<>vlACT_Decimales)
		End case 
		
	: ($vt_accion="retornaFormatoXDecimales")
		Case of 
			: ($ptr1->=0)
				$vt_retorno:="|Long"
			: ($ptr1->=1)
				$vt_retorno:="|Real_1Dec"
			: ($ptr1->=2)
				$vt_retorno:="|Real_2Dec"
			: ($ptr1->=3)
				$vt_retorno:="|Real_3Dec"
			Else 
				$vt_retorno:="|Real_4Dec"
		End case 
		
		
	: ($vt_accion="retornaFormato")
		If ($ptr1->="UF@")
			$vt_retorno:="|Despliegue_ACT"
		Else 
			$ignore:=ACTutl_GetDecimalFormat ("Despliegue_ACT")
			Case of 
				: (<>vlACT_Decimales=0)
					$vt_retorno:="|Long"
				: (<>vlACT_Decimales=1)
					$vt_retorno:="|Real_1Dec"
				: (<>vlACT_Decimales=2)
					$vt_retorno:="|Real_2Dec"
				: (<>vlACT_Decimales=3)
					$vt_retorno:="|Real_3Dec"
				: (<>vlACT_Decimales=4)
					$vt_retorno:="|Real_4Dec"
				Else 
					$vt_retorno:="|Despliegue_ACT"
			End case 
		End if 
	: ($vt_accion="pagoMinimo")
		$vt_monedaPago:=ST_GetWord (ACT_DivisaPais ;1;";")
		$dec:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaPago))
		Case of 
			: ($dec=0)
				$vt_retorno:="1"
			: ($dec=1)
				$vt_retorno:="0"+<>tXS_RS_DecimalSeparator+"1"
			: ($dec=2)
				$vt_retorno:="0"+<>tXS_RS_DecimalSeparator+"01"
			: ($dec=3)
				$vt_retorno:="0"+<>tXS_RS_DecimalSeparator+"001"
			: ($dec=4)
				$vt_retorno:="0"+<>tXS_RS_DecimalSeparator+"0001"
			Else 
				$vt_retorno:="0"
		End case 
	: ($vt_accion="ultimaFechaPago")
		READ ONLY:C145([ACT_Transacciones:178])
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=$ptr1->)
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
		ORDER BY:C49([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5;<)
		$ptr2->:=[ACT_Transacciones:178]Fecha:5
	: ($vt_accion="numeroDecimalesDespliegue")
		
		READ ONLY:C145([Colegio:31])
		ALL RECORDS:C47([Colegio:31])
		FIRST RECORD:C50([Colegio:31])
		$vt_retorno:=String:C10([Colegio:31]Numero_Decimales:53)
		
	: ($vt_accion="PGS_eliminaDsctosCargosAsociados")
		
		$l_ejecutado:=1
		
		READ WRITE:C146([ACT_Transacciones:178])
		READ WRITE:C146([ACT_Cargos:173])
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$ptr1->)
		CREATE SET:C116([ACT_Transacciones:178];"tTodas")
		KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-102;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-103)
		CREATE SET:C116([ACT_Cargos:173];"cargos")
		If (Records in selection:C76([ACT_Cargos:173])>0)
			$monto:=Abs:C99([ACT_Cargos:173]Monto_Neto:5)
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			CREATE SET:C116([ACT_Transacciones:178];"transacciones")
			USE SET:C118("tTodas")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8="Pago con Descuento";*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Debito:6=$monto)
			ADD TO SET:C119([ACT_Transacciones:178];"transacciones")
			USE SET:C118("tTodas")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8="Balanceo Descuento";*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Debito:6=$monto)
			If (Records in selection:C76([ACT_Transacciones:178])>0)
				FIRST RECORD:C50([ACT_Transacciones:178])
				$monedaDescuento:=KRL_GetTextFieldData (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]Moneda:28)
				USE SET:C118("tTodas")
				QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8="Pago con Descuento")
				FIRST RECORD:C50([ACT_Transacciones:178])
				While (Not:C34(End selection:C36([ACT_Transacciones:178])))
					KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;True:C214)
					$montoMonedaPago:=ACTcar_CalculaSaldo ("retornaSaldoMonedaPago";[ACT_Transacciones:178]Fecha:5;->[ACT_Transacciones:178]Debito:6;->$monedaDescuento)
					$montoMonedaCargo:=ACTcar_CalculaSaldo ("retornaPagoMonedaCargo";[ACT_Transacciones:178]Fecha:5;->$montoMonedaPago;->[ACT_Cargos:173]Moneda:28)
					[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]Saldo:23+($montoMonedaCargo*-1)
					[ACT_Cargos:173]MontosPagados:8:=[ACT_Cargos:173]MontosPagados:8-$montoMonedaCargo
					[ACT_Cargos:173]MontosPagadosMPago:52:=[ACT_Cargos:173]MontosPagadosMPago:52-$montoMonedaPago
					SAVE RECORD:C53([ACT_Cargos:173])
					NEXT RECORD:C51([ACT_Transacciones:178])
				End while 
			End if 
			USE SET:C118("transacciones")
			KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
			ARRAY LONGINT:C221($al_recNumAvisos;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$al_recNumAvisos;"")
			USE SET:C118("cargos")
			  //20130730 RCH
			  //KRL_DeleteSelection (->[ACT_Cargos];False)
			  //USE SET("transacciones")
			  //KRL_DeleteSelection (->[ACT_Transacciones];False)
			  //For ($i;1;Size of array($al_recNumAvisos))
			  //ACTac_Recalcular ($al_recNumAvisos{$i})
			  //End for 
			$l_ejecutado:=KRL_DeleteSelection (->[ACT_Cargos:173];False:C215)
			If ($l_ejecutado=1)
				USE SET:C118("transacciones")
				$l_ejecutado:=KRL_DeleteSelection (->[ACT_Transacciones:178];False:C215)
				For ($i;1;Size of array:C274($al_recNumAvisos))
					ACTac_Recalcular ($al_recNumAvisos{$i})
				End for 
			End if 
			
		End if 
		READ ONLY:C145([ACT_Transacciones:178])
		READ ONLY:C145([ACT_Transacciones:178])
		SET_ClearSets ("cargos";"transacciones";"tTodas")
		
		$vt_retorno:=String:C10($l_ejecutado)
		
	: ($vt_accion="CargaMonedasCargos")
		C_LONGINT:C283($vl_idCargo;$i)
		For ($i;1;Size of array:C274($ptr1->))
			REDUCE SELECTION:C351([ACT_Cargos:173];0)
			$vl_idCargo:=$ptr1->{$i}
			If (KRL_GetBooleanFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11))
				APPEND TO ARRAY:C911($ptr2->;KRL_GetTextFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]Moneda:28))
			Else 
				APPEND TO ARRAY:C911($ptr2->;ST_GetWord (ACT_DivisaPais ;1;";"))
			End if 
		End for 
		
	: ($vt_accion="CambiaFechaACargosEMitidos")
		TRACE:C157
		C_BLOB:C604($xBlob)
		ARRAY LONGINT:C221($alACT_IdsAvisos;0)
		C_DATE:C307($vd_fechaE;$vd_fechaV)
		
	: ($vt_accion="DeclaraVarsGen")
		C_BOOLEAN:C305(vbACT_CargoEspecial)
		C_REAL:C285(vdACT_AñoAviso)
		C_REAL:C285(bc_EliminaDesctos)
		C_TEXT:C284(vsACT_CtaContable;vsACT_CentroContable;vsACT_CCtaContable;vsACT_CCentroContable;vsACT_CodAuxCta;vsACT_CodAuxCCta)
		C_BOOLEAN:C305(vbACT_ImputacionUNica)
		C_REAL:C285(cbACT_NoDocTrib)
		C_DATE:C307(vdACT_FechaUFSel)
		C_LONGINT:C283(vdACT_AñoAviso2)
		  //atACT_NombreMonedaEm
		  //adACT_fechasEm
		C_BOOLEAN:C305(vbACT_montoAnual)
		C_LONGINT:C283(vlACT_numeroCuotas)
		
	: ($vt_accion="CargaBlobParaGeneracion")
		  //C_BLOB($xBlob)
		  //$xBlob:=$ptr1->
		ACTcar_OpcionesGenerales ("DeclaraVarsGen")
		BLOB_Variables2Blob ($ptr1;0;->aLong1;->b1;->b2;->b3;->vlACT_SelectedMatrixID;->vlACT_selectedItemId;->vsACT_Glosa;->vsACT_Moneda;->vrACT_Monto;->cbACT_EsDescuento;->cbACT_Afecto_IVA;->bc_ReplaceSameDescription;->aMeses;->aMeses2;->viACT_DiaGeneracion;->bc_ExecuteOnServer;->vbACT_CargoEspecial;->vdACT_AñoAviso;->bc_EliminaDesctos;->vsACT_CtaContable;->vsACT_CentroContable;->vsACT_CCtaContable;->vsACT_CCentroContable;->vbACT_ImputacionUNica;->vsACT_CodAuxCta;->vsACT_CodAuxCCta;->cbACT_NoDocTrib;->vdACT_FechaUFSel;->vdACT_AñoAviso2;->atACT_NombreMonedaEm;->adACT_fechasEm;->vbACT_montoAnual;->vlACT_numeroCuotas)
		
	: ($vt_accion="CargaVarsParaGeneracion")
		  //C_BLOB($xBlob)
		  //$xBlob:=$ptr1->
		ACTcar_OpcionesGenerales ("DeclaraVarsGen")
		BLOB_Blob2Vars ($ptr1;0;->aLong1;->b1;->b2;->b3;->vlACT_SelectedMatrixID;->vlACT_selectedItemId;->vsACT_Glosa;->vsACT_Moneda;->vrACT_Monto;->cbACT_EsDescuento;->cbACT_Afecto_IVA;->bc_ReplaceSameDescription;->aMeses;->aMeses2;->viACT_DiaGeneracion;->bc_ExecuteOnServer;->vbACT_CargoEspecial;->vdACT_AñoAviso;->bc_EliminaDesctos;->vsACT_CtaContable;->vsACT_CentroContable;->vsACT_CCtaContable;->vsACT_CCentroContable;->vbACT_ImputacionUNica;->vsACT_CodAuxCta;->vsACT_CodAuxCCta;->cbACT_NoDocTrib;->vdACT_FechaUFSel;->vdACT_AñoAviso2;->atACT_NombreMonedaEm;->adACT_fechasEm;->vbACT_montoAnual;->vlACT_numeroCuotas)
		
	: ($vt_accion="DeclaraVarsEm")
		C_REAL:C285(mAvisoApoderado;mAvisoAlumno)
		C_LONGINT:C283(vdACT_AñoAviso2)
		C_DATE:C307(vdACT_FechaUFSel)
		C_LONGINT:C283(vdACT_DiaVctoAviso)
		  //atACT_NombreMonedaEm
		C_REAL:C285(cbVctoSegunConf)
		C_LONGINT:C283(cb_NoPrepagarAuto)
		  //adACT_fechasEm
		C_BOOLEAN:C305(vbACT_montoAnual)
		C_LONGINT:C283(vlACT_numeroCuotas)
		C_LONGINT:C283(cbUltimoDiaMes)
		C_LONGINT:C283(l_diasEmision)  //20180725 RCH Ticket 206430
		
	: ($vt_accion="CargaBlobParaEmision")
		  //C_BLOB($xBlob)
		  //$xBlob:=$ptr1->
		ACTcar_OpcionesGenerales ("DeclaraVarsEm")
		  //BLOB_Variables2Blob ($ptr1;0;->aLong1;->b1;->b2;->b3;->bHidePrintSettings;->aMeses;->aMeses2;->viACT_DiaGeneracion;->vdACT_FechaAviso;->vdACT_DiaAviso;->bc_ExecuteOnServer;->vs1;->vs2;->Generar;->vdACT_AñoAviso;->atACT_ModelosAviso;->cbIncluirSaldosAnteriores;->mAvisoApoderado;->mAvisoAlumno;->vdACT_AñoAviso2;->vdACT_FechaUFSel;->vdACT_DiaVctoAviso;->atACT_NombreMonedaEm;->cbVctoSegunConf;->cb_NoPrepagarAuto;->adACT_fechasEm;->vbACT_montoAnual;->vlACT_numeroCuotas;->cbUltimoDiaMes)
		BLOB_Variables2Blob ($ptr1;0;->aLong1;->b1;->b2;->b3;->bHidePrintSettings;->aMeses;->aMeses2;->viACT_DiaGeneracion;->vdACT_FechaAviso;->vdACT_DiaAviso;->bc_ExecuteOnServer;->vs1;->vs2;->Generar;->vdACT_AñoAviso;->atACT_ModelosAviso;->cbIncluirSaldosAnteriores;->mAvisoApoderado;->mAvisoAlumno;->vdACT_AñoAviso2;->vdACT_FechaUFSel;->l_diasEmision;->atACT_NombreMonedaEm;->cbVctoSegunConf;->cb_NoPrepagarAuto;->adACT_fechasEm;->vbACT_montoAnual;->vlACT_numeroCuotas;->cbUltimoDiaMes)  //20180725 RCH Ticket 206430
		
	: ($vt_accion="CargaVarsParaEmision")
		  //C_BLOB($xBlob)
		  //$xBlob:=$ptr1->
		ACTcar_OpcionesGenerales ("DeclaraVarsEm")
		  //BLOB_Blob2Vars ($ptr1;0;->aLong1;->b1;->b2;->b3;->bHidePrintSettings;->aMeses;->aMeses2;->viACT_DiaGeneracion;->vdACT_FechaAviso;->vdACT_DiaAviso;->bc_ExecuteOnServer;->vs1;->vs2;->Generar;->vdACT_AñoAviso;->atACT_ModelosAviso;->cbIncluirSaldosAnteriores;->mAvisoApoderado;->mAvisoAlumno;->vdACT_AñoAviso2;->vdACT_FechaUFSel;->vdACT_DiaVctoAviso;->atACT_NombreMonedaEm;->cbVctoSegunConf;->cb_NoPrepagarAuto;->adACT_fechasEm;->vbACT_montoAnual;->vlACT_numeroCuotas;->cbUltimoDiaMes)
		BLOB_Blob2Vars ($ptr1;0;->aLong1;->b1;->b2;->b3;->bHidePrintSettings;->aMeses;->aMeses2;->viACT_DiaGeneracion;->vdACT_FechaAviso;->vdACT_DiaAviso;->bc_ExecuteOnServer;->vs1;->vs2;->Generar;->vdACT_AñoAviso;->atACT_ModelosAviso;->cbIncluirSaldosAnteriores;->mAvisoApoderado;->mAvisoAlumno;->vdACT_AñoAviso2;->vdACT_FechaUFSel;->l_diasEmision;->atACT_NombreMonedaEm;->cbVctoSegunConf;->cb_NoPrepagarAuto;->adACT_fechasEm;->vbACT_montoAnual;->vlACT_numeroCuotas;->cbUltimoDiaMes)  //20180725 RCH Ticket 206430
		
	: ($vt_accion="ObtieneMontoCuota")
		C_LONGINT:C283($vl_totalCuotas;$vl_numCuota;$vl_decimales;$pos)
		C_REAL:C285($vrACT_montoMoneda;$vr_montoMinimo;$vr_montoMensual;$vr_diferencia;$vr_montoCuota)
		C_TEXT:C284($vt_moneda;$vt_montoMinimo)
		
		$vrACT_montoMoneda:=$ptr1->
		$vt_moneda:=$ptr2->
		$vl_totalCuotas:=$ptr3->
		$vl_numCuota:=$ptr4->
		
		$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_moneda))
		$vt_montoMinimo:="0"+<>tXS_RS_DecimalSeparator+("0"*$vl_decimales)
		$vt_montoMinimo:=Substring:C12($vt_montoMinimo;1;Length:C16($vt_montoMinimo)-1)+"1"
		$vr_montoMinimo:=Num:C11($vt_montoMinimo)
		
		$vr_montoMensual:=Trunc:C95(($vrACT_montoMoneda/$vl_totalCuotas);$vl_decimales)
		
		$vr_diferencia:=Trunc:C95($vrACT_montoMoneda-(Trunc:C95($vr_montoMensual*$vl_totalCuotas;$vl_decimales));$vl_decimales)
		ARRAY REAL:C219($arACT_Cuotas;$vl_totalCuotas)
		If ($vr_diferencia>0)
			$pos:=$vl_totalCuotas
			While ($vr_diferencia>0)
				If ($vr_diferencia>$vr_montoMinimo)
					$vr_diferencia:=$vr_diferencia-$vr_montoMinimo
					$arACT_Cuotas{$pos}:=$vr_montoMinimo
				Else 
					$arACT_Cuotas{$pos}:=$vr_diferencia
					$vr_diferencia:=0
				End if 
				$pos:=$pos-1
			End while 
		End if 
		
		If (Size of array:C274($arACT_Cuotas)>=0)
			$vr_montoCuota:=$vr_montoMensual+$arACT_Cuotas{$vl_numCuota}
		Else 
			$vr_montoCuota:=$vr_montoMensual
		End if 
		$vt_retorno:=String:C10($vr_montoCuota)
		
	: ($vt_accion="FiltraYQuitaTransaccionesNC")
		CREATE SET:C116([ACT_Transacciones:178];$ptr1->)
		While (Not:C34(End selection:C36([ACT_Transacciones:178])))
			$found:=Find in field:C653([ACT_Cargos:173]ID:1;[ACT_Transacciones:178]ID_Item:3)
			If ($found#-1)
				GOTO RECORD:C242([ACT_Cargos:173];$found)
				If ([ACT_Transacciones:178]ID_Pago:4#0)
					If (([ACT_Cargos:173]Monto_Neto:5<0) | ([ACT_Transacciones:178]Glosa:8="Pago con Descuento"))
						REMOVE FROM SET:C561([ACT_Transacciones:178];$ptr1->)
					End if 
				End if 
				If ([ACT_Cargos:173]Ref_Item:16=-129)
					REMOVE FROM SET:C561([ACT_Transacciones:178];$ptr1->)
				End if 
			End if 
			NEXT RECORD:C51([ACT_Transacciones:178])
		End while 
		
	: ($vt_accion="FijaMontoMonedaVariableCargo")
		C_LONGINT:C283($vl_idCargo)
		C_TEXT:C284($vt_retorno;$vt_moneda)
		C_REAL:C285($vr_montoNeto;$vrACT_saldo;$vr_montoPagado)
		$vl_idCargo:=$ptr1->
		$vt_retorno:="1"
		$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
		REDUCE SELECTION:C351([ACT_Cargos:173];0)
		KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->$vl_idCargo;True:C214)
		If (([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11) & ($vt_moneda#[ACT_Cargos:173]Moneda:28))
			If (ok=1)
				$vr_montoNeto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
				KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->$vl_idCargo;True:C214)
				$vb_valorFijado:=False:C215
				Case of 
					: ([ACT_Cargos:173]Saldo:23=0)
						[ACT_Cargos:173]Monto_Neto:5:=$vr_montoNeto
						[ACT_Cargos:173]MontosPagados:8:=$vr_montoNeto
						$vb_valorFijado:=True:C214
						
					: ([ACT_Cargos:173]Monto_Neto:5>0)
						$vrACT_saldo:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
						KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->$vl_idCargo;True:C214)
						If ($vrACT_saldo<Num:C11(ACTcar_OpcionesGenerales ("PagoMinimo")))
							[ACT_Cargos:173]Saldo:23:=0
							[ACT_Cargos:173]Monto_Neto:5:=$vr_montoNeto
							[ACT_Cargos:173]MontosPagados:8:=$vr_montoNeto
						Else 
							READ ONLY:C145([ACT_Transacciones:178])
							QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
							QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
							ARRAY LONGINT:C221($alACT_recNumT;0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$alACT_recNumT;"")
							$vr_montoPagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$alACT_recNumT;->[ACT_Transacciones:178]Debito:6)
							
							[ACT_Cargos:173]Monto_Neto:5:=$vr_montoPagado+$vrACT_saldo
							[ACT_Cargos:173]Saldo:23:=$vrACT_saldo
							[ACT_Cargos:173]MontosPagados:8:=$vr_montoPagado
							
						End if 
						$vb_valorFijado:=True:C214
						
				End case 
				If ($vb_valorFijado)
					[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11:=False:C215
					If ([ACT_Cargos:173]TasaIVA:21#0)
						[ACT_Cargos:173]Monto_Bruto:24:=Round:C94([ACT_Cargos:173]Monto_Neto:5/<>vrACT_FactorIVA;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_moneda)))
						[ACT_Cargos:173]TasaIVA:21:=<>vrACT_TasaIVA
						[ACT_Cargos:173]Monto_IVA:20:=Round:C94([ACT_Cargos:173]Monto_Bruto:24*<>vrACT_TasaIVA/100;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_moneda)))
						[ACT_Cargos:173]Monto_Afecto:27:=[ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]Monto_IVA:20
					Else 
						[ACT_Cargos:173]TasaIVA:21:=0
						[ACT_Cargos:173]Monto_Afecto:27:=0
						[ACT_Cargos:173]Monto_IVA:20:=0
						[ACT_Cargos:173]Monto_Bruto:24:=[ACT_Cargos:173]Monto_Neto:5
					End if 
					SAVE RECORD:C53([ACT_Cargos:173])
					
					  //actualizo montos de debito en transacciones
					READ WRITE:C146([ACT_Transacciones:178])
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
					APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]Debito:6:=[ACT_Transacciones:178]MontoMonedaPago:14)
					APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]ValorMoneda:13:=1)
					KRL_UnloadReadOnly (->[ACT_Transacciones:178])
					
				End if 
			Else 
				If (Records in selection:C76([ACT_Cargos:173])=1)
					$vt_retorno:="0"
				End if 
			End if 
		End if 
		KRL_UnloadReadOnly (->[ACT_Cargos:173])
		
	: ($vt_accion="ObtieneTextoDescuento")
		$vt_retorno:=" (descuento de "
		
	: ($vt_accion="CalculaMontosCargo")
		C_TEXT:C284($vt_monedaCargo)
		C_REAL:C285($desctoXItem)
		$vt_monedaCargo:=$ptr1->
		$descuento:=$ptr2->
		$desctoXItem:=$ptr3->
		[ACT_Cargos:173]PctDescuentoAplicado:58:=Round:C94(([ACT_Cargos:173]Descuentos_Familia:26+[ACT_Cargos:173]Descuentos_Ingresos:25+[ACT_Cargos:173]Descuentos_Individual:31+[ACT_Cargos:173]Descuentos_Cargas:51+$desctoXItem)*100/[ACT_Cargos:173]Monto_Neto:5;<>vlACT_decimalesDcto)
		If ([xxACT_Items:179]Afecto_IVA:12)
			[ACT_Cargos:173]Monto_Bruto:24:=Round:C94([ACT_Cargos:173]Monto_Neto:5/<>vrACT_FactorIVA;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
			If (cbCrearDctosEnLineasSeparadas=0)
				If ($descuento>=100)
					$montonetodsctos:=0
				Else 
					$montonetodsctos:=[ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]Descuentos_Familia:26-[ACT_Cargos:173]Descuentos_Ingresos:25-[ACT_Cargos:173]Descuentos_Individual:31-[ACT_Cargos:173]Descuentos_Cargas:51-$desctoXItem
				End if 
			Else 
				$montonetodsctos:=[ACT_Cargos:173]Monto_Neto:5
			End if 
			[ACT_Cargos:173]TasaIVA:21:=<>vrACT_TasaIVA
			$afecto:=$montonetodsctos/<>vrACT_FactorIVA
			[ACT_Cargos:173]Monto_IVA:20:=Round:C94($afecto*<>vrACT_TasaIVA/100;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
			[ACT_Cargos:173]Monto_Neto:5:=$montonetodsctos
			[ACT_Cargos:173]Monto_Afecto:27:=[ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]Monto_IVA:20
		Else 
			[ACT_Cargos:173]TasaIVA:21:=0
			[ACT_Cargos:173]Monto_Afecto:27:=0
			[ACT_Cargos:173]Monto_IVA:20:=0
			[ACT_Cargos:173]Monto_Bruto:24:=[ACT_Cargos:173]Monto_Neto:5
			If (cbCrearDctosEnLineasSeparadas=0)
				If ($descuento>=100)
					[ACT_Cargos:173]Monto_Neto:5:=0
				Else 
					[ACT_Cargos:173]Monto_Neto:5:=[ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]Descuentos_Familia:26-[ACT_Cargos:173]Descuentos_Ingresos:25-[ACT_Cargos:173]Descuentos_Individual:31-[ACT_Cargos:173]Descuentos_Cargas:51-$desctoXItem
				End if 
			End if 
		End if 
		
	: ($vt_accion="CalculaTotalDescuento")
		C_REAL:C285($desctoXItem)
		$desctoXItem:=$ptr1->
		If (cbCrearDctosEnLineasSeparadas=0)
			[ACT_Cargos:173]Total_Desctos:45:=[ACT_Cargos:173]Descuentos_Familia:26+[ACT_Cargos:173]Descuentos_Ingresos:25+[ACT_Cargos:173]Descuentos_Individual:31+[ACT_Cargos:173]Descuentos_Cargas:51+$desctoXItem
		End if 
		
End case 
$0:=$vt_retorno