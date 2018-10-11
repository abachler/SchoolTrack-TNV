al_NivelDesdeInf:=Self:C308->
If (al_NivelDesdeInf>al_NivelHastaInf)
	BEEP:C151
	al_NivelDesdeInf:=al_NivelHastaInf
	Self:C308->:=at_NivelHastaInf
End if 