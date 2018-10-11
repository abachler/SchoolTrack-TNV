Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		C_REAL:C285(vr_montoDevolucion;vr_MaxPago;vr_montoDuplicacion)
		C_REAL:C285(vr_MaxExento;vr_MaxAfecto;vr_MaxIVA;vr_MaxDevolucion;vr_MaxDuplicacion;vr_MaxDuplicacionA;vr_MaxDuplicacionE)
		C_REAL:C285(vr_montoExento;vr_montoAfecto;vr_montoIVA;vr_montoTotal)
		C_LONGINT:C283(cs_generarDevolución)
		C_LONGINT:C283(vl_idApdo;vl_idTercero;vl_idRazonSocial)
		
		  // Modificado por: Saùl Ponce (27-07-2017) Ticket Nº 184256
		C_LONGINT:C283(vl_idApdoOriginal;vl_idTerceroOriginal)
		C_DATE:C307(vd_fechaDcto)
		C_TEXT:C284(vt_fechaDcto;vt_detalleNC;vt_refRazon)
		ARRAY LONGINT:C221($al_recNumsTransacciones;0)
		ARRAY TEXT:C222(atACT_DetallesNCT2;0)
		C_BOOLEAN:C305(vb_documentElectronico)
		C_TEXT:C284(t_monedaDT)  //20161020 RCH
		
		  //duplica deuda
		C_REAL:C285(cs_duplicarDeuda;cs_duplicarDeudaMontoOriginal)
		
		ARRAY LONGINT:C221(alACTpgs_Avisos2Recalc;0)
		
		ARRAY TEXT:C222(atACT_referencia;0)
		ACTdte_GeneraArchivo ("CodigosDeReferencia";->atACT_referencia)
		
		ACTbol_OpcionesDuplicacionNC ("DeclaraArreglosGuardaItemMonto")
		ACTbol_SeleccionItemsNC ("DeclaraArreglos")
		
		vr_montoExento:=0
		vr_montoAfecto:=0
		vr_montoIVA:=0
		vr_montoTotal:=0
		
		vr_MaxExento:=0
		vr_MaxAfecto:=0
		vr_MaxIVA:=0
		vr_MaxDevolucion:=0
		cs_generarDevolución:=0
		vr_montoDevolucion:=0
		vr_MaxPago:=0
		vt_Observacion:=""
		vr_MaxDuplicacion:=0
		  //vr_MaxDuplicacionA:=0
		  //vr_MaxDuplicacionE:=0
		vr_montoDuplicacion:=0
		vr_montoItemIncluirAfecto:=0
		vr_montoItemIncluirExento:=0
		
		$recNum:=Record number:C243([ACT_Boletas:181])
		READ ONLY:C145([ACT_Transacciones:178])
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
		CREATE SET:C116([ACT_Transacciones:178];"Transacciones")
		
		READ ONLY:C145([Personas:7])
		READ ONLY:C145([ACT_Terceros:138])
		vl_idApdo:=[ACT_Boletas:181]ID_Apoderado:14
		vl_idTercero:=[ACT_Boletas:181]ID_Tercero:21
		vl_idRazonSocial:=[ACT_Boletas:181]ID_RazonSocial:25
		
		  // Modificado por: Saúl Ponce (27-07-2017) Ticket Nº 184256, Por si necesito conocer los valores más tarde al crear NC
		vl_idApdoOriginal:=[ACT_Boletas:181]Receptor_Id_Apdo_org:44
		vl_idTerceroOriginal:=[ACT_Boletas:181]Receptor_Id_Tercero_org:45
		
		  // Modificado por: Saúl Ponce (27-07-2017) Ticket Nº 184256, Para manejar las creación de NC a personas diferentes a las que ingresaron el pago. 
		Case of 
			: ([ACT_Boletas:181]Receptor_Id_Apdo_org:44>0)
				vl_idApdo:=[ACT_Boletas:181]Receptor_Id_Apdo_org:44
				vl_idTercero:=0
				
			: ([ACT_Boletas:181]Receptor_Id_Tercero_org:45>0)
				vl_idTercero:=[ACT_Boletas:181]Receptor_Id_Tercero_org:45
				vl_idApdo:=0
				
			Else 
				vl_idApdo:=[ACT_Boletas:181]ID_Apoderado:14
				vl_idTercero:=[ACT_Boletas:181]ID_Tercero:21
		End case 
		
		vb_documentElectronico:=[ACT_Boletas:181]documento_electronico:29
		
		KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->vl_idApdo)
		KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->vl_idTercero)
		
		OBJECT SET VISIBLE:C603(*;"vn@";False:C215)
		OBJECT SET VISIBLE:C603(*;"ID@";False:C215)
		OBJECT SET VISIBLE:C603(*;"labelTercero@";False:C215)
		If ([Personas:7]No:1>0)
			OBJECT SET VISIBLE:C603(*;"vn@";True:C214)
			OBJECT SET VISIBLE:C603(*;"ID@";True:C214)
			PP_SetIdentificadorPrincipal 
		Else 
			If (vl_idTercero>0)
				OBJECT SET VISIBLE:C603(*;"labelTercero@";True:C214)
				vApellidosyNombresT:=[ACT_Terceros:138]Nombre_Completo:9
				ACTter_SetIdentificador (->vt_labelIdentificador;->valorIdentificador)
				If ((vt_labelIdentificador="RUT") & (Num:C11(Substring:C12(valorIdentificador;1;Length:C16(valorIdentificador)-1))>0))
					OBJECT SET FORMAT:C236(valorIdentificador;"##.###.###-#")
				End if 
			End if 
		End if 
		
		$recNum:=Record number:C243([ACT_Boletas:181])
		If (([ACT_Boletas:181]ID_DctoAsociado:19=0) & ([ACT_Boletas:181]Referencia_TipoDocumento:37=""))  //es un documento tributario no nc o no nd
			vl_NumDctoAsociado:=[ACT_Boletas:181]Numero:11
			vl_idDocumentoAsociado:=[ACT_Boletas:181]ID:1
			vt_detalleNC:=""
			vt_refRazon:=""
			
			t_monedaDT:=[ACT_Boletas:181]Moneda:53  //20161020 RCH
			
			AT_Initialize (->atACT_DetallesNCT2)
			
			  //quito los descuentos de la lista de cargos
			For ($I;Size of array:C274(al_recNumsCargos);1;-1)
				GOTO RECORD:C242([ACT_Cargos:173];al_recNumsCargos{$I})
				If ([ACT_Cargos:173]Monto_Neto:5<0)
					AT_Delete ($i;1;->al_recNumsCargos)
				End if 
			End for 
			
			C_BOOLEAN:C305($b_montoEnMoneda)  //20161025 RCH
			For ($I;1;Size of array:C274(al_recNumsCargos))
				GOTO RECORD:C242([ACT_Cargos:173];al_recNumsCargos{$I})
				GOTO RECORD:C242([ACT_Boletas:181];$recNum)
				$b_montoEnMoneda:=Choose:C955([ACT_Boletas:181]Moneda:53="";False:C215;([ACT_Boletas:181]Moneda:53#<>vtACT_monedaPais))  //20161021 RCH 
				  //$vr_montoCargo:=ACTbol_GetMontoLinea ("Transacciones")
				$vr_montoCargo:=ACTbol_GetMontoLinea ("Transacciones";True:C214)  //20170513 RCH
				If ([ACT_Cargos:173]TasaIVA:21>0)
					vr_MaxAfecto:=vr_MaxAfecto+$vr_montoCargo
				Else 
					vr_MaxExento:=vr_MaxExento+$vr_montoCargo
				End if 
				$vt_set:="Transacciones"
				  //$vr_monto:=ACTtra_CalculaMontos ("CalculaDesctoAsociado";->$vt_set;->[ACT_Cargos]ID)
				$vr_monto:=ACTtra_CalculaMontos ("CalculaDesctoAsociado";->$vt_set;->[ACT_Cargos:173]ID:1;->$b_montoEnMoneda)
				GOTO RECORD:C242([ACT_Cargos:173];al_recNumsCargos{$I})
				$vr_montoCargo:=$vr_montoCargo-$vr_monto
				If ([ACT_Cargos:173]TasaIVA:21>0)
					vr_MaxAfecto:=vr_MaxAfecto-$vr_monto
				Else 
					vr_MaxExento:=vr_MaxExento-$vr_monto
				End if 
				
				  //20120502 RCH Se guarda para duplicar cargos.
				USE SET:C118("Transacciones")
				QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
				QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Pago con Descuento")
				$vr_montoCargoOrg:=Round:C94(Sum:C1([ACT_Transacciones:178]Debito:6);4)
				ACTbol_OpcionesDuplicacionNC ("GuardaItemMonto";->$vr_montoCargo;->$vr_montoCargoOrg)
				
				  //20140311 ASM Para seleccionar los items a incluir al emitir notas de crédito.
				ACTbol_SeleccionItemsNC ("GuardaItemMontoNotaCredito";->$vr_montoCargo)
				
			End for 
			
			CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];al_recNumsCargos;"")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Moneda:28#ST_GetWord (ACT_DivisaPais ;1;";"))
			If (Records in selection:C76([ACT_Cargos:173])>0)
				OBJECT SET VISIBLE:C603(*;"duplicarDeuda7";True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*;"duplicarDeuda7";False:C215)
			End if 
			
			GOTO RECORD:C242([ACT_Boletas:181];$recNum)
			$vr_MaxAfecto:=vr_MaxAfecto/<>vrACT_FactorIVA
			
			  //20120814 RCH Se estaba redondeando no a la moeda pais
			  //vr_MaxIVA:=Round($vr_MaxAfecto*<>vrACT_TasaIVA/100;Num(ACTcar_OpcionesGenerales ("numeroDecimales";->[ACT_Cargos]Moneda)))
			  //vr_MaxAfecto:=Round(vr_MaxAfecto-vr_MaxIVA;Num(ACTcar_OpcionesGenerales ("numeroDecimales";->[ACT_Cargos]Moneda)))
			$vt_monedaPais:=ST_GetWord (ACT_DivisaPais ;1;";")
			vr_MaxIVA:=Round:C94($vr_MaxAfecto*<>vrACT_TasaIVA/100;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaPais)))
			vr_MaxAfecto:=Round:C94(vr_MaxAfecto-vr_MaxIVA;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaPais)))
			
			CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];al_recNumsCargos;"")
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			CREATE SET:C116([ACT_Transacciones:178];"TransaccionesCargos")
			INTERSECTION:C121("Transacciones";"TransaccionesCargos";"Transacciones")
			USE SET:C118("Transacciones")
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumsTransacciones;"")
			CLEAR SET:C117("TransaccionesCargos")
			
			USE SET:C118("Transacciones")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4>0)
			CREATE SET:C116([ACT_Transacciones:178];"Transacciones")
			
			For ($I;1;Size of array:C274(al_recNumsCargos))
				GOTO RECORD:C242([ACT_Cargos:173];al_recNumsCargos{$I})
				vr_MaxPago:=vr_MaxPago+ACTbol_GetMontoLinea ("Transacciones")
			End for 
			CLEAR SET:C117("Transacciones")
			vd_fechaDcto:=Current date:C33(*)
			vd_fechaDctoOrg:=vd_fechaDcto
			atACT_referencia:=0
			
			OBJECT SET ENTERABLE:C238(*;"boleta@";True:C214)
			OBJECT SET VISIBLE:C603(*;"NumDcto@";False:C215)
			_O_ENABLE BUTTON:C192(btn_Generar)
			OBJECT SET VISIBLE:C603(*;"obj_devolucion@";True:C214)
			_O_ENABLE BUTTON:C192(bCalendar1)
		Else 
			If ([ACT_Boletas:181]ID_DctoAsociado:19#0)
				KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->[ACT_Boletas:181]ID_DctoAsociado:19)
				vl_NumDctoAsociado:=[ACT_Boletas:181]Numero:11
			Else 
				vl_NumDctoAsociado:=Num:C11([ACT_Boletas:181]Referencia_FolioDocumento:38)
			End if 
			vr_MaxExento:=0
			vr_MaxAfecto:=0
			vr_MaxIVA:=0
			GOTO RECORD:C242([ACT_Boletas:181];$recNum)
			vl_numDoc:=[ACT_Boletas:181]Numero:11
			vr_montoExento:=[ACT_Boletas:181]Monto_Total:6-[ACT_Boletas:181]Monto_IVA:5-[ACT_Boletas:181]Monto_Afecto:4
			vr_montoAfecto:=[ACT_Boletas:181]Monto_Afecto:4
			vr_montoIVA:=[ACT_Boletas:181]Monto_IVA:5
			vr_montoTotal:=[ACT_Boletas:181]Monto_Total:6
			vd_fechaDcto:=[ACT_Boletas:181]FechaEmision:3
			atACT_referencia:=[ACT_Boletas:181]codigo_referencia:31
			vt_Observacion:=[ACT_Boletas:181]Observacion:18
			
			vt_detalleNC:=[ACT_Boletas:181]Detalle_NC:35
			vt_refRazon:=[ACT_Boletas:181]Referencia_Razon:40
			
			t_monedaDT:=[ACT_Boletas:181]Moneda:53  //20161020 RCH
			
			$l_offSet:=BLOB_Blob2Vars (->[ACT_Boletas:181]xDetalleNC:41;0;->atACT_DetallesNCT2)
			
			OBJECT SET ENTERABLE:C238(*;"boleta@";False:C215)
			OBJECT SET VISIBLE:C603(*;"NumDcto@";True:C214)
			_O_DISABLE BUTTON:C193(btn_Generar)
			OBJECT SET VISIBLE:C603(*;"obj_devolucion@";False:C215)
			_O_DISABLE BUTTON:C193(bCalendar1)
		End if 
		  //vt_fechaDcto:=String(vd_fechaDcto)
		vt_fechaDcto:=String:C10(DT_GetDateFromDayMonthYear (Day of:C23(vd_fechaDcto);Month of:C24(vd_fechaDcto);Year of:C25(vd_fechaDcto)))
		vr_MaxDevolucion:=0
		IT_SetEnterable ((cs_generarDevolución=1);0;->vr_montoDevolucion)
		
		vr_montoExento:=vr_MaxExento
		vr_montoAfecto:=vr_MaxAfecto
		vr_montoIVA:=vr_MaxIVA
		vr_montoTotal:=vr_montoExento+vr_montoAfecto+vr_montoIVA
		If (vr_montoTotal<=vr_MaxPago)
			vr_MaxDevolucion:=vr_montoTotal
		Else 
			vr_MaxDevolucion:=vr_MaxPago
		End if 
		  //vr_MaxDuplicacionA:=vr_montoAfecto+vr_montoIVA
		  //vr_MaxDuplicacionE:=vr_montoExento
		  //vr_MaxDuplicacion:=vr_montoTotal
		
		cs_duplicarDeuda:=0
		cs_duplicarDeudaMontoOriginal:=0
		  //20120502 RCH Se llenan arreglos del listbox para duplicar cargos
		ACTbol_OpcionesDuplicacionNC ("SeteaListBox")
		ACTbol_OpcionesDuplicacionNC ("CalculaMontoDuplicacion")
		ACTbol_SeleccionItemsNC ("CargaArreglosNotaDeCredito")
		
		OBJECT SET ENABLED:C1123(*;"duplicarDeuda7";(cs_duplicarDeuda=1))
		OBJECT SET VISIBLE:C603(*;"vt_msjMoneda";(cs_duplicarDeudaMontoOriginal=0))
		
		OBJECT SET VISIBLE:C603(*;"duplicarDeuda@";([ACT_Boletas:181]ID_DctoAsociado:19=0))
		C_TEXT:C284(vt_msjMoneda)
		vt_msjMoneda:=__ ("Los montos serán emitidos en la moneda: ")+ST_GetWord (ACT_DivisaPais ;1;";")
		
		  //OBJECT SET VISIBLE(*;"referencia_cod2_@";((atACT_referencia=2) & vb_documentElectronico))
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		If ([ACT_Boletas:181]ID_DctoAsociado:19=0)
			$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
			  // Modificado por: Saúl Ponce (18/01/2018) Ticket Nº 197420, quedaba con una diferencia de $1, no dejaba emitir NC. Alteraba los valores totales.
			  // vr_montoIVA:=Round(vr_montoAfecto*(<>vrACT_TasaIVA/100);Num(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_moneda)))
			  //If (True)
			If (vr_montoAfecto=vr_MaxAfecto)  // 20180130 RCH Ticket 198339. No se calculaba correctamente el IVA cuando se modificaba el monto afecto
				C_REAL:C285($vr_montoTotalAfectos)
				$vr_montoTotalAfectos:=0
				For ($y;1;Size of array:C274(abACT_ItemsSeleccionado))
					If (abACT_ItemsSeleccionado{$y})
						If (abACT_Afecto{$y})
							$vr_montoTotalAfectos:=(ar_MontoIvaCargoSel{$y}+$vr_montoTotalAfectos)
						End if 
					End if 
				End for 
				vr_montoIVA:=$vr_montoTotalAfectos
			Else 
				vr_montoIVA:=Round:C94(vr_montoAfecto*(<>vrACT_TasaIVA/100);Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_moneda)))
			End if 
			
			
			  //20130625 RCH
			If (vr_montoIVA>vr_MaxIVA)
				vr_montoIVA:=vr_MaxIVA
			End if 
			vr_montoTotal:=vr_montoExento+vr_montoAfecto+vr_montoIVA
			IT_SetEnterable ((cs_generarDevolución=1);0;->vr_montoDevolucion)
			If (vr_montoTotal<=vr_MaxPago)
				vr_MaxDevolucion:=vr_montoTotal
			Else 
				vr_MaxDevolucion:=vr_MaxPago
			End if 
			  //vr_MaxDuplicacionA:=vr_montoAfecto+vr_montoIVA
			  //vr_MaxDuplicacionE:=vr_montoExento
			  //vr_MaxDuplicacion:=vr_montoTotal
			
			C_BOOLEAN:C305(vbACT_calculaMontoDup)
			If (vbACT_calculaMontoDup)
				ACTbol_OpcionesDuplicacionNC ("CalculaMontoDuplicacion")
				vbACT_calculaMontoDup:=False:C215
			End if 
			
			OBJECT SET ENABLED:C1123(*;"duplicarDeuda7";(cs_duplicarDeuda=1))
			cs_duplicarDeudaMontoOriginal:=Choose:C955((cs_duplicarDeuda=0);0;cs_duplicarDeudaMontoOriginal)
			
			OBJECT SET VISIBLE:C603(*;"vt_msjMoneda";(cs_duplicarDeudaMontoOriginal=0))
			
		End if 
End case 