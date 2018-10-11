

If (j_tabla2=1)
	ARRAY LONGINT:C221(ATSTRAL_FALTACONV;6)
	For ($i;1;6)
		ATSTRAL_FALTACONV{$i}:=ATSTRAL_FALTAMINUTOSDESDE{$i}
	End for 
	AL_SetEnterable (xALP_TablaFaltasMin;4;0)
	AL_UpdateArrays (xALP_TablaFaltasMin;-2)
Else 
	ARRAY LONGINT:C221(ATSTRAL_FALTACONV;4)
	For ($i;1;4)
		ATSTRAL_FALTACONV{$i}:=ATSTRAL_FALTAMINUTOSDESDE{$i}
	End for 
	AL_SetEnterable (xALP_TablaFaltasMin;4;0)
	AL_UpdateArrays (xALP_TablaFaltasMin;-2)
End if 

