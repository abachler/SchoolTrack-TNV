//%attributes = {}
  // XCR_DeleteSelection 
  // 20110518 RCH No existia este metodo para eliminar masivamente...
C_LONGINT:C283($0)
$0:=0
If (USR_checkRights ("D";->[Actividades:29]))
	$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar los registros seleccionados?");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		ARRAY LONGINT:C221($alSTR_recNumActividades;0)
		LONGINT ARRAY FROM SELECTION:C647([Actividades:29];$alSTR_recNumActividades;"")
		
		CREATE EMPTY SET:C140([Actividades:29];"setCursos")
		For ($i;1;Size of array:C274($alSTR_recNumActividades))
			READ WRITE:C146([Actividades:29])
			GOTO RECORD:C242([Actividades:29];$alSTR_recNumActividades{$i})
			READ WRITE:C146([Alumnos_Actividades:28])
			QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Actividad_numero:2=[Actividades:29]ID:1;*)
			QUERY:C277([Alumnos_Actividades:28]; & [Alumnos_Actividades:28]Año:3=<>gYear)
			DELETE SELECTION:C66([Alumnos_Actividades:28])
			DELETE RECORD:C58([Actividades:29])
			KRL_UnloadReadOnly (->[Alumnos_Actividades:28])
			KRL_UnloadReadOnly (->[Actividades:29])
		End for 
		NIV_LoadArrays 
		KRL_ExecuteOnConnectedClients ("NIV_LoadArrays")
		$0:=1
	End if 
Else 
	USR_ALERT_UserHasNoRights (3)
End if 
