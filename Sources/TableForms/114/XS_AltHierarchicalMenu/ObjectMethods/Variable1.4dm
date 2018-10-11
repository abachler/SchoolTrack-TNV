Case of 
	: (Form event:C388=On Load:K2:1)
		AL_SetLine (Self:C308->;0)
	: (alProEvt=1)
		atXSmnu_MenuCommand:=AL_GetLine (Self:C308->)
		ACCEPT:C269
End case 