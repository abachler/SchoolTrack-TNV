//%attributes = {}
  //AL_isNotAbsent

If (DateIsValid ($1))
	QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1)
	QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1=$1)
	If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
		$0:=$1
	Else 
		CD_Dlog (0;[Alumnos:2]apellidos_y_nombres:40+__ (" ya está registrado como inasistente en esta fecha."))
		$0:=!00-00-00!
	End if 
Else 
	$0:=!00-00-00!
End if 