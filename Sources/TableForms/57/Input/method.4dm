Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		Case of 
			: (flagCreacion=2)
				[Buses_escolares:57]Patente:1:=sMatBus
			: (flagCreacion=1)
				[Buses_escolares:57]Numero:10:=vl_NoBus
		End case 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
