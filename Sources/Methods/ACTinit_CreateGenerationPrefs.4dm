//%attributes = {}
  //ACTinit_CreateGenerationPrefs

C_TEXT:C284($1;$vt_accion)
C_POINTER:C301($ptr1)
C_BLOB:C604(xBlob)
SET BLOB SIZE:C606(xBlob;0)
If (Count parameters:C259>=1)
	$vt_accion:=$1
End if 
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 


If ($vt_accion="")
	$vt_accion:="todos"
End if 


Case of 
	: ($vt_accion="getBlobVarsGenDeuda")
		  //preferencias generación de deuda
		
		cb_GenerarDeudaAuto:=0
		dDeudaTodo:=0
		dDeudaMes:=1
		mMesComenzado:=1
		mMesVencido:=0
		viACT_DiaDeuda:=1
		vs_labelDiaDeuda:="del mes"
		viACT_DiaVencimiento:=15
		viACT_DiasRetardo:=0
		viACT_DiaVencimiento2:=0
		viACT_DiaVencimiento3:=0
		viACT_DiaVencimiento4:=0
		BLOB_Variables2Blob ($ptr1;0;->cb_GenerarDeudaAuto;->dDeudaTodo;->dDeudaMes;->mMesComenzado;->mMesVencido;->viACT_DiaDeuda;->vs_labelDiaDeuda;->viACT_DiaVencimiento;->viACT_DiasRetardo;->viACT_DiaVencimiento2;->viACT_DiaVencimiento3;->viACT_DiaVencimiento4)
		
	: ($vt_accion="setPrefGenDeuda")
		ACTinit_CreateGenerationPrefs ("getBlobVarsGenDeuda";->xBlob)
		PREF_SetBlob (0;"ACT_Deudas";xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
	: ($vt_accion="getBlobVarsOrdenAvisos")
		OrdenDefault:=1
		OrdenCurNivNom:=0
		
		BLOB_Variables2Blob ($ptr1;0;->OrdenCurNivNom;->OrdenDefault)
	: ($vt_accion="getBlobVarsAvisos")
		  //preferencias de avisos de cobranza
		cb_GenerarAvisoAuto:=0
		bAvisoApoderado:=1
		bAvisoAlumno:=0
		cb_IncluirSaldosAnteriores:=0
		cbAgrupar:=0
		vlACT_PagosCta:=0
		vlACT_PagosApdo:=1
		mOrdenInterno:=1
		mCtaGlosa:=0
		cb_ImprimirCerosAviso:=0
		cb_UsarCategorias:=0
		cb_EliminarCargos:=0
		cb_CalcularParaTodosLosAvisos:=0
		cb_NoPrepagarAuto:=0
		cbAgruparXAlumnoItem:=0
		cs_GeneraAvisoPorFamilia:=0  //20170507 RCH
		
		  //PDFS Avisos JHB (61-64) 20130416
		cb_GenerarPDF:=0
		vt_maquinaPDF:=""
		  //============
		  //BLOB_Variables2Blob ($ptr1;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto;->cbAgruparXAlumnoItem;->cb_GenerarPDF;->vt_maquinaPDF)
		BLOB_Variables2Blob ($ptr1;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto;->cbAgruparXAlumnoItem;->cb_GenerarPDF;->vt_maquinaPDF;->cs_GeneraAvisoPorFamilia)  //20170507 RCH
		  //
		  //
		  //BLOB_Variables2Blob ($ptr1;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto;->cbAgruparXAlumnoItem)
		
	: ($vt_accion="setPrefAvisos")
		ACTinit_CreateGenerationPrefs ("getBlobVarsAvisos";->xBlob)
		PREF_SetBlob (0;"ACT_Avisos";xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
	: ($vt_accion="todos")
		ACTinit_CreateGenerationPrefs ("setPrefGenDeuda")
		ACTinit_CreateGenerationPrefs ("setPrefAvisos")
End case 
