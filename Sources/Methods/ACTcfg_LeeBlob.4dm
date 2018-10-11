//%attributes = {}
  //ACTcfg_LeeBlob

C_TEXT:C284($1;$accion)
C_BLOB:C604(xBlob)
SET BLOB SIZE:C606(xBlob;0)
C_OBJECT:C1216($ob_conf;$0;$ob_retorno)

$accion:=$1
Case of 
	: ($accion="ACTcfg_GeneralesIngresoPagos")
		  //C_LONGINT(cbDatosCta;cbDatosApdo;cb_PermitePorCta;cb_soloCuotasVencidas)
		C_LONGINT:C283(cbDatosCta;cbDatosApdo;cb_PermitePorCta;cb_soloCuotasVencidas;cb_noPagosConFechasAnteriores)  // 179864
		xBlob:=PREF_fGetBlob (0;"SelIngPagos")
		  //BLOB_Blob2Vars (->xBlob;0;->cbDatosCta;->cbDatosApdo;->cb_PermitePorCta;->cb_soloCuotasVencidas)
		BLOB_Blob2Vars (->xBlob;0;->cbDatosCta;->cbDatosApdo;->cb_PermitePorCta;->cb_soloCuotasVencidas;->cb_noPagosConFechasAnteriores)  // 179864
		If (cb_PermitePorCta=0)
			cbDatosApdo:=1  //Solo por precaucion
		End if 
		
	: ($accion="ACTcfg_GeneralesEmAvisos")
		ACTinit_CreateGenerationPrefs ("getBlobVarsAvisos";->xBlob)
		xBlob:=PREF_fGetBlob (0;"ACT_Avisos";xBlob)
		
		  //JHB (22) 20130416
		  //BLOB_Blob2Vars (->xBlob;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto;->cbAgruparXAlumnoItem;->cb_GenerarPDF;->vt_maquinaPDF)
		BLOB_Blob2Vars (->xBlob;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto;->cbAgruparXAlumnoItem;->cb_GenerarPDF;->vt_maquinaPDF;->cs_GeneraAvisoPorFamilia)  //201070507 RCH
		  //BLOB_Blob2Vars (->xBlob;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto;->cbAgruparXAlumnoItem;->cb_GenerarPDF;->vt_maquinaPDF;->cs_GeneraAvisoPorFamilia;->cb_SepararCargosXPct;->cb_EmitirEnMismoACXPct)  //20170627 RCH
		
		  //orden JVP 155965 20160520
		ACTinit_CreateGenerationPrefs ("getBlobVarsOrdenAvisos";->xBlob)
		xBlob:=PREF_fGetBlob (0;"act_ordenEmisionAvisos";xBlob)
		BLOB_Blob2Vars (->xBlob;0;->OrdenCurNivNom;->OrdenDefault)
		  //BLOB_Blob2Vars (->xBlob;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto;->cbAgruparXAlumnoItem)
		
	: ($accion="ACTcfg_MonedasYTasas")
		  //ACTinit_CreateMonedas ("CreaBlobMonedas";->xBlob)
		  //xBlob:=PREF_fGetBlob (0;"ACT_Monedas";xBlob)
		  //BLOB_Blob2Vars (->xBlob;0;->atACT_NombreMoneda;->arACT_ValorMoneda;->atACT_SimboloMoneda)
		ARRAY TEXT:C222(atACT_NombreMoneda;0)
		ARRAY REAL:C219(arACT_ValorMoneda;0)
		ARRAY TEXT:C222(atACT_SimboloMoneda;0)
		READ ONLY:C145([xxACT_Monedas:146])
		QUERY:C277([xxACT_Monedas:146];[xxACT_Monedas:146]Codigo_Pais:6=<>gCountryCode)
		SELECTION TO ARRAY:C260([xxACT_Monedas:146]Nombre_Moneda:2;atACT_NombreMoneda;[xxACT_Monedas:146]Valor:3;arACT_ValorMoneda;[xxACT_Monedas:146]Simbolo:4;atACT_SimboloMoneda)
		
	: ($accion="ACTcfg_AlertasYOtros")
		C_LONGINT:C283(cbAlertaEmisionAvisos)
		C_TEXT:C284(vtACTcfg_MailTo;vtACTcfg_MailCC;vtACTcfg_MailBCC)
		cbAlertaEmisionAvisos:=0
		vtACTcfg_MailTo:=""
		vtACTcfg_MailCC:=""
		vtACTcfg_MailBCC:=""
		BLOB_Variables2Blob (->xBlob;0;->cbAlertaEmisionAvisos;->vtACTcfg_MailTo;->vtACTcfg_MailCC;->vtACTcfg_MailBCC)
		xBlob:=PREF_fGetBlob (0;"ACTcfg_Alertas";xBlob)
		BLOB_Blob2Vars (->xBlob;0;->cbAlertaEmisionAvisos;->vtACTcfg_MailTo;->vtACTcfg_MailCC;->vtACTcfg_MailBCC)
		
	: ($accion="ACTcfg_MultasRecargos")
		ACTcfg_OpcionesRecargos ("InitVars")
		BLOB_Variables2Blob (->xBlob;0;->cbMultaXProtesto;->vtACTcfg_SelectedItemName;->vlACTcfg_SelectedItemId;->b_MultaProtFija;->b_MultaProtPorc;->vr_PctMontoMulta;->cbMultaPermiteMod)
		xBlob:=PREF_fGetBlob (0;"ACTcfg_Multas";xBlob)
		BLOB_Blob2Vars (->xBlob;0;->cbMultaXProtesto;->vtACTcfg_SelectedItemName;->vlACTcfg_SelectedItemId;->b_MultaProtFija;->b_MultaProtPorc;->vr_PctMontoMulta;->cbMultaPermiteMod)
		
	: ($accion="ACTcfg_Condonaciones")
		ACTcfg_OpcionesCondonacion ("InitVars")
		BLOB_Variables2Blob (->xBlob;0;->cbSolicitaMotivoCondonacion;->cbCondonacionDescuento;->cbCondonacionCargo;->cbCondonacionAviso;->cb_condonaDesdeMenu)
		xBlob:=PREF_fGetBlob (0;"ACTcfg_Condonaciones";xBlob)
		BLOB_Blob2Vars (->xBlob;0;->cbSolicitaMotivoCondonacion;->cbCondonacionDescuento;->cbCondonacionCargo;->cbCondonacionAviso;->cb_condonaDesdeMenu)
		
	: ($accion="ACTcfg_ReimpresionBoletas")
		ACTcfg_OpcionesReimpBoletas ("InitVars")
		BLOB_Variables2Blob (->xBlob;0;->cbMultaXReimprimir;->vtACTcfg_SelectedItemName;->vlACTcfg_SelectedItemId;->btn_MultaProtFija;->btn_MultaProtPorc;->vr_PctMontoMulta;->cbMultaPermiteMod)
		xBlob:=PREF_fGetBlob (0;"ACTcfg_ReimprimirBoletas";xBlob)
		BLOB_Blob2Vars (->xBlob;0;->cbMultaXReimprimir;->vtACTcfg_SelectedItemName;->vlACTcfg_SelectedItemId;->btn_MultaProtFija;->btn_MultaProtPorc;->vr_PctMontoMulta;->cbMultaPermiteMod)
		
	: ($accion="ACTcfg_NivelesCalculoNoCargas")
		ACTcfgdes_OpcionesGenerales ("InitArraysPref")
		BLOB_Variables2Blob (->xBlob;0;->ai_nivelesConsideradoNoHijo;->ai_nivelesConsideradoNoCarga)
		xBlob:=PREF_fGetBlob (0;"ACTcfg_CalculoNoHijo_NoCargas";xBlob)
		BLOB_Blob2Vars (->xBlob;0;->ai_nivelesConsideradoNoHijo;->ai_nivelesConsideradoNoCarga)
		
	: ($accion="ACTcfg_MultasXCaja")
		ACTcfg_OpcionesRecargosCaja ("InitVars")
		BLOB_Variables2Blob (->xBlob;0;->cbMultaXCaja;->vtACTcfg_SelectedItemNCaja;->vlACTcfg_SelectedItemIdCaja;->a_MultaCajaFija;->a_MultaCajaPorc;->vr_PctMontoMultaCaja;->cbMultaCajaPermiteMod)
		xBlob:=PREF_fGetBlob (0;"ACTcfg_MultasXCaja";xBlob)
		BLOB_Blob2Vars (->xBlob;0;->cbMultaXCaja;->vtACTcfg_SelectedItemNCaja;->vlACTcfg_SelectedItemIdCaja;->a_MultaCajaFija;->a_MultaCajaPorc;->vr_PctMontoMultaCaja;->cbMultaCajaPermiteMod)
		
		BLOB_Variables2Blob (->xBlob;0;->cs_multiplicarMontoRXC;->cs_considerarAvisosDesde;->vdACT_FechaRXC;->cs_considerarPCTAvisosMorosoRXC;->vr_PctAvisosMorosos)
		xBlob:=PREF_fGetBlob (0;"ACTcfg_MultasXCaja2";xBlob)
		BLOB_Blob2Vars (->xBlob;0;->cs_multiplicarMontoRXC;->cs_considerarAvisosDesde;->vdACT_FechaRXC;->cs_considerarPCTAvisosMorosoRXC;->vr_PctAvisosMorosos)
		
	: ($accion="ACTcfg_MultasRecargosAut")
		ACTcfg_OpcionesRecargosAut ("InitVars")
		ACTcfg_OpcionesRecargosAut ("CreaBlob";->xBlob)
		xBlob:=PREF_fGetBlob (0;"ACTcfg_MultasAut";xBlob)
		ACTcfg_OpcionesRecargosAut ("CargaBlob";->xBlob)
		
	: ($accion="ACT_DescuentosFamilia")
		xBlob:=PREF_fGetBlob (0;"ACT_DescuentosFamilia";xBlob)
		BLOB_Blob2Vars (->xBlob;0;->gGroupByFamily;->gGroupByGardian;->oOrderbyBirthDate;->oOrderByClass;->nOrdenAscendiente;->nOrdenDescendiente;->cbUsarDescuentosFamilia;->cbUsarDescuentosIngresos;->cbUsarDescuentosIndividual;->cbIncluirAdmision;->cbUsarDescuentosCargas;->cbUsarDescuentosXSeparado;->cbConsiderarDctoMaximo;->vr_descuentoMaximo;->cbCrearDctosEnLineasSeparadas)
		
	: ($accion="ACTcfg_TareasFinDia")
		ACTcfg_OpcionesTareasFinDia ("InitVars")
		ACTcfg_OpcionesTareasFinDia ("CreaBlob")
		xBlob:=PREF_fGetBlob (0;$accion;xBlob)
		ACTcfg_OpcionesTareasFinDia ("CargaBlob")
		
	: ($accion="ACTcfg_CuerpoMail")
		ACTcfg_OpcionesTextoMail ("InitVars")
		ACTcfg_OpcionesTextoMail ("CreaBlob")
		xBlob:=PREF_fGetBlob (0;$accion;xBlob)
		ACTcfg_OpcionesTextoMail ("CargaBlob")
		
	: ($accion="ACTcfg_DetallePagos")
		ACTcfg_OpcionesDetallePagos ("DeclaraVars")
		ACTcfg_OpcionesDetallePagos ("ArmaBlob";->xBlob)
		xBlob:=PREF_fGetBlob (0;$accion;xBlob)
		ACTcfg_OpcionesDetallePagos ("DesarmaBlob";->xBlob)
		
	: ($accion="ACTcfg_GeneralesDeudas")
		xBlob:=PREF_fGetBlob (0;"ACT_Deudas";xBlob)
		BLOB_Blob2Vars (->xBlob;0;->cb_GenerarDeudaAuto;->dDeudaTodo;->dDeudaMes;->mMesComenzado;->mMesVencido;->viACT_DiaDeuda;->vs_labelDiaDeuda;->viACT_DiaVencimiento;->viACT_DiasRetardo;->viACT_DiaVencimiento2;->viACT_DiaVencimiento3;->viACT_DiaVencimiento4)
		
	: ($accion="ACT_DocsTributarios")
		xBlob:=PREF_fGetBlob (0;$accion;xBlob)
		  //20130210 RCH
		  //BLOB_Blob2Vars (->xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada;->atACT_idNumeracion;->cb_UtilizaMultiNum;->btnUsuario;->btnRBD;->cb_EmiteXApoderado;->cb_EmiteXCuenta;->atACT_RazonSocial;->alACT_RazonSocial;->cb_Sincroniza;->alACT_IdDTSinc;->atACT_DTSinc;->cbOrdenaRegXFam;->vlACTdt_numLineas)
		  //BLOB_Blob2Vars (->xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada;->atACT_idNumeracion;->cb_UtilizaMultiNum;->btnUsuario;->btnRBD;->cb_EmiteXApoderado;->cb_EmiteXCuenta;->atACT_RazonSocial;->alACT_RazonSocial;->cb_Sincroniza;->alACT_IdDTSinc;->atACT_DTSinc;->cbOrdenaRegXFam;->vlACTdt_numLineas;->apACT_EmiteAfectoExento;->abACT_EmiteAfectoExento)
		  //BLOB_Blob2Vars (->xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada;->atACT_idNumeracion;->cb_UtilizaMultiNum;->btnUsuario;->btnRBD;->cb_EmiteXApoderado;->cb_EmiteXCuenta;->atACT_RazonSocial;->alACT_RazonSocial;->cb_Sincroniza;->alACT_IdDTSinc;->atACT_DTSinc;->cbOrdenaRegXFam;->vlACTdt_numLineas;->apACT_EmiteAfectoExento;->abACT_EmiteAfectoExento;->cbEmitirXCategorias)
		BLOB_Blob2Vars (->xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada;->atACT_idNumeracion;->cb_UtilizaMultiNum;->btnUsuario;->btnRBD;->cb_EmiteXApoderado;->cb_EmiteXCuenta;->atACT_RazonSocial;->alACT_RazonSocial;->cb_Sincroniza;->alACT_IdDTSinc;->atACT_DTSinc;->cbOrdenaRegXFam;->vlACTdt_numLineas;->apACT_EmiteAfectoExento;->abACT_EmiteAfectoExento;->cbEmitirXCategorias;->cbEmitirXMonedas;->lACTbol_DiaVencimiento)
		
	: ($accion="ACT_CorrelativoPago")
		ACTcfg_OpcionesCorrelativoPago ("DeclaraVars")
		ACTcfg_OpcionesCorrelativoPago ("ArmaBlob";->xBlob)
		xBlob:=PREF_fGetBlob (0;$accion;xBlob)
		ACTcfg_OpcionesCorrelativoPago ("DesarmaBlob";->xBlob)
		
	: ($accion="ACT_DivisionCargosEnEmision")
		ACTcc_DividirEmision ("DeclaraVars")
		$ob_conf:=ACTcc_DividirEmision ("ArmaObjeto")
		$ob_conf:=PREF_fGetObject (0;$accion;$ob_conf)
		ACTcc_DividirEmision ("DesarmaObjeto";->$ob_conf)
		
	: ($accion="ACT_OpcionesImpresion")
		ACTcfg_OpcionesGenRecibo ("DeclaraVars")
		$ob_conf:=ACTcfg_OpcionesGenRecibo ("ArmaObjeto")
		$ob_conf:=PREF_fGetObject (0;$accion;$ob_conf)
		ACTcfg_OpcionesGenRecibo ("DesarmaObjeto";->$ob_conf)
		
	: ($accion="ACT_DescuentosPorTramo")
		ACTpgs_DescuentosXTramo ("DeclaraVars")
		$ob_conf:=ACTpgs_DescuentosXTramo ("ArmaObjeto")
		$ob_retorno:=PREF_fGetObject (0;$accion;$ob_conf)
		
End case 
SET BLOB SIZE:C606(xBlob;0)

$0:=$ob_retorno