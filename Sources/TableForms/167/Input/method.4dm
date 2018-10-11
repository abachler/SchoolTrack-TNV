


Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY INTEGER:C220(al_Salas_Hora;0)
		ARRAY DATE:C224(ad_Salas_Desde;0)
		ARRAY DATE:C224(ad_Salas_Hasta;0)
		ARRAY TEXT:C222(at_Salas_Asignatura;0)
		ARRAY TEXT:C222(at_Salas_Curso;0)
		ARRAY TEXT:C222(at_Salas_Dia;0)
		ARRAY INTEGER:C220($al_salas_Dia;0)
		
		OBJECT SET ENTERABLE:C238(*;"@";USR_checkRights ("M";->[TMT_Horario:166]))
		READ ONLY:C145([Asignaturas:18])
		READ ONLY:C145([TMT_Horario:166])
		
		If ([TMT_Salas:167]ID_Sala:1#0)
			QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Sala:6=[TMT_Salas:167]ID_Sala:1)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			ORDER BY:C49([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1;>;[TMT_Horario:166]NumeroHora:2;>;[TMT_Horario:166]SesionesDesde:12;>;[TMT_Horario:166]SesionesHasta:13;>)
			SELECTION TO ARRAY:C260([TMT_Horario:166]NumeroDia:1;$al_salas_Dia;[TMT_Horario:166]NumeroHora:2;al_Salas_Hora;[TMT_Horario:166]SesionesDesde:12;ad_Salas_Desde;[TMT_Horario:166]SesionesHasta:13;ad_Salas_Hasta;[Asignaturas:18]denominacion_interna:16;at_Salas_Asignatura;[Asignaturas:18]Curso:5;at_Salas_Curso)
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		End if 
		
		ARRAY TEXT:C222(at_Salas_Dia;Size of array:C274($al_salas_Dia))
		For ($i;1;Size of array:C274(at_Salas_Dia))
			at_Salas_Dia{$i}:=DT_DayNameFromISODayNumber ($al_salas_Dia{$i})
		End for 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 