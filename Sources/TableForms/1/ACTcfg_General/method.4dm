Case of 
	: (Form event:C388=On Load:K2:1)
		ACTcfg_LoadConfigData (1)
		ACTinit_FirstRelease 
		XS_SetConfigInterface 
		ACTcfg_OpcionesRecargos ("DeclaraVars")
		ACTcfg_OpcionesRecargosCaja ("DeclaraVars")
		ACTcfg_OpcionesRecargosAut ("DeclaraVars")
		C_BOOLEAN:C305(vb_muestraMensaje)
		C_REAL:C285(cbUsarDescuentosXSeparado;cbConsiderarDctoMaximo;vr_descuentoMaximo;cbCrearDctosEnLineasSeparadas)
		vb_muestraMensaje:=True:C214
		
		vtACT_InicioEjercicio:=String:C10(<>vdACT_InicioEjercicio;7)
		vtACT_TerminoEjercicio:=String:C10(<>vdACT_TerminoEjercicio;7)
		bAvisoApoderadoInitial:=bAvisoApoderado
		bAvisoAlumnoInitial:=bAvisoAlumno
		If (cb_PermitePorCta=1)
			IT_SetButtonState (True:C214;->cbDatosCta;->cbDatosApdo)
		Else 
			cbDatosApdo:=1
			cbDatosCta:=0
			IT_SetButtonState (False:C215;->cbDatosCta;->cbDatosApdo)
		End if 
		If (mOrdenInterno=1)
			vtACT_DescOrdenes:="Cargos vencidos, cargos no pertenecientes a la matriz, cargos pertenecientes a la"+" matriz en el orden establecido por la matriz."
		Else 
			vtACT_DescOrdenes:="Cuenta corriente, glosa, saldo, fecha de emisión, fecha de vencimiento."
		End if 
		vl_decimales:=<>vlACT_NoDecimalesDespl
		IT_SetEnterable (cbConsiderarDctoMaximo=1;0;->vr_descuentoMaximo)
		IT_SetButtonState (cbFPXDefecto=1;->btnFDPXDef;->bFormasdePago)
		IT_SetButtonState (cb_IncluirSaldosAnteriores=1;->cb_CalcularParaTodosLosAvisos)
		ACTcfg_OpcionesRecargos ("SeteaFiltroYFormatoCampoPct";->vr_PctMontoMulta)
		ACTcfg_OpcionesRecargosCaja ("SeteaFiltroYFormatoCampoPct";->vr_PctMontoMultaCaja)
		ACTcfg_OpcionesRecargosAut ("SeteaFiltroYFormatoCampoPct";->vr_PctMontoRecAut)
		C_LONGINT:C283(vl_lastTab;vlACTcfg_Recargos)
		
		SELECT LIST ITEMS BY POSITION:C381(vlACTcfg_Recargos;1)
		vl_lastTab:=0
		
		If (Num:C11(ACTcfg_OpcionesTextoMail ("ValidaRBD"))=1)
			OBJECT SET VISIBLE:C603(*;"Email@";False:C215)
		End if 
		If (csACTcfg_MostrarDctos=0)
			csACTcfg_AgruparDctosEnCaja:=0
			_O_DISABLE BUTTON:C193(csACTcfg_AgruparDctosEnCaja)
		Else 
			_O_ENABLE BUTTON:C192(csACTcfg_AgruparDctosEnCaja)
		End if 
		
		C_BOOLEAN:C305($enable)
		$enable:=Choose:C955((cbAgrupar=1) | (cbAgruparXAlumnoItem=1);True:C214;False:C215)
		cb_AgruparCargos:=Choose:C955($enable;1;0)
		OBJECT SET ENABLED:C1123(cbAgrupar;$enable)
		OBJECT SET ENABLED:C1123(cbAgruparXAlumnoItem;$enable)
		
		ACTcfg_OpcionesPagares ("OnLoad")
		
		OBJECT SET ENTERABLE:C238(abACTcfg_aplicaATotal;(cbUsarDescuentosXSeparado=1))
		
		OBJECT SET ENABLED:C1123(cb_SepararACsXPct;(cb_SepararCargosXPct=1))
		OBJECT SET ENABLED:C1123(cb_SepararDTsXPct;(cb_SepararCargosXPct=1))
		
		If ((<>gCountryCode="cl") | (<>gCountryCode="uy"))  //20180406 RCH
			OBJECT SET FORMAT:C236(*;"rs_rut";"###.###.###-#")
			OBJECT SET FORMAT:C236(*;"rs_rut_rp";"###.###.###-#")
		End if 
		
		
	: (Form event:C388=On Clicked:K2:4)
		$tab:=Selected list items:C379(vlACT_ConfigGenerales)
		Case of 
			: ($tab=1)
				IT_SetButtonState (cbFPXDefecto=1;->btnFDPXDef;->bFormasdePago)
				vt_FormadePagoXDef:=ST_Boolean2Str (cbFPXDefecto=0;ACTcfgfdp_OpcionesGenerales ("fdpFromLista");vt_FormadePagoXDef)
				If (csACTcfg_MostrarDctos=0)
					csACTcfg_AgruparDctosEnCaja:=0
					_O_DISABLE BUTTON:C193(csACTcfg_AgruparDctosEnCaja)
				Else 
					_O_ENABLE BUTTON:C192(csACTcfg_AgruparDctosEnCaja)
				End if 
				
				OBJECT SET ENABLED:C1123(cb_SepararACsXPct;(cb_SepararCargosXPct=1))
				OBJECT SET ENABLED:C1123(cb_SepararDTsXPct;(cb_SepararCargosXPct=1))
				
			: ($tab=2)
				ACTcfg_OpcionesRazonesSociales ("SeteaObjetos")
				  //20140708 RCH Si es emisor electrónico, se bloquea la edición del RUT para evitar que puedan cambiarlo y obtener datos asociados a otros RUT
				OBJECT SET ENTERABLE:C238([ACT_RazonesSociales:279]RUT:3;(Not:C34([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? 1)))
				
			: ($tab=3)
				If (cbConsiderarDctoMaximo=1)
					OBJECT SET ENTERABLE:C238(vr_descuentoMaximo;True:C214)
				Else 
					OBJECT SET ENTERABLE:C238(vr_descuentoMaximo;False:C215)
					vr_descuentoMaximo:=0
				End if 
				
			: ($tab=4)
				If (cb_IncluirSaldosAnteriores=0)
					cb_CalcularParaTodosLosAvisos:=0
					_O_DISABLE BUTTON:C193(cb_CalcularParaTodosLosAvisos)
				Else 
					_O_ENABLE BUTTON:C192(cb_CalcularParaTodosLosAvisos)
				End if 
				
				  //20170507 RCH
				OBJECT SET ENABLED:C1123(cs_GeneraAvisoPorFamilia;(bAvisoApoderado=1))
				If (bAvisoAlumno=1)
					cs_GeneraAvisoPorFamilia:=0
				End if 
				
			: ($tab=5)
				OBJECT SET VISIBLE:C603(*;"cbMultaXCaja@";False:C215)
				OBJECT SET VISIBLE:C603(*;"multaCaja@";False:C215)
				OBJECT SET VISIBLE:C603(*;"cbMultaXProtesto@";False:C215)
				OBJECT SET VISIBLE:C603(*;"multaProt@";False:C215)
				OBJECT SET VISIBLE:C603(*;"cbMultaAut@";False:C215)
				OBJECT SET VISIBLE:C603(*;"multaAut@";False:C215)
				OBJECT SET VISIBLE:C603(*;"cbRecargoAutXTramo@";False:C215)
				OBJECT SET VISIBLE:C603(*;"multaXTramo@";False:C215)
				
				If (Is a list:C621(vlACTcfg_Recargos))
					vl_lastTab:=Selected list items:C379(vlACTcfg_Recargos)
				Else 
					vl_lastTab:=0
				End if 
				Case of 
					: (vl_lastTab=1)
						OBJECT SET VISIBLE:C603(*;"cbMultaXCaja@";True:C214)
						OBJECT SET VISIBLE:C603(*;"multaCaja@";True:C214)
						ACTcfg_OpcionesRecargosCaja ("ValidacionesFormCfg")
					: (vl_lastTab=2)
						OBJECT SET VISIBLE:C603(*;"cbMultaXProtesto@";True:C214)
						OBJECT SET VISIBLE:C603(*;"multaProt@";True:C214)
						ACTcfg_OpcionesRecargos ("ValidacionesForm")
					: (vl_lastTab=3)
						OBJECT SET VISIBLE:C603(*;"cbMultaAut@";True:C214)
						OBJECT SET VISIBLE:C603(*;"multaAut@";True:C214)
						ACTcfg_OpcionesRecargosAut ("ValidacionesForm")
						
					: (vl_lastTab=4)
						OBJECT SET VISIBLE:C603(*;"cbRecargoAutXTramo@";True:C214)
						OBJECT SET VISIBLE:C603(*;"multaXTramo@";True:C214)
						ACTcfg_OpcionesRecAutTabla ("ValidacionesForm")
						
				End case 
				ACTcfg_OpcionesCondonacion ("ValidacionesForm")
				
			: ($tab=6)
				ACTcfg_OpcionesPagares ("OcultaAreasCarreras_Dctos")
				
				ACTcfg_OpcionesPagares ("SetEstadoTacho")
				ACTcfg_OpcionesPagares ("SetEstadoTachoDctos")
				
				If (cs_genPagare=0)
					cs_imprimirPagare:=0
					_O_DISABLE BUTTON:C193(cs_imprimirPagare)
				Else 
					_O_ENABLE BUTTON:C192(cs_imprimirPagare)
				End if 
				
		End case 
		
		OBJECT SET ENTERABLE:C238(abACTcfg_aplicaATotal;(cbUsarDescuentosXSeparado=1))
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		HL_ClearList (hl_Pagina1)
		POST KEY:C465(27;0)
End case 
