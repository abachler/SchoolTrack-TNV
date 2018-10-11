//%attributes = {}
  //ACTpgs_IngresarPagos

C_BOOLEAN:C305(vbACT_documentando)
C_BOOLEAN:C305(vb_NoMostrarAlertas)
C_BOOLEAN:C305($2;$boletear)
C_BOOLEAN:C305($3;$importacion)
C_BOOLEAN:C305(vb_faltanDatos;vb_serieDuplicada;vb_descuadre)  //RCH
C_BOOLEAN:C305(vb_fechaPagoNoPermitida)  // 179864
C_REAL:C285($0)
C_BOOLEAN:C305($continuar)
C_DATE:C307(vdACT_FechaUF)
  //20120430 RCH Para guardar id dcto reemplazado
C_LONGINT:C283($vl_idDctoPago)
C_BOOLEAN:C305(vbACT_fillArrayIDDocPago)
C_TEXT:C284($t_nombreUsuario)
C_TEXT:C284($t_referencia;$t_jsonDatosPago;$t_ordenCompra)

vdACT_FechaUF:=!00-00-00!
$continuar:=True:C214
$0:=0
Grabar:=True:C214
$SerieDuplicada:=False:C215
$FaltanDatos:=False:C215
$fechaIncorrecta:=False:C215
$FormadePago:=$1
vb_faltanDatos:=False:C215  //rch
vb_serieDuplicada:=False:C215  //rch
vb_descuadre:=False:C215
vb_fechaPagoNoPermitida:=False:C215  // 179864

COPY ARRAY:C226(<>atACT_ModosdePago;atACT_Modo_de_Pago)

$boletear:=True:C214
If (Count parameters:C259>=2)
	$boletear:=$2
End if 
If (Count parameters:C259>=3)
	$importacion:=$3  //proceso de importación
End if 
If (Count parameters:C259>=4)
	vdACT_FechaUF:=$4
End if 
C_BOOLEAN:C305($vb_noValidaDatos)
If (Count parameters:C259>=5)
	$vb_noValidaDatos:=$5
End if 
  //20130729 RCH
If (Count parameters:C259>=6)
	$t_nombreUsuario:=$6
End if 
  //20131006 RCH
If (Count parameters:C259>=7)
	$t_referencia:=$7
End if 
If (Count parameters:C259>=8)
	$t_jsonDatosPago:=$8
End if 
If (Count parameters:C259>=9)
	$t_ordenCompra:=$9
End if 

If (vdACT_FechaUF=!00-00-00!)
	vdACT_FechaUF:=vdACT_FechaPago
End if 
  //vdACT_FechaPago  fecha de ingreso de pago.
  //vdACT_FechaUF   fecha seleccionada para montos en moneda variable en importación de pagos

  // Modificado por: Saúl Ponce (14-02-2017) - Ticket N° 175102
  // Para almacenar las transacciones con glosa 'Pago con Descuento' y 'Balanceo Descuento'
If (Current process name:C1392="Ingreso de Pagos") | (Current process name:C1392="Documentar Deudas")
	  //CREATE SET([ACT_Transacciones];"ACT_transDeUtilizacionDesctos")
	CREATE EMPTY SET:C140([ACT_Transacciones:178];"ACT_transDeUtilizacionDesctos")  //20170315 RCH Se crea un set vacio ya que la tabla podia venir con algún registro cargado
End if 

