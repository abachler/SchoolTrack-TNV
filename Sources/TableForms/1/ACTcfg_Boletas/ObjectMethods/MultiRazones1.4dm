ACTcfdi_OpcionesGenerales ("SaveConf";->vlACT_RSSel)

  //20150720 RCH Guarda opciones
ACTdte_AlertasOpciones ("GuardaBlob";->vlACT_RSSel)
ACTdte_OpcionesManeja ("GuardaBlob";->vlACT_RSSel)

vlACT_RSSel:=alACTcfg_Razones{atACTcfg_Razones}
ACTcfdi_OpcionesGenerales ("OnLoadConf";->vlACT_RSSel)
KRL_FindAndLoadRecordByIndex (->[ACT_RazonesSociales:279]id:1;->vlACT_RSSel;True:C214)
ACTcfgbol_OpcionesDTE ("OnLoadForm")