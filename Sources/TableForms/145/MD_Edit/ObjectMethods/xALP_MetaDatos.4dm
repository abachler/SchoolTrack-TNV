Case of 
	: (alProEvt=AL Single click event)
		$row:=AL_GetLine (Self:C308->)
		$col:=AL_GetColumn (Self:C308->)
		AL_GotoCell (Self:C308->;$col;$row)
	: (alProEvt=AL Empty Area Single click)
		AL_ExitCell (Self:C308->)
End case 
MData_Edit_OnClickEvent (Self:C308->)