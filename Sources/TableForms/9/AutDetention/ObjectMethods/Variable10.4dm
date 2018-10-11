  //[Alumnos_Castigos.AutDetention.bGen

If (DateIsValid (ddDate))
	READ WRITE:C146([Alumnos_Castigos:9])
	CREATE RECORD:C68([Alumnos_Castigos:9])
	[Alumnos_Castigos:9]Motivo:2:="Anotaciones acumuladas"
	[Alumnos_Castigos:9]Observaciones:3:=sObs
	[Alumnos_Castigos:9]Profesor_Numero:6:=iProfID
	[Alumnos_Castigos:9]Horas_de_castigo:7:=iHrs
	[Alumnos_Castigos:9]Alumno_Numero:8:=[Alumnos:2]numero:1
	[Alumnos_Castigos:9]Nivel_Numero:11:=[Alumnos:2]nivel_numero:29
	[Alumnos_Castigos:9]Fecha:9:=ddDate
	SAVE RECORD:C53([Alumnos_Castigos:9])
	UNLOAD RECORD:C212([Alumnos_Castigos:9])
	READ ONLY:C145([Alumnos_Castigos:9])
	LOG_RegisterEvt ("Conducta - Registro de castigo propuesto: "+[Alumnos:2]apellidos_y_nombres:40+" , "+[Alumnos:2]curso:20)
	
	$value:=0
	$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
	AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]AnotacionesNegativas_Cumulo:54;->$value)
	CANCEL:C270
End if 
