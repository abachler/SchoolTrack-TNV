IT_Clairvoyance (Self:C308;-><>aPsyEvents;"Tipo de Evento (orientación)")

If (Form event:C388=On Losing Focus:K2:8)
	SET WINDOW TITLE:C213(__ ("Registro de ")+[Alumnos_EventosOrientacion:21]Tipo_evento:11+__ (" para ")+[Alumnos:2]apellidos_y_nombres:40)
End if 