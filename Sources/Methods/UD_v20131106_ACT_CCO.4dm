//%attributes = {}
  //UD_v20131106_ACT_CCO
  //Actualiza nueva variable vtACTmail_CCO en blob.

If (ACT_AccountTrackInicializado )
	C_BLOB:C604(xBlob)
	ACTcfg_OpcionesTextoMail ("InitVars")
	ACTcfg_OpcionesTextoMail ("CreaBlob")
	xBlob:=PREF_fGetBlob (0;"ACTcfg_CuerpoMail";xBlob)
	BLOB_Blob2Vars (->xBlob;0;->vt_CuerpoMail;->vt_CuerpoMail2;->vtACTmail_AsuntoMail;->vtACTmail_ResponderA;->vtACTmail_NombreDe)
	ACTcfg_OpcionesTextoMail ("GuardaBlob")
End if 