If (vrACT_MontoPago>0)
	C_LONGINT:C283($vl_rnCta)
	If (vbACT_PagoXCuenta)
		$vl_rnCta:=Record number:C243([ACT_CuentasCorrientes:175])
	Else 
		$vl_rnCta:=-1
	End if 
	
	  // 179864
	C_TEXT:C284($vt_fechaValida)
	C_DATE:C307($vd_fechaIngreso)
	$vd_fechaIngreso:=Current date:C33(*)
	$vt_fechaValida:=ACTpgs_validaFechaPago ("IngresarPagos";$vd_fechaIngreso)  // 179864
	If ($vt_fechaValida="ok")  // 179864
		Case of 
				
			: ($FormadePago=-3)
				
			: ($FormadePago=-4)
				If ((vtACT_BancoNombre="") | (vtACT_NoSerie="") | (vdACT_FechaDocumento=!00-00-00!))
					If (($importacion) | ($vb_noValidaDatos))
						vb_faltanDatos:=True:C214  //RCH
						Grabar:=False:C215
					Else 
						If (Not:C34(vb_documentando))
							Grabar:=False:C215
							$FaltanDatos:=True:C214
							If (Not:C34(vb_NoMostrarAlertas))
								CD_Dlog (0;__ ("Faltan datos para completar el pago."))
							Else 
								LOG_RegisterEvt ("Faltan datos para completar el pago.")
							End if 
							vb_documentando:=True:C214  //para que se ejecute sólo una vez
						End if 
					End if 
				End if 
				If (Not:C34($FaltanDatos))
					SET QUERY DESTINATION:C396(Into variable:K19:4;$duplicados)
					QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8=vtACT_BancoCodigo;*)
					QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]Ch_Cuenta:11=vtACT_BancoCuenta;*)
					QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]NoSerie:12=vtACT_NoSerie;*)
					QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]Nulo:37=False:C215)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					
					  //C_LONGINT($duplicados)
					  //$duplicados:=ACTdc_buscaDuplicados ($FormadePago;vtACT_NoSerie;vtACT_BancoCuenta;vtACT_BancoCodigo)
					
					If ($duplicados>0)
						If (($importacion) | ($vb_noValidaDatos))
							vb_serieDuplicada:=True:C214  //rch
							Grabar:=False:C215
						Else 
							Grabar:=False:C215
							If (Not:C34(vb_NoMostrarAlertas))
								CD_Dlog (0;__ ("Para este banco ya existe un cheque con ese número de serie."))
								GOTO OBJECT:C206(vtACT_NoSerie)
							Else 
								LOG_RegisterEvt ("Para este banco ya existe un cheque con ese número de serie.")
							End if 
						End if 
					End if 
				End if 
				If ((Not:C34($FaltanDatos)) & (Not:C34($SerieDuplicada)))
					If (vdACT_FechaDocumento-Current date:C33(*)<=-60)
						If (($importacion) | ($vb_noValidaDatos))
							  //se importan cheques vencidos
						Else 
							If (Not:C34(vb_NoMostrarAlertas))
								$t:=CD_Dlog (0;__ ("La fecha indicada para este cheque generaría un cheque vencido. ¿Desea ingresarlo de todas maneras?");__ ("");__ ("No");__ ("Si"))
								If ($t=1)
									GOTO OBJECT:C206(vtACT_FechaDocumento)
									Grabar:=False:C215
								End if 
							End if 
						End if 
					End if 
				End if 
			: ($FormadePago=-6)
				If (vtACT_TCDocumento="")
					If (($importacion) | ($vb_noValidaDatos))
						vb_faltanDatos:=True:C214  //RCH
						Grabar:=False:C215
					Else 
						Grabar:=False:C215
						If (Not:C34(vb_NoMostrarAlertas))
							CD_Dlog (0;__ ("Faltan datos para completar el pago."))
						Else 
							LOG_RegisterEvt ("Faltan datos para completar el pago.")
						End if 
					End if 
				End if 
			: ($FormadePago=-7)
				If (vtACT_RDocumento="")
					If (($importacion) | ($vb_noValidaDatos))
						vb_faltanDatos:=True:C214  //RCH
						Grabar:=False:C215
					Else 
						Grabar:=False:C215
						If (Not:C34(vb_NoMostrarAlertas))
							CD_Dlog (0;__ ("Faltan datos para completar el pago."))
						Else 
							LOG_RegisterEvt ("Faltan datos para completar el pago.")
						End if 
					End if 
				End if 
			: ($FormadePago=-8)
				If ((vdACT_LFechaEmision=!00-00-00!) | (vdACT_LFechaVencimiento=!00-00-00!) | (vtACT_LTitular="") | (vtACT_LRUTTitular=""))
					If (($importacion) | ($vb_noValidaDatos))
						vb_faltanDatos:=True:C214  //RCH
						Grabar:=False:C215
					Else 
						Grabar:=False:C215
						If (Not:C34(vb_NoMostrarAlertas))
							CD_Dlog (0;__ ("Faltan datos para completar el pago."))
						Else 
							LOG_RegisterEvt ("Faltan datos para completar el pago.")
						End if 
					End if 
				End if 
		End case 
	Else 
		Grabar:=False:C215
		If (($importacion) | ($vb_noValidaDatos))
			vb_fechaPagoNoPermitida:=True:C214
		Else 
			If (Not:C34(vb_NoMostrarAlertas))
				CD_Dlog (0;$vt_fechaValida)
			Else 
				LOG_RegisterEvt ($vt_fechaValida)
			End if 
		End if 
	End if 
	
	If (Grabar)
		
		If (vbACTpgs_PagoXTercero)
			$idPersona:=0
			$idTercero:=[ACT_Terceros:138]Id:1
			$vt_nombrePersona:=[ACT_Terceros:138]Nombre_Completo:9
			$ptr_table:=->[ACT_Terceros:138]
			$recNumPersona:=Record number:C243([ACT_Terceros:138])
		Else 
			$idPersona:=[Personas:7]No:1
			$idTercero:=0
			$vt_nombrePersona:=[Personas:7]Apellidos_y_nombres:30
			$ptr_table:=->[Personas:7]
			$recNumPersona:=Record number:C243([Personas:7])
		End if 
		KRL_ReloadInReadWriteMode ($ptr_table)
		Case of 
			: ($FormadePago=-4)
				$vb_continuar:=False:C215
				If ($idTercero=0)
					If (([Personas:7]ACT_Banco_Cta:47="") | ([Personas:7]ACT_Numero_Cta:51="") | ([Personas:7]ACT_Titular_Cta:49="") | ([Personas:7]ACT_RUTTitutal_Cta:50=""))
						$vb_continuar:=True:C214
					End if 
				Else 
					If (([ACT_Terceros:138]PAC_Banco_Nombre:44="") | ([ACT_Terceros:138]PAC_Banco_ID:45="") | ([ACT_Terceros:138]PAC_TitularCta:57="") | ([ACT_Terceros:138]PAC_Identificador:46="") | ([ACT_Terceros:138]PAC_NumCta:47=""))
						$vb_continuar:=True:C214
					End if 
				End if 
				If ($vb_continuar)
					If (($importacion) | ($vb_noValidaDatos))
						  //de momento no se almacenan los datos
					Else 
						If (Not:C34(vb_documentando))
							If (Not:C34(vb_NoMostrarAlertas))
								  //20121005 RCH
								  //If (Not([Personas]ACT_Modo_de_pago=atACT_Modo_de_Pago{2}))
								If (Not:C34([Personas:7]ACT_id_modo_de_pago:94=-10))
									$r:=CD_Dlog (0;__ ("Existen datos de la cuenta bancaria vacíos para este apoderado (en Infos. para pagos).\r\r¿Desea utilizar los datos del cheque como datos permanentes para ")+$vt_nombrePersona+__ ("?");__ ("");__ ("Si");__ ("No"))
									If ($r=1)
										If ($idTercero=0)
											[Personas:7]ACT_Banco_Cta:47:=vtACT_BancoNombre
											[Personas:7]ACT_ID_Banco_Cta:48:=vtACT_BancoID
											[Personas:7]ACT_Titular_Cta:49:=vtACT_BancoTitular
											[Personas:7]ACT_RUTTitutal_Cta:50:=vtACT_BancoRutTitular
											[Personas:7]ACT_Numero_Cta:51:=vtACT_BancoCuenta
											SAVE RECORD:C53([Personas:7])
										Else 
											[ACT_Terceros:138]PAC_Banco_Nombre:44:=vtACT_BancoNombre
											[ACT_Terceros:138]PAC_Banco_ID:45:=vtACT_BancoID
											[ACT_Terceros:138]PAC_TitularCta:57:=vtACT_BancoTitular
											[ACT_Terceros:138]PAC_Identificador:46:=vtACT_BancoRutTitular
											[ACT_Terceros:138]PAC_NumCta:47:=vtACT_BancoCuenta
											SAVE RECORD:C53([ACT_Terceros:138])
										End if 
									End if 
									vb_documentando:=True:C214
								End if 
							End if 
						End if 
					End if 
				End if 
			: ($FormadePago=-6)
				$vb_continuar:=False:C215
				If ($idTercero=0)
					If (([Personas:7]ACT_Tipo_TC:52="") | ([Personas:7]ACT_Numero_TC:54="") | ([Personas:7]ACT_Titular_TC:55="") | ([Personas:7]ACT_RUTTitular_TC:56="") | ([Personas:7]ACT_MesVenc_TC:57="") | ([Personas:7]ACT_AñoVenc_TC:58="") | ([Personas:7]ACT_Banco_TC:53=""))
						$vb_continuar:=True:C214
					End if 
				Else 
					If (([ACT_Terceros:138]PAT_TipoTC:35="") | ([ACT_Terceros:138]PAT_NumTC:36="") | ([ACT_Terceros:138]PAT_TitularTC:56="") | ([ACT_Terceros:138]PAT_Identificador:34="") | ([ACT_Terceros:138]PAT_VencMesTC:38="") | ([ACT_Terceros:138]PAT_VencAgnoTC:37="") | ([ACT_Terceros:138]PAT_Banco_Emisor:39=""))
						$vb_continuar:=True:C214
					End if 
				End if 
				If ($vb_continuar)
					If (($importacion) | ($vb_noValidaDatos))
						  //de momento no se almacenan los datos
					Else 
						If (Not:C34(vb_NoMostrarAlertas))
							  //20121005 RCH
							  //If (Not([Personas]ACT_Modo_de_pago=atACT_Modo_de_Pago{3}))
							
							  //If (Not([Personas]ACT_id_modo_de_pago=-9))
							If ($idTercero=0)
								$l_IdModoPago:=[Personas:7]ACT_id_modo_de_pago:94
							Else 
								$l_IdModoPago:=[ACT_Terceros:138]Id_Modo_de_Pago:61
							End if 
							If (Not:C34($l_IdModoPago=-9))
								$r:=CD_Dlog (0;__ ("Existen datos de la tarjeta de crédito vacíos para este apoderado (en Infos. para pagos).\r\r¿Desea utilizar los datos de la tarjeta como datos permanentes para ")+$vt_nombrePersona+__ ("?");__ ("");__ ("Si");__ ("No"))
								If ($r=1)
									C_TEXT:C284(vtACT_TCRUTTitular;vtACT_TCCodigo)  // Cuando se guardan los datos directo desde la ventana de pagos, el rut y el codigo no son datos obligatorios. las variables venian indefinidas.
									If ($idTercero=0)
										[Personas:7]ACT_Tipo_TC:52:=vtACT_TCTipo
										If (Position:C15("x";vtACT_TCNumero)=0)
											[Personas:7]ACT_Numero_TC:54:=ACTpp_CRYPTTC ("xxACT_SetCryptTC";->vtACT_TCNumero;->[Personas:7]ACT_xPass:91)
										End if 
										[Personas:7]ACT_Titular_TC:55:=vtACT_TCTitular
										[Personas:7]ACT_RUTTitular_TC:56:=vtACT_TCRUTTitular
										[Personas:7]ACT_MesVenc_TC:57:=vtACT_TCMesVencimiento
										[Personas:7]ACT_AñoVenc_TC:58:=vtACT_TCAgnoVencimiento
										[Personas:7]ACT_Banco_TC:53:=vtACT_TCBancoEmisor
										SAVE RECORD:C53([Personas:7])
									Else 
										[ACT_Terceros:138]PAT_TipoTC:35:=vtACT_TCTipo
										If (Position:C15("x";vtACT_TCNumero)=0)
											[ACT_Terceros:138]PAT_NumTC:36:=ACTpp_CRYPTTC ("xxACT_SetCryptTC";->vtACT_TCNumero;->[ACT_Terceros:138]xPass:58)
										End if 
										[ACT_Terceros:138]PAT_TitularTC:56:=vtACT_TCTitular
										[ACT_Terceros:138]PAT_Identificador:34:=vtACT_TCRUTTitular
										[ACT_Terceros:138]PAT_VencMesTC:38:=vtACT_TCMesVencimiento
										[ACT_Terceros:138]PAT_VencAgnoTC:37:=vtACT_TCAgnoVencimiento
										[ACT_Terceros:138]PAT_Banco_Emisor:39:=vtACT_TCBancoEmisor
										SAVE RECORD:C53([ACT_Terceros:138])
									End if 
									LOG_RegisterEvt ("Datos de Tarjeta de Crédito modificados desde ingreso de pagos para "+" "+$vt_nombrePersona)
								End if 
							End if 
						End if 
					End if 
				End if 
		End case 
		KRL_UnloadReadOnly ($ptr_table)
		READ ONLY:C145($ptr_table->)
		GOTO RECORD:C242($ptr_table->;$recNumPersona)
		ARRAY LONGINT:C221(aIDs;0)
		$0:=vrACT_MontoAdeudado
		$rnPago:=-1
		If ((vrACT_MontoAdeudado>0) | ($importacion))
			If (vrACT_MontoAdeudado>0)
				vbACTpgs_NoUtilizarDctos:=True:C214
				ACTpgs_CreaCargoDesctoEspecial 
				vbACTpgs_NoUtilizarDctos:=False:C215
				ACTpgs_ReordenaArraysCargos 
				If (Not:C34(vbACT_documentando))
					ACTpgs_CalculaInteresCargos (vdACT_FechaPago;$importacion)
					
					ACTpgs_DescuentosXTramo ("CreaDescuentosIngresoPagos")
				End if 
				$continuar:=ACTpgs_OpcionesImportacion ($importacion;True:C214;vdACT_FechaUF)
			Else 
				$continuar:=ACTpgs_OpcionesImportacion ($importacion;False:C215;vdACT_FechaUF)
				If ($continuar)
					$continuar:=False:C215
					GOTO RECORD:C242($ptr_table->;$recNumPersona)
					$vl_idDctoPago:=ACTpgs_CreacionDocdePago ($FormadePago)
					If (vbACT_fillArrayIDDocPago)
						APPEND TO ARRAY:C911(alACT_fillArrayIDDocPago;$vl_idDctoPago)
					End if 
					KRL_GotoRecord (->[ACT_CuentasCorrientes:175];$vl_rnCta)
					  //20130729 RCH
					  //ACTpgs_CreacionPago (vrACT_MontoPago)
					  //ACTpgs_CreacionPago (vrACT_MontoPago;$t_nombreUsuario)
					ACTpgs_CreacionPago (vrACT_MontoPago;$t_nombreUsuario;$t_referencia;$t_jsonDatosPago;$t_ordenCompra)
					LOAD RECORD:C52([ACT_Pagos:172])
					$rnPago:=Record number:C243([ACT_Pagos:172])
					If ($importacion)
						APPEND TO ARRAY:C911(<>alACT_RecNumPagosInforme;$rnPago)
					End if 
					ACTpgs_CreacionDocCartera ($FormadePago)
				End if 
			End if 
			If ($continuar)
				GOTO RECORD:C242($ptr_table->;$recNumPersona)
				C_BOOLEAN:C305($vb_validateT)
				If (Not:C34(In transaction:C397))
					START TRANSACTION:C239
					$vb_validateT:=True:C214
				End if 
				
				  //20120907 ASM para utilizar los disponibles en los pagos.
				  //20120912 RCH Esto no puede ir aca
				  //For (vQR_long1;1;Size of array(alACT_RecNumsAvisos))
				  //ACTac_Prepagar (alACT_RecNumsAvisos{vQR_long1})
				  //End for 
				
				$MontoPagado:=ACTpgs_AsignaPagoACargos 
				ACTcfg_ItemsMatricula ("ActualizaCampoDesdePagado")
				KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
				GOTO RECORD:C242($ptr_table->;$recNumPersona)
				$vl_idDctoPago:=ACTpgs_CreacionDocdePago ($FormadePago)
				If (vbACT_fillArrayIDDocPago)
					APPEND TO ARRAY:C911(alACT_fillArrayIDDocPago;$vl_idDctoPago)
				End if 
				KRL_GotoRecord (->[ACT_CuentasCorrientes:175];$vl_rnCta)
				  //20130729 RCH
				  //ACTpgs_CreacionPago ($MontoPagado)
				  //ACTpgs_CreacionPago ($MontoPagado;$t_nombreUsuario)
				  //ACTpgs_CreacionPago (vrACT_MontoPago;$t_nombreUsuario;$t_referencia;$t_jsonDatosPago;$t_ordenCompra)
				ACTpgs_CreacionPago ($MontoPagado;$t_nombreUsuario;$t_referencia;$t_jsonDatosPago;$t_ordenCompra)  //20141009 RCH
				LOAD RECORD:C52([ACT_Pagos:172])
				ACTpgs_CreacionDocCartera ($FormadePago)
				If (vrACT_MontoDescto>0)
					$event:="Aplicación de descuento en caja de "+String:C10(vrACT_MontoDescto)+" a "+$vt_nombrePersona+"."
					LOG_RegisterEvt ($event;Table:C252(->[ACT_Pagos:172]);[ACT_Pagos:172]ID:1)
				End if 
				
				  // Modificado por: Saúl Ponce (14-02-2017) - Ticket N° 175102
				  // Las transacciones 'Pago con Descuento' y 'Balanceo Descuento' adquieren ID de pago
				If (Current process name:C1392="Ingreso de Pagos") | (Current process name:C1392="Documentar Deudas")
					If (Records in set:C195("ACT_transDeUtilizacionDesctos")>0)
						ACTpgs_AsignaIDPagoEnTrans ("ACT_transDeUtilizacionDesctos";IDParaTrans)
						CLEAR SET:C117("ACT_transDeUtilizacionDesctos")
					End if 
				End if 
				
				ACTpgs_AsignaIDPagoEnTrans ("FaltaIDPago";IDParaTrans)
				
				If ($vb_validateT)
					VALIDATE TRANSACTION:C240
				End if 
				KRL_FindAndLoadRecordByIndex (->[ACT_Pagos:172]ID:1;->IDParaTrans)
				LOAD RECORD:C52([ACT_Pagos:172])
				$rnPago:=Record number:C243([ACT_Pagos:172])
				If ($importacion)
					APPEND TO ARRAY:C911(<>alACT_RecNumPagosInforme;$rnPago)
				End if 
			End if 
		Else 
			$vl_idDctoPago:=ACTpgs_CreacionDocdePago ($FormadePago)
			If (vbACT_fillArrayIDDocPago)
				APPEND TO ARRAY:C911(alACT_fillArrayIDDocPago;$vl_idDctoPago)
			End if 
			  //20130729 RCH
			  //ACTpgs_CreacionPago (vrACT_MontoPago)
			  //ACTpgs_CreacionPago (vrACT_MontoPago;$t_nombreUsuario)
			ACTpgs_CreacionPago (vrACT_MontoPago;$t_nombreUsuario;$t_referencia;$t_jsonDatosPago;$t_ordenCompra)
			LOAD RECORD:C52([ACT_Pagos:172])
			$rnPago:=Record number:C243([ACT_Pagos:172])
			If ($importacion)
				APPEND TO ARRAY:C911(<>alACT_RecNumPagosInforme;$rnPago)
			End if 
			ACTpgs_CreacionDocCartera ($FormadePago)
		End if 
		If ($rnPago#-1)
			GOTO RECORD:C242([ACT_Pagos:172];$rnPago)
			ACTcfg_OpcionesCondonacion ("GuardaMotivo")
		End if 
		ACTcfg_OpcionesCondonacion ("InitVars")
		If ($boletear)
			  //Creacion de las boletas si asi esta definido en la preferencias
			SELECTION TO ARRAY:C260([ACT_Pagos:172]ID:1;aIDPagosporBoleta)
			fUnaBoleta:=1
			fUnaBoletaporDocumento:=0
			ACTpgs_EmitirBoletasDocumentar (->aIDPagosporBoleta;->$idPersona;$idTercero)
			If (cb_GenerarBoletaCaja=1)
				If (cbImprimirBoletas=1)
					ACTcfgbol_OpcionesMultiNum ("validaNumBol")
				End if 
			End if 
			FLUSH CACHE:C297
		Else 
			If (Not:C34($importacion))
				ARRAY LONGINT:C221($al_idPagoT;0)
				  //REDUCE SELECTION([ACT_Pagos];1)
				If (Records in selection:C76([ACT_Pagos:172])>0)
					SELECTION TO ARRAY:C260([ACT_Pagos:172]ID:1;$al_idPagoT)
					APPEND TO ARRAY:C911(aIDPagosDocumentar;$al_idPagoT{1})
				End if 
			End if 
		End if 
		KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
		KRL_UnloadReadOnly (->[ACT_Pagos:172])
		KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
		AT_Initialize (->aIDs)
		If ((Not:C34(vb_faltanDatos)) | (Not:C34(vb_serieDuplicada)) | (Not:C34(vb_descuadre))) & ($rnPago#-1)
			READ ONLY:C145([ACT_Pagos:172])
			GOTO RECORD:C242([ACT_Pagos:172];$rnPago)
			LOG_RegisterEvt ("Ingreso de Pago con "+vsACT_FormasdePago+" de "+String:C10(vrACT_MontoPago;"|Despliegue_ACT_Pagos")+" de "+$vt_nombrePersona+ST_Boolean2Str (vdACT_FechaPago#Current date:C33(*);", con fecha de pago "+String:C10(vdACT_FechaPago);"")+".";Table:C252(->[ACT_Pagos:172]);[ACT_Pagos:172]ID:1)
		End if 
		ACTpgs_ClearDlogVars 
		vrACT_MontoPago:=0
		vsACT_RUTApoderado:=""
		vsACT_RUTTercero:=""
		vsACT_RUTCta:=""
		ACTcfg_OpcionesFormasDePago ("InicializaVariablesIngresoPagos")
		FORM GOTO PAGE:C247(1)
		GOTO OBJECT:C206(vsACT_RUTApoderado)
	End if 
Else 
	ACTpgs_ClearDlogVars 
	vrACT_MontoPago:=0
	vsACT_RUTApoderado:=""
	vsACT_RUTTercero:=""
	vsACT_RUTCta:=""
	ACTcfg_OpcionesFormasDePago ("InicializaVariablesIngresoPagos")
	FORM GOTO PAGE:C247(1)
	GOTO OBJECT:C206(vsACT_RUTApoderado)
End if 
FLUSH CACHE:C297
vb_NoMostrarAlertas:=False:C215
vbACT_documentando:=False:C215
  //ACTac_RecalcularSaldosAvisos (->alACT_RecNumsAvisos)