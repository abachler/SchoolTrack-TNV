//%attributes = {}
  // Método: TGR_ACT_Cargos
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 09:45:00
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)
C_BOOLEAN:C305(<>cbACT_NoRedondear)
C_REAL:C285($vr_decimales)

  // Código principal
  //SNT_ACT_Avisos:=5001
  //SNT_ACT_Cargos:=5002
  //SNT_ACT_Pagos:=5003
  //SNT_MT_Prestamos:=5004

If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[ACT_Cargos:173]DTS_Creacion:48:=DTS_MakeFromDateTime 
			[ACT_Cargos:173]ID:1:=SQ_SeqNumber (->[ACT_Cargos:173]ID:1)
			If ((Current date:C33(*)>[ACT_Cargos:173]Fecha_de_Vencimiento:7) & ([ACT_Cargos:173]Fecha_de_Vencimiento:7#!00-00-00!))
				[ACT_Cargos:173]Monto_Vencido:30:=(Abs:C99([ACT_Cargos:173]Monto_Neto:5)-[ACT_Cargos:173]MontosPagados:8)*-1
			End if 
			
			If (Not:C34(<>cbACT_NoRedondear))
				ACTcfg_ValidaCountryCode 
				If ((<>gCountryCode#"") & ([ACT_Cargos:173]Moneda:28#""))  //20110401 RCH Hay casos en MX en que se redondea a 0 decimal... caso no reproducido...
					If (([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11) & ([ACT_Cargos:173]Moneda:28#ST_GetWord (ACT_DivisaPais ;1;";")))
						$vr_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->[ACT_Cargos:173]Moneda:28))
					Else 
						ACTutl_GetDecimalFormat 
						$vr_decimales:=<>vlACT_Decimales
					End if 
					[ACT_Cargos:173]Descuentos_Cargas:51:=Round:C94([ACT_Cargos:173]Descuentos_Cargas:51;$vr_decimales)
					[ACT_Cargos:173]Descuentos_Familia:26:=Round:C94([ACT_Cargos:173]Descuentos_Familia:26;$vr_decimales)
					[ACT_Cargos:173]Descuentos_Individual:31:=Round:C94([ACT_Cargos:173]Descuentos_Individual:31;$vr_decimales)
					[ACT_Cargos:173]Descuentos_Ingresos:25:=Round:C94([ACT_Cargos:173]Descuentos_Ingresos:25;$vr_decimales)
					[ACT_Cargos:173]Descuentos_XItem:35:=Round:C94([ACT_Cargos:173]Descuentos_XItem:35;$vr_decimales)
					[ACT_Cargos:173]Descuentos_XItemMoneda:37:=Round:C94([ACT_Cargos:173]Descuentos_XItemMoneda:37;$vr_decimales)
					[ACT_Cargos:173]Intereses:29:=Round:C94([ACT_Cargos:173]Intereses:29;$vr_decimales)
					[ACT_Cargos:173]MontosPagados:8:=Round:C94([ACT_Cargos:173]MontosPagados:8;$vr_decimales)
					[ACT_Cargos:173]MontosPagadosMPago:52:=Round:C94([ACT_Cargos:173]MontosPagadosMPago:52;$vr_decimales)
					[ACT_Cargos:173]MontoXPctDescto:36:=Round:C94([ACT_Cargos:173]MontoXPctDescto:36;<>vlACT_decimalesDcto)
					[ACT_Cargos:173]MontoXPctDesctoMoneda:38:=Round:C94([ACT_Cargos:173]MontoXPctDesctoMoneda:38;$vr_decimales)
					[ACT_Cargos:173]Monto_Afecto:27:=Round:C94([ACT_Cargos:173]Monto_Afecto:27;$vr_decimales)
					[ACT_Cargos:173]Monto_Bruto:24:=Round:C94([ACT_Cargos:173]Monto_Bruto:24;$vr_decimales)
					[ACT_Cargos:173]Monto_IVA:20:=Round:C94([ACT_Cargos:173]Monto_IVA:20;$vr_decimales)
					  //[ACT_Cargos]Monto_Moneda:=Round([ACT_Cargos]Monto_Moneda;$vr_decimales)`el monto moneda puede ser con decimales pero emitido en moneda fija sin decimales
					[ACT_Cargos:173]Monto_Neto:5:=Round:C94([ACT_Cargos:173]Monto_Neto:5;$vr_decimales)
					[ACT_Cargos:173]Monto_relativo:6:=Round:C94([ACT_Cargos:173]Monto_relativo:6;<>vlACT_decimalesDcto)
					[ACT_Cargos:173]Monto_Vencido:30:=Round:C94([ACT_Cargos:173]Monto_Vencido:30;$vr_decimales)
					[ACT_Cargos:173]PctDescto_XItem:34:=Round:C94([ACT_Cargos:173]PctDescto_XItem:34;<>vlACT_decimalesDcto)
					[ACT_Cargos:173]Saldo:23:=Round:C94([ACT_Cargos:173]Saldo:23;$vr_decimales)
					[ACT_Cargos:173]TasaIVA:21:=Round:C94([ACT_Cargos:173]TasaIVA:21;$vr_decimales)
					[ACT_Cargos:173]Total_Desctos:45:=Round:C94([ACT_Cargos:173]Total_Desctos:45;$vr_decimales)
					[ACT_Cargos:173]Total_DesctosMoneda:46:=Round:C94([ACT_Cargos:173]Total_DesctosMoneda:46;$vr_decimales)
				End if 
			End if 
			
			ACTcc_CreateUpdateTransaction 
			
			  //SNT_CreaReferencia (SNT_ACT_Cargos;[ACT_Cargos]ID;SNT_Accion_Actualizar )
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[ACT_Cargos:173]DTS_Modificacion:49:=DTS_MakeFromDateTime 
			If ((Current date:C33(*)>[ACT_Cargos:173]Fecha_de_Vencimiento:7) & ([ACT_Cargos:173]Fecha_de_Vencimiento:7#!00-00-00!))
				[ACT_Cargos:173]Monto_Vencido:30:=(Abs:C99([ACT_Cargos:173]Monto_Neto:5)-[ACT_Cargos:173]MontosPagados:8)*-1
			End if 
			C_LONGINT:C283($vl_idT)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_idT)
			READ ONLY:C145([ACT_Transacciones:178])
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If ((Old:C35([ACT_Cargos:173]ID_CuentaCorriente:2)#[ACT_Cargos:173]ID_CuentaCorriente:2) | (Old:C35([ACT_Cargos:173]ID_Apoderado:18)#[ACT_Cargos:173]ID_Apoderado:18) | (Old:C35([ACT_Cargos:173]Mes:13)#([ACT_Cargos:173]Mes:13)) | (Old:C35([ACT_Cargos:173]Año:14)#[ACT_Cargos:173]Año:14) | (Old:C35([ACT_Cargos:173]Monto_Neto:5)#[ACT_Cargos:173]Monto_Neto:5) | (Old:C35([ACT_Cargos:173]Glosa:12)#[ACT_Cargos:173]Glosa:12) | (Old:C35([ACT_Cargos:173]FechaEmision:22)#[ACT_Cargos:173]FechaEmision:22) | (Old:C35([ACT_Cargos:173]ID_Documento_de_Cargo:3)#[ACT_Cargos:173]ID_Documento_de_Cargo:3) | (Old:C35([ACT_Cargos:173]Fecha_de_generacion:4)#[ACT_Cargos:173]Fecha_de_generacion:4) | ($vl_idT=0) | (Old:C35([ACT_Cargos:173]ID_Tercero:54)#[ACT_Cargos:173]ID_Tercero:54))
				ACTcc_CreateUpdateTransaction 
			End if 
			ACTcfg_ValidaCountryCode 
			
			  // >> 20120719 RCH si el cargo queda con saldo inferior al pago minimo se deja en 0
			If ([ACT_Cargos:173]Saldo:23#0)
				If (Abs:C99(ACTcar_CalculaSaldo ("retornaSaldoMonedaPago";Current date:C33(*);->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Moneda:28))<Num:C11(ACTcar_OpcionesGenerales ("pagoMinimo")))
					[ACT_Cargos:173]Saldo:23:=0
				End if 
			End if 
			
			If ((<>gCountryCode#"") & ([ACT_Cargos:173]Moneda:28#""))  //20110401 RCH Hay casos en MX en que se redondea a 0 decimal... caso no reproducido...
				If (Not:C34(<>cbACT_NoRedondear))
					If (([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11) & ([ACT_Cargos:173]Moneda:28#ST_GetWord (ACT_DivisaPais ;1;";")))
						$vr_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->[ACT_Cargos:173]Moneda:28))
					Else 
						ACTutl_GetDecimalFormat 
						$vr_decimales:=<>vlACT_Decimales
					End if 
					[ACT_Cargos:173]Descuentos_Cargas:51:=Round:C94([ACT_Cargos:173]Descuentos_Cargas:51;$vr_decimales)
					[ACT_Cargos:173]Descuentos_Familia:26:=Round:C94([ACT_Cargos:173]Descuentos_Familia:26;$vr_decimales)
					[ACT_Cargos:173]Descuentos_Individual:31:=Round:C94([ACT_Cargos:173]Descuentos_Individual:31;$vr_decimales)
					[ACT_Cargos:173]Descuentos_Ingresos:25:=Round:C94([ACT_Cargos:173]Descuentos_Ingresos:25;$vr_decimales)
					[ACT_Cargos:173]Descuentos_XItem:35:=Round:C94([ACT_Cargos:173]Descuentos_XItem:35;$vr_decimales)
					[ACT_Cargos:173]Descuentos_XItemMoneda:37:=Round:C94([ACT_Cargos:173]Descuentos_XItemMoneda:37;$vr_decimales)
					[ACT_Cargos:173]Intereses:29:=Round:C94([ACT_Cargos:173]Intereses:29;$vr_decimales)
					[ACT_Cargos:173]MontosPagados:8:=Round:C94([ACT_Cargos:173]MontosPagados:8;$vr_decimales)
					[ACT_Cargos:173]MontosPagadosMPago:52:=Round:C94([ACT_Cargos:173]MontosPagadosMPago:52;$vr_decimales)
					[ACT_Cargos:173]MontoXPctDescto:36:=Round:C94([ACT_Cargos:173]MontoXPctDescto:36;$vr_decimales)
					[ACT_Cargos:173]MontoXPctDesctoMoneda:38:=Round:C94([ACT_Cargos:173]MontoXPctDesctoMoneda:38;$vr_decimales)
					[ACT_Cargos:173]Monto_Afecto:27:=Round:C94([ACT_Cargos:173]Monto_Afecto:27;$vr_decimales)
					[ACT_Cargos:173]Monto_Bruto:24:=Round:C94([ACT_Cargos:173]Monto_Bruto:24;$vr_decimales)
					[ACT_Cargos:173]Monto_IVA:20:=Round:C94([ACT_Cargos:173]Monto_IVA:20;$vr_decimales)
					  //[ACT_Cargos]Monto_Moneda:=Round([ACT_Cargos]Monto_Moneda;$vr_decimales)`el monto moneda puede ser con decimales pero emitido en moneda fija sin decimales
					[ACT_Cargos:173]Monto_Neto:5:=Round:C94([ACT_Cargos:173]Monto_Neto:5;$vr_decimales)
					[ACT_Cargos:173]Monto_relativo:6:=Round:C94([ACT_Cargos:173]Monto_relativo:6;<>vlACT_decimalesDcto)
					[ACT_Cargos:173]Monto_Vencido:30:=Round:C94([ACT_Cargos:173]Monto_Vencido:30;$vr_decimales)
					[ACT_Cargos:173]PctDescto_XItem:34:=Round:C94([ACT_Cargos:173]PctDescto_XItem:34;<>vlACT_decimalesDcto)
					[ACT_Cargos:173]Saldo:23:=Round:C94([ACT_Cargos:173]Saldo:23;$vr_decimales)
					[ACT_Cargos:173]TasaIVA:21:=Round:C94([ACT_Cargos:173]TasaIVA:21;$vr_decimales)
					[ACT_Cargos:173]Total_Desctos:45:=Round:C94([ACT_Cargos:173]Total_Desctos:45;$vr_decimales)
					[ACT_Cargos:173]Total_DesctosMoneda:46:=Round:C94([ACT_Cargos:173]Total_DesctosMoneda:46;$vr_decimales)
				End if 
			End if 
			
			  //20130626 RCH NF CANTIDAD
			If ([ACT_Cargos:173]cantidad:65=0)
				[ACT_Cargos:173]cantidad:65:=1
			End if 
			
			  //If (([ACT_Cargos]FechaEmision#Old([ACT_Cargos]FechaEmision)) | ([ACT_Cargos]Fecha_de_Vencimiento#Old([ACT_Cargos]Fecha_de_Vencimiento)) | ([ACT_Cargos]ID_CuentaCorriente#Old([ACT_Cargos]ID_CuentaCorriente)) | ([ACT_Cargos]Glosa#Old([ACT_Cargos]Glosa | ([ACT_Cargos]Moneda#Old([ACT_Cargos]Moneda)) | ([ACT_Cargos]Monto_Neto#Old([ACT_Cargos]Monto_Neto)) | ([ACT_Cargos]Saldo#Old([ACT_Cargos]Saldo)))
			  //SNT_CreaReferencia (SNT_ACT_Cargos;[ACT_Cargos]ID;SNT_Accion_Actualizar )
			  //End if 
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			READ WRITE:C146([ACT_Transacciones:178])
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
			DELETE SELECTION:C66([ACT_Transacciones:178])
			READ ONLY:C145([ACT_Transacciones:178])
			  //SNT_CreaReferencia (SNT_ACT_Cargos;[ACT_Cargos]ID;SNT_Accion_Eliminar )
	End case 
End if 



