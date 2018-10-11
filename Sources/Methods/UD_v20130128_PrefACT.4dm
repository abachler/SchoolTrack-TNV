//%attributes = {}
  //UD_v20130128_PrefACT

If (ACT_AccountTrackInicializado )
	C_BLOB:C604($xBlob)
	SET BLOB SIZE:C606($xBlob;0)
	C_LONGINT:C283($offset)
	$offset:=BLOB_Variables2Blob (->$xBlob;0;->vtACTp_Periodo;->cs_genPagare;->cs_imprimirPagare;->cs_genContrato;->vtACTp_ModPagare;->vtACTp_ModContrato)
	$xBlob:=PREF_fGetBlob (0;"ACT_ConfPagares2";$xBlob)
	$offset:=BLOB_Blob2Vars (->$xBlob;0;->vtACTp_Periodo;->cs_genPagare;->cs_imprimirPagare;->cs_genContrato;->vtACTp_ModPagare;->vtACTp_ModContrato)
	
	ACTcfg_OpcionesPagares ("DeclaraVarsInterfaz1")
	BLOB_Variables2Blob (->$xBlob;0;->vtACTp_Periodo;->cs_genPagare;->cs_imprimirPagare;->cs_genContrato;->vtACTp_ModPagare;->vtACTp_ModContrato)
	PREF_SetBlob (0;"ACT_ConfPagares2";$xBlob)
End if 