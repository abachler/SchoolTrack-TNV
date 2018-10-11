$mesAbierto:=ACTcm_IsMonthOpenFromDate (vdACT_FechaPago)
If (Not:C34($mesAbierto))
	CD_Dlog (0;__ ("El pago no puede ser registrado con esta fecha ya que corresponde a un mes cerrado."))
Else 
	$vb_go:=ACTpgs_OpcionesVR ("ValidaSoloEmitir")
	If ($vb_go)
		ACTcfg_LoadConfigData (8)
		ACTcfg_LoadConfigData (9)
		vrACT_MontoPago:=vr_Total
		vrACT_MontoAPagar:=vrACT_MontoPago
		vrACT_MontoSeleccionado:=vrACT_MontoAPagar
		vrACT_MontoAdeudado:=vrACT_MontoAPagar
		vForma:=0
		vtNombre:=""
		$vl_idApdo:=[Personas:7]No:1
		$vl_idTer:=[ACT_Terceros:138]Id:1
		WDW_OpenDialogInDrawer (->[ACT_Pagos:172];"FormadePago")
		  //20120427 ASM - RCH Se cambia validacion de vForma>0 a vForma#0 ya que ahora la variable vForma tiene el id de la forma de pago
		If (vForma#0)
			$recNum:=Record number:C243(ptrACTpgs_Table->)
			$vb_continuar:=ACTpgs_OpcionesVR ("GeneraAvisos")
			
			If ($vb_continuar)
				GOTO RECORD:C242(ptrACTpgs_Table->;$recNum)
				
				ARRAY LONGINT:C221(alACTpgs_Avisos2Recalc;0)
				ARRAY LONGINT:C221($alACTpgs_Avisos2Recalc;0)
				ARRAY LONGINT:C221($aIDPagosporBoleta;0)  //20160818 JVP se crea arreglo local para imprimir recibo
				C_LONGINT:C283($proc)
				
				C_BOOLEAN:C305(vbACT_IngresoPagosCaja)
				vbACT_IngresoPagosCaja:=True:C214
				
				$proc:=IT_UThermometer (1;0;__ ("Ingresando pagos. Un momento por favor..."))
				C_LONGINT:C283(vl_cargosEliminados)
				vl_cargosEliminados:=0
				ACTpgs_IngresarPagos (vForma)
				COPY ARRAY:C226(alACTpgs_Avisos2Recalc;$alACTpgs_Avisos2Recalc)
				COPY ARRAY:C226(aIDPagosporBoleta;$aIDPagosporBoleta)  //20160818 JVP se duplica arreglo
				
				For ($r;1;Size of array:C274($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
					ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False:C215;True:C214)
					If (Find in array:C230(alACT_RecNumsAvisos;$alACTpgs_Avisos2Recalc{$r})=-1)
						APPEND TO ARRAY:C911(alACT_RecNumsAvisos;$alACTpgs_Avisos2Recalc{$r})
					End if 
				End for 
				  //ticket 166536  JVP 20160818
				C_REAL:C285($cbImprimirRecPago)
				$cbImprimirRecPago:=cbImprimirRecPago
				IT_UThermometer (-2;$proc)
				ACTmnu_RecalcularSaldosAvisos (->alACT_RecNumsAvisos;Current date:C33(*);False:C215;True:C214)
				If ((vForma=-8) & (vb_imprimirLetra) & (vt_noserieLetra2Print#"") & (vl_indiceConfLetras>0))
					$r:=CD_Dlog (0;__ ("¿Desea imprimir la letra ahora?");__ ("");__ ("Si");__ ("No"))
					If ($r=1)
						$vl_idFormaDePago:=-8
						
						ARRAY TEXT:C222(atACTlc_Folio;0)
						ACTcfg_LoadConfigData (8)
						READ ONLY:C145([ACT_Documentos_de_Pago:176])
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
				If (Process number:C372("Explorador AccountTrack")>0)
					<>vb_Refresh:=True:C214
				End if 
				
				vbACT_IngresoPagosCaja:=False:C215
				
				cbImprimirRecPago:=$cbImprimirRecPago
				If (cbImprimirRecPago=1)
					ACTcfg_OpcionesGenRecibo ("CreaTrabajoImpresion";->atACT_Recibos{atACT_Recibos};->$aIDPagosporBoleta)
				End if 
				
			End if 
			ACTpgs_OpcionesVR ("LimpiaCampos")
		End if 
		
	End if 
End if 