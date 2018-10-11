vb_Gral_CFG_Mod:=True:C214
$msg:=ST_Boolean2Str (SN3_ActuaDatosNoMailApo=1;"Activado";"Desactivado")+", el no envío de mails a los padres con el resultado de su actualización"
LOG_RegisterEvt ($msg;0;0;<>lUSR_CurrentUserID;"ActuaDatos")