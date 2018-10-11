C_TEXT:C284($t_respuesta)
C_LONGINT:C283($l_proc)

$l_proc:=IT_UThermometer (1;0;__ ("Guardando configuración..."))
ACTfear_OpcionesGenerales ("GuardaBlob";->vlACT_RSSel)
IT_UThermometer (0;$l_proc;__ ("Consultando a la AFIP..."))
$t_respuesta:=ACTfear_FEParamGetPtosVenta (vlACT_RSSel)
IT_UThermometer (-2;$l_proc)
CD_Dlog (0;$t_respuesta)