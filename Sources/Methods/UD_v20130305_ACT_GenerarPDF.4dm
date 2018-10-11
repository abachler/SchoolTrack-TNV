//%attributes = {}
If (ACT_AccountTrackInicializado )
	C_BLOB:C604(xBlob)
	ACTinit_CreateGenerationPrefs ("getBlobVarsAvisos";->xBlob)
	xBlob:=PREF_fGetBlob (0;"ACT_Avisos";xBlob)
	BLOB_Blob2Vars (->xBlob;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto;->cbAgruparXAlumnoItem)
	cb_GenerarPDF:=0
	BLOB_Variables2Blob (->xBlob;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto;->cbAgruparXAlumnoItem;->cb_GenerarPDF)
	PREF_SetBlob (0;"ACT_Avisos";xBlob)
	SET BLOB SIZE:C606(xBlob;0)
End if 