//%attributes = {}
  //ACTcfg_validaCtasEspeciales

  //ARRAY STRING(80;<>asACT_GlosaCta;0)
  //ARRAY STRING(80;<>asACT_CuentaCta;0)
  //ARRAY STRING(80;<>asACT_CodAuxCta;0)
  //ARRAY STRING(80;<>asACT_Centro;0)
  //ARRAY TEXT(atACT_CtasEspecialesGlosa;0)
  //ARRAY STRING(80;asACT_CtasEspecialesCta;0)
  //ARRAY STRING(80;asACT_CtasEspecialesCentro;0)
  //C_BLOB(xBlob)
  //SET BLOB SIZE(xBlob;0)
  //ACTcfg_LoadConfigData (10)
  //ARRAY TEXT($atACT_CtasEspeciales;0)
  //APPEND TO ARRAY($atACT_CtasEspeciales;"IVA Debito Fiscal")
  //APPEND TO ARRAY($atACT_CtasEspeciales;"Saldos disponibles")
  //
  //For ($i;1;Size of array($atACT_CtasEspeciales))
  //If (Find in array(atACT_CtasEspecialesGlosa;$atACT_CtasEspeciales{$i})=-1)
  //ACTcfg_OpcionesContabilidad ("InsertaGlosaArreglosCuentasEspeciales";->$atACT_CtasEspeciales{$i})
  //End if 
  //End for 
  //
  //  //If (Find in array(atACT_CtasEspecialesGlosa;"IVA Debito Fiscal")=-1)
  //  //APPEND TO ARRAY(atACT_CtasEspecialesGlosa;"IVA Debito Fiscal")
  //  //AT_Insert (0;1;->asACT_CtasEspecialesCta;->asACT_CtasEspecialesCentro)
  //  //ACTcfg_OpcionesContabilidad ("InsertaArreglosCuentasEspeciales")
  //  //End if 
  //  //If (Find in array(atACT_CtasEspecialesGlosa;"Saldos disponibles")=-1)
  //  //APPEND TO ARRAY(atACT_CtasEspecialesGlosa;"Saldos disponibles")
  //  //AT_Insert (0;1;->asACT_CtasEspecialesCta;->asACT_CtasEspecialesCentro)
  //  //End if 
  //ACTcfg_SaveConfig (10)
  //SET BLOB SIZE(xBlob;0)
ACTcfg_OpcionesContabilidad ("VerificaCuentasEspeciales")