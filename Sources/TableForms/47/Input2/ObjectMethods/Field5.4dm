$recNum:=Find in field:C653([xShell_Users:47]login:9;[xShell_Users:47]login:9)
If ($recNum>=0)
	$ignore:=CD_Dlog (0;__ ("Ya existe un usuario registrado con ese nombre. Por favor elija un nombre de usuario distinto."))
	Self:C308->:=""
	GOTO OBJECT:C206(Self:C308->)
Else 
	If (Position:C15("_";Self:C308->)=1)
		BEEP:C151
		Self:C308->:=Substring:C12(Self:C308->;2)
	End if 
End if 