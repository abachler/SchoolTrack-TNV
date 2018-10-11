$fEvent:=Form event:C388
Case of 
	: ($fEvent=On Load:K2:1)
		$currentChoice:=[ADT_Candidatos:49]secs_Presentación:23
		For ($i;1;Size of array:C274(adPST_PresentDate))
			$secs:=SYS_DateTime2Secs (adPST_PresentDate{$i};aLPST_PresentTime{$i})
			$sum:=aiPST_Asistentes{$i}
			Case of 
				: ($sum>=viPST_MaxPerPresentation)
					AL_SetRowColor (Self:C308->;$i;"Black";0;"";4)
				: (($sum+vi_asistPresent)>viPST_MaxPerPresentation)
					AL_SetRowColor (Self:C308->;$i;"Black";0;"";3)
				Else 
					AL_SetRowColor (Self:C308->;$i;"Black";0;"";178)
			End case 
			  //aiPST_Asistentes{$i}:=$sum
			If ($secs=$currentChoice)
				AL_SetRowStyle (Self:C308->;$i;1;"Tahoma")
			Else 
				AL_SetRowStyle (Self:C308->;$i;0;"Tahoma")
			End if 
		End for 
		AL_SetLine (Self:C308->;0)
End case 
If (alProEvt=2)
	$line:=AL_GetLine (Self:C308->)
	If (adPST_PresentDate{$line}<Current date:C33(*))
		CD_Dlog (0;__ ("No es posible asignar una fecha de presentación en el pasado."))
	Else 
		adPST_PresentDate:=AL_GetLine (Self:C308->)
		ACCEPT:C269
	End if 
End if 