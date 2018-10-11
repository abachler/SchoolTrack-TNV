
If (KRL_RegistroFueModificado (->[MPA_DefinicionEjes:185]))
	If ([MPA_DefinicionEjes:185]Nombre:3#"")
		MPAcfg_Eje_AlGuardar 
		If (MPAcfg_Eje_EsValido )
			$l_respuestaUsuario:=CD_Dlog (0;__ ("Usted registró información para este Eje de aprendizaje\r\r¿Desea guardar la información registrada?");"";__ ("Guardar");__ ("No guardar");__ ("Cancelar"))
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
Else 
	CANCEL:C270
End if 

