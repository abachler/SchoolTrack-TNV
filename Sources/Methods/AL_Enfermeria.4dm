//%attributes = {}
  //AL_Enfermeria

  //Busca la asignatura y el profesor donde se encontraba el alumno 
  //al momento de la visita a enfermeria del alumno
  //Creado por: Jorge Tapia Bastias
  //Fecha:14-10-2004
  //Hora:16:00 hrs.

  //ABK: Ponemos en REad only las tablas sobre las que buscamos, evitando que puedan quedar tomadas
READ ONLY:C145([Profesores:4])
READ ONLY:C145([TMT_Horario:166])
READ ONLY:C145([Asignaturas:18])

UNLOAD RECORD:C212([Profesores:4])
[Alumnos_EventosEnfermeria:14]Asignatura:11:=""
EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
	KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
End if 


If (Records in selection:C76([TMT_Horario:166])>0)
	  //busqueda de los registros de horario para la fecha de la visita e enfermeria
	QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12<=[Alumnos_EventosEnfermeria:14]Fecha:2;*)
	QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=[Alumnos_EventosEnfermeria:14]Fecha:2)
	  //ABK en las tres lineas que siguen se busca el horario para el día y la hora
	QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=(Day number:C114([Alumnos_EventosEnfermeria:14]Fecha:2)-1);*)
	QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]Desde:3<=[Alumnos_EventosEnfermeria:14]Hora_de_Ingreso:3;*)
	QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]Hasta:4>=[Alumnos_EventosEnfermeria:14]Hora_de_Ingreso:3)
	  //ABK: recuperación de la información de asignatura y profesor
	If (Records in selection:C76([TMT_Horario:166])>0)
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[TMT_Horario:166]ID_Asignatura:5)
		[Alumnos_EventosEnfermeria:14]Asignatura:11:=[Asignaturas:18]denominacion_interna:16
		[Alumnos_EventosEnfermeria:14]ID_Profesor:12:=[Asignaturas:18]profesor_numero:4
		[Alumnos_EventosEnfermeria:14]ID_Profesor_Autoriza:13:=[Asignaturas:18]profesor_numero:4
		QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Alumnos_EventosEnfermeria:14]ID_Profesor_Autoriza:13)
		vProfAutoriza:=[Profesores:4]Apellidos_y_nombres:28
		QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Alumnos_EventosEnfermeria:14]ID_Profesor:12)
		OBJECT SET VISIBLE:C603(*;"asignatura@";True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*;"asignatura@";False:C215)
		If (Is new record:C668([Alumnos_EventosEnfermeria:14]))
			[Alumnos_EventosEnfermeria:14]Fuera_de_horario:14:=True:C214
		End if 
	End if 
End if 