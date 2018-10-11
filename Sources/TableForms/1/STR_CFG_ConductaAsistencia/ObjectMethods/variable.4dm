If (Form event:C388=On Data Change:K2:15)
	PREF_Set (0;"ST_BloqueoAnotacionDias";String:C10(<>vi_nd_reg_anotacion))
	$t_logCambios:=__ ("La cantidad de dias para una anotación después del evento cambió a ^0";String:C10(<>vi_nd_reg_anotacion))+"\n"  //MONO 205385
	APPEND TO ARRAY:C911(at_logCambios;$t_logCambios)
End if 
