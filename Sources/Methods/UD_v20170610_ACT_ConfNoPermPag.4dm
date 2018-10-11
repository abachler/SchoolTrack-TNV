//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce 179864 
  // Fecha y hora: 04-05-17, 11:08:23
  // ----------------------------------------------------
  // Método: UD_v20170610_ACT_ConfNoPermPag
  // Descripción: Actualización del Blob de las preferencias de configuración de ingreso de pagos pagos, creando
  // la nueva preferencia cb_noPagosConFechasAnteriores. 
  // 
  //
  // Parámetros: No requiere.
  // ----------------------------------------------------


If (ACT_AccountTrackInicializado )
	C_LONGINT:C283(cbDatosCta;cbDatosApdo;cb_PermitePorCta;cb_soloCuotasVencidas)
	C_BLOB:C604(xBlob)
	
	SET BLOB SIZE:C606(xBlob;0)
	xBlob:=PREF_fGetBlob (0;"SelIngPagos";xBlob)
	BLOB_Blob2Vars (->xBlob;0;->cbDatosCta;->cbDatosApdo;->cb_PermitePorCta;->cb_soloCuotasVencidas)
	
	SET BLOB SIZE:C606(xBlob;0)
	BLOB_Variables2Blob (->xBlob;0;->cbDatosCta;->cbDatosApdo;->cb_PermitePorCta;->cb_soloCuotasVencidas;->cb_noPagosConFechasAnteriores)
	PREF_SetBlob (0;"SelIngPagos";xBlob)
	SET BLOB SIZE:C606(xBlob;0)
End if 
