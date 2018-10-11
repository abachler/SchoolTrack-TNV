$choicemes2:=Pop up menu:C542(AT_array2text (->aMeses2;";"))
If ($choicemes2>0)
	vs2:=aMeses2{$choicemes2}
	aMeses2:=Find in array:C230(aMeses2;vs2)
	If (Shift down:C543)
		aMeses:=aMeses2
		vs1:=aMeses{aMeses}
	Else 
		aMeses:=Find in array:C230(aMeses;vs1)
	End if 
	If (aMeses>aMeses2)
		If (vdACT_AñoAviso=vdACT_AñoAviso2)
			BEEP:C151
			aMeses:=aMeses2
			vs1:=vs2
		End if 
	End if 
End if 