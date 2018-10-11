$line:=AL_GetLine (xALP_Impuesto)
$go:=True:C214
If ($line>0)
	AL_UpdateArrays (xALP_Impuesto;0)
	LOG_RegisterEvt ("Eliminación de  tasa de impuesto para el año "+String:C10(alACT_AñoTasaImpuesto{$line})+".")
	AT_Delete ($line;1;->alACT_AñoTasaImpuesto;->arACT_TasaMesImpuesto;->arACT_TasaMaximaImpuesto)
	AL_UpdateArrays (xALP_Impuesto;-2)
	AL_SetLine (xALP_Impuesto;0)
	IT_SetButtonState (False:C215;->bDeleteImpuesto)
Else 
	BEEP:C151
End if 