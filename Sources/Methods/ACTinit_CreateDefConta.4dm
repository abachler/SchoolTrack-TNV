//%attributes = {}
  //ACTinit_CreateDefConta
  //
  //$accountTrackIsInitialized:=Num(PREF_fGet (0;"ACT_Inicializado";"0"))
  //If ($accountTrackIsInitialized=1)
  //SET BLOB SIZE(xblob;0)
  //ARRAY STRING(80;<>asACT_GlosaCta;0)
  //ARRAY STRING(80;<>asACT_CuentaCta;0)
  //ARRAY STRING(80;<>asACT_CodAuxCta;0)
  //ARRAY STRING(80;<>asACT_Centro;0)
  //ARRAY TEXT(atACT_CtasEspecialesGlosa;0)
  //ARRAY STRING(80;asACT_CtasEspecialesCta;0)
  //ARRAY STRING(80;asACT_CtasEspecialesCentro;0)
  //AT_Insert (1;3;->atACT_CtasEspecialesGlosa;->asACT_CtasEspecialesCta;->asACT_CtasEspecialesCentro)
  //atACT_CtasEspecialesGlosa{1}:="IVA Debito Fiscal"
  //asACT_CtasEspecialesCta{1}:=""
  //asACT_CtasEspecialesCentro{1}:=""
  //atACT_CtasEspecialesGlosa{2}:="Descuentos"
  //asACT_CtasEspecialesCta{2}:=""
  //asACT_CtasEspecialesCentro{2}:=""
  //atACT_CtasEspecialesGlosa{3}:="Saldos disponibles"
  //asACT_CtasEspecialesCta{3}:=""
  //asACT_CtasEspecialesCentro{3}:=""
  //BLOB_Variables2Blob (->xBlob;0;-><>asACT_GlosaCta;-><>asACT_CuentaCta;-><>asACT_Centro;->atACT_CtasEspecialesGlosa;->asACT_CtasEspecialesCta;->asACT_CtasEspecialesCentro;-><>asACT_CodAuxCta)
  //xBlob:=PREF_fGetBlob (0;"Contabilidad";xBlob)
  //SET BLOB SIZE(xBlob;0)
  //End if 

If (ACT_AccountTrackInicializado )
	ACTcfg_OpcionesContabilidad ("VerificaCuentasEspeciales")
End if 