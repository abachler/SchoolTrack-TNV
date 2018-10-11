Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		xALP_Set_ACT_ApdosCta 
		AL_SetLine (xALP_ApdosCta;0)
		_O_DISABLE BUTTON:C193(bOK)
		For ($i;1;Size of array:C274(aEsApdoCta))
			If (aEsApdoCta{$i})
				AL_SetRowColor (xALP_ApdosCta;$i;"Red";0)
				AL_SetRowStyle (xALP_ApdosCta;$i;2)
			Else 
				AL_SetRowColor (xALP_ApdosCta;$i;"";16)
				AL_SetRowStyle (xALP_ApdosCta;$i;0)
			End if 
		End for 
		AL_UpdateArrays (xALP_ApdosCta;-1)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
