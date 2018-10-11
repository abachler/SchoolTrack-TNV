$ref:=Selected list items:C379(hlTab_ACT_Transacciones)
AL_UpdateArrays (xALP_Transacciones;0)
ACTcc_LoadTransacciones ($ref)
AL_UpdateArrays (xALP_Transacciones;-2)
AL_SetLine (xALP_Transacciones;0)
For ($i;1;Size of array:C274(aTransWidths))
	AL_SetWidths (xALP_Transacciones;$i;1;aTransWidths{$i})
End for 