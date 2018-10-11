Case of 
	: (Form event:C388=On Clicked:K2:4)
		READ ONLY:C145([Personas:7])
		GOTO RECORD:C242([Personas:7];aParentRecNo{Self:C308->})
	: (Form event:C388=On Double Clicked:K2:5)
		READ ONLY:C145([Personas:7])
		GOTO RECORD:C242([Personas:7];aParentRecNo{Self:C308->})
		ACCEPT:C269
End case 
