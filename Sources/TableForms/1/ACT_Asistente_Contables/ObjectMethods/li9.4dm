If (Self:C308->>Year of:C25(Current date:C33(*)))
	BEEP:C151
	Self:C308->:=Year of:C25(Current date:C33(*))
	GOTO OBJECT:C206(Self:C308->)
End if 