
$minutos:=AT_array2text (->al_minutos)
$choice:=Pop up menu:C542($minutos;al_minutos)
If ($choice>0)
	SN3_DataRecInterval:=al_minutos{$choice}
	vb_Gral_CFG_Mod:=True:C214
	$msg:="El intervalo de recepción de datos ha sido fijado a "+String:C10(SN3_DataRecInterval)+" minutos."
	LOG_RegisterEvt ($msg;0;0;<>lUSR_CurrentUserID;"ActuaDatos")
End if 