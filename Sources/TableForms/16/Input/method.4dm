

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		
		QUERY:C277([Profesores:4];[Profesores:4]Inactivo:62=False:C215)
		ORDER BY:C49([Profesores:4];[Profesores:4]Nombre_comun:21;>)
		SELECTION TO ARRAY:C260([Profesores:4]Nombre_comun:21;at_Profesores_Nombres;[Profesores:4]Numero:1;al_Profesores_ID)
		
		If ([Alumnos_EventosPersonales:16]Fecha:3=!00-00-00!)
			[Alumnos_EventosPersonales:16]Fecha:3:=Current date:C33
			[Alumnos_EventosPersonales:16]Alumno_Numero:1:=[Alumnos:2]numero:1
			[Alumnos_EventosPersonales:16]Autor:8:=<>tUSR_CurrentUser
			[Alumnos_EventosPersonales:16]ID_Autor:11:=<>lUSR_RelatedTableUserID
			[Alumnos_EventosPersonales:16]Tipo_de_evento:6:="Observación"
			[Alumnos_EventosPersonales:16]ID_Owner:2:=0
		End if 
		SET WINDOW TITLE:C213(__ ("Registro de ")+[Alumnos_EventosPersonales:16]Tipo_de_evento:6+__ (" para ")+[Alumnos:2]apellidos_y_nombres:40)
		If ([Alumnos_EventosPersonales:16]ID_Owner:2>0)
			bPrivate:=1
		End if 
		If ([Alumnos_EventosPersonales:16]Tipo_de_evento:6="Entrevista")
			STX_EvtPersVentanaEntrevista 
		Else 
			STX_EvtPersVentanaEvento 
		End if 
	: (Form event:C388=On Data Change:K2:15)
		Case of 
			: ([Alumnos_EventosPersonales:16]Tipo_de_evento:6="Entrevista")
				STX_EvtPersVentanaEntrevista 
			Else 
				STX_EvtPersVentanaEvento 
		End case 
End case 


Spell_CheckSpelling 