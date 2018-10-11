//%attributes = {}
  //ACTcfg_LoadConfigData

C_BLOB:C604(xBlob)
ACTdesc_OpcionesVariables ("DeclaraVars")
C_REAL:C285(<>vrACT_FactorIVA;<>vrACT_TasaIVA;<>vrACT_TasaInterés;<>vrACT_MultaRetardo)
  //<>vrACT_TasaIVA:=19
  //<>vrACT_FactorIVA:=1+(<>vrACT_TasaIVA/100)
  //<>vrACT_MultaRetardo:=0

  //carga los datos correspondientes a cada página de configuracion

$page:=$1

Case of 
	: ($page=1)  //general
		  //  `ejercicio        
		  //xBlob:=PREF_fGetBlob (0;"ACT_PreferenciasGenerales";xBlob)
		  //BLOB_Blob2Vars (->xBlob;0;-><>vdACT_InicioEjercicio;-><>vdACT_TerminoEjercicio)
		  //SET BLOB SIZE(xBlob;0)
		
		  //Descuentos familia (orden alumnos) 
		  //xBlob:=PREF_fGetBlob (0;"ACT_DescuentosFamilia";xBlob)
		  //BLOB_Blob2Vars (->xBlob;0;->gGroupByFamily;->gGroupByGardian;->oOrderbyBirthDate;->oOrderByClass;->nOrdenAscendiente;->nOrdenDescendiente;->cbUsarDescuentosFamilia;->cbUsarDescuentosIngresos;->cbUsarDescuentosIndividual;->cbIncluirAdmision;->cbUsarDescuentosCargas)
		ACTcfg_LeeBlob ("ACT_DescuentosFamilia")
		
		  //preferencias generación de deuda
		  //xBlob:=PREF_fGetBlob (0;"ACT_Deudas";xBlob)
		  //BLOB_Blob2Vars (->xBlob;0;->cb_GenerarDeudaAuto;->dDeudaTodo;->dDeudaMes;->mMesComenzado;->mMesVencido;->viACT_DiaDeuda;->vs_labelDiaDeuda;->viACT_DiaVencimiento;->viACT_DiasRetardo;->viACT_DiaVencimiento2;->viACT_DiaVencimiento3;->viACT_DiaVencimiento4)
		ACTcfg_LeeBlob ("ACTcfg_GeneralesDeudas")
		
		  //preferencias de avisos de cobranza
		ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
		
		$vb_readWrite:=True:C214
		ACTcfg_OpcionesRazonesSociales ("LoadConfig";->$vb_readWrite)
		
		  //xBlob:=PREF_fGetBlob (0;"SelIngPagos";xBlob)
		  //BLOB_Blob2Vars (->xBlob;0;->cbDatosCta;->cbDatosApdo;->cb_PermitePorCta;->cb_soloCuotasVencidas)
		ACTcfg_LeeBlob ("ACTcfg_GeneralesIngresoPagos")
		
		  //Tramos de ingreso
		hl_TramosIngreso:=LOC_LoadList ("ACT_TramosIngreso")
		OBJECT SET ENTERABLE:C238(hl_TramosIngreso;True:C214)
		
		  // Otras preferencias
		viACT_ACTDecideApoderado:=Num:C11(PREF_fGet (0;"ACT_DecideApoderado";"1"))
		viACT_AsignarMatAdmision:=Num:C11(PREF_fGet (0;"ACT_AsignarMatAdmision";"1"))
		
		ACTinit_CreateDefAfectasInteres ("LeeBlob")
		
		ACTcfgfdp_OpcionesGenerales ("loadcfg_FdPXDef")
		ACTcfg_LeeBlob ("ACTcfg_AlertasYOtros")
		ACTcfg_OpcionesRecargos ("LeeBlob")
		ACTcfg_OpcionesCondonacion ("LeeBlob")
		ACTcfg_OpcionesRecargosCaja ("LeeBlob")
		ACTcfg_OpcionesRecargosAut ("LeeBlob")
		ACTcfg_OpcionesTareasFinDia ("LeeBlob")
		ACTcfg_OpcionesDetallePagos ("LeeBlob")
		
		  //recargos segun tabla
		ACTcfg_OpcionesRecAutTabla ("LeeConf")
		
		ACTcfg_OpcionesGenABancarios ("LeeBlob")
		
		  //  //20130813 RCH Webpay
		  //ACTcfg_OpcionesWebpay ("LeeBlob")
		
		  //20160713 RCH
		ACTcfg_OpcionesDescuentos ("CargaConf")
		
		  //20161002 RCH
		ACTcfg_OpcionesCorrelativoPago ("LeeConf")
		
		ACTcc_DividirEmision ("LeeConf")
		
		ACTcfg_OpcionesGenRecibo ("LeeConf")
		
	: ($page=2)  //items de cargo
		ACTcfgmyt_OpcionesGenerales ("LeeMonedas")
		  //ACTcfgmyt_OpcionesGenerales ("ValidaMonedaXDefecto")
		
		AL_UpdateArrays (xALP_Items;0)
		
		ARRAY REAL:C219(arACT_DesctoPorHijo;16)
		ARRAY REAL:C219(arACT_DesctoTramo;16)
		ARRAY REAL:C219(arACT_DesctoPorFamilia;16)
		vi_lastLine:=0
		
		ACTitems_CargaLista (__ ("Todos"))
		
		If (Records in selection:C76([xxACT_Items:179])>0)
			vi_lastLine:=1
			ACTdesc_OpcionesVariables ("LeeConfItem";->alACT_IdItem{vi_lastLine})
		Else 
			  //aqui tenemos que resolver el hecho de que no haya ningun item creado y noi se vean los campos.
			CD_Dlog (0;__ ("No existen definiciones de items de cargo.\rSe creará uno ahora."))
			
			ACTitems_CreaItemConf 
			ACTcfg_SaveItemdeCargo   //20140410 ASM Para guardar el item de cargo.
		End if 
		ACTitems_CargaItemConf 
		
	: ($page=3)  //matrices
		AL_UpdateArrays (xALP_Items2;0)
		AL_UpdateArrays (xALP_Matrices;0)
		ACTcfg_LoadDataMatrices 
		ACTcfg_UpdateItems2Area 
		AL_UpdateArrays (xALP_Items2;-2)
		AL_UpdateArrays (xALP_Matrices;-2)
		If (Size of array:C274(alACT_IDItem)>0)
			AL_SetLine (xALP_Items2;1)
		Else 
			AL_SetLine (xALP_Items2;0)
		End if 
		ARRAY INTEGER:C220($select;1)
		$select{1}:=0
		AL_SetSelect (xALP_Matrices;$select)
		ACTcfg_TestMatrixButtons 
	: ($page=4)  //bancos
		  //$offset:=0
		  //SET BLOB SIZE(xblob;0)
		  //AL_UpdateArrays (xALP_Bancos;0)
		  //ARRAY TEXT(atACT_BankID;0)
		  //ARRAY TEXT(atACT_BankName;0)
		  //BLOB_Variables2Blob (->xblob;0;->atACT_BankID;->atACT_BankName)
		  //
		  //xblob:=PREF_fGetBlob (0;"ACT_Bancos";xblob)
		  //BLOB_Blob2Vars (->xblob;0;->atACT_BankID;->atACT_BankName)
		  //SORT ARRAY(atACT_BankName;atACT_BankID;>)
		  //SET BLOB SIZE(xblob;0)
		  //AL_UpdateArrays (xALP_Bancos;-2)
		  //AL_SetLine (xALP_Bancos;0)
		  //DISABLE BUTTON(bClearBank)
		AL_UpdateArrays (xALP_Bancos;0)
		
		ACTcfgmyt_CargaArreglos 
		
		AL_UpdateArrays (xALP_Bancos;-2)
		AL_SetLine (xALP_Bancos;0)
		For ($i;1;Size of array:C274(abACT_BankModified))
			ARRAY LONGINT:C221($LongArray;2;0)
			If (abACT_BankEstandar{$i})
				$enterable:=Num:C11(<>lUSR_CurrentUserID<0)
				AL_SetCellEnter (xALP_Bancos;1;$i;2;$i;$LongArray;$enterable)
				AL_SetCellStyle (xALP_Bancos;1;$i;2;$i;$LongArray;2;"")
			End if 
		End for 
		_O_DISABLE BUTTON:C193(bClearBank)
		_O_DISABLE BUTTON:C193(bEstandar)
		vtACT_PaisBancos:=<>vtXS_CountryCode
		
	: ($page=5)  //listas
		ACTcfg_Listas 
	: ($page=6)  //tasas y monedas
		
		  //AL_UpdateArrays (xALP_Divisas;0)
		  //AL_UpdateArrays (xALP_UF;0)
		  //AL_UpdateArrays (xALP_IPC;0)
		  //AL_UpdateArrays (xALP_Impuesto;0)
		READ ONLY:C145([xShell_Prefs:46])
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="ACT_IPC@";*)
		QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]User:9=0)
		ARRAY LONGINT:C221(alACT_IPCYEars;Records in selection:C76([xShell_Prefs:46]))
		
		For ($i;1;Records in selection:C76([xShell_Prefs:46]))
			alACT_IPCYEars{$i}:=Num:C11(ST_GetWord ([xShell_Prefs:46]Reference:1;2))
			NEXT RECORD:C51([xShell_Prefs:46])
		End for 
		
		SORT ARRAY:C229(alACT_IPCYEars;>)
		vl_LastYear:=Year of:C25(Current date:C33(*))
		alACT_IPCYEars:=Find in array:C230(alACT_IPCYEars;vl_LastYear)
		  //BUTTON TEXT(bMantenerSincro;"Sincronizar con SII (año "+String(alACT_IPCYEars{alACT_IPCYEars})+")")
		
		ARRAY INTEGER:C220(aiACT_YearIPC;12)
		ARRAY TEXT:C222(atACT_MesIPC;12)
		ARRAY REAL:C219(arACT_VariacionIPC;12)
		ARRAY REAL:C219(arACT_UFReferencia;12)
		If (alACT_IPCYEars=-1)
			COPY ARRAY:C226(<>atXS_MonthNames;atACT_MesIPC)
			AT_Populate (->aiACT_YearIPC;->vl_LastYear)
			SET BLOB SIZE:C606(xBlob;0)
			BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
			PREF_SetBlob (0;"ACT_IPC "+String:C10(vl_LastYear);xBlob)
			QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="ACT_IPC@";*)
			QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]User:9=0)
			ARRAY LONGINT:C221(alACT_IPCYEars;Records in selection:C76([xShell_Prefs:46]))
			
			For ($i;1;Records in selection:C76([xShell_Prefs:46]))
				alACT_IPCYEars{$i}:=Num:C11(ST_GetWord ([xShell_Prefs:46]Reference:1;2))
				NEXT RECORD:C51([xShell_Prefs:46])
			End for 
			
			SORT ARRAY:C229(alACT_IPCYEars;>)
			vl_LastYear:=Year of:C25(Current date:C33(*))
			alACT_IPCYEars:=Find in array:C230(alACT_IPCYEars;vl_LastYear)
			OBJECT SET TITLE:C194(bMantenerSincro;__ ("Sincronizar con SII (año ")+String:C10(alACT_IPCYEars{alACT_IPCYEars})+")")
		End if 
		xBlob:=PREF_fGetBlob (0;"ACT_IPC "+String:C10(vl_LastYear);xBlob)
		BLOB_Blob2Vars (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		SET BLOB SIZE:C606(xBlob;0)
		  //AL_UpdateArrays (xALP_IPC;-2)
		
		  //monedas
		ACTcfg_AddRemoveUF 
		  //ACTcfgmyt_OpcionesGenerales ("LeeMonedas")
		  //ACTcfgmyt_OpcionesGenerales ("ValidaMonedaXDefecto")
		  //AL_UpdateArrays (xALP_UF;-2)
		
		  //AL_UpdateArrays (xALP_Divisas;-2)
		  //ACTcfg_ColorUndelDivisas 
		
		  //iVA, Tasa Interes, etc.
		xBlob:=PREF_fGetBlob (0;"ACT_IVA_tasas";xBlob)
		BLOB_Blob2Vars (->xBlob;0;-><>vrACT_TasaIVA;-><>vrACT_FactorIVA;-><>vrACT_TasaInterés;-><>vrACT_MultaRetardo)
		SET BLOB SIZE:C606(xBlob;0)
		
		  //Impuesto timbres y estampillas
		ARRAY LONGINT:C221(alACT_AñoTasaImpuesto;0)
		ARRAY REAL:C219(arACT_TasaMesImpuesto;0)
		ARRAY REAL:C219(arACT_TasaMaximaImpuesto;0)
		xBlob:=PREF_fGetBlob (0;"ACT_ImpuestoTimbres";xBlob)
		BLOB_Blob2Vars (->xBlob;0;->alACT_AñoTasaImpuesto;->arACT_TasaMesImpuesto;->arACT_TasaMaximaImpuesto)
		SET BLOB SIZE:C606(xBlob;0)
		  //AL_UpdateArrays (xALP_Impuesto;-2)
		
	: ($page=7)  //Archivos Bancarios
		
	: ($page=8)  //Documentos Tributarios
		ACTcfg_LoadPrinters 
		ACTcfg_LoadBolModels 
		ACTcfg_InitBolArrays 
		SET BLOB SIZE:C606(xBlob;0)
		
		  //20120225 RCH Se pasa a metod actcfg_leeBlob
		  //xBlob:=PREF_fGetBlob (0;"ACT_DocsTributarios";xBlob)
		  //  //BLOB_Blob2Vars (->xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada)
		  //BLOB_Blob2Vars (->xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada;->atACT_idNumeracion;->cb_UtilizaMultiNum;->btnUsuario;->btnRBD;->cb_EmiteXApoderado;->cb_EmiteXCuenta;->atACT_RazonSocial;->alACT_RazonSocial;->cb_Sincroniza;->alACT_IdDTSinc;->atACT_DTSinc;->cbOrdenaRegXFam;->vlACTdt_numLineas)
		ACTcfg_LeeBlob ("ACT_DocsTributarios")
		
		SET BLOB SIZE:C606(xBlob;0)
		ACTbol_LoadParamsSubvenciones 
		ACTcfg_TranslateDocsTribData 
		ACTcfg_OpcionesReimpBoletas ("LeeBlob")
		
		ACTcfg_OpcionesRazonesSociales ("LeePreferencias")  //en la emision de boletas se testea si hay multinumeracion
		
		C_LONGINT:C283(vlACTdt_numLineasOrg)
		vlACTdt_numLineasOrg:=vlACTdt_numLineas
		
		  // lee razones
		ACTcfdi_OpcionesGenerales ("CargaConf")
		
		  //carga conf alertas
		ACTdte_AlertasOpciones ("LeeBlob";->vlACT_RSSel)
		
		  //20150203 RCH carga opciones dte
		ACTdte_OpcionesManeja ("LeeBlob";->vlACT_RSSel)
		
		ACTfear_OpcionesGenerales ("CargaConf";->vlACT_RSSel)
		
		ACTcc_DividirEmision ("LeeConf")  //20170711 RCH
		
	: ($page=9)  //Formas de Pago
		ACTinit_LoadFdPago 
	: ($page=10)  //Contabilidad
		ACTcfg_OpcionesContabilidad ("CargaConfiguracion")
		
End case 