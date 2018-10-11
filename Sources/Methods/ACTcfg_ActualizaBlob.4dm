//%attributes = {}
  //ACTcfg_ActualizaBlob

C_TEXT:C284($1;$accion)
$accion:=$1
Case of 
	: ($accion="20080617_CFGGeneralesPagos")
		C_LONGINT:C283(cbDatosCta;cbDatosApdo;cb_PermitePorCta;cb_soloCuotasVencidas)
		C_BLOB:C604(xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		xBlob:=PREF_fGetBlob (0;"SelIngPagos";xBlob)
		BLOB_Blob2Vars (->xBlob;0;->cbDatosCta;->cbDatosApdo;->cb_PermitePorCta)
		cb_soloCuotasVencidas:=0
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->cbDatosCta;->cbDatosApdo;->cb_PermitePorCta;->cb_soloCuotasVencidas)
		PREF_SetBlob (0;"SelIngPagos";xBlob)
		SET BLOB SIZE:C606(xBlob;0)
End case 
