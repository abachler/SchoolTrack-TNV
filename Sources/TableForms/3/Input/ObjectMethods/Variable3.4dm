IT_clairvoyanceOnFields2 (Self:C308;->[Profesores:4]Apellidos_y_nombres:28)

If (Form event:C388=On Data Change:K2:15)
	If (Records in selection:C76([Profesores:4])=1)
		If ([Profesores:4]Inactivo:62)
			$ignore:=CD_Dlog (0;__ ("El profesor seleccionado está inactivado.\rSelecione un profesor activo o active el profesor seleccionado."))
			vs_ProfesorJefe:=""
			[Cursos:3]Numero_del_profesor_jefe:2:=0
			GOTO OBJECT:C206(vs_ProfesorJefe)
		Else 
			vs_ProfesorJefe:=[Profesores:4]Apellidos_y_nombres:28
			[Cursos:3]Numero_del_profesor_jefe:2:=[Profesores:4]Numero:1
			RELATE ONE:C42([Actividades:29]No_Profesor:3)
		End if 
	Else 
		vs_ProfesorJefe:=""
		[Cursos:3]Numero_del_profesor_jefe:2:=0
		$ignore:=CD_Dlog (0;__ ("No hay ningún profesor en la base de datos cuyos apellidos y nombre comience con \"")+Get edited text:C655+"\"")
		GOTO OBJECT:C206(vs_ProfesorJefe)
	End if 
End if 