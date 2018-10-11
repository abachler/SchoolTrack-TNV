
If (KRL_RegistroFueModificado (->[MPA_DefinicionCompetencias:187]))
	If ([MPA_DefinicionCompetencias:187]Competencia:6#"")
		MPAcfg_Comp_AlGuardar 
		If (MPAcfg_Comp_EsValida )
			$l_respuestaUsuario:=CD_Dlog (0;__ ("Usted registró información para esta Competencia\r\r¿Desea guardar la información registrada?");"";__ ("Guardar");__ ("No guardar");__ ("Cancelar"))
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