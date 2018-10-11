Case of 
	: ((Form event:C388=On Getting Focus:K2:7) | (Form event:C388=On After Keystroke:K2:26))
		IT_Clairvoyance (Self:C308;-><>aComuna;"Comunas")
		
	: (Form event:C388=On Losing Focus:K2:8)
		If ((Old:C35([Familia:78]Comuna:8)#[Familia:78]Comuna:8) & ([Familia:78]Comuna:8#""))
			AL_ActualizaDireccionFamilia (Self:C308)
		End if 
End case 