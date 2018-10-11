Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If ([Familia_RegistroEventos:140]ID_Familia:1=0)
			[Familia_RegistroEventos:140]ID_Familia:1:=[Familia:78]Numero:1
			[Familia_RegistroEventos:140]Fecha_Evento:2:=Current date:C33(*)
			[Familia_RegistroEventos:140]Registrado_por:5:=<>tUSR_CurrentUser
			[Familia_RegistroEventos:140]ID_Autor:9:=<>lUSR_RelatedTableUserID
			SET WINDOW TITLE:C213(__ ("Nuevo evento familiar"))
		Else 
			SET WINDOW TITLE:C213(__ ("Registro de Eventos Familiares"))
		End if 
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
