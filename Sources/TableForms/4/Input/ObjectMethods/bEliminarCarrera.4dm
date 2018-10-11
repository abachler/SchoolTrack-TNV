If (USR_checkRights ("M";->[Profesores:4]))
	$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar esta información?");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		_O_QUERY SUBRECORDS:C108([Profesores:4]Carrera:16;([Profesores]Carrera'Fecha=ad_CarreraProfesor_Fecha{ad_CarreraProfesor_Fecha}) & ([Profesores]Carrera'Cargo=at_CarreraProfesor_Puesto{at_CarreraProfesor_Puesto}))
		_O_DELETE SUBRECORD:C96([Profesores:4]Carrera:16)
		AT_Delete (at_CarreraProfesor_Puesto;1;->ad_carreraProfesor_Fecha;->at_carreraProfesor_Puesto)
		ProfCarrera:=True:C214  //197852 
	End if 
End if 