If (DateIsValid (Self:C308->))
	HIGHLIGHT TEXT:C210(sMotivo;1;80)
Else 
	Self:C308->:=!00-00-00!
	GOTO OBJECT:C206(Self:C308->)
	HIGHLIGHT TEXT:C210(Self:C308->;1;80)
End if 