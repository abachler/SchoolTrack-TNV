$line:=AL_GetLine (xALP_Divisas)
If ($line>0)
	$vl_idMoneda:=alACT_IdRegistro{$line}
	AL_UpdateArrays (xALP_Divisas;0)
	ACTcfgmyt_OpcionesGenerales ("CFG_EliminaMoneda";->$vl_idMoneda)
	AL_UpdateArrays (xALP_Divisas;-2)
	AL_SetLine (xALP_Divisas;$line)
	IT_SetButtonState (False:C215;->bDeleteMoneda)
	ACTcfg_ColorUndelDivisas 
Else 
	BEEP:C151
End if 
