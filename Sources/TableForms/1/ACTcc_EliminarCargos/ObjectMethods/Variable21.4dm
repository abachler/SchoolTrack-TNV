If (vdACT_AñoAviso>vdACT_AñoAviso2)
	BEEP:C151
	vdACT_AñoAviso2:=vdACT_AñoAviso
	If (aMeses>aMeses2)
		aMeses:=aMeses2
		vs1:=aMeses{aMeses}
		vs2:=aMeses2{aMeses2}
	End if 
End if 