//%attributes = {}
  //ACTud_UpdateBlobs

C_TEXT:C284($vt_accion;$1)
$vt_accion:=$1

Case of 
	: ($vt_accion="UD_v20091116_BlobBoletas")
		  //ACTud_UpdateBlobs ("UD_v20091116_BlobBoletas")
		C_LONGINT:C283($accountTrackIsInitialized)
		$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
		If ($accountTrackIsInitialized=1)
			C_TEXT:C284($vText)
			C_BLOB:C604(xBlob)
			ACTcfg_InitBolArrays 
			cb_GenerarBoletaCaja:=0
			cb_SeqBoletaPorUsuario:=0
			cb_EmitirRecibo:=0
			vtACT_ModRecibo:=""
			vlACT_NextRecibo:=1
			vtACT_PrinterRecibo:=""
			vtACT_CatVR:=""
			vlACT_CatVR:=0
			vlACT_ModRecibo:=0
			cbAgruparBoletas:=0
			cb_GenerarBoletaCero:=0
			cb_ImprimirCeros:=0
			cb_EliminarPagosAsociados:=1
			cbUsarCategorias:=0
			cb_BoletaSubvencionada:=0
			cb_UtilizaMultiNum:=0
			btnUsuario:=1
			btnRBD:=0
			cb_EmiteXApoderado:=1
			cb_EmiteXCuenta:=0
			cb_Sincroniza:=0
			cbOrdenaRegXFam:=0
			vlACTdt_numLineas:=13
			
			SET BLOB SIZE:C606(xBlob;0)
			xBlob:=PREF_fGetBlob (0;"ACT_DocsTributarios";xBlob)
			BLOB_Blob2Vars (->xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada;->atACT_idNumeracion;->cb_UtilizaMultiNum;->btnUsuario;->btnRBD;->cb_EmiteXApoderado;->cb_EmiteXCuenta;->atACT_RazonSocial;->alACT_RazonSocial;->cb_Sincroniza;->alACT_IdDTSinc;->atACT_DTSinc;->cbOrdenaRegXFam)
			SET BLOB SIZE:C606(xBlob;0)
			BLOB_Variables2Blob (->xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada;->atACT_idNumeracion;->cb_UtilizaMultiNum;->btnUsuario;->btnRBD;->cb_EmiteXApoderado;->cb_EmiteXCuenta;->atACT_RazonSocial;->alACT_RazonSocial;->cb_Sincroniza;->alACT_IdDTSinc;->atACT_DTSinc;->cbOrdenaRegXFam;->vlACTdt_numLineas)
			PREF_SetBlob (0;"ACT_DocsTributarios";xBlob)
			SET BLOB SIZE:C606(xBlob;0)
		End if 
		
End case 