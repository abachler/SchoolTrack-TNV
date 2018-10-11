If ((Self:C308->>vr_MaxDevolucion) | (Self:C308->>[ACT_Boletas:181]Monto_Total:6))
	Self:C308->:=0
	BEEP:C151
End if 