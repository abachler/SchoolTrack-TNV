ACTcfdi_OpcionesGenerales ("SaveConf";->vlACT_RSSel)
ACTfear_OpcionesGenerales ("GuardaBlob";->vlACT_RSSel)  //20161123 RCH
vlACT_RSSel:=alACTcfg_Razones{atACTcfg_Razones}
ACTcfdi_OpcionesGenerales ("OnLoadConf";->vlACT_RSSel)
If (<>gCountryCode="ar")  //20161026 RCH
	ACTfear_OpcionesGenerales ("CargaConf";->vlACT_RSSel)
End if 
