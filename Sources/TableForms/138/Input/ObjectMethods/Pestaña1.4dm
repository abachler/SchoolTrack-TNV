C_LONGINT:C283($itemref)
$pos:=Selected list items:C379(hlTab_ACT_Transacciones)

GET LIST ITEM:C378(hlTab_ACT_Transacciones;$pos;$itemref;$itemtext)

AL_UpdateArrays (xALP_Transacciones;0)
ACTter_LoadTransacciones ($itemref)
AL_UpdateArrays (xALP_Transacciones;-2)
AL_SetLine (xALP_Transacciones;0)
For ($i;1;Size of array:C274(aTransWidths))
	AL_SetWidths (xALP_Transacciones;$i;1;aTransWidths{$i})
End for 
