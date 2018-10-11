Case of 
	: (vi_PageNumber=1)
		vi_PageNumber:=1
	: (vi_PageNumber=2)
		vi_PageNumber:=1
	: (vi_PageNumber=3)
		vi_PageNumber:=2
	: (vi_PageNumber=4)
		vi_PageNumber:=2
	: (vi_PageNumber=5)
		Case of 
			: (b1=1)
				vi_PageNumber:=2
			: (b2=1)
				vi_PageNumber:=3
			: (b3=1)
				vi_PageNumber:=4
		End case 
	: (vi_PageNumber=6)
		vi_PageNumber:=5
	: (vi_PageNumber=7)
		vi_PageNumber:=6
End case 
FORM GOTO PAGE:C247(vi_PageNumber)
POST KEY:C465(Character code:C91("+");256)