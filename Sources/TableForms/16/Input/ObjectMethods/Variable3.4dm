If (([Alumnos_EventosPersonales:16]ID_Autor:11=<>lUSR_RelatedTableUserID) | (USR_IsGroupMember_by_GrpID (-15001)))
	If (USR_checkRights ("D";->[Alumnos_EventosPersonales:16]))
		$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente borrar este registro?");__ ("");__ ("No");__ ("Eliminar"))
		If ($r=2)
			DELETE RECORD:C58([Alumnos_EventosPersonales:16])
			CANCEL:C270
		End if 
	Else 
		USR_ALERT_UserHasNoRights (3)
	End if 
Else 
	$r:=CD_Dlog (2;__ ("Usted no es el autor de este evento ni tiene la condición de Administrador.\r\rEl evento no puede ser eliminado."))
End if 