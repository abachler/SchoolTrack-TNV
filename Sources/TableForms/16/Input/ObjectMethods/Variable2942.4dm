If (Self:C308->>0)
	[Alumnos_EventosPersonales:16]Tipo_de_evento:6:=Self:C308->{Self:C308->}
	If ([Alumnos_EventosPersonales:16]Tipo_de_evento:6="Entrevista")
		STX_EvtPersVentanaEntrevista 
	Else 
		STX_EvtPersVentanaEvento 
		OBJECT SET VISIBLE:C603(*;"Entrevista@";False:C215)
	End if 
	SET WINDOW TITLE:C213(__ ("Registro de ")+[Alumnos_EventosPersonales:16]Tipo_de_evento:6+__ (" para ")+[Alumnos:2]apellidos_y_nombres:40)
End if 