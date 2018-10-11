$y_profesorJefe:=OBJECT Get pointer:C1124(Object current:K67:2)

IT_clairvoyanceOnFields2 ($y_profesorJefe;->[Profesores:4]Apellidos_y_nombres:28)

If (Form event:C388=On Data Change:K2:15)
	If (Records in selection:C76([Profesores:4])=1)
		If ([Profesores:4]Inactivo:62)
			$ignore:=CD_Dlog (0;__ ("El profesor seleccionado está inactivado.\rSelecione un profesor activo o active el profesor seleccionado."))
			$y_profesorJefe->:=""
			[Actividades:29]No_Profesor:3:=0
			GOTO OBJECT:C206($y_profesorJefe->)
		Else 
			$y_profesorJefe->:=[Profesores:4]Apellidos_y_nombres:28
			[Actividades:29]No_Profesor:3:=[Profesores:4]Numero:1
			RELATE ONE:C42([Actividades:29]No_Profesor:3)
		End if 
	Else 
		$y_profesorJefe->:=""
		[Actividades:29]No_Profesor:3:=0
		$ignore:=CD_Dlog (0;__ ("No hay ningún profesor en la base de datos cuyos apellidos y nombre comience con \"")+Get edited text:C655+"\"")
		GOTO OBJECT:C206($y_profesorJefe->)
	End if 
End if 
