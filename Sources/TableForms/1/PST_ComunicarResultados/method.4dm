Case of 
	: (Form event:C388=On Load:K2:1)
		  //carga las formas de comunicar los resultados que ha configurado el colegio en listas configurables
		XS_SetInterface 
		xALP_Set_ADT_ComunicarResultado 
		
		For ($i;1;Size of array:C274(<>FormasComunicarResultados))
			If (<>FormasComunicarResultados{$i}=[ADT_Candidatos:49]FormaComunicarResultados:58)
				AL_SetRowColor (xALP_ComunicacionResultados;$i;"";7;"";161)
				AL_SetRowStyle (xALP_ComunicacionResultados;$i;1)
			Else 
				AL_SetRowColor (xALP_ComunicacionResultados;$i;"";7;"";161)
			End if 
		End for 
		AL_SetLine (xALP_ComunicacionResultados;0)
End case 
