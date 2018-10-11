//%attributes = {}
  //ACTac_Prepagar

  //REGISTRO DE CAMBIOS
  //20080331 RCH Se agrega un tercer parámetro al método para que pueda ser llamado desde la pestaña pagos.
  //cuando se pase un tercer parámetro el método mostrará una ventana de selección de avisos y cargos para el apoderado del pago
C_TEXT:C284($vt_nomPersona)
C_REAL:C285($pago;$vr_deuda;$vr_saldoPago)
C_REAL:C285($montoTransaccion)
C_BOOLEAN:C305($2;$PrepagoPostPago;$seleccionarPrepago)
C_REAL:C285($vr_saldoPago)
C_LONGINT:C283($vl_idPago)
C_REAL:C285(cbImprimirRecPago)
C_LONGINT:C283(cbImprimirBoletas)
C_LONGINT:C283($vl_idPago)
C_BOOLEAN:C305($vb_cancelarIngresoPago)
C_LONGINT:C283($cb_NoPrepagarAuto)  //20140624 RCH Se maneja 5o parametro para soportar preferencia al emitir A.C.

cbImprimirBoletas:=0
cbImprimirRecPago:=0

$RNAviso:=$1
$PrepagoPostPago:=False:C215
$seleccionarPrepago:=False:C215
$r:=1
$cb_NoPrepagarAuto:=cb_NoPrepagarAuto
Case of 
	: (Count parameters:C259=2)
		$PrepagoPostPago:=$2
	: (Count parameters:C259=3)
		$PrepagoPostPago:=$2
		$seleccionarPrepago:=$3
	: (Count parameters:C259=4)
		$PrepagoPostPago:=$2
		$seleccionarPrepago:=$3
		$vl_idPago:=$4
	: (Count parameters:C259=5)
		$PrepagoPostPago:=$2
		$seleccionarPrepago:=$3
		$vl_idPago:=$4
		$cb_NoPrepagarAuto:=$5
End case 

