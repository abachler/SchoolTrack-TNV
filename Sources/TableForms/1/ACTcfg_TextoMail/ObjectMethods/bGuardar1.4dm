ACTcfg_OpcionesTextoMail ("GuardaBlob")
If (vtACT_varOriginal#vt_CuerpoMail)
	LOG_RegisterEvt ("Cambio en texto de cuerpo de mail efectuado.")
	vtACT_varOriginal:=""
End if 
