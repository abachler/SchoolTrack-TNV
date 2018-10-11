ARRAY LONGINT:C221(aIDPagosporBoleta;0)

  // 179864 
C_TEXT:C284($vt_fechaValida)
C_BOOLEAN:C305($vb_continuar)
C_DATE:C307($vd_fecha)

$vb_continuar:=True:C214
$vd_fecha:=Current date:C33(*)

$vt_fechaValida:=ACTpgs_validaFechaPago ("IngresoPagosCaja";$vd_fecha)
If (cb_noPagosConFechasAnteriores=1)
	If ($vt_fechaValida#"ok")
		$vb_continuar:=False:C215
		CD_Dlog (0;$vt_fechaValida)
	End if 
End if 
  // 179864

If ($vb_continuar)  // 179864
	
	If ((RNApdo#-1) | (RNCta#-1) | (RNTercero#-1))
		If ((vrACT_MontoAPagar<=0) & (cb_OcupaSaldos=1))
			ACTpgs_ClearDlogVars 
			vrACT_MontoPago:=0
			vsACT_RUTApoderado:=""
			vsACT_RutCta:=""
			vsACT_RUTTercero:=""
			ACTcfg_OpcionesFormasDePago ("InicializaVariablesIngresoPagos")
			ACTcfg_OpcionesFormasDePago ("GOTOPAGE";->vlACT_FormasdePago)
			GOTO OBJECT:C206(vsACT_RUTApoderado)
			For ($tt;1;Size of array:C274(alACT_RecNumsAvisos))
				ACTac_Prepagar (alACT_RecNumsAvisos{$tt};True:C214)
			End for 
			ACTmnu_RecalcularSaldosAvisos (->alACT_RecNumsAvisos;Current date:C33(*);False:C215)
			
		Else 
			$mesAbierto:=ACTcm_IsMonthOpenFromDate (vdACT_FechaPago)
			If (Not:C34($mesAbierto))
				CD_Dlog (0;__ ("El pago no puede ser registrado con esta fecha ya que corresponde a un mes cerrado."))
			Else 
				C_BOOLEAN:C305($vb_continuar)
				C_BOOLEAN:C305(vbACT_IngresoPagosCaja)
				vbACT_IngresoPagosCaja:=True:C214
				$vb_continuar:=Num:C11(ACTpgs_EliminaCargosNoSel ("ValidaSeleccionCargos"))=1
				If ($vb_continuar)
					ACTpgs_EliminaCargosNoSel ("LlenaArreglos")
					vForma:=0
					vtNombre:=__ ("Modo de pago: ")
					$vl_idApdo:=[Personas:7]No:1
					$vl_idTer:=[ACT_Terceros:138]Id:1
					Case of 
						: (vbACT_PagoXCuenta)
							  //20121005 RCH
							  //vtNombre:=vtNombre+ST_Qte ([Personas]ACT_Modo_de_pago)+"\r"+__ ("Pago por cuenta para: ")+vsACT_NomApellidoCta
							vtNombre:=vtNombre+ST_Qte ([Personas:7]ACT_modo_de_pago_new:95)+"\r"+__ ("Pago por cuenta para: ")+vsACT_NomApellidoCta
						: (vbACT_PagoXApdo)
							vtNombre:=vtNombre+ST_Qte ([Personas:7]ACT_modo_de_pago_new:95)+"\r"+__ ("Pago por apoderado para: ")+vsACT_NomApellido
						: (vbACTpgs_PagoXTercero)
							vtNombre:=vtNombre+ST_Qte ([ACT_Terceros:138]Modo_de_Pago:30)+"\r"+__ ("Pago para el tercero: ")+vsACT_NomApellidoTer
					End case 
					
					  //20120709 ASM código agregado  por nueva funcionalidad "Recargo en formas de Pago"
					ACTfdp_OpcionesRecargos ("CargaVariables";->vlACT_FormasdePago)
					If (crPermitirRecargoItem=1)
						vrACT_MontoRecargo:=ACTfdp_OpcionesRecargos ("CargaMontoRecargo";->vlACT_FormasdePago;->vrACT_MontoAPagar)
						ACTfdp_OpcionesRecargos ("SumaMontos")
						OBJECT SET VISIBLE:C603(*;"multaCfg4";True:C214)
						OBJECT SET VISIBLE:C603(*;"multaCfg7";True:C214)
						OBJECT SET VISIBLE:C603(*;"multaCfg3";True:C214)
						OBJECT SET VISIBLE:C603(*;"multaCfg2";True:C214)
						If (crPermitirModificarMonto=1)
							OBJECT SET ENTERABLE:C238(*;"multaCfg2";True:C214)
						Else 
							OBJECT SET ENTERABLE:C238(*;"multaCfg2";False:C215)
						End if 
					Else 
						  //OBJECT SET VISIBLE(*;"multaCfg7";False)
						  //OBJECT SET VISIBLE(*;"multaCfg4";False)
						OBJECT SET VISIBLE:C603(*;"multaCfg3";False:C215)
						OBJECT SET VISIBLE:C603(*;"multaCfg2";False:C215)
					End if 
					
					WDW_OpenDialogInDrawer (->[ACT_Pagos:172];"FormadePago")
					If (vForma#0)
						ARRAY LONGINT:C221(alACTpgs_Avisos2Recalc;0)
						ARRAY LONGINT:C221($alACTpgs_Avisos2Recalc;0)  //20140311 RCH Error en linea 76 al ingresar pago
						ARRAY LONGINT:C221($aIDPagosporBoleta;0)  //20160729 JVP se crea arreglo local para imprimir recibo
						ACTpgs_LimpiaVarsInterfaz ("UpdateAreas0")
						ACTpgs_EliminaCargosNoSel ("EliminaCargos")
						C_LONGINT:C283($proc)
						$proc:=IT_UThermometer (1;0;__ ("Ingresando pagos. Un momento por favor..."))
						C_LONGINT:C283(vl_cargosEliminados)
						vl_cargosEliminados:=0
						ACTpgs_IngresarPagos (vForma)
						COPY ARRAY:C226(alACTpgs_Avisos2Recalc;$alACTpgs_Avisos2Recalc)
						COPY ARRAY:C226(aIDPagosporBoleta;$aIDPagosporBoleta)
						For ($r;1;Size of array:C274($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
							ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False:C215;True:C214)
						End for 
						  //ticket 163647  JVP 20160620
						C_REAL:C285($cbImprimirRecPago)
						$cbImprimirRecPago:=cbImprimirRecPago
						  //20131210 RCH Cambio arreglo alACT_RecNumsAvisos por alACTpgs_Avisos2Recalc
						For ($tt;1;Size of array:C274($alACTpgs_Avisos2Recalc))
							ACTac_Prepagar ($alACTpgs_Avisos2Recalc{$tt};True:C214)
						End for 
						IT_UThermometer (-2;$proc)
						cbImprimirRecPago:=$cbImprimirRecPago
						ACTmnu_RecalcularSaldosAvisos (->$alACTpgs_Avisos2Recalc;Current date:C33(*);False:C215;True:C214)
						If ((vForma=-8) & (vb_imprimirLetra) & (vt_noserieLetra2Print#"") & (vl_indiceConfLetras>0))
							$r:=CD_Dlog (0;__ ("¿Desea imprimir la letra ahora?");__ ("");__ ("Si");__ ("No"))
							If ($r=1)
								ARRAY TEXT:C222(atACTlc_Folio;0)
								ACTcfg_LoadConfigData (8)
								READ ONLY:C145([ACT_Documentos_de_Pago:176])
								
								$vl_idFormaDePago:=-8
								
								QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]NoSerie:12=vt_noserieLetra2Print;*)
								QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]id_forma_de_pago:51=$vl_idFormaDePago)
								
								  //20120224 RCH Se sacan posibles documentos nulos...
								$vl_idEstadoNulo:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoNulo";->$vl_idFormaDePago))
								QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_estado:53#$vl_idEstadoNulo)
								
								CREATE SET:C116([ACT_Documentos_de_Pago:176];"doc2Print")
								If ((Records in set:C195("doc2Print")>0) & (vl_indiceConfLetras>0))
									AT_Insert (0;1;->atACTlc_Folio)
									atACTlc_Folio{Size of array:C274(atACTlc_Folio)}:=vt_noserieLetra2Print
									ACTlc_PrintLetras ("doc2Print";alACT_IDDT{vl_indiceConfLetras})
								End if 
								CLEAR SET:C117("doc2Print")
								AT_Initialize (->atACTlc_Folio)
							End if 
							vt_noserieLetra2Print:=""
							vb_imprimirLetra:=False:C215
						End if 
						KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
						ACTpp_OpcionesCalculoMontos ("CalculaDesdeArreglosIdsApdoTerceros";->$vl_idApdo;->$vl_idTer)
						
						If (Size of array:C274($alACTpgs_Avisos2Recalc)=0)  //20170802 RCH Si no hay cargos seleccionados, se calcula el saldo del apdo en batch
							Case of 
								: (RNApdo#-1)
									BM_CreateRequest ("ACTpp_ActualizaValores";String:C10(RNApdo))
								: (RNCta#-1)
									READ ONLY:C145([ACT_CuentasCorrientes:175])
									KRL_GotoRecord (->[ACT_CuentasCorrientes:175];RNCta)
									$vl_recNum:=KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9)
									If ($vl_recNum>=0)
										BM_CreateRequest ("ACTpp_ActualizaValores";String:C10($vl_recNum))
									End if 
								: (RNTercero#-1)
									READ ONLY:C145([ACT_Terceros:138])
									KRL_GotoRecord (->[ACT_Terceros:138];RNTercero)
									If ([ACT_Terceros:138]Id:1>0)
										BM_CreateRequest ("ACTter_ActualizaValores";String:C10([ACT_Terceros:138]Id:1))
									End if 
							End case 
						End if 
						
						If (Process number:C372("Explorador AccountTrack")>0)
							<>vb_Refresh:=True:C214
						End if 
						
						vbACT_IngresoPagosCaja:=False:C215
						
						  ////20170714 RCH para inicializar los arreglos de cargos de intereses eliminados
						vb_descuentoBorrado:=False:C215  //20170714 RCH
						vb_interesBorrado:=False:C215  //20170714 RCH
						
						If (cbImprimirRecPago=1)
							ACTcfg_OpcionesGenRecibo ("CreaTrabajoImpresion";->atACT_Recibos{atACT_Recibos};->$aIDPagosporBoleta)
						End if 
						
					End if 
				End if 
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("Antes de ingresar un pago seleccione un Apoderado, un Tercero o una Cuenta Corriente."))
	End if 
End if 