If (($cb_NoPrepagarAuto=0) | ($seleccionarPrepago))
	
	CREATE EMPTY SET:C140([ACT_Transacciones:178];"PonleBoleta")
	READ WRITE:C146([ACT_Cargos:173])
	READ WRITE:C146([ACT_Documentos_de_Cargo:174])
	READ WRITE:C146([ACT_Pagos:172])
	If (Not:C34($seleccionarPrepago))
		GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$RNAviso)
		SET QUERY LIMIT:C395(1)
		QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
		SET QUERY LIMIT:C395(0)
		If ([ACT_Avisos_de_Cobranza:124]ID_Tercero:26=0)
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[ACT_Documentos_de_Cargo:174]ID_Apoderado:12;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0;*)
		Else 
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Tercero:26=[ACT_Documentos_de_Cargo:174]ID_Tercero:24;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0;*)
		End if 
		If (Not:C34($PrepagoPostPago))
			Case of 
				: (vlACT_PagosCta=1)
					If ([ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2#0)
						QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_CtaCte:21=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
					Else 
						QUERY:C277([ACT_Pagos:172])
					End if 
				: (vlACT_PagosApdo=1)
					QUERY:C277([ACT_Pagos:172])
			End case 
		Else 
			If (cb_OcupaSaldos=0)
				Case of 
					: (vlACT_PagosCta=1)
						If ([ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2#0)
							QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_CtaCte:21=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
						Else 
							QUERY:C277([ACT_Pagos:172])
						End if 
					Else 
						QUERY:C277([ACT_Pagos:172])
				End case 
			Else 
				QUERY:C277([ACT_Pagos:172])
			End if 
		End if 
	Else 
		READ ONLY:C145([Personas:7])
		READ ONLY:C145([ACT_Transacciones:178])
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Pagos:172]ID_Apoderado:3)
		QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=[ACT_Pagos:172]ID_Tercero:26)
		  //20111114 RCH Se comenta codigo porque no encontre para que servia cargar los avisos de cobranza....
		  //Case of 
		  //: (vlACT_PagosCta=1)
		  //If ([ACT_Pagos]ID_CtaCte#0)
		  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_CuentaCorriente=[ACT_Pagos]ID_CtaCte)
		  //KRL_RelateSelection (->[ACT_Avisos_de_Cobranza]ID_Aviso;->[ACT_Transacciones]No_Comprobante;"")
		  //ORDER BY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_CuentaCorrriente;<)
		  //QUERY SELECTION([ACT_Pagos];[ACT_Pagos]ID_CtaCte=[ACT_Avisos_de_Cobranza]ID_CuentaCorrriente)
		  //End if 
		  //End case 
		If (Records in selection:C76([ACT_Pagos:172])>0)
			ACTpgs_LimpiaVarsInterfaz ("InitVarsApdoCtaTer")
			$pagoTercero:=[ACT_Pagos:172]ID_Tercero:26
			KRL_ReloadInReadWriteMode (->[ACT_Pagos:172])
			vdACT_FechaPago:=[ACT_Pagos:172]Fecha:2
			vdACT_FechaUF:=vdACT_FechaPago
			PUSH RECORD:C176([ACT_Pagos:172])
			If ((cb_PermitePorCta=1) & (cbDatosCta=1))
				READ ONLY:C145([ACT_CuentasCorrientes:175])
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[ACT_Pagos:172]ID_Apoderado:3)
				
				  // ASM 20141117 ticket 138503
				If ([ACT_Pagos:172]ID_CtaCte:21#0)
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Pagos:172]ID_CtaCte:21)
				End if 
				
				ORDER BY:C49([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Saldo_Ejercicio:21;<)
				RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
				  //ACTpgs_CargaDatosPagoCta (False;vdACT_FechaPago)
				  //20111213 RCH se agregan parametros para que cargue la deuda a pesar de que el disponible sea mayor a la deuda...
				ACTpgs_CargaDatosPagoCta (False:C215;vdACT_FechaPago;0;0;!00-00-00!;True:C214)
				$vt_nomPersona:=[Personas:7]Apellidos_y_nombres:30
			Else 
				If ($pagoTercero=0)
					RNApdo:=Record number:C243([Personas:7])
					  //ACTpgs_CargaDatosPagoApdo (False;vdACT_FechaPago)
					  //20111213 RCH se agregan parametros para que cargue la deuda a pesar de que el disponible sea mayor a la deuda...
					ACTpgs_CargaDatosPagoApdo (False:C215;vdACT_FechaPago;0;0;!00-00-00!;True:C214)
					$vt_nomPersona:=[Personas:7]Apellidos_y_nombres:30
				Else 
					RNTercero:=Record number:C243([ACT_Terceros:138])
					  //ACTpgs_CargaDatosPagoTercero (False;vdACT_FechaPago)
					  //20111213 RCH se agregan parametros para que cargue la deuda a pesar de que el disponible sea mayor a la deuda...
					ACTpgs_CargaDatosPagoTercero (False:C215;vdACT_FechaPago;0;0;!00-00-00!;True:C214)
					$vt_nomPersona:=[ACT_Terceros:138]Nombre_Completo:9
				End if 
			End if 
			READ WRITE:C146([ACT_Pagos:172])
			POP RECORD:C177([ACT_Pagos:172])
			ONE RECORD SELECT:C189([ACT_Pagos:172])
			
			
			$vr_saldoPago:=[ACT_Pagos:172]Saldo:15
			$vl_idPago:=[ACT_Pagos:172]ID:1
			For ($i;1;Size of array:C274(abACT_ASelectedAvisos))  //para seleccionar a pagar todos los avisos
				abACT_ASelectedAvisos{$i}:=True:C214
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAvisos{$i})
			End for 
			$vr_deuda:=Abs:C99(AT_GetSumArray (->arACT_CSaldo))
			arACT_CSaldo{0}:=0
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->arACT_CSaldo;"<";->$DA_Return)
			If (Size of array:C274($DA_Return)>0)
				vbACT_Prepago:=True:C214
				WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTpgs_AvisosDocumentar";-2;4;__ ("Avisos por pagar"))
				
				  //20120508 RCH Se cambia titulo para mostrar saldo de pago
				  //SET WINDOW TITLE(__ ("Avisos por pagar para ")+$vt_nomPersona)
				$vt_title:=__ ("Avisos por pagar para ")+$vt_nomPersona
				If ($seleccionarPrepago)
					$vt_title:=$vt_title+". "+__ ("Pago ")+String:C10([ACT_Pagos:172]ID:1)+__ (" disponible ")+String:C10([ACT_Pagos:172]Saldo:15)
				End if 
				SET WINDOW TITLE:C213($vt_title)
				
				DIALOG:C40([xxSTR_Constants:1];"ACTpgs_AvisosDocumentar")
				CLOSE WINDOW:C154
				If (ok=1)
					AT_Initialize (->alACT_CIdsAvisos;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo)
					AT_Initialize (->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt)
					ACTpgs_RetornaArreglosCargos 
					AT_Initialize (->alACT_CIdsAvisosTemp;->adACT_CFechaEmisionTemp;->adACT_CFechaVencimientoTemp;->atACT_CAlumnoTemp;->atACT_CGlosaTemp;->arACT_CMontoNetoTemp;->arACT_CInteresesTemp;->arACT_CSaldoTemp;->alACT_RecNumsCargosTemp;->alACT_CRefsTemp;->alACT_CIDCtaCteTemp;->asACT_MarcasTemp;->arACT_MontoMonedaTemp;->atACT_MonedaCargoTemp;->atACT_MonedaSimboloTemp)
					AT_Initialize (->arACT_MontoPagadoTemp;->alACT_CIdsCargosTemp;->alACT_CIdDctoCargoTemp;->arACT_MontoIVATemp;->arACT_CMontoAfectoTemp;->adACT_CfechaInteresTemp;->alACT_CidCargoGenIntTemp)
					abACT_ASelectedAvisos{0}:=True:C214
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->abACT_ASelectedAvisos;"=";->$DA_Return)
					If (Size of array:C274($DA_Return)>0)
						$format:="|Despliegue_ACT"
						$r:=CD_Dlog (0;__ ("¿Está seguro de querer utilizar el saldo disponible por un monto de: ")+String:C10($vr_saldoPago;$format)+__ (",  del pago número: ")+String:C10($vl_idPago)+__ (", para ")+$vt_nomPersona+__ ("?");"";__ ("Si");__ ("No");__ ("Cancelar"))
						If ($r#1)
							$vb_cancelarIngresoPago:=True:C214
							REDUCE SELECTION:C351([ACT_Pagos:172];0)
						Else 
							ACTpgs_EliminaCargosNoSel ("LlenaArreglos")
							ACTpgs_EliminaCargosNoSel ("EliminaCargos")
						End if 
					Else 
						$vb_cancelarIngresoPago:=True:C214
						REDUCE SELECTION:C351([ACT_Pagos:172];0)
						CD_Dlog (0;__ ("No hay avisos de cobranza seleccionados para el apoderado ")+$vt_nomPersona+__ ("."))
					End if 
				Else 
					$vb_cancelarIngresoPago:=True:C214
					REDUCE SELECTION:C351([ACT_Pagos:172];0)
				End if 
			Else 
				$vb_cancelarIngresoPago:=True:C214
				REDUCE SELECTION:C351([ACT_Pagos:172];0)
				CD_Dlog (0;__ ("El apoderado ")+$vt_nomPersona+__ (" no tiene deuda emitida."))
			End if 
		Else 
			CD_Dlog (0;__ ("No hay pagos con saldo para ")+$vt_nomPersona+__ ("."))
		End if 
	End if 
	
	If (($vl_idPago#0) & ($r=1) & (Not:C34($vb_cancelarIngresoPago)))
		  //20110927 RCH En ciertos casos el pago podia no encontrarse debido a un ingreso por cuenta y una emision por apdo o viceversa
		  //QUERY SELECTION([ACT_Pagos];[ACT_Pagos]ID=$vl_idPago)
		QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID:1=$vl_idPago)
	End if 
	
	If (Records in selection:C76([ACT_Pagos:172])=0)
		UNLOAD RECORD:C212([ACT_Documentos_de_Cargo:174])
		READ ONLY:C145([ACT_Pagos:172])
	Else 
		ACTcfg_ItemsMatricula ("InicializaYLee")
		  //20120912 RCH Si es post pago no se calculan los saldos
		If (Not:C34($PrepagoPostPago))
			ACTcc_OpcionesCalculoCtaCte ("InitArrays")
		End if 
		ARRAY LONGINT:C221($aRecNumPagos;0)
		SELECTION TO ARRAY:C260([ACT_Pagos:172];$aRecNumPagos)
		For ($x;1;Size of array:C274($aRecNumPagos))
			ARRAY LONGINT:C221(aIDPagosporBoleta;0)
			READ WRITE:C146([ACT_Pagos:172])
			GOTO RECORD:C242([ACT_Pagos:172];$aRecNumPagos{$x})
			If (Not:C34(Locked:C147([ACT_Pagos:172])))
				  //20120912 RCH Si es post pago no se calculan los saldos
				If (Not:C34($PrepagoPostPago))
					ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";->[ACT_Pagos:172]ID_Apoderado:3)
				End if 
				vlACT_FormasdePago:=[ACT_Pagos:172]id_forma_de_pago:30
				vsACT_FormasdePago:=[ACT_Pagos:172]FormaDePago:7
				vdACT_FechaPago:=[ACT_Pagos:172]Fecha:2
				vdACT_FechaUF:=vdACT_FechaPago
				$vl_idApoderado:=[ACT_Pagos:172]ID_Apoderado:3
				$vl_idTercero:=[ACT_Pagos:172]ID_Tercero:26
				APPEND TO ARRAY:C911(aIDPagosporBoleta;[ACT_Pagos:172]ID:1)
				If (Not:C34($seleccionarPrepago))
					GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$RNAviso)
					KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
					KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
					ACTcc_LoadCargosIntoArrays 
				Else 
					ACTpgs_CalculaInteresCargos (vdACT_FechaPago;False:C215;False:C215)
					
					ACTpgs_DescuentosXTramo ("CreaDescuentosIngresoPagos")  //20170714 RCH
					
					KRL_GotoRecord (->[ACT_Pagos:172];$aRecNumPagos{$x};True:C214)
				End if 
				$saldoPago:=ACTpgs_AsignaPagoACargos ("PonleBoleta";[ACT_Pagos:172]ID:1;[ACT_Pagos:172]Saldo:15)
				ACTcfg_ItemsMatricula ("ActualizaCampoDesdePagado")
				KRL_GotoRecord (->[ACT_Pagos:172];$aRecNumPagos{$x};True:C214)
				[ACT_Pagos:172]Saldo:15:=$saldoPago
				SAVE RECORD:C53([ACT_Pagos:172])
				KRL_UnloadReadOnly (->[ACT_Pagos:172])
				
				READ WRITE:C146([ACT_Transacciones:178])
				USE SET:C118("PonleBoleta")
				CLEAR SET:C117("PonleBoleta")
				ARRAY LONGINT:C221($alACT_TransaccionesaPago;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$alACT_TransaccionesaPago;"")
				For ($t;1;Size of array:C274($alACT_TransaccionesaPago))
					GOTO RECORD:C242([ACT_Transacciones:178];$alACT_TransaccionesaPago{$t})
					$ok:=ACTpgs_AsignaIdTransaccion ([ACT_Transacciones:178]ID_Transaccion:1)
					If (Not:C34($ok))
						BM_CreateRequest ("ACT_AsignaIDTransaccion";String:C10([ACT_Transacciones:178]ID_Transaccion:1);String:C10([ACT_Transacciones:178]ID_Transaccion:1))
					End if 
				End for 
				
				fUnaBoleta:=1
				fUnaBoletaporDocumento:=0
				ACTpgs_EmitirBoletasDocumentar (->aIDPagosporBoleta;->$vl_idApoderado;$vl_idTercero;"Boleta creada desde prepago.")
				If (cb_GenerarBoletaCaja=1)
					If (cbImprimirBoletas=1)
						ACTcfgbol_OpcionesMultiNum ("validaNumBol")
					End if 
				End if 
			Else 
				If ($seleccionarPrepago)
					CD_Dlog (0;__ ("El registro del pago número ")+String:C10([ACT_Pagos:172]ID:1)+__ (" se encuentra bloqueado por otro proceso. Por favor intente más tarde."))
				End if 
			End if 
			KRL_UnloadReadOnly (->[ACT_Pagos:172])
			
		End for 
		  //20120912 RCH Si es post pago no se calculan los saldos
		If (Not:C34($PrepagoPostPago))
			ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas")
		End if 
		
		For ($x;1;Size of array:C274($aRecNumPagos))
			READ ONLY:C145([ACT_Pagos:172])
			KRL_GotoRecord (->[ACT_Pagos:172];$aRecNumPagos{$x})
			LOG_RegisterEvt ("Prepago para el pago número: "+String:C10([ACT_Pagos:172]ID:1)+" realizado.")
		End for 
	End if 
	vbACT_IngresandoPagos:=False:C215
	ACTpgs_DeclareArraysCargos 
	KRL_UnloadReadOnly (->[ACT_Transacciones:178])
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	READ ONLY:C145([ACT_Pagos:172])
	
	  //20120629 RCH
	vlACT_idACIntereses:=0
	
End if 