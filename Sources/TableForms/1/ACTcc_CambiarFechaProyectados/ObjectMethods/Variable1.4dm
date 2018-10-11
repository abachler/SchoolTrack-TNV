Case of 
	: (vi_PageNumber=1)
		vi_PageNumber:=1
	: (vi_PageNumber=2)
		vi_PageNumber:=1
	: (vi_PageNumber=3)
		vi_PageNumber:=2
	: (vi_PageNumber=4)
		vi_PageNumber:=3
End case 
FORM GOTO PAGE:C247(vi_PageNumber)
POST KEY:C465(Character code:C91("+");256)