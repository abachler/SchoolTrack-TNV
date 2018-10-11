Case of 
	: (vi_PageNumber=1)
		vi_PageNumber:=1
	: (vi_PageNumber=2)
		vi_PageNumber:=1
	: (vi_PageNumber=3)
		If (cbPAC=1)
			vi_PageNumber:=2
		Else 
			vi_PageNumber:=1
		End if 
End case 
FORM GOTO PAGE:C247(vi_PageNumber)
POST KEY:C465(Character code:C91("+");256)