$choicemes1:=Pop up menu:C542(Meses1;aMeses)
If ($choicemes1>0)
	vs1:=aMeses{$choicemes1}
	aMeses:=Find in array:C230(aMeses;vs1)
	If (Shift down:C543)
		aMeses2:=aMeses
		vs2:=aMeses2{aMeses2}
	Else 
		aMeses2:=Find in array:C230(aMeses2;vs2)
	End if 
	If (aMeses>aMeses2)
		If (vdACT_AñoAviso>=vdACT_AñoAviso2)
			BEEP:C151
			aMeses2:=aMeses
			vs2:=vs1
		End if 
	End if 
	vdACT_FechaAviso:=DT_GetDateFromDayMonthYear (vdACT_DiaAviso;aMeses;vdACT_AñoAviso)
End if 