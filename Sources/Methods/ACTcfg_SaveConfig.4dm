//%attributes = {}
  //ACTcfg_SaveConfig

C_BLOB:C604(xBlob)
C_PICTURE:C286($bundle)
  //Guarda las configuraciones de AccountTrack

$page:=$1
Case of 
	: ($page=1)  //general
		  //  `ejercicio    
		  //BLOB_Variables2Blob (->xBlob;0;-><>vdACT_InicioEjercicio;-><>vdACT_TerminoEjercicio)
		  //PREF_SetBlob (0;"ACT_PreferenciasGenerales";xBlob)
		
		  //orden alumnos
		  //BLOB_Variables2Blob (->xBlob;0;->gGroupByFamily;->gGroupByGardian;->oOrderbyBirthDate;->oOrderByClass;->nOrdenAscendiente;->nOrdenDescendiente;->cbUsarDescuentosFamilia;->cbUsarDescuentosIngresos;->cbUsarDescuentosIndividual;->cbIncluirAdmision;->cbUsarDescuentosCargas)
		  //PREF_SetBlob (0;"ACT_DescuentosFamilia";xBlob)
		BLOB_Variables2Blob (->xBlob;0;->gGroupByFamily;->gGroupByGardian;->oOrderbyBirthDate;->oOrderByClass;->nOrdenAscendiente;->nOrdenDescendiente;->cbUsarDescuentosFamilia;->cbUsarDescuentosIngresos;->cbUsarDescuentosIndividual;->cbIncluirAdmision;->cbUsarDescuentosCargas;->cbUsarDescuentosXSeparado;->cbConsiderarDctoMaximo;->vr_descuentoMaximo;->cbCrearDctosEnLineasSeparadas)
		PREF_SetBlob (0;"ACT_DescuentosFamilia";xBlob)
		
		ACTcfg_OpcionesRazonesSociales ("Guarda")
		ACTcfg_OpcionesRazonesSociales ("CargaPrincipal")
		
		  //Seleccion para Ingreso Pagos
		  //BLOB_Variables2Blob (->xBlob;0;->cbDatosCta;->cbDatosApdo;->cb_PermitePorCta;->cb_soloCuotasVencidas)
		BLOB_Variables2Blob (->xBlob;0;->cbDatosCta;->cbDatosApdo;->cb_PermitePorCta;->cb_soloCuotasVencidas;->cb_noPagosConFechasAnteriores)  //179864 
		PREF_SetBlob (0;"SelIngPagos";xBlob)
		
		  //Deuda
		BLOB_Variables2Blob (->xBlob;0;->cb_GenerarDeudaAuto;->dDeudaTodo;->dDeudaMes;->mMesComenzado;->mMesVencido;->viACT_DiaDeuda;->vs_labelDiaDeuda;->viACT_DiaVencimiento;->viACT_DiasRetardo;->viACT_DiaVencimiento2;->viACT_DiaVencimiento3;->viACT_DiaVencimiento4)
		PREF_SetBlob (0;"ACT_Deudas";xBlob)
		
		  //Avisos de cobranza
		  //JHB (33) 20130416
		  //BLOB_Variables2Blob (->xBlob;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto;->cbAgruparXAlumnoItem;->cb_GenerarPDF;->vt_maquinaPDF)
		BLOB_Variables2Blob (->xBlob;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto;->cbAgruparXAlumnoItem;->cb_GenerarPDF;->vt_maquinaPDF;->cs_GeneraAvisoPorFamilia)  //20170507 RCH
		  //BLOB_Variables2Blob (->xBlob;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto;->cbAgruparXAlumnoItem;->cb_GenerarPDF;->vt_maquinaPDF;->cs_GeneraAvisoPorFamilia;->cb_SepararCargosXPct;->cb_EmitirEnMismoACXPct)  //20170627 RCH
		
		
		  //BLOB_Variables2Blob (->xBlob;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto;->cbAgruparXAlumnoItem)
		PREF_SetBlob (0;"ACT_Avisos";xBlob)
		
		  //orden emision avisos
		  //nuevo orden ticket 155965 JVP 201605
		BLOB_Variables2Blob (->xBlob;0;->OrdenCurNivNom;->OrdenDefault)
		PREF_SetBlob (0;"act_ordenEmisionAvisos";xBlob)
		If (Not:C34(Undefined:C82(yBWR_CurrentTable)))
			If (Not:C34(Is nil pointer:C315(yBWR_CurrentTable)))
				If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
					BWR_LoadFormReportsArrays (->[ACT_Avisos_de_Cobranza:124])
				End if 
			End if 
		End if 
		
		PREF_Set (0;"ACT_DecideApoderado";String:C10(viACT_ACTDecideApoderado))
		PREF_Set (0;"ACT_AsignarMatAdmision";String:C10(viACT_AsignarMatAdmision))
		
		
		ACTinit_CreateDefAfectasInteres ("GuardaBlob")
		
		ACTcfgfdp_OpcionesGenerales ("savecfg_FdPXDef")
		ACTcfg_GuardaBlob ("ACTcfg_AlertasYOtros")
		ACTcfg_OpcionesRecargos ("GuardaBlob")
		ACTcfg_OpcionesCondonacion ("GuardaBlob")
		ACTcfg_OpcionesRecargosCaja ("GuardaBlob")
		ACTcfg_OpcionesRecargosAut ("GuardaBlob")
		ACTcfg_OpcionesTareasFinDia ("GuardaBlob")
		ACTcfg_OpcionesDetallePagos ("GuardaBlob")
		ACTcfg_OpcionesPagares ("GuardaBlobs")
		
		  //recargos segun tabla
		ACTcfg_OpcionesRecAutTabla ("GuardaBlob")
		
		ACTcfg_OpcionesGenABancarios ("GuardaBlob")
		
		  //20160714 RCH
		ACTcfg_OpcionesDescuentos ("GuardaConf")
		
		  //20161002 RCH
		ACTcfg_OpcionesCorrelativoPago ("GuardaConf")
		
		ACTcc_DividirEmision ("GuardaConf")  //20170711 RCH
		
		ACTcfg_OpcionesGenRecibo ("GuardaConf")  //20170711 RCH
		
	: ($page=2)  //Items de cargo
		ACTcfg_SaveItemdeCargo 
	: ($page=3)  //Matrices
		ACTinit_LoadMatrixIntoArrays 
	: ($page=4)  //bancos
		  //For ($i;Size of array(atACT_BankID);1;-1)
		  //If ((atACT_BankID{$i}="") | (atACT_BankName{$i}=""))
		  //AT_Delete ($i;1;->atACT_BankID;->atACT_BankName)
		  //End if 
		  //End for 
		  //$offset:=0
		  //BLOB_Variables2Blob (->xblob;0;->atACT_BankID;->atACT_BankName)
		  //PREF_SetBlob (0;"ACT_Bancos";xblob)
		  //SET BLOB SIZE(xBlob;0)
		
		abACT_BankModified{0}:=True:C214
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->abACT_BankModified;"=";->$DA_Return)
		READ WRITE:C146([xxACT_Bancos:129])
		For ($i;1;Size of array:C274($DA_Return))
			If (alACT_BankRecNum{$DA_Return{$i}}#-1)
				If ((atACT_BankName{$DA_Return{$i}}#"") & (atACT_BankID{$DA_Return{$i}}#""))
					GOTO RECORD:C242([xxACT_Bancos:129];alACT_BankRecNum{$DA_Return{$i}})
					[xxACT_Bancos:129]Codigo:2:=atACT_BankID{$DA_Return{$i}}
					[xxACT_Bancos:129]Nombre:1:=atACT_BankName{$DA_Return{$i}}
					[xxACT_Bancos:129]Estandar:4:=abACT_BankEstandar{$DA_Return{$i}}
					[xxACT_Bancos:129]mx_NumeroConvenio:5:=atACT_BankNumConvenio{$DA_Return{$i}}
					SAVE RECORD:C53([xxACT_Bancos:129])
				End if 
			Else 
				If ((atACT_BankName{$DA_Return{$i}}#"") & (atACT_BankID{$DA_Return{$i}}#""))
					CREATE RECORD:C68([xxACT_Bancos:129])
					[xxACT_Bancos:129]Codigo:2:=atACT_BankID{$DA_Return{$i}}
					[xxACT_Bancos:129]Nombre:1:=atACT_BankName{$DA_Return{$i}}
					[xxACT_Bancos:129]Estandar:4:=abACT_BankEstandar{$DA_Return{$i}}
					[xxACT_Bancos:129]mx_NumeroConvenio:5:=atACT_BankNumConvenio{$DA_Return{$i}}
					[xxACT_Bancos:129]Pais:3:=vtACT_PaisBancos
					SAVE RECORD:C53([xxACT_Bancos:129])
				End if 
			End if 
		End for 
		KRL_UnloadReadOnly (->[xxACT_Bancos:129])
		
	: ($page=5)  //listas    
		If (Changed=True:C214)
			  //BLOB_Variables2Blob (->[xShell_List]Contents;0;->sElements)
			  //SAVE RECORD([xShell_List])
			  //20140107 ASM Ticket  128514
			TBL_SaveListAndArrays (->sElements;->sElements)
		End if 
		UNLOAD RECORD:C212([xShell_List:39])
		READ ONLY:C145([xShell_List:39])
		
	: ($page=6)  //monedas y tasas
		BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		PREF_SetBlob (0;"ACT_IPC "+String:C10(vl_lastYear);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		BLOB_Variables2Blob (->xBlob;0;->atACT_NombreMoneda;->arACT_ValorMoneda;->atACT_SimboloMoneda)
		PREF_SetBlob (0;"ACT_Monedas";xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		  //$currentUFRef:=atACT_UFReference{vi_LastUFMonth}
		  //SET BLOB SIZE(xBlob;0)
		  //BLOB_Variables2Blob (->xBlob;0;->aiACT_DiaUF;->arACT_ValorUF)
		  //PREF_SetBlob (0;$currentUFRef;xBlob)
		  //SET BLOB SIZE(xBlob;0)
		
		BLOB_Variables2Blob (->xBlob;0;-><>atACT_FreqFacturacion;-><>arACT_FreqDescuento)
		PREF_SetBlob (0;"ACT_Frecuencias Facturación";xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		  //iVA, Tasa Interes, etc.
		BLOB_Variables2Blob (->xBlob;0;-><>vrACT_TasaIVA;-><>vrACT_FactorIVA;-><>vrACT_TasaInterés;-><>vrACT_MultaRetardo)
		PREF_SetBlob (0;"ACT_IVA_tasas";xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		  //Impuesto timbres y estampillas
		BLOB_Variables2Blob (->xBlob;0;->alACT_AñoTasaImpuesto;->arACT_TasaMesImpuesto;->arACT_TasaMaximaImpuesto)
		PREF_SetBlob (0;"ACT_ImpuestoTimbres";xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
	: ($page=7)  //Archivos Bancarios
		
		If (modificado)
			$grabar:=CD_Dlog (0;__ ("¿Desea guardar la definición actual para este banco?");__ ("");__ ("Si");__ ("No"))
			If ($grabar=1)
				If (Size of array:C274(alACT_Largo)>0)
					ACTcfg_CheckRRecuadDef 
				End if 
				BLOB_Variables2Blob (->xBlob;0;->vNombreModelo;->vl_LargoReg;->vl_TiposReg;->vt_CharFiller;->alACT_Campo;->atACT_Descripcion;->alACT_Largo;->atACT_Tipo;->atACT_Posicion;->atACT_Correspondencia;->alACT_PosIni;->alACT_PosFinal;->vl_PreviosReg;->vl_PosterioresReg;->r1;->r2;->r3)
				$NameModel:="["+atACT_BankID{Find in array:C230(atACT_BankName;vtACT_BancoNombre)}+"] "+vNombreModelo
				PREF_SetBlob (0;$NameModel;xBlob)
				SET BLOB SIZE:C606(xBlob;0)
			End if 
		End if 
	: ($page=8)  //Documentos tributarios
		  //BLOB_Variables2Blob (->xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada)
		  //BLOB_Variables2Blob (->xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada;->atACT_idNumeracion;->cb_UtilizaMultiNum;->btnUsuario;->btnRBD;->cb_EmiteXApoderado;->cb_EmiteXCuenta;->atACT_RazonSocial;->alACT_RazonSocial;->cb_Sincroniza;->alACT_IdDTSinc;->atACT_DTSinc;->cbOrdenaRegXFam;->vlACTdt_numLineas;->apACT_EmiteAfectoExento;->abACT_EmiteAfectoExento)
		  //BLOB_Variables2Blob (->xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada;->atACT_idNumeracion;->cb_UtilizaMultiNum;->btnUsuario;->btnRBD;->cb_EmiteXApoderado;->cb_EmiteXCuenta;->atACT_RazonSocial;->alACT_RazonSocial;->cb_Sincroniza;->alACT_IdDTSinc;->atACT_DTSinc;->cbOrdenaRegXFam;->vlACTdt_numLineas;->apACT_EmiteAfectoExento;->abACT_EmiteAfectoExento;->cbEmitirXCategorias)
		BLOB_Variables2Blob (->xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada;->atACT_idNumeracion;->cb_UtilizaMultiNum;->btnUsuario;->btnRBD;->cb_EmiteXApoderado;->cb_EmiteXCuenta;->atACT_RazonSocial;->alACT_RazonSocial;->cb_Sincroniza;->alACT_IdDTSinc;->atACT_DTSinc;->cbOrdenaRegXFam;->vlACTdt_numLineas;->apACT_EmiteAfectoExento;->abACT_EmiteAfectoExento;->cbEmitirXCategorias;->cbEmitirXMonedas;->lACTbol_DiaVencimiento)
		PREF_SetBlob (0;"ACT_DocsTributarios";xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		ACTbol_SaveParamsSubvenciones 
		If (Not:C34(Undefined:C82(yBWR_CurrentTable)))
			If (Not:C34(Is nil pointer:C315(yBWR_CurrentTable)))
				If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
					BWR_LoadFormReportsArrays (->[ACT_Boletas:181])
				End if 
			End if 
		End if 
		ACTcfg_OpcionesReimpBoletas ("GuardaBlob")
		
		  //20111026 RCH esta variable se deberia llenar en la mayoria de los casos en ACTcfg_Onload
		C_LONGINT:C283(vlACT_RSSel)
		ACTcfdi_OpcionesGenerales ("SaveConf";->vlACT_RSSel)
		
		ACTdte_AlertasOpciones ("GuardaBlob";->vlACT_RSSel)  //20150202 RCH
		
		ACTdte_OpcionesManeja ("GuardaBlob";->vlACT_RSSel)  //20150203 RCH
		
		ACTfear_OpcionesGenerales ("GuardaBlob";->vlACT_RSSel)  //20150620 RCH
		
	: ($page=9)  //Formas de Pago
		ACTcfg_OpcionesFormasDePago ("GuardarConf")
		
	: ($page=10)  //Contabilidad
		ACTcfg_OpcionesContabilidad ("GuardaConfiguracion")
		
End case 