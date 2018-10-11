//%attributes = {}
$y_Names:=$1
$y_Data:=$2

READ ONLY:C145([Alumnos_Inasistencias:10])

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave;$t_useruuid)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
$t_useruuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"usuario")
$t_uuidinasistencia:=NV_GetValueFromPairedArrays ($y_names;$y_data;"uuidinasistencia")
$t_observacion:=NV_GetValueFromPairedArrays ($y_names;$y_data;"observacion")
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	$idProf:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_useruuid;->[Profesores:4]Numero:1)
	$idUser:=KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$idProf;->[xShell_Users:47]No:1)
	If (True:C214)  //si fuera necesario verificar algun permiso
		If (<>vb_BloquearModifSituacionFinal)
			$0:=SERwa_GeneraRespuesta ("-2";"El registro de información conductual está bloqueado para el ciclo escolar actual a contar del "+String:C10(<>vd_FechaBloqueoSchoolTrack;5))
		Else 
			If (KRL_FindAndLoadRecordByIndex (->[Alumnos_Inasistencias:10]Auto_UUID:14;->$t_uuidinasistencia;True:C214)>-1)
				[Alumnos_Inasistencias:10]Observaciones:3:=$t_observacion
				SAVE RECORD:C53([Alumnos_Inasistencias:10])
				KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
				$0:=SERwa_GeneraRespuesta ("0";"Registro modificado con exito.")
			Else 
				$0:=SERwa_GeneraRespuesta ("-3";"Registro de inasistencia inexistente.")
			End if 
		End if 
	Else 
		$0:=SERwa_GeneraRespuesta ("-1";"Lo siento, Ud. no está autorizado para utilizar esta función.")
	End if 
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 