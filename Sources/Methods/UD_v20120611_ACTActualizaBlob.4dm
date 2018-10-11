//%attributes = {}
  //UD_v20120611_ACTActualizaBlob
  //metodo para agregar la variable vrACT_recargoMulta1 al blob

If (ACT_AccountTrackInicializado )
	C_BLOB:C604(xBlob)
	SET BLOB SIZE:C606(xBlob;0)
	ACTcfg_OpcionesRecargosAut ("InitVars")
	ACTcfg_OpcionesRecargosAut ("CreaBlob";->xBlob)
	xBlob:=PREF_fGetBlob (0;"ACTcfg_MultasAut";xBlob)
	BLOB_Blob2Vars (->xBlob;0;->cbRecargoAut;->vtACTcfg_SelectedItemAut;->vlACTcfg_SelectedItemAut;->c_RecAutFijo;->c_RecAutPct;->vr_PctMontoRecAut;->cs_CargoAfectoSeparado;->cs_UtilizarFechaActual;->cs_GenerarMultaEnMismoAviso;->cs_GenerarMultaDia1;->vl_MultasMaximas;->cs_maximoMultas)
	ACTcfg_GuardaBlob ("ACTcfg_MultasRecargosAut")
	SET BLOB SIZE:C606(xBlob;0)
End if 