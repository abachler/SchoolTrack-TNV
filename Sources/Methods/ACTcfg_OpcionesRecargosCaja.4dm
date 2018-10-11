//%attributes = {}
  //ACTcfg_OpcionesRecargosCaja

C_TEXT:C284($vt_accion;$1;$filter)
$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="BuscaItemsADesplegar")
		ACTqry_Items ("CargosNoRelativosNoEspecialesNoIntereses";->[xxACT_Items:179]ID:1;->al_IdsItems;->[xxACT_Items:179]Glosa:2;->at_GlosasItems)
		
	: ($vt_accion="DeclaraVars")
		C_TEXT:C284(vtACTcfg_SelectedItemNCaja)
		C_LONGINT:C283(vlACTcfg_SelectedItemIdCaja;cbMultaXCaja;a_MultaCajaFija;a_MultaCajaPorc;cbMultaCajaPermiteMod)
		C_REAL:C285(vr_PctMontoMultaCaja)
		ARRAY LONGINT:C221(al_IdsItems;0)
		ARRAY TEXT:C222(at_GlosasItems;0)
		C_LONGINT:C283(vl_idCargoXCaja)
		
		C_REAL:C285(cs_multiplicarMontoRXC;cs_considerarAvisosDesde;cs_considerarPCTAvisosMorosoRXC;vr_PctAvisosMorosos)
		C_DATE:C307(vdACT_FechaRXC)
		
	: ($vt_accion="InitVars")
		ACTcfg_OpcionesRecargosCaja ("DeclaraVars")
		cbMultaXCaja:=0
		a_MultaCajaFija:=0
		a_MultaCajaPorc:=0
		vr_PctMontoMultaCaja:=0
		vlACTcfg_SelectedItemIdCaja:=0
		cbMultaCajaPermiteMod:=0
		vtACTcfg_SelectedItemNCaja:=""
		vl_idCargoXCaja:=-1
		
		cs_multiplicarMontoRXC:=0
		cs_considerarAvisosDesde:=0
		vdACT_FechaRXC:=!00-00-00!
		cs_considerarPCTAvisosMorosoRXC:=0
		vr_PctAvisosMorosos:=0
		
	: ($vt_accion="LeeBlob")
		ACTcfg_LeeBlob ("ACTcfg_MultasXCaja")
		
	: ($vt_accion="GuardaBlob")
		ACTcfg_GuardaBlob ("ACTcfg_MultasXCaja")
		
	: ($vt_accion="CargaDatosMulta")
		C_LONGINT:C283(vlACT_idItemMulta;vl_idCargoXCaja)
		C_REAL:C285(vrACT_MontoMulta;vrACT_MontoSeleccionado)
		vlACT_idItemMulta:=0
		vrACT_MontoMulta:=0
		vl_idCargoXCaja:=-1
		ACTcfg_OpcionesRecargosCaja ("LeeBlob")
		If (cbMultaXCaja=1)
			If (vlACTcfg_SelectedItemIdCaja#0)
				If ((a_MultaCajaFija#0) | (a_MultaCajaPorc#0))
					REDUCE SELECTION:C351([xxACT_Items:179];0)
					KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->vlACTcfg_SelectedItemIdCaja)
					If (Records in selection:C76([xxACT_Items:179])=1)
						vlACT_idItemMulta:=[xxACT_Items:179]ID:1
						Case of 
							: (a_MultaCajaFija=1)
								vrACT_MontoMulta:=0
								If (cs_multiplicarMontoRXC=0)
									vrACT_MontoMulta:=ACTut_retornaMontoEnMoneda ([xxACT_Items:179]Monto:7;[xxACT_Items:179]Moneda:10;vdACT_FechaPago;ST_GetWord (ACT_DivisaPais ;1;";"))
									
								Else 
									C_DATE:C307($vd_fechaEmision)
									C_LONGINT:C283($vl_pctAvisoMoroso)
									
									ARRAY LONGINT:C221($al_avisosVencidos;0)
									ARRAY LONGINT:C221($al_avisosSeleccionados;0)
									ARRAY LONGINT:C221($al_avisos2Calc;0)
									abACT_ASelectedAvisos{0}:=True:C214
									AT_SearchArray (->abACT_ASelectedAvisos;"=";->$al_avisosSeleccionados)
									adACT_AFechaVencimiento{0}:=vdACT_FechaPago
									AT_SearchArray (->adACT_AFechaVencimiento;"<=";->$al_avisosVencidos)
									AT_intersect (->$al_avisosSeleccionados;->$al_avisosVencidos;->$al_avisos2Calc)
									
									If (cs_considerarAvisosDesde=1)
										ARRAY LONGINT:C221($al_avisosEmision;0)
										$vd_fechaEmision:=vdACT_FechaRXC
										COPY ARRAY:C226($al_avisos2Calc;$al_avisosSeleccionados)
										adACT_AFechaEmision{0}:=$vd_fechaEmision
										AT_SearchArray (->adACT_AFechaEmision;">=";->$al_avisosEmision)
										AT_intersect (->$al_avisosSeleccionados;->$al_avisosEmision;->$al_avisos2Calc)
									End if 
									
									If (cs_considerarPCTAvisosMorosoRXC=1)
										ARRAY LONGINT:C221($al_PCTSaldos;0)
										$vl_pctAvisoMoroso:=vr_PctAvisosMorosos
										If ($vl_pctAvisoMoroso>100)
											$vl_pctAvisoMoroso:=100
										End if 
										If ($vl_pctAvisoMoroso<0)
											$vl_pctAvisoMoroso:=0
										End if 
										
										  //lleno arreglo con PCT para comparacion
										ARRAY LONGINT:C221($al_arreglosPCT;Size of array:C274(alACT_AIDAviso))
										For ($i;1;Size of array:C274($al_avisos2Calc))
											READ ONLY:C145([ACT_Documentos_de_Cargo:174])
											READ ONLY:C145([ACT_Cargos:173])
											QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=alACT_AIDAviso{$al_avisos2Calc{$i}})
											KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
											$vr_monto1:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;vdACT_FechaPago)
											$vr_monto2:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;vdACT_FechaPago))
											$al_arreglosPCT{$al_avisos2Calc{$i}}:=($vr_monto2*100)/$vr_monto1
										End for 
										
										  //intersecto los avisos ya seleccionados con el nuevo filtro
										COPY ARRAY:C226($al_avisos2Calc;$al_avisosSeleccionados)
										$al_arreglosPCT{0}:=$vl_pctAvisoMoroso
										AT_SearchArray (->$al_arreglosPCT;">=";->$al_PCTSaldos)
										AT_intersect (->$al_avisosSeleccionados;->$al_PCTSaldos;->$al_avisos2Calc)
										
									End if 
									
									For ($i;1;Size of array:C274($al_avisos2Calc))
										C_DATE:C307($vd_FechaCalculoMultaXC)
										$vl_idAviso:=alACT_AIDAviso{$al_avisos2Calc{$i}}
										$vd_FechaCalculoMultaXC:=KRL_GetDateFieldData (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$vl_idAviso;->[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
										
										$vl_diasAtraso:=vdACT_FechaPago-$vd_FechaCalculoMultaXC
										If ($vl_diasAtraso>0)
											vrACT_MontoMulta:=vrACT_MontoMulta+([xxACT_Items:179]Monto:7*$vl_diasAtraso)
										End if 
										
									End for 
									vrACT_MontoMulta:=ACTut_retornaMontoEnMoneda (vrACT_MontoMulta;[xxACT_Items:179]Moneda:10;vdACT_FechaPago;ST_GetWord (ACT_DivisaPais ;1;";"))
									
								End if 
							: (a_MultaCajaPorc=1)
								If (vr_PctMontoMultaCaja>0)
									C_REAL:C285($vr_montoAtrasado)
									ARRAY LONGINT:C221($al_avisosVencidos;0)
									ARRAY LONGINT:C221($al_avisosSeleccionados;0)
									ARRAY LONGINT:C221($al_avisos2Calc;0)
									abACT_ASelectedAvisos{0}:=True:C214
									AT_SearchArray (->abACT_ASelectedAvisos;"=";->$al_avisosSeleccionados)
									adACT_AFechaVencimiento{0}:=vdACT_FechaPago
									AT_SearchArray (->adACT_AFechaVencimiento;"<=";->$al_avisosVencidos)
									AT_intersect (->$al_avisosSeleccionados;->$al_avisosVencidos;->$al_avisos2Calc)
									For ($i;1;Size of array:C274($al_avisos2Calc))
										$vr_montoAtrasado:=$vr_montoAtrasado+ACTpgs_RetornaMontoXAviso ("MontoDesdeNoAvisos";False:C215;String:C10(alACT_AIDAviso{$al_avisos2Calc{$i}});vdACT_FechaPago)
									End for 
									ACTcfg_OpcionesRecargosCaja ("CalculaMontoMultaXCaja";->$vr_montoAtrasado)
								Else 
									LOG_RegisterEvt ("La multa automática no pudo ser generada porque se tiene configurado obtener el m"+"onto desde un porcentaje del monto del documento protestado pero el porcentaje no"+" fue ingresado o está en 0eb la configuración.")
								End if 
						End case 
					Else 
						LOG_RegisterEvt ("La multa automática no pudo ser generada porque el ítem de cargo seleccionado no "+"existe.")
					End if 
				Else 
					LOG_RegisterEvt ("La multa automática no pudo ser generada porque no existe configuración para dete"+"rminar el monto.")
				End if 
			Else 
				LOG_RegisterEvt ("La multa automática no pudo ser generada porque no se tiene configurado el ítem d"+"e cargo a"+"l cual asociar el monto del  recargo o multa.")
			End if 
		End if 
		
	: ($vt_accion="CalculaMontoMultaXCaja")
		If ((a_MultaCajaPorc#0) & (vr_PctMontoMultaCaja>0))
			vrACT_MontoMulta:=Round:C94($ptr1->*(vr_PctMontoMultaCaja/100);<>vlACT_Decimales)
		End if 
		
	: ($vt_accion="GeneraMultaXCaja")
		C_BOOLEAN:C305(vb_multaGenerada)
		vl_idCargoXCaja:=-1
		ACTcfg_OpcionesRecargosCaja ("LeeBlob")
		If (cbMultaXCaja=1)
			If (Not:C34(vb_multaGenerada))
				If (vlACT_idItemMulta#0)
					If (vrACT_MontoMulta>0)
						ACTcfg_ItemsMatricula ("InicializaYLee")
						C_LONGINT:C283($recNumPersona)
						READ ONLY:C145([Personas:7])
						READ ONLY:C145([ACT_CuentasCorrientes:175])
						$recNumPersona:=Record number:C243([Personas:7])
						ARRAY LONGINT:C221($DA_Return;0)
						abACT_ASelectedCargo{0}:=True:C214
						AT_SearchArray (->abACT_ASelectedCargo;"=";->$DA_Return)
						If (Size of array:C274($DA_Return)>0)
							QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=alACT_CIDCtaCte{$DA_Return{1}})
						Else 
							QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1;*)
							QUERY SELECTION:C341([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]Estado:4=True:C214)
							FIRST RECORD:C50([ACT_CuentasCorrientes:175])
						End if 
						If (((Records in selection:C76([ACT_CuentasCorrientes:175])>0) & (Records in selection:C76([Personas:7])>0)) | (vbACTpgs_PagoXTercero))
							$vl_idTercero:=0
							If (vbACTpgs_PagoXTercero)
								$vl_idTercero:=[ACT_Terceros:138]Id:1
							End if 
							vl_idCargoXCaja:=ACTac_CreateCargoDocCargoImp (True:C214;vlACT_idItemMulta;vrACT_MontoMulta;Current date:C33(*);False:C215;[ACT_CuentasCorrientes:175]ID:1;[Personas:7]No:1;False:C215;False:C215;$vl_idTercero)
							If (vl_idCargoXCaja=-1)
								LOG_RegisterEvt ("La multa automática no pudo ser generada.")
							End if 
							vlACT_idItemMulta:=0
							vrACT_MontoMulta:=0
							vb_multaGenerada:=True:C214
						Else 
							LOG_RegisterEvt ("La multa automática no pudo ser generada debido a que no fueron encontradas cuent"+"as y/o apoderados a los cuales hacer el cargo.")
						End if 
						ACTcfg_ItemsMatricula ("ActualizaCampoDesdeEmitido")
						KRL_GotoRecord (->[Personas:7];$recNumPersona)
					Else 
						LOG_RegisterEvt ("La multa automática no pudo ser generada porque el monto del movimiento no es may"+"or a 0.")
					End if 
				Else 
					LOG_RegisterEvt ("La multa automática no pudo ser generada porque no fue seleccionado un ítem de ca"+"rgo.")
				End if 
			End if 
		End if 
		
	: ($vt_accion="InsertaCargoXCaja4Pago")
		If (vl_idCargoXCaja#-1)
			ACTpgs_AppendCarToArray (vl_idCargoXCaja)
			vl_idCargoXCaja:=-1
		End if 
		
	: ($vt_accion="SeteaFiltroYFormatoCampoPct")
		$filter:="&"+ST_Qte ("0-9;"+<>tXS_RS_DecimalSeparator)
		OBJECT SET FILTER:C235($ptr1->;$filter)
		OBJECT SET FORMAT:C236($ptr1->;"###0"+<>tXS_RS_DecimalSeparator+"###")
		
	: ($vt_accion="ValidacionesFormCfg")
		If (cbMultaXCaja=1)
			_O_ENABLE BUTTON:C192(*;"multaCaja@")
			OBJECT SET ENTERABLE:C238(*;"multaCaja@";True:C214)
			If ((a_MultaCajaFija=0) & (a_MultaCajaPorc=0))
				a_MultaCajaFija:=1
			End if 
			If (a_MultaCajaFija=1)
				_O_ENABLE BUTTON:C192(*;"multaCaja2_@")
				OBJECT SET ENTERABLE:C238(*;"multaCaja2_@";True:C214)
				
				If (cs_multiplicarMontoRXC=1)
					OBJECT SET ENTERABLE:C238(*;"multaCaja2_0_@";True:C214)
					_O_ENABLE BUTTON:C192(*;"multaCaja2_0_@")
					If (cs_considerarAvisosDesde=1)
						OBJECT SET ENTERABLE:C238(vdACT_FechaRXC;True:C214)
						_O_ENABLE BUTTON:C192(bCalendarMXC)
						If (vdACT_FechaRXC=!00-00-00!)
							vdACT_FechaRXC:=Current date:C33(*)
						End if 
					Else 
						OBJECT SET ENTERABLE:C238(vdACT_FechaRXC;False:C215)
						_O_DISABLE BUTTON:C193(bCalendarMXC)
					End if 
					If (cs_considerarPCTAvisosMorosoRXC=1)
						OBJECT SET ENTERABLE:C238(vr_PctAvisosMorosos;True:C214)
					Else 
						OBJECT SET ENTERABLE:C238(vr_PctAvisosMorosos;False:C215)
					End if 
				Else 
					OBJECT SET ENTERABLE:C238(*;"multaCaja2_0_@";False:C215)
					_O_DISABLE BUTTON:C193(*;"multaCaja2_0_@")
					_O_DISABLE BUTTON:C193(bCalendarMXC)
					cs_considerarAvisosDesde:=0
					cs_considerarPCTAvisosMorosoRXC:=0
				End if 
				
				If (vr_PctAvisosMorosos<0)
					BEEP:C151
					vr_PctAvisosMorosos:=0
				End if 
				If (vr_PctAvisosMorosos>100)
					BEEP:C151
					vr_PctAvisosMorosos:=100
				End if 
			Else 
				cs_considerarAvisosDesde:=0
				cs_considerarPCTAvisosMorosoRXC:=0
				cs_multiplicarMontoRXC:=0
				_O_DISABLE BUTTON:C193(*;"multaCaja2_@")
				OBJECT SET ENTERABLE:C238(*;"multaCaja2_@";False:C215)
				_O_DISABLE BUTTON:C193(bCalendarMXC)
			End if 
			If (cs_considerarAvisosDesde=0)
				vdACT_FechaRXC:=!00-00-00!
			End if 
			If (cs_considerarPCTAvisosMorosoRXC=0)
				vr_PctAvisosMorosos:=0
			End if 
			If (a_MultaCajaPorc=1)
				OBJECT SET ENTERABLE:C238(vr_PctMontoMultaCaja;True:C214)
			Else 
				vr_PctMontoMultaCaja:=0
				OBJECT SET ENTERABLE:C238(vr_PctMontoMultaCaja;False:C215)
			End if 
			If (Size of array:C274(at_GlosasItems)=0)
				ACTcfg_OpcionesRecargosCaja ("BuscaItemsADesplegar")
			End if 
		Else 
			_O_DISABLE BUTTON:C193(*;"multaCaja@")
			OBJECT SET ENTERABLE:C238(*;"multaCaja@";False:C215)
			ACTcfg_OpcionesRecargosCaja ("InitVars")
		End if 
		If (vtACTcfg_SelectedItemNCaja="")
			vlACTcfg_SelectedItemIdCaja:=0
		End if 
		If (a_MultaCajaPorc=0)
			vr_PctMontoMultaCaja:=0
		End if 
		OBJECT SET ENTERABLE:C238(*;"multaCaja10";False:C215)
		
	: ($vt_accion="ValidacionesFormIngPagos")
		If (cbMultaXCaja=1)
			vrACT_MontoSeleccionado:=vrACT_MontoAPagar
			vrACT_MontoPago:=vrACT_MontoSeleccionado+vrACT_MontoMulta
			ACTcfgmyt_OpcionesGenerales ("SumaMontos")
			OBJECT SET VISIBLE:C603(*;"multaCfg@";True:C214)
			OBJECT SET ENTERABLE:C238(*;"multaCfg2";True:C214)
			OBJECT SET ENTERABLE:C238(vrACT_MontoPago;False:C215)
			If (cbMultaCajaPermiteMod=1)
				OBJECT SET ENTERABLE:C238(*;"multaCfg1";True:C214)
			Else 
				OBJECT SET ENTERABLE:C238(*;"multaCfg1";False:C215)
			End if 
		Else 
			OBJECT SET ENTERABLE:C238(vrACT_MontoPago;True:C214)
			OBJECT SET VISIBLE:C603(*;"multaCfg@";False:C215)
			OBJECT SET ENTERABLE:C238(*;"multaCfg@";False:C215)
		End if 
		
	: ($vt_accion="ValidacionesFormDocumentar")
		C_REAL:C285(vrACT_MontoSeleccionado)
		If (cbMultaXCaja=1)
			vrACT_MontoSeleccionado:=vrACT_MontoAPagar
			vrACT_MontoAPagarApdo:=vrACT_MontoSeleccionado+vrACT_MontoMulta
			OBJECT SET VISIBLE:C603(*;"multaCfg@";True:C214)
			OBJECT SET ENTERABLE:C238(*;"multaCfg2";True:C214)
			OBJECT SET ENTERABLE:C238(vrACT_MontoAPagarApdo;False:C215)
			If (cbMultaCajaPermiteMod=1)
				OBJECT SET ENTERABLE:C238(*;"multaCfg1";True:C214)
			Else 
				OBJECT SET ENTERABLE:C238(*;"multaCfg1";False:C215)
			End if 
		Else 
			OBJECT SET ENTERABLE:C238(vrACT_MontoAPagarApdo;True:C214)
			OBJECT SET VISIBLE:C603(*;"multaCfg@";False:C215)
			OBJECT SET ENTERABLE:C238(*;"multaCfg@";False:C215)
		End if 
End case 
