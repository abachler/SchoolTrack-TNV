//%attributes = {}
  //ACTinit_CreateDocTributarios

C_BLOB:C604(xBlob)
SET BLOB SIZE:C606(xBlob;0)
$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
If ($accountTrackIsInitialized=1)
	
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
	
	ACTcfg_OpcionesReimpBoletas ("InitVars")
	ACTcfg_SaveConfig (8)
	
	cs_0102:=0
	cs_0103:=0
	cs_0104:=0
	cs_0105:=0
	cs_0106:=0
	cs_0107:=0
	cs_0108:=0
	cs_0109:=0
	cs_0110:=0
	cs_0111:=0
	cs_0201:=0
	cs_0202:=0
	cs_0203:=0
	cs_0204:=0
	cs_0205:=0
	cs_0206:=0
	cs_0207:=0
	cs_0208:=0
	cs_0209:=0
	cs_0210:=0
	cs_0211:=0
	cs_0212:=0
	cs_0301:=0
	cs_0302:=0
	cs_0303:=0
	cs_0304:=0
	cs_0305:=0
	cs_0306:=0
	cs_0307:=0
	cs_0308:=0
	cs_0309:=0
	cs_0310:=0
	cs_0311:=0
	cs_g01:=0
	cs_g02:=0
	cs_g03:=0
	cs_g04:=0
	vt_TextoImprimir:=""
	vt_AgnoBoleta:=""
	
	vt_obsCompletoSBeca:=""  //OBS bol
	vt_obsCompletoCBeca:=""
	vt_obsAbonoSBeca:=""
	vt_obsAbonoCBeca:=""
	vt_obsSaldoSbeca:=""
	vt_obsSaldoCbeca:=""
	cs_0112:=0
	cs_0213:=0
	cs_0312:=0
	
	ACTbol_SaveParamsSubvenciones 
End if 