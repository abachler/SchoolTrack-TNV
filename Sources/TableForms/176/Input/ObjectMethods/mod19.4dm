$rut:=CTRY_CL_VerifRUT (Self:C308->)
If ($rut="")
	Self:C308->:=$rut
	GOTO OBJECT:C206(Self:C308->)
End if 