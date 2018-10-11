
If (alProEvt=1)
	$line:=AL_GetLine (Self:C308->)
	IT_SetButtonState ((USR_checkRights ("M";->[Alumnos_FichaMedica:13]) & ($line>0));->bDelSalud_Hospitalizacion)
End if 
