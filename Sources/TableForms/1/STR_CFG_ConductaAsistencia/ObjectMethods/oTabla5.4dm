

If (j_tabla2=1)
	ARRAY LONGINT:C221(ATSTRAL_FALTACONV;6)
	For ($i;1;6)
		$valor:=ATSTRAL_FALTAMINUTOSDESDE{$i}+(Round:C94((ATSTRAL_FALTAMINUTOSHASTA{$i}-ATSTRAL_FALTAMINUTOSDESDE{$i})/2;0))
		ATSTRAL_FALTACONV{$i}:=$valor
	End for 
	AL_SetEnterable (xALP_TablaFaltasMin;4;0)
	AL_UpdateArrays (xALP_TablaFaltasMin;-2)
Else 
	ARRAY LONGINT:C221(ATSTRAL_FALTACONV;4)
	For ($i;1;4)
		$valor:=ATSTRAL_FALTAMINUTOSDESDE{$i}+(Round:C94((ATSTRAL_FALTAMINUTOSHASTA{$i}-ATSTRAL_FALTAMINUTOSDESDE{$i})/2;0))
		ATSTRAL_FALTACONV{$i}:=$valor
	End for 
	AL_SetEnterable (xALP_TablaFaltasMin;4;0)
	AL_UpdateArrays (xALP_TablaFaltasMin;-2)
End if 

