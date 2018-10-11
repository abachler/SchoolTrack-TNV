//%attributes = {}
  //XCR_Delete

C_LONGINT:C283($0)
If (USR_checkRights ("D";->[Actividades:29]))
	$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar la actividad ")+[Actividades:29]Nombre:2+__ ("?");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		READ WRITE:C146([Alumnos_Actividades:28])
		QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Actividad_numero:2=[Actividades:29]ID:1;*)
		QUERY:C277([Alumnos_Actividades:28]; & [Alumnos_Actividades:28]Año:3=<>gYear)
		DELETE SELECTION:C66([Alumnos_Actividades:28])
		READ ONLY:C145([Alumnos_Actividades:28])
		DELETE RECORD:C58([Actividades:29])
		NIV_LoadArrays 
		KRL_ExecuteOnConnectedClients ("NIV_LoadArrays")
		$0:=1
	End if 
Else 
	USR_ALERT_UserHasNoRights (3)
End if 