Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		ACTcfg_OpcionesReimpBoletas ("InitVars")
		
		ACTcfg_InitBolArrays 
		vtACT_ModRecibo:=__ ("Seleccionar...")
		vlACT_NextRecibo:=0
		vtACT_PrinterRecibo:=__ ("Seleccionar...")
		vtACT_CatVR:=__ ("Seleccionar...")
		vlACT_CatVR:=0
		ACTcfg_OpcionesRazonesSociales ("LoadConfig")
		ACTcfg_LoadConfigData (8)
		
		  //20130211 RCH valido el icono porque en la actualizacion en server no se agrego solo
		For ($i;1;Size of array:C274(abACT_EmiteAfectoExento))
			If (abACT_EmiteAfectoExento{$i}=True:C214)
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_EmiteAfectoExento{$i})
			Else 
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_EmiteAfectoExento{$i})
			End if 
		End for 
		
		If ((btnUsuario=0) & (btnRBD=0))
			btnUsuario:=1
		End if 
		ACTbol_LeeListaDocsTribs ("LeeLista")
		
		xALPSet_ACT_TiposdeDoc 
		xALPSet_ACT_CatsDT 
		xALPSet_ACT_Modelos 
		ACTcfg_SetDocRowsColor 
		AL_SetSort (ALP_TiposdeDoc;2;3)
		AL_SetSort (xALP_CatsDT;2)
		AL_SetSort (xAL_Modelos;1)
		AL_SetLine (ALP_TiposdeDoc;0)
		AL_SetLine (xALP_CatsDT;0)
		AL_SetLine (xAL_Modelos;0)
		IT_SetButtonState ((Not:C34(bBoletasAgregadas=0));->cb_BoletaPorItem)
		If (bBoletasAgregadas=0)
			cb_BoletaPorItem:=0
		End if 
		
		atACT_ModelosDoc:=0
		vtACT_ModelosDoc:=""
		IT_SetButtonState (False:C215;->bEditarModelo;->bGuardarModelo;->bBorrarModelo;->bDuplicarModelo;->bDelDoc;->bDelCat)
		ACTinit_FirstRelease 
		
		vlACT_TempNextRecibo:=vlACT_NextRecibo
		vtACT_EstadisticaCat:=__ ("Ninguna categoría seleccionada.")
		
		If (cb_UtilizaMultiNum=1)
			_O_DISABLE BUTTON:C193(*;"btn@")
		Else 
			_O_ENABLE BUTTON:C192(*;"btn@")
		End if 
		ACTcfgbol_OpcionesMultiNum ("llenaPopUp";->atACT_RBDList)
		If ((btnUsuario=0) & (btnRBD=0))
			cb_UtilizaMultiNum:=0
			btnUsuario:=1
		End if 
		If ((cb_EmiteXApoderado=0) & (cb_EmiteXCuenta=0))
			cb_EmiteXApoderado:=1
		End if 
		
		If (Size of array:C274(atACT_Impresoras)=1)
			vtACT_PrinterRecibo:=atACT_Impresoras{1}
		End if 
		IT_SetButtonState ((cb_GenerarBoletaCaja=1);->cb_GenerarBoletaCero)
		ACTcfg_MarkStandardDTModels 
		$cond:=((Not:C34(Is compiled mode:C492)) & (<>lUSR_CurrentUserID<0))
		OBJECT SET VISIBLE:C603(*;"estandar@";$cond)
		cb_EsEstandar:=0
		_O_DISABLE BUTTON:C193(cb_EsEstandar)
		IT_SetButtonState ((cb_BoletaSubvencionada=1);->bConfigSubvencionada)
		OBJECT SET VISIBLE:C603(*;"subvencionados@";(<>vtXS_CountryCode="cl"))
		ACTcfg_OpcionesReimpBoletas ("SeteaFiltroYFormatoCampoPct";->vr_PctMontoMulta)
		
		$vb_hayVentanaPago:=ACTcfg_LeeConfEnNuevoProc ("LeeConfEnOtroProceso")
		If ($vb_hayVentanaPago)
			CD_Dlog (0;__ ("Hay al menos una ventana de pagos abierta en este u otro equipo. Los posibles cambios no serán almacenados."))
		End if 
		
		  //cambio de nombre a pestaña
		Case of 
				  // Modificado por: Saúl Ponce (05-04-2017) Ticket 168412, habilitación de la pestaña para UY
			: (<>gCountryCode="uy")
				SET LIST ITEM PROPERTIES:C386(hl_ACT_cfgDocTrib;4;True:C214;Plain:K14:1;0)
				SET LIST ITEM:C385(hl_ACT_cfgDocTrib;4;__ ("Facturas Electrónicas");4)
			: (<>gCountryCode="ar")
				SET LIST ITEM PROPERTIES:C386(hl_ACT_cfgDocTrib;4;True:C214;Plain:K14:1;0)
				SET LIST ITEM:C385(hl_ACT_cfgDocTrib;4;__ ("Facturas Electrónicas");4)  // facturas electrónicas
				
			: (<>gCountryCode="mx")
				SET LIST ITEM PROPERTIES:C386(hl_ACT_cfgDocTrib;4;True:C214;Plain:K14:1;0)
				SET LIST ITEM:C385(hl_ACT_cfgDocTrib;4;__ ("Comprobantes Digitales");4)  // comprobantes fiscales digitales
				
			: (<>gCountryCode="cl")
				SET LIST ITEM PROPERTIES:C386(hl_ACT_cfgDocTrib;4;True:C214;Plain:K14:1;0)
				  //20120303 RCH valores por defecto DTE
				C_TEXT:C284($vt_propiedad;vtACT_rutaClienteXDef)
				$vt_propiedad:="FILE|rutaAlmacenamientoArchivosCliente"
				vtACT_rutaClienteXDef:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
				
			Else 
				  //para todos los paises por ahora esta deshabilitado
				SET LIST ITEM PROPERTIES:C386(hl_ACT_cfgDocTrib;4;False:C215;Plain:K14:1;0)
		End case 
		
		hl_listConfCFDI:=New list:C375
		APPEND TO LIST:C376(hl_listConfCFDI;__ ("Certificados");1)
		APPEND TO LIST:C376(hl_listConfCFDI;__ ("Propiedades");2)
		APPEND TO LIST:C376(hl_listConfCFDI;__ ("Rutas");3)
		SELECT LIST ITEMS BY POSITION:C381(hl_listConfCFDI;1)
		OBJECT SET VISIBLE:C603(lb_generacionFIle;False:C215)
		OBJECT SET VISIBLE:C603(lb_generacionXML;False:C215)
		OBJECT SET VISIBLE:C603(*;"cert@";True:C214)
		_O_ENABLE BUTTON:C192(at_proveedores)
		
		KRL_FindAndLoadRecordByIndex (->[ACT_RazonesSociales:279]id:1;->alACTcfg_Razones{atACTcfg_Razones};True:C214)
		ACTcfgbol_OpcionesDTE ("OnLoadForm")
		
		ACTfear_OpcionesGenerales ("SetObjetosConf")
		
		  //opciones dte cl
		ACTdte_OpcionesManeja ("ArreglosVars")
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Double Clicked:K2:5))
		$tab:=Selected list items:C379(hl_ACT_cfgDocTrib)
		Case of 
			: ($tab=2)
				AL_SetEnterable (ALP_TiposdeDoc;2;2;atACT_Categorias)
				AL_UpdateArrays (ALP_TiposdeDoc;-2)
				If (cb_UtilizaMultiNum=0)
					_O_DISABLE BUTTON:C193(*;"btn@")
				Else 
					_O_ENABLE BUTTON:C192(*;"btn@")
				End if 
				If ((btnUsuario=0) & (btnRBD=0))
					btnUsuario:=1
				End if 
			: ($tab=1) | ($tab=0)
				ACTcfg_OpcionesReimpBoletas ("ValidacionesForm")
				
			: ($tab=4)
				
				OBJECT SET ENABLED:C1123(*;"cs_conf_2_@";cs_emitirCFDI=1)
				OBJECT SET ENABLED:C1123(at_proveedores;cs_emitirCFDI=1)
				OBJECT SET ENABLED:C1123(*;"edit_Proveedor@";cs_emitirCFDI=1)
				OBJECT SET ENABLED:C1123(*;"carga_Proveedor@";cs_emitirCFDI=1)
				
				If (cs_emitirCFDI=0)
					cs_generarArchivoIP:=0
					cs_asignarFolio:=0
					cs_imprimirDocumento:=0
				Else 
					  //si el proveedor es distinto de colegium se habilita...
					ARRAY TEXT:C222($at_proveedores;0)
					ACTdte_OpcionesGenerales ("CargaProveedoresXDefecto";->$at_proveedores)
					OBJECT SET ENABLED:C1123(*;"edit_Proveedor@";((Find in array:C230($at_proveedores;at_proveedores{at_proveedores})=-1) & (at_proveedores<=Size of array:C274(at_proveedores))))
				End if 
				
				If (cs_generarArchivoIP=0)
					vtACT_rutaServer:=""
					vtACT_rutaCliente:=""
				End if 
				OBJECT SET ENABLED:C1123(*;"vtACT_rutaServer";cs_generarArchivoIP=1)
				OBJECT SET ENABLED:C1123(*;"vtACT_rutaCliente";cs_generarArchivoIP=1)
				
				If (<>gCountryCode="cl")
					  //OBJECT SET ENABLED(*;"cs_conf_2_0";(at_proveedores{at_proveedores}#"Colegium"))
					  //OBJECT SET ENABLED(*;"cs_conf_2_1";(at_proveedores{at_proveedores}#"Colegium"))
					  //OBJECT SET ENABLED(*;"cs_conf_2_3";(at_proveedores{at_proveedores}#"Colegium"))
					
					OBJECT SET ENABLED:C1123(*;"cs_conf_2_@";(at_proveedores{at_proveedores}#"Colegium"))
					
					If (at_proveedores{at_proveedores}="Colegium")  //20140818 RCH
						cs_asignarFolio:=0
						cs_generarArchivoIP:=0
						cs_imprimirDocumento:=0
					End if 
					
				End if 
		End case 
		ACTcfgbol_OpcionesDTE ("SetVisibleConf")
		
		  //20131129
		ACTdte_AlertasOpciones ("ValidaVariablesForm")
		
		  //20150811 RCH
		If (r_generaDTEAlIngresarPago=0)
			r_abrirDTEAlIngresarPago:=0
			r_enviarDTEAlIngresarPago:=0
			r_abrirDTEIngresoPagoNoReceptor:=0
		End if 
		OBJECT SET ENABLED:C1123(r_abrirDTEAlIngresarPago;r_generaDTEAlIngresarPago=1)
		OBJECT SET ENABLED:C1123(r_enviarDTEAlIngresarPago;r_generaDTEAlIngresarPago=1)
		OBJECT SET ENABLED:C1123(r_abrirDTEIngresoPagoNoReceptor;r_generaDTEAlIngresarPago=1)
		
		OBJECT SET ENABLED:C1123(r_abrirDTEIngresoPagoNoReceptor;r_abrirDTEAlIngresarPago=1)
		r_abrirDTEIngresoPagoNoReceptor:=Choose:C955((r_abrirDTEAlIngresarPago=0);0;r_abrirDTEIngresoPagoNoReceptor)
		
	: (Form event:C388=On Data Change:K2:15)
		  // Modificado por: Saúl Ponce (11-10-2016) Ticket N° 168906
		ACT_LimpiaTexto 
End case 
