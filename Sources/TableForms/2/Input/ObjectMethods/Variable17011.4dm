If (alProEvt=0)
	AL_GetCurrCell (Self:C308->;$Col;$Row)
	If (($col>0) & ($row>0))
		AL_ExitCell (Self:C308->)
	End if 
Else 
	$row:=AL_GetLine (Self:C308->)
	IT_SetButtonState (($row>0) & (USR_checkRights ("M";->[Alumnos:2]));->bDelConnexion)
End if 