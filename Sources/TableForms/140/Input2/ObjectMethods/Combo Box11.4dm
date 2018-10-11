If (Form event:C388=On Clicked:K2:4)
	[Familia_RegistroEventos:140]Tipo_Evento:3:=<>at_EventosFamiliares{0}
Else 
	IT_Clairvoyance (-><>at_EventosFamiliares{0};-><>at_EventosFamiliares;"Eventos familias")
	[Familia_RegistroEventos:140]Tipo_Evento:3:=<>at_EventosFamiliares{0}
End if 