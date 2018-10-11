$evt:=Form event:C388
Case of 
	: ($evt=On Clicked:K2:4)
		If (cb_mostrarUsuario=1)
			  //`mostrar columna de usuario
			AL_SetColOpts (xALP_Observaciones;1;1;1;1;0)
			$err:=ALP_DefaultColSettings (xALP_Observaciones;2;"atTextoObservacion";"Observaciones";300;"";0;1;1)
			AL_UpdateArrays (xALP_Observaciones;-2)
		Else 
			  //`ocultar columna de usuario
			AL_SetColOpts (xALP_Observaciones;1;1;1;2;0)
			  //`agrandar el texto de las observaciones
			$err:=ALP_DefaultColSettings (xALP_Observaciones;2;"atTextoObservacion";"Observaciones";368;"";0;1;1)
			AL_UpdateArrays (xALP_Observaciones;-2)
		End if 
End case 