Case of 
	: (Form event:C388=On Data Change:K2:15)
		Case of 
			: (Self:C308->>100)
				Self:C308->:=100
			: (Self:C308-><0)
				Self:C308->:=0
		End case 
		Self:C308->:=Round:C94(Self:C308->;2)
		
End case 