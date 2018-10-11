
If (vi_LineasPorFila<10)
	vi_LineasPorFila:=vi_LineasPorFila+1
	AL_SetHeight (xALP_Competencias;1;4;vi_LineasPorFila;4)
	AL_UpdateArrays (xALP_Competencias;-2)
Else 
	BEEP:C151
End if 

