If (USR_checkRights ("M";->[Profesores:4]))
	$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente borrar esta información?");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		DELETE FROM ARRAY:C228(ad_CarreraProfesor_Fecha;at_CarreraProfesor_Puesto)
		DELETE FROM ARRAY:C228(at_CarreraProfesor_Puesto;at_CarreraProfesor_Puesto)
		_O_DELETE SUBRECORD:C96([Profesores:4]Carrera:16)
		CANCEL:C270
	End if 
Else 
	USR_ALERT_UserHasNoRights (1)
End if 