Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		xALSet_ADT_SelectPostJInfantil 
		For ($i;1;Size of array:C274(adPST_JFBirthDate))
			If ((adPST_JFBirthDate{$i}<adPST_FromDate{1}) | (adPST_JFBirthDate{$i}>adPST_ToDate{Size of array:C274(adPST_ToDate)}))
				AL_SetRowColor (xALP_PlayGroup;$i;"";4;"";0)
			Else 
				AL_SetRowColor (xALP_PlayGroup;$i;"";7;"";0)
			End if 
		End for 
		AL_SetSort (xALP_PlayGroup;1)
		AL_SetLine (xALP_PlayGroup;0)
	: (Form event:C388=On Close Box:K2:21)
		REDUCE SELECTION:C351([Alumnos:2];0)
		CANCEL:C270
End case 
