If (<>popIntLoc2>0)
	Case of 
		: (<>popIntLoc2=1)
			[Alumnos_EventosPersonales:16]Interlocutor:10:=[Alumnos:2]Nombre_Común:30
			OBJECT SET ENTERABLE:C238([Alumnos_EventosPersonales:16]Interlocutor:10;False:C215)
			OBJECT SET COLOR:C271([Alumnos_EventosPersonales:16]Interlocutor:10;-(15+(256*12)))
		: (<>popIntLoc2=2)
			QUERY:C277([Personas:7];[Personas:7]No:1=[Alumnos:2]Apoderado_académico_Número:27)
			[Alumnos_EventosPersonales:16]Interlocutor:10:=[Personas:7]Apellidos_y_nombres:30
			OBJECT SET ENTERABLE:C238([Alumnos_EventosPersonales:16]Interlocutor:10;False:C215)
			OBJECT SET COLOR:C271([Alumnos_EventosPersonales:16]Interlocutor:10;-(15+(256*12)))
		: (<>popIntLoc2=3)
			RELATE ONE:C42([Alumnos:2]curso:20)
			RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
			[Alumnos_EventosPersonales:16]Interlocutor:10:=[Profesores:4]Nombre_comun:21
			OBJECT SET ENTERABLE:C238([Alumnos_EventosPersonales:16]Interlocutor:10;False:C215)
			OBJECT SET COLOR:C271([Alumnos_EventosPersonales:16]Interlocutor:10;-(15+(256*12)))
		: (<>popIntLoc2=4)
			[Alumnos_EventosPersonales:16]Interlocutor:10:=<>gRector
			OBJECT SET ENTERABLE:C238([Alumnos_EventosPersonales:16]Interlocutor:10;False:C215)
			OBJECT SET COLOR:C271([Alumnos_EventosPersonales:16]Interlocutor:10;-(15+(256*12)))
		: (<>popIntLoc2=5)
			[Alumnos_EventosPersonales:16]Interlocutor:10:=""
			OBJECT SET ENTERABLE:C238([Alumnos_EventosPersonales:16]Interlocutor:10;True:C214)
			OBJECT SET COLOR:C271([Alumnos_EventosPersonales:16]Interlocutor:10;-15)
			GOTO OBJECT:C206([Alumnos_EventosPersonales:16]Interlocutor:10)
		: (<>popIntLoc2=6)
			[Alumnos_EventosPersonales:16]Interlocutor:10:=""
			OBJECT SET ENTERABLE:C238([Alumnos_EventosPersonales:16]Interlocutor:10;True:C214)
			OBJECT SET COLOR:C271([Alumnos_EventosPersonales:16]Interlocutor:10;-15)
			GOTO OBJECT:C206([Alumnos_EventosPersonales:16]Interlocutor:10)
	End case 
	OBJECT SET ENTERABLE:C238([Alumnos_EventosPersonales:16]Interlocutor:10;([Alumnos_EventosPersonales:16]Interlocutor:10#""))
End if 