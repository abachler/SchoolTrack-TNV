If (Self:C308->="")
	Case of 
		: (Form event:C388=On Getting Focus:K2:7)
			POST KEY:C465(Character code:C91("-");256)
	End case 
End if 

Case of 
	: (Form event:C388=On Losing Focus:K2:8)
		If (Test path name:C476(Self:C308->)#Is a document:K24:1)
			Self:C308->:=""
		End if 
End case 