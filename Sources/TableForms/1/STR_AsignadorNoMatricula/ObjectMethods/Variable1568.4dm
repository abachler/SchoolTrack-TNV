If (Self:C308->>0)
	  //<>i_ToGrade:=aNivelNo{Self->}
	If (aPopNivel1>aPopNivel2)
		BEEP:C151
		aPopNivel1:=aPopNivel2
		Self:C308->:=aPopNivel2
	End if 
	
End if 