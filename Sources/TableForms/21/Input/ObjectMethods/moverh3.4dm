If (USR_checkRights ("D";->[Alumnos_EventosOrientacion:21]))
	$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente borrar este registro?");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		DELETE RECORD:C58([Alumnos_EventosOrientacion:21])
		CANCEL:C270
	End if 
Else 
	USR_ALERT_UserHasNoRights (3)
End if 
