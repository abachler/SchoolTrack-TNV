//%attributes = {}
  //UD_v20170507_PrefEmisionAC

If (ACT_AccountTrackInicializado )
	C_BLOB:C604(xBlob)
	ACTinit_CreateGenerationPrefs ("getBlobVarsAvisos";->xBlob)
	xBlob:=PREF_fGetBlob (0;"ACT_Avisos";xBlob)
	  //Modificado por: Saúl Ponce (24/10/2017) Ticket Nº 187763, se perdía la configuración de los avisos de cobranza
	  //BLOB_Variables2Blob (->xBlob;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto;->cbAgruparXAlumnoItem;->cb_GenerarPDF;->vt_maquinaPDF)
	BLOB_Blob2Vars (->xBlob;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto;->cbAgruparXAlumnoItem;->cb_GenerarPDF;->vt_maquinaPDF)
	cs_GeneraAvisoPorFamilia:=0
	BLOB_Variables2Blob (->xBlob;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto;->cbAgruparXAlumnoItem;->cb_GenerarPDF;->vt_maquinaPDF;->cs_GeneraAvisoPorFamilia)
	PREF_SetBlob (0;"ACT_Avisos";xBlob)
	SET BLOB SIZE:C606(xBlob;0)
End if 