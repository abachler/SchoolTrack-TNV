TipoTransacciones:=AT_array2text (->atACT_TipoTransacciones)
$choice:=Pop up menu:C542(TipoTransacciones)

If ($choice#0)
	vsACT_TipoTransacciones:=atACT_TipoTransacciones{$choice}
	AL_UpdateArrays (xALP_Transacciones;0)
	ACTcc_LoadTransacciones ($choice)
	AL_UpdateArrays (xALP_Transacciones;-2)
	AL_SetLine (xALP_Transacciones;0)
End if 