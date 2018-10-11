Case of 
	: (Form event:C388=On Drop:K2:12)
		RESOLVE POINTER:C394(Self:C308;$varName;$tableNum;$FieldNum)
		XS_Settings ("HandleDrag";$varName)
		
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			
		End if 
End case 
