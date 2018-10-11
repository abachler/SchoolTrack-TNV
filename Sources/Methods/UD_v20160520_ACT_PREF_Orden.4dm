//%attributes = {}
  //UD_v20160520_ACT_PREF_Orden
If (ACT_AccountTrackInicializado )
	C_BLOB:C604(xBlob)
	  //ACTinit_CreateGenerationPrefs ("getBlobVarsAvisos";->xBlob)
	xBlob:=PREF_fGetBlob (0;"act_ordenEmisionAvisos";xBlob)
	BLOB_Blob2Vars (->xBlob;0;->OrdenCurNivNom;->OrdenDefault)
	SET BLOB SIZE:C606(xblob;0)
	OrdenDefault:=1
	OrdenCurNivNom:=0
	SET BLOB SIZE:C606(xblob;0)
	BLOB_Variables2Blob (->xBlob;0;->OrdenCurNivNom;->OrdenDefault)
	PREF_SetBlob (0;"act_ordenEmisionAvisos";xBlob)
	SET BLOB SIZE:C606(xBlob;0)
End if 


