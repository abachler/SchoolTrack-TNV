If (b1Mode=1)
	FORM GOTO PAGE:C247(2)
	vi_PageNumber:=2
Else 
	FORM GOTO PAGE:C247(3)
	vi_PageNumber:=3
End if 
vt_ImportDocPath:=""
vt_ErrorStatus:=""