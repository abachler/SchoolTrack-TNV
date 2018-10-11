//%attributes = {}
  //ACTpgs_CreaCargoDesctoEspecial
C_BOOLEAN:C305($0)
C_LONGINT:C283($l_idResponsable)  //20170627 RCH
$0:=True:C214

If (vrACT_MontoDescto>0)
	
	C_BOOLEAN:C305($vb_cargoNotaCredito;$vb_tienePrivilegio)
	ARRAY LONGINT:C221(alACT_idsAvisosDctos2Rec;0)
	If (Count parameters:C259>=2)
		$vl_ieDescuentoExento:=$1
		$vl_ieDescuentoAfecto:=$2
		$vb_tienePrivilegio:=True:C214
	Else 
		$vl_ieDescuentoExento:=4
		$vl_ieDescuentoAfecto:=3
		$vb_tienePrivilegio:=USR_GetMethodAcces (Current method name:C684)
	End if 
	If (Count parameters:C259>=3)
		$vl_idCargoRelacionado:=$3
	Else 
		$vl_idCargoRelacionado:=0
	End if 
	  // Modificado por: Saúl Ponce (24-03-2017) Ticket 177232, para pasar el id de la boleta a la que se le efectúa nota de crédito
	If (Count parameters:C259>=4)
		$l_idBoleta:=$4
	Else 
		$l_idBoleta:=0
	End if 
	C_TEXT:C284($vt_monedaConta)
	
	If ($vb_tienePrivilegio)
		ARRAY LONGINT:C221($al_idsAvisos;0)
		ARRAY LONGINT:C221($al_idsDocCargo;0)
		ARRAY LONGINT:C221($al_RNCargos;0)
		$rncta:=Record number:C243([ACT_CuentasCorrientes:175])
		While (vrACT_MontoDesctoExento>0)
			For ($i;1;Size of array:C274(alACT_RecNumsCargos))
				If (vrACT_MontoDesctoExento>0) & (arACT_CMontoNeto{$i}>0)
					If (arACT_MontoIVA{$i}=0)
						ACTcfg_LoadCargosEspeciales ($vl_ieDescuentoExento)
						$vl_idCargo:=alACT_CIdsCargos{$i}
						If (Application version:C493>="11@")
							vb_Modificado_4Dv11:=True:C214
							$recNum:=Find in field:C653([ACT_Cargos:173]ID:1;$vl_idCargo)
						Else 
							  //$recNum:=Find in field([ACT_Cargos]ID;$vl_idCargo)
						End if 
						If ($recNum#-1)
							
							  // Modificado por: Saúl Ponce (24-03-2017) Ticket 177232, determinar el monto del cargo involucrado en la boleta o NC
							GOTO RECORD:C242([ACT_Cargos:173];$recNum)
							$l_idResponsable:=OB Get:C1224(ACTcc_DividirEmision ("ObtieneIdResponsableDesdeCargo";->[ACT_Cargos:173]ID:1);"id_responsable")  //20170627 RCH
							If ($l_idBoleta>0)
								KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$l_idBoleta;False:C215)
								ACTbol_BuscaCargosCargaSet ("$trxCargo";$l_idBoleta)
								GOTO RECORD:C242([ACT_Cargos:173];$recNum)
								$maxDescto:=ACTbol_GetMontoLinea ("$trxCargo")
								CLEAR SET:C117("$trxCargo")
							Else 
								$maxDescto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;vdACT_FechaPago))
							End if 
							
							$vl_idAviso:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
							vbACTpgs_CalcularAvisosArr:=True:C214
							If (Find in array:C230(alACT_idsAvisosDctos2Rec;$vl_idAviso)=-1)
								APPEND TO ARRAY:C911(alACT_idsAvisosDctos2Rec;$vl_idAviso)
							End if 
							
							  // Modificado por: Saúl Ponce (06-01-2017) Ticket Nº 173614 - (ST-CL) Bradford School
							  // para determinar el monto del cargo involucrado en la boleta o NC.
							  //GOTO RECORD([ACT_Cargos];$recNum)
							
							  // Modificado por: Saúl Ponce (08-02-2017) - Ticket Nº 175102 
							  // Cuando se realiza un descuento exento o afecto durante el ingreso de pagos, no existe una boleta cargada
							  // Cuando hay un documento tributario cargado asumo que está siendo llamando para calcular el máximo de descuento desde Notas de Crédito
							  //If (Records in selection([ACT_Boletas])>0)
							  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Item=[ACT_Cargos]ID)
							  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]ID_Pago#0)
							  //CREATE SET([ACT_Transacciones];"trxCargo")
							  //$maxDescto:=ACTbol_GetMontoLinea ("trxCargo")
							  //CLEAR SET("trxCargo")
							  //Else 
							  //  // En caso contrario, calculo el máximo de descuento a partir de lo que falta por pagar del cargo
							  //$maxDescto:=Abs(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos]Saldo;->[ACT_Cargos]Saldo;vdACT_FechaPago))
							  //End if 
							
							  //$vl_idAviso:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo]ID_Documento;->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]No_ComprobanteInterno)
							  //vbACTpgs_CalcularAvisosArr:=True
							  //If (Find in array(alACT_idsAvisosDctos2Rec;$vl_idAviso)=-1)
							  //APPEND TO ARRAY(alACT_idsAvisosDctos2Rec;$vl_idAviso)
							  //End if 
							
							  //GOTO RECORD([ACT_Cargos];$recNum)
							  //$vl_idCta:=[ACT_Cargos]ID_CuentaCorriente
							  //$vl_idAviso:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo]ID_Documento;->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]No_ComprobanteInterno)
							  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]No_ComprobanteInterno=$vl_idAviso)
							  //KRL_RelateSelection (->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]ID_Documento;"")
							  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]ID_CuentaCorriente=$vl_idCta)
							  //$maxDesctoAviso:=Abs(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos]Saldo;->[ACT_Cargos]Saldo;vdACT_FechaPago))
							  //GOTO RECORD([ACT_Cargos];$recNum)
							  //If ([ACT_Cargos]EmitidoSegúnMonedaCargo)
							  //$maxDescto:=Abs(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos]Saldo;->[ACT_Cargos]Saldo;vdACT_FechaPago))
							  //Else 
							  //$maxDescto:=Abs(arACT_CSaldo{$i})
							  //End if 
							  //  //el caso del espiritu santo habian descuentos creados superiores al monto del item
							  //  //por ejemplo, habian 2 cargos por cada aviso pagado. Un cargo era por 100 y un descuento por 95. El apoderado genera un descuento pr 50 (seleccionando todos los avisos a pagar)
							  //If ($maxDescto>$maxDesctoAviso)
							  //vbACTpgs_CalcularAvisosArr:=True
							  //If (Find in array(alACT_idsAvisosDctos2Rec;$vl_idAviso)=-1)
							  //APPEND TO ARRAY(alACT_idsAvisosDctos2Rec;$vl_idAviso)
							  //End if 
							  //$maxDescto:=$maxDesctoAviso
							  //End if 
							
							Case of 
								: (vrACT_MontoDesctoExento>$maxDescto)
									$descto:=$maxDescto*-1
									vrACT_MontoDesctoExento:=vrACT_MontoDesctoExento-$maxDescto
								: (vrACT_MontoDesctoExento=$maxDescto)
									$descto:=$maxDescto*-1
									vrACT_MontoDesctoExento:=0
								: (vrACT_MontoDesctoExento<$maxDescto)
									$descto:=vrACT_MontoDesctoExento*-1
									vrACT_MontoDesctoExento:=0
							End case 
							$vl_IdApoderado:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]ID_Apoderado:18)
							$vl_idTercero:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]ID_Tercero:54)
							$vl_mes:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]Mes:13)
							$vl_agno:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]Año:14)
							$vd_fechaGeneracion:=KRL_GetDateFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]Fecha_de_generacion:4)
							$vd_fechaVencimiento:=KRL_GetDateFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]Fecha_de_Vencimiento:7)
							$vd_fechaEmision:=KRL_GetDateFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]FechaEmision:22)
							$vl_idRazon:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]ID_RazonSocial:57)
							$vt_nombreRazon:=KRL_GetTextFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]RazonSocialAsociada:56)
							
							CREATE RECORD:C68([ACT_Cargos:173])
							[ACT_Cargos:173]ID_CuentaCorriente:2:=alACT_CIDCtaCte{$i}
							[ACT_Cargos:173]ID_Apoderado:18:=$vl_IdApoderado
							[ACT_Cargos:173]ID_Documento_de_Cargo:3:=alACT_CIdDctoCargo{$i}
							[ACT_Cargos:173]ID_Tercero:54:=$vl_idTercero
							[ACT_Cargos:173]Mes:13:=$vl_mes
							[ACT_Cargos:173]Año:14:=$vl_agno
							[ACT_Cargos:173]Fecha_de_generacion:4:=$vd_fechaGeneracion
							
							[ACT_Cargos:173]Glosa:12:=[xxACT_Items:179]Glosa:2
							[ACT_Cargos:173]Ref_Item:16:=[xxACT_Items:179]ID:1
							
							  // Modificado por: Saúl Ponce (09-12-2016)
							$vt_monedaConta:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;<>vtACT_monedaPais)
							
							  //[ACT_Cargos]No_de_Cuenta_contable:=[xxACT_Items]No_de_Cuenta_Contable
							  //[ACT_Cargos]No_CCta_contable:=[xxACT_Items]No_CCta_contable
							  //[ACT_Cargos]Centro_de_costos:=[xxACT_Items]Centro_de_Costos
							  //[ACT_Cargos]CCentro_de_costos:=[xxACT_Items]CCentro_de_costos
							  //[ACT_Cargos]Centro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CC")  //20131015 RCH
							  //[ACT_Cargos]CCentro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CCC")  //20131015 RCH
							  //[ACT_Cargos]CodAuxCta:=[xxACT_Items]CodAuxCta
							  //[ACT_Cargos]CodAuxCCta:=[xxACT_Items]CodAuxCCta
							
							[ACT_Cargos:173]No_de_Cuenta_contable:17:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CTA";$vt_monedaConta)
							[ACT_Cargos:173]Centro_de_costos:15:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CC";$vt_monedaConta)
							[ACT_Cargos:173]CodAuxCta:43:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CA";$vt_monedaConta)
							[ACT_Cargos:173]No_CCta_contable:39:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCTA";$vt_monedaConta)
							[ACT_Cargos:173]CCentro_de_costos:40:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCC";$vt_monedaConta)
							[ACT_Cargos:173]CodAuxCCta:44:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCA";$vt_monedaConta)
							
							
							[ACT_Cargos:173]No_Incluir_en_DocTrib:50:=[xxACT_Items:179]No_incluir_en_DocTributario:31
							
							[ACT_Cargos:173]Fecha_de_Vencimiento:7:=$vd_fechaVencimiento
							  //[ACT_Cargos]LastInterestsUpdate:=$vd_fechaVencimiento
							[ACT_Cargos:173]FechaEmision:22:=$vd_fechaEmision
							[ACT_Cargos:173]LastInterestsUpdate:42:=ACTcar_FechaCalculoIntereses ("ObtieneFecha";->[ACT_Cargos:173]FechaEmision:22;->[ACT_Cargos:173]Fecha_de_Vencimiento:7)  //20140825 RCH Intereses
							[ACT_Cargos:173]Moneda:28:=ST_GetWord (ACT_DivisaPais ;1;";")
							[ACT_Cargos:173]Monto_Neto:5:=$descto
							[ACT_Cargos:173]Monto_Moneda:9:=$descto
							[ACT_Cargos:173]Descuento_Especial:33:=True:C214
							[ACT_Cargos:173]Saldo:23:=$descto*-1
							[ACT_Cargos:173]RazonSocialAsociada:56:=$vt_nombreRazon
							[ACT_Cargos:173]ID_RazonSocial:57:=$vl_idRazon
							[ACT_Cargos:173]ID_CargoRelacionado:47:=$vl_idCargoRelacionado
							If ($l_idResponsable>0)
								OB SET:C1220([ACT_Cargos:173]OB_Responsable:70;"id_responsable";$l_idResponsable)  //20170627 RCH
							End if 
							SAVE RECORD:C53([ACT_Cargos:173])
							
							  //pagos en arreglos
							APPEND TO ARRAY:C911($al_RNCargos;Record number:C243([ACT_Cargos:173]))
							
							READ WRITE:C146([ACT_Transacciones:178])
							QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
							If ([ACT_Transacciones:178]No_Comprobante:10=0)
								[ACT_Transacciones:178]No_Comprobante:10:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
							End if 
							SAVE RECORD:C53([ACT_Transacciones:178])
							
							APPEND TO ARRAY:C911($al_idsAvisos;alACT_CIdsAvisos{$i})
							APPEND TO ARRAY:C911($al_idsDocCargo;alACT_CIdDctoCargo{$i})
							  //End if 
							If (vrACT_MontoDesctoExento=0)
								$i:=Size of array:C274(alACT_RecNumsCargos)
							End if 
						End if 
					End if 
				End if 
			End for 
			KRL_UnloadReadOnly (->[ACT_Transacciones:178])
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
			
			If (vrACT_MontoDesctoExento>0)
				LOG_RegisterEvt ("Durante el ingreso de pagos para el apoderado "+[Personas:7]Apellidos_y_nombres:30+", el descuento ingresado no pudo ser aplicado completamente. Faltó por aplicar un"+" monto de: "+String:C10(vrACT_MontoDesctoExento)+".")
				vrACT_MontoDesctoExento:=0
				$0:=False:C215
			End if 
			
		End while 
		While (vrACT_MontoDesctoAfecto>0)
			For ($i;1;Size of array:C274(alACT_RecNumsCargos))
				If (vrACT_MontoDesctoAfecto>0) & (arACT_CMontoNeto{$i}>0)
					If (arACT_MontoIVA{$i}#0)
						ACTcfg_LoadCargosEspeciales ($vl_ieDescuentoAfecto)
						$vl_idCargo:=alACT_CIdsCargos{$i}
						If (Application version:C493>="11@")
							vb_Modificado_4Dv11:=True:C214
							$recNum:=Find in field:C653([ACT_Cargos:173]ID:1;$vl_idCargo)
						Else 
							  //$recNum:=Find index key([ACT_Cargos]ID;$vl_idCargo)
						End if 
						If ($recNum#-1)
							
							  // Modificado por: Saúl Ponce (24-03-2017) Ticket 177232, determinar el monto del cargo involucrado en la boleta o NC
							GOTO RECORD:C242([ACT_Cargos:173];$recNum)
							$l_idResponsable:=OB Get:C1224(ACTcc_DividirEmision ("ObtieneIdResponsableDesdeCargo";->[ACT_Cargos:173]ID:1);"id_responsable")  //20170627 RCH
							If ($l_idBoleta>0)
								KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$l_idBoleta;False:C215)
								ACTbol_BuscaCargosCargaSet ("$trxCargo";$l_idBoleta)
								GOTO RECORD:C242([ACT_Cargos:173];$recNum)
								$maxDescto:=ACTbol_GetMontoLinea ("$trxCargo")
								CLEAR SET:C117("$trxCargo")
							Else 
								$maxDescto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;vdACT_FechaPago))
							End if 
							
							$vl_idAviso:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
							vbACTpgs_CalcularAvisosArr:=True:C214
							If (Find in array:C230(alACT_idsAvisosDctos2Rec;$vl_idAviso)=-1)
								APPEND TO ARRAY:C911(alACT_idsAvisosDctos2Rec;$vl_idAviso)
							End if 
							
							  // Modificado por: Saúl Ponce (06-01-2017) Ticket Nº 173614 - (ST-CL) Bradford School
							  // para determinar el monto del cargo involucrado en la boleta o NC.
							  //GOTO RECORD([ACT_Cargos];$recNum)
							
							  // Modificado por: Saúl Ponce (08-02-2017) - Ticket Nº 175102 
							  // Cuando se realiza un descuento exento o afecto durante el ingreso de pagos, no existe una boleta cargada
							  // Cuando hay un documento tributario cargado asumo que está siendo llamando para calcular el máximo de descuento desde Notas de Crédito
							  //If (Records in selection([ACT_Boletas])>0)
							  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Item=[ACT_Cargos]ID)
							  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]ID_Pago#0)
							  //CREATE SET([ACT_Transacciones];"trxCargo")
							  //$maxDescto:=ACTbol_GetMontoLinea ("trxCargo")
							  //CLEAR SET("trxCargo")
							  //Else 
							  //  // En caso contrario, calculo el máximo de descuento a partir de lo que falta por pagar del cargo
							  //$maxDescto:=Abs(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos]Saldo;->[ACT_Cargos]Saldo;vdACT_FechaPago))
							  //End if 
							
							  //$vl_idAviso:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo]ID_Documento;->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]No_ComprobanteInterno)
							  //vbACTpgs_CalcularAvisosArr:=True
							  //If (Find in array(alACT_idsAvisosDctos2Rec;$vl_idAviso)=-1)
							  //APPEND TO ARRAY(alACT_idsAvisosDctos2Rec;$vl_idAviso)
							  //End if 
							
							  //GOTO RECORD([ACT_Cargos];$recNum)
							  //$vl_idCta:=[ACT_Cargos]ID_CuentaCorriente
							  //$vl_idAviso:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo]ID_Documento;->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]No_ComprobanteInterno)
							  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]No_ComprobanteInterno=$vl_idAviso)
							  //KRL_RelateSelection (->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]ID_Documento;"")
							  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]ID_CuentaCorriente=$vl_idCta)
							  //$maxDesctoAviso:=Abs(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos]Saldo;->[ACT_Cargos]Saldo;vdACT_FechaPago))
							  //GOTO RECORD([ACT_Cargos];$recNum)
							  //If ([ACT_Cargos]EmitidoSegúnMonedaCargo)
							  //$maxDescto:=Abs(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos]Saldo;->[ACT_Cargos]Saldo;vdACT_FechaPago))
							  //Else 
							  //$maxDescto:=Abs(arACT_CSaldo{$i})
							  //End if 
							  //  //el caso del espiritu santo habian descuentos creados superiores al monto del item
							  //  //por ejemplo, habian 2 cargos por cada aviso pagado. Un cargo era por 100 y un descuento por 95. El apoderado genera un descuento pr 50 (seleccionando todos los avisos a pagar)
							  //If ($maxDescto>$maxDesctoAviso)
							  //vbACTpgs_CalcularAvisosArr:=True
							  //If (Find in array(alACT_idsAvisosDctos2Rec;$vl_idAviso)=-1)
							  //APPEND TO ARRAY(alACT_idsAvisosDctos2Rec;$vl_idAviso)
							  //End if 
							  //$maxDescto:=$maxDesctoAviso
							  //End if 
							
							Case of 
								: (vrACT_MontoDesctoAfecto>$maxDescto)
									$descto:=$maxDescto*-1
									vrACT_MontoDesctoAfecto:=vrACT_MontoDesctoAfecto-$maxDescto
								: (vrACT_MontoDesctoAfecto=$maxDescto)
									$descto:=$maxDescto*-1
									vrACT_MontoDesctoAfecto:=0
								: (vrACT_MontoDesctoAfecto<$maxDescto)
									$descto:=vrACT_MontoDesctoAfecto*-1
									vrACT_MontoDesctoAfecto:=0
							End case 
							$vl_IdApoderado:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]ID_Apoderado:18)
							$vl_idTercero:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]ID_Tercero:54)
							$vl_mes:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]Mes:13)
							$vl_agno:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]Año:14)
							$vd_fechaGeneracion:=KRL_GetDateFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]Fecha_de_generacion:4)
							$vd_fechaVencimiento:=KRL_GetDateFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]Fecha_de_Vencimiento:7)
							$vd_fechaEmision:=KRL_GetDateFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]FechaEmision:22)
							$vl_idRazon:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]ID_RazonSocial:57)
							$vt_nombreRazon:=KRL_GetTextFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]RazonSocialAsociada:56)
							
							CREATE RECORD:C68([ACT_Cargos:173])
							[ACT_Cargos:173]ID_CuentaCorriente:2:=alACT_CIDCtaCte{$i}
							[ACT_Cargos:173]ID_Apoderado:18:=$vl_IdApoderado
							[ACT_Cargos:173]ID_Documento_de_Cargo:3:=alACT_CIdDctoCargo{$i}
							[ACT_Cargos:173]ID_Tercero:54:=$vl_idTercero
							[ACT_Cargos:173]Mes:13:=$vl_mes
							[ACT_Cargos:173]Año:14:=$vl_agno
							[ACT_Cargos:173]Fecha_de_generacion:4:=$vd_fechaGeneracion
							
							[ACT_Cargos:173]Glosa:12:=[xxACT_Items:179]Glosa:2
							[ACT_Cargos:173]Ref_Item:16:=[xxACT_Items:179]ID:1
							
							  // Modificado por: Saúl Ponce (09-12-2016)
							$vt_monedaConta:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;<>vtACT_monedaPais)
							
							  //[ACT_Cargos]No_de_Cuenta_contable:=[xxACT_Items]No_de_Cuenta_Contable
							  //[ACT_Cargos]No_CCta_contable:=[xxACT_Items]No_CCta_contable
							  //[ACT_Cargos]Centro_de_costos:=[xxACT_Items]Centro_de_Costos
							  //[ACT_Cargos]CCentro_de_costos:=[xxACT_Items]CCentro_de_costos
							  //[ACT_Cargos]Centro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CC")  //20131015 RCH
							  //[ACT_Cargos]CCentro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CCC")  //20131015 RCH
							  //[ACT_Cargos]CodAuxCta:=[xxACT_Items]CodAuxCta
							  //[ACT_Cargos]CodAuxCCta:=[xxACT_Items]CodAuxCCta
							
							[ACT_Cargos:173]No_de_Cuenta_contable:17:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CTA";$vt_monedaConta)
							[ACT_Cargos:173]Centro_de_costos:15:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CC";$vt_monedaConta)
							[ACT_Cargos:173]CodAuxCta:43:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CA";$vt_monedaConta)
							[ACT_Cargos:173]No_CCta_contable:39:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCTA";$vt_monedaConta)
							[ACT_Cargos:173]CCentro_de_costos:40:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCC";$vt_monedaConta)
							[ACT_Cargos:173]CodAuxCCta:44:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCA";$vt_monedaConta)
							
							[ACT_Cargos:173]No_Incluir_en_DocTrib:50:=[xxACT_Items:179]No_incluir_en_DocTributario:31
							
							[ACT_Cargos:173]Fecha_de_Vencimiento:7:=$vd_fechaVencimiento
							  //[ACT_Cargos]LastInterestsUpdate:=$vd_fechaVencimiento
							[ACT_Cargos:173]FechaEmision:22:=$vd_fechaEmision
							[ACT_Cargos:173]LastInterestsUpdate:42:=ACTcar_FechaCalculoIntereses ("ObtieneFecha";->[ACT_Cargos:173]FechaEmision:22;->[ACT_Cargos:173]Fecha_de_Vencimiento:7)  //20140825 RCH Intereses
							[ACT_Cargos:173]Moneda:28:=ST_GetWord (ACT_DivisaPais ;1;";")
							[ACT_Cargos:173]Monto_Neto:5:=$descto
							[ACT_Cargos:173]TasaIVA:21:=<>vrACT_TasaIVA
							[ACT_Cargos:173]Monto_IVA:20:=Round:C94([ACT_Cargos:173]Monto_Neto:5*<>vrACT_TasaIVA/100;<>vlACT_Decimales)
							[ACT_Cargos:173]Monto_Afecto:27:=[ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]Monto_IVA:20
							[ACT_Cargos:173]Monto_Moneda:9:=$descto
							[ACT_Cargos:173]Descuento_Especial:33:=True:C214
							[ACT_Cargos:173]Saldo:23:=$descto*-1
							[ACT_Cargos:173]RazonSocialAsociada:56:=$vt_nombreRazon
							[ACT_Cargos:173]ID_RazonSocial:57:=$vl_idRazon
							[ACT_Cargos:173]ID_CargoRelacionado:47:=$vl_idCargoRelacionado
							If ($l_idResponsable>0)
								OB SET:C1220([ACT_Cargos:173]OB_Responsable:70;"id_responsable";$l_idResponsable)  //20170627 RCH
							End if 
							SAVE RECORD:C53([ACT_Cargos:173])
							
							  //pagos en arreglos
							APPEND TO ARRAY:C911($al_RNCargos;Record number:C243([ACT_Cargos:173]))
							
							READ WRITE:C146([ACT_Transacciones:178])
							QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
							If ([ACT_Transacciones:178]No_Comprobante:10=0)
								[ACT_Transacciones:178]No_Comprobante:10:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
							End if 
							SAVE RECORD:C53([ACT_Transacciones:178])
							
							APPEND TO ARRAY:C911($al_idsAvisos;alACT_CIdsAvisos{$i})
							APPEND TO ARRAY:C911($al_idsDocCargo;alACT_CIdDctoCargo{$i})
							
							If (vrACT_MontoDesctoAfecto=0)
								$i:=Size of array:C274(alACT_RecNumsCargos)
							End if 
						End if 
					End if 
				End if 
			End for 
			KRL_UnloadReadOnly (->[ACT_Transacciones:178])
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
			
			If (vrACT_MontoDesctoAfecto>0)
				LOG_RegisterEvt ("Durante el ingreso de pagos para el apoderado "+[Personas:7]Apellidos_y_nombres:30+", el descuento ingresado no pudo ser aplicado completamente. Faltó por aplicar un"+" monto de: "+String:C10(vrACT_MontoDesctoAfecto;"|Despliegue_ACT_Pagos")+".")
				vrACT_MontoDesctoAfecto:=0
				$0:=False:C215
			End if 
			
		End while 
		If ($rncta#-1)
			GOTO RECORD:C242([ACT_CuentasCorrientes:175];$rncta)
		End if 
		  //pagos en arreglos
		For ($x;1;Size of array:C274($al_RNCargos))
			ACTpgs_AppendCarToArray ($al_RNCargos{$x})
		End for 
		AT_DistinctsArrayValues (->$al_idsAvisos)
		AT_DistinctsArrayValues (->$al_idsDocCargo)
		For ($x;1;Size of array:C274($al_idsDocCargo))
			$vl_idDoc:=$al_idsDocCargo{$x}
			KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->$vl_idDoc)
			If (Record number:C243([ACT_Documentos_de_Cargo:174])#-1)
				ACTcc_CalculaDocumentoCargo (Record number:C243([ACT_Documentos_de_Cargo:174]))
			End if 
		End for 
		
		If (($vl_ieDescuentoExento=4) | ($vl_ieDescuentoAfecto=3))
			For ($x;1;Size of array:C274($al_idsAvisos))
				$vl_idAviso:=$al_idsAvisos{$x}
				KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$vl_idAviso)
				If (Record number:C243([ACT_Avisos_de_Cobranza:124])#-1)
					ACTac_Recalcular (Record number:C243([ACT_Avisos_de_Cobranza:124]);vdACT_FechaPago)
				End if 
			End for 
		End if 
		
		  //se inicializan variables utilizadas
		vbACTpgs_CalcularAvisosArr:=False:C215
		ARRAY LONGINT:C221(alACT_idsAvisosDctos2Rec;0)
		
	End if 
End if 