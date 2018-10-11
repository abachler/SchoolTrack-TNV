//%attributes = {}
  //ADTcon_fSave

$0:=0

If (USR_checkRights ("M";->[ADT_Contactos:95]))
	If ((KRL_RegistroFueModificado (->[ADT_Contactos:95])) | (vb_ProsModified))
		If (([ADT_Contactos:95]Apellido_Paterno:2#"") & ([ADT_Contactos:95]Telefono_Domicilio:9#"") | ([ADT_Contactos:95]Telefono_Profesional:8#"") | ([ADT_Contactos:95]Telefono_Celular:10#"") | ([ADT_Contactos:95]eMail:7#""))
			If ([ADT_Contactos:95]ID:1=0)
				[ADT_Contactos:95]ID:1:=SQ_SeqNumber (->[ADT_Contactos:95]ID:1)
			End if 
			ADTcon_SaveProspectos 
			SAVE RECORD:C53([ADT_Contactos:95])
			$0:=1
		Else 
			$ignore:=CD_Dlog (0;__ ("Faltan datos para grabar este contacto. Se requiere al menos el apellido paterno y algún teléfono o el email."))
			$0:=-1
		End if 
	End if 
End if 