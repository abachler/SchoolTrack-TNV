Case of 
	: (Form event:C388=On Load:K2:1)
		ACTepr_OpcionesGenerales ("DeclaraVariables")
		ACTepr_OpcionesGenerales ("InicializaVariables")
		ACTepr_OpcionesGenerales ("CargaDatosApoderado";->ACTepr_RutApoderado)
		
		For ($l_indice;1;Size of array:C274(abACTepr_Enviar))
			If (abACTepr_Enviar{$l_indice})
				APPEND TO ARRAY:C911(alACTepr_Colores;0)
			Else 
				APPEND TO ARRAY:C911(alACTepr_Colores;16711680)
			End if 
		End for 
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		
End case 