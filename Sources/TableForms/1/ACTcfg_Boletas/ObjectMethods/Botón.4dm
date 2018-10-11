  //llamar a dummy
ACTfear_OpcionesGenerales ("GuardaBlob";->vlACT_RSSel)

C_TEXT:C284($t_respuesta)
$t_respuesta:=ACTfear_FEDummy (vlACT_RSSel)
CD_Dlog (0;"Verificación de servicios AFIP "+Choose:C955(cs_ambienteHomologacion=1;"Ambiente de Homologación";"Ambiente de Producción")+":"+"\r\r"+$t_respuesta)