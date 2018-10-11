//%attributes = {}
  //TRACE
$y_Names:=$1
$y_Data:=$2

READ ONLY:C145([Asignaturas_RegistroSesiones:168])

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave;$t_useruuid)

$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
$t_useruuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"usuario")
$t_profuuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuid_profesor")
$t_uuidasignatura:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuid_asignatura")
$t_fecha:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fecha")
$l_hora:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"hora"))
$t_registrada:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"registrada")
$d_fecha:=Date:C102(DT_FechaISO_a_FechaHora ($t_fecha))
$b_registrada:=($t_registrada="true")
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	$idProf:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_profuuid;->[Profesores:4]Numero:1)
	$idUser:=KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$idProf;->[xShell_Users:47]No:1)
	If (True:C214)  //si fuera necesario verificar algun permiso
		If (KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]auto_uuid:12;->$t_uuidasignatura)>-1)
			READ WRITE:C146([Asignaturas_RegistroSesiones:168])
			QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_fecha;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=$l_hora)
			If (Records in selection:C76([Asignaturas_RegistroSesiones:168])=0)
				AS_CreaSesionesAsignatura ([Asignaturas:18]Numero:1;$d_fecha)
				READ WRITE:C146([Asignaturas_RegistroSesiones:168])
				QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
				QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_fecha;*)
				QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=$l_hora)
			End if 
			[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=$b_registrada
			If ($b_registrada)
				[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=String:C10(Current date:C33(*);ISO date GMT:K1:10;Current time:C178(*))
				[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=USR_GetUserName ($idUser)
			Else 
				[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=""
				[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=""
			End if 
			SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
			KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
			$0:=SERwa_GeneraRespuesta ("0";"Registro modificado con exito.")
		Else 
			$0:=SERwa_GeneraRespuesta ("-2";"Asignatura inexistente.")
		End if 
	Else 
		$0:=SERwa_GeneraRespuesta ("-1";"Lo siento, Ud. no está autorizado para utilizar esta función.")
	End if 
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 