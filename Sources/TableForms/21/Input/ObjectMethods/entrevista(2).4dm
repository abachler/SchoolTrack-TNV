If (<>popIntLoc>0)
	Case of 
		: (<>popIntLoc=1)
			[Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4:=[Alumnos:2]Nombre_Común:30
			OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4;False:C215)
			OBJECT SET COLOR:C271([Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4;-(15+(256*12)))
		: (<>popIntLoc=2)
			QUERY:C277([Personas:7];[Personas:7]No:1=[Alumnos:2]Apoderado_académico_Número:27)
			[Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4:=[Personas:7]Apellidos_y_nombres:30
			OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4;False:C215)
			OBJECT SET COLOR:C271([Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4;-(15+(256*12)))
		: (<>popIntLoc=3)
			RELATE ONE:C42([Alumnos:2]curso:20)
			RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
			[Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4:=[Profesores:4]Nombre_comun:21
			OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4;False:C215)
			OBJECT SET COLOR:C271([Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4;-(15+(256*12)))
		: (<>popIntLoc=4)
			[Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4:=<>gRector
			OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4;False:C215)
			OBJECT SET COLOR:C271([Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4;-(15+(256*12)))
		: (<>popIntLoc=5)
			[Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4:=""
			OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4;True:C214)
			OBJECT SET COLOR:C271([Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4;-15)
			GOTO OBJECT:C206([Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4)
		: (<>popIntLoc=6)
			[Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4:=""
			OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4;True:C214)
			OBJECT SET COLOR:C271([Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4;-15)
			GOTO OBJECT:C206([Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4)
	End case 
End if 