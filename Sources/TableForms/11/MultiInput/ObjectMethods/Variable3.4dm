If (Self:C308-><=Current date:C33(*))
	If (DateIsValid (Self:C308->))
		HIGHLIGHT TEXT:C210(sMotivo;1;80)
	Else 
		Self:C308->:=!00-00-00!
		GOTO OBJECT:C206(Self:C308->)
		HIGHLIGHT TEXT:C210(Self:C308->;1;80)
	End if 
Else 
	Self:C308->:=!00-00-00!
	GOTO OBJECT:C206(Self:C308->)
	HIGHLIGHT TEXT:C210(Self:C308->;1;80)
	$l_ignorar:=CD_Dlog (0;__ ("La fecha ingresada es posterior a hoy.\r\rNo es posible registrar una anotación anticipadamente."))
End if 
