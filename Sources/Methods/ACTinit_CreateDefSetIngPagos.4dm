//%attributes = {}
  //ACTinit_CreateDefSetIngPagos

C_LONGINT:C283(cbDatosCta;cbDatosApdo;cb_PermitePorCta;cb_soloCuotasVencidas)
C_BLOB:C604(xBlob)
cbDatosCta:=0
cbDatosApdo:=1
cb_PermitePorCta:=0
cb_soloCuotasVencidas:=0
SET BLOB SIZE:C606(xBlob;0)
  //BLOB_Variables2Blob (->xBlob;0;->cbDatosCta;->cbDatosApdo;->cb_PermitePorCta;->cb_soloCuotasVencidas)
BLOB_Variables2Blob (->xBlob;0;->cbDatosCta;->cbDatosApdo;->cb_PermitePorCta;->cb_soloCuotasVencidas;->cb_noPagosConFechasAnteriores)  //179864
PREF_SetBlob (0;"SelIngPagos";xBlob)