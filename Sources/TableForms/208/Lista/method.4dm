If (Form event:C388=On Display Detail:K2:22)
	C_LONGINT:C283($id_asignatura)
	If ([Alumnos_Calificaciones:208]ID_Asignatura:5#0)
		$id_asignatura:=Abs:C99([Alumnos_Calificaciones:208]ID_Asignatura:5)
		$recNum:=KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$id_asignatura)
		If ($recNum>=0)
			vt_NombreAsignatura:=[Asignaturas:18]Asignatura:3+" / "+[Asignaturas:18]denominacion_interna:16
		Else 
			vt_NombreAsignatura:=[Alumnos_Calificaciones:208]NombreOficialAsignatura:7+" (Asignatura histórica)"
		End if 
	Else 
		vt_NombreAsignatura:=[Alumnos_Calificaciones:208]NombreOficialAsignatura:7+" (Asignatura histórica)"
	End if 
End if 