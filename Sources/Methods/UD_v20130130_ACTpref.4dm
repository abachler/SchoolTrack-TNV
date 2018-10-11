//%attributes = {}
  //UD_v20130130_ACTpref
If (ACT_AccountTrackInicializado )
	C_BLOB:C604($xBlob)
	ACTcfg_OpcionesRecargosAut ("InitVars")
	ACTcfg_OpcionesRecargosAut ("CreaBlob";->$xBlob)
	$xBlob:=PREF_fGetBlob (0;"ACTcfg_MultasAut";$xBlob)
	BLOB_Blob2Vars (->$xBlob;0;->cbRecargoAut;->vtACTcfg_SelectedItemAut;->vlACTcfg_SelectedItemAut;->c_RecAutFijo;->c_RecAutPct;->vr_PctMontoRecAut;->cs_CargoAfectoSeparado;->cs_UtilizarFechaActual;->cs_GenerarMultaEnMismoAviso;->cs_GenerarMultaDia1;->vl_MultasMaximas;->cs_maximoMultas;->vrACT_recargoMulta1)
	ACTcfg_GuardaBlob ("ACTcfg_MultasRecargosAut")
End if 