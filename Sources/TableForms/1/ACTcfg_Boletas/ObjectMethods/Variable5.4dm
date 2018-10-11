If (Self:C308-><vlACT_TempNextRecibo)
	If ((Macintosh option down:C545) | (Windows Alt down:C563))
		vlACT_TempNextRecibo:=Self:C308->
	Else 
		BEEP:C151
		Self:C308->:=vlACT_TempNextRecibo
	End if 
Else 
	vlACT_TempNextRecibo:=Self:C308->
End if 