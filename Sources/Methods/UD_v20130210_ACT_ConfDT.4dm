//%attributes = {}
  //UD_v20130210_ACT_ConfDT
  //20130210 RCH Requerimiento Aleman Pto Montt
If (ACT_AccountTrackInicializado )
	  //leo configuracion DT
	ACTcfg_InitBolArrays 
	C_BLOB:C604(xBlob)
	SET BLOB SIZE:C606(xBlob;0)
	xBlob:=PREF_fGetBlob (0;"ACT_DocsTributarios";xBlob)
	BLOB_Blob2Vars (->xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada;->atACT_idNumeracion;->cb_UtilizaMultiNum;->btnUsuario;->btnRBD;->cb_EmiteXApoderado;->cb_EmiteXCuenta;->atACT_RazonSocial;->alACT_RazonSocial;->cb_Sincroniza;->alACT_IdDTSinc;->atACT_DTSinc;->cbOrdenaRegXFam;->vlACTdt_numLineas)
	SET BLOB SIZE:C606(xBlob;0)
	
	For ($i;1;Size of array:C274(abACT_ReqDatos))
		AT_Insert (0;1;->abACT_EmiteAfectoExento;->apACT_EmiteAfectoExento)
		If (<>gCountryCode="mx")
			abACT_EmiteAfectoExento{Size of array:C274(abACT_EmiteAfectoExento)}:=True:C214
			GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_EmiteAfectoExento{Size of array:C274(apACT_EmiteAfectoExento)})
		Else 
			abACT_EmiteAfectoExento{Size of array:C274(abACT_EmiteAfectoExento)}:=False:C215
			GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_EmiteAfectoExento{Size of array:C274(apACT_EmiteAfectoExento)})
		End if 
	End for 
	BLOB_Variables2Blob (->xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada;->atACT_idNumeracion;->cb_UtilizaMultiNum;->btnUsuario;->btnRBD;->cb_EmiteXApoderado;->cb_EmiteXCuenta;->atACT_RazonSocial;->alACT_RazonSocial;->cb_Sincroniza;->alACT_IdDTSinc;->atACT_DTSinc;->cbOrdenaRegXFam;->vlACTdt_numLineas;->apACT_EmiteAfectoExento;->abACT_EmiteAfectoExento)
	PREF_SetBlob (0;"ACT_DocsTributarios";xBlob)
	SET BLOB SIZE:C606(xBlob;0)
End if 