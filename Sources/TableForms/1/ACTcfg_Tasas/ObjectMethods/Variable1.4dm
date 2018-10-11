AL_UpdateArrays (xALP_Impuesto;0)
AT_Insert (1;1;->alACT_AñoTasaImpuesto;->arACT_TasaMesImpuesto;->arACT_TasaMaximaImpuesto)
If (Size of array:C274(alACT_AñoTasaImpuesto)=1)
	alACT_AñoTasaImpuesto{1}:=Year of:C25(Current date:C33(*))
Else 
	alACT_AñoTasaImpuesto{1}:=alACT_AñoTasaImpuesto{2}+1
End if 
Case of 
	: (alACT_AñoTasaImpuesto{1}=2007)
		arACT_TasaMesImpuesto{1}:=0.125
		arACT_TasaMaximaImpuesto{1}:=1.5
		
	: (alACT_AñoTasaImpuesto{1}=2008)
		arACT_TasaMesImpuesto{1}:=0.1125
		arACT_TasaMaximaImpuesto{1}:=1.35
		
	Else 
		
		arACT_TasaMesImpuesto{1}:=0.1
		arACT_TasaMaximaImpuesto{1}:=1.2
		
End case 
AL_SetLine (xALP_Impuesto;1)
AL_UpdateArrays (xALP_Impuesto;-2)
AL_SetCellHigh (xALP_Impuesto;1;80)
$line:=AL_GetLine (xALP_Impuesto)
IT_SetButtonState (($line>0);->bDeleteImpuesto)