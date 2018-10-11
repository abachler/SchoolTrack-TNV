


If (KRL_RegistroFueModificado (->[MPA_DefinicionDimensiones:188]))
	MPAcfg_Dim_AlGuardar 
	If (MPAcfg_Dim_EsValida )
		$l_respuestaUsuario:=CD_Dlog (0;__ ("Usted registró información para esta Dimensión de aprendizaje\r\r¿Desea guardar la información registrada?");"";__ ("Guardar");__ ("No guardar");__ ("Cancelar"))
		Case of 
			: ($l_respuestaUsuario=1)
				ACCEPT:C269
			: ($l_respuestaUsuario=2)
				CANCEL:C270
			Else 
				  // la ventana permanece abierta
		End case 
	End if 
Else 
	CANCEL:C270
End if 

