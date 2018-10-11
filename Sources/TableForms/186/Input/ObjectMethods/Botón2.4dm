If (Is new record:C668([MPA_DefinicionAreas:186]))
	If ([MPA_DefinicionAreas:186]AreaAsignatura:4#"")
		$l_respuestaUsuario:=CD_Dlog (0;__ ("¿Desea realmente descartar la creación del área ")+[MPA_DefinicionAreas:186]AreaAsignatura:4+"?";"";__ ("Descartar");__ ("Guardar");__ ("Cancelar"))
		Case of 
			: ($l_respuestaUsuario=1)
				CANCEL:C270
			: ($l_respuestaUsuario=2)
				MPAcfg_Area_AlGuardar 
				If (MPAcfg_Area_EsValida )
					ACCEPT:C269
				End if 
			Else 
				  // la ventana permanece abierta
		End case 
	Else 
		CANCEL:C270
	End if 
Else 
	MPAcfg_Area_AlGuardar 
	If (MPAcfg_Area_EsValida )
		ACCEPT:C269
	End if 
End if 