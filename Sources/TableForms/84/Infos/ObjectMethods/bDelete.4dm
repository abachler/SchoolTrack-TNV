
OK:=CD_Dlog (0;"¿Desea Usted realmente eliminar este registro histórico?";"";"No";"Si")
If (OK=2)
	DELETE RECORD:C58([Alumnos_Calificaciones:208])
	LOG_RegisterEvt ("Eliminación de registros históricos para el alumno: "+[Alumnos:2]apellidos_y_nombres:40)
	ACCEPT:C269
End if 
