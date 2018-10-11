If (Self:C308->="")
	Self:C308->:=[xShell_Users:47]login:9
End if 
If (Position:C15("_";Self:C308->)=1)
	BEEP:C151
	Self:C308->:=Substring:C12(Self:C308->;2)
End if 