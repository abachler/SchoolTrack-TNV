Case of 
	: (alProEvt=1)
		$line:=AL_GetLine (Self:C308->)
		IT_SetButtonState ((USR_checkRights ("M";->[Alumnos_FichaMedica:13]) & ($line>0));->bDelSalud_Vacuna)
	: (alProEvt=-1)
		AL_GetSort (xALP_vacunas;$sort)
		If (Abs:C99($sort)=1)
			Case of 
				: ((Macintosh option down:C545) | (Windows Alt down:C563))
					AL_SetSort (xALP_vacunas;-4)
				Else 
					AL_SetSort (xALP_vacunas;4)
			End case 
		End if 
End case 