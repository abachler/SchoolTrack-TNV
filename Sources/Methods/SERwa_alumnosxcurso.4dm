//%attributes = {}
C_TEXT:C284($0)
C_POINTER:C301($y_Names;$y_Data;$1;$2)

$y_Names:=$1
$y_Data:=$2

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave;$t_useruuid)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
$t_curso:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"curso")
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	READ ONLY:C145([Alumnos:2])
	ARRAY POINTER:C280($cols;0)
	ARRAY TEXT:C222($names;0)
	Case of 
		: ($t_curso="Egresados")
			QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;=;Nivel_Egresados*1;*)
			QUERY:C277([Alumnos:2]; | ;[Alumnos:2]nivel_numero:29;=;1002)
		: ($t_curso="Retirados")
			QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;=;Nivel_Retirados*1;*)  //20160525 ASM Ticket 155677
			QUERY:C277([Alumnos:2]; | ;[Alumnos:2]curso:20="RET")
		: ($t_curso="Admisión")
			QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;=;Nivel_AdmisionDirecta*1)
		Else 
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$t_curso)
	End case 
	ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
	APPEND TO ARRAY:C911($cols;->[Alumnos:2]auto_uuid:72)
	APPEND TO ARRAY:C911($cols;->[Alumnos:2]apellidos_y_nombres:40)
	APPEND TO ARRAY:C911($names;"uuid_alumno")
	APPEND TO ARRAY:C911($names;"nombre_alumno")
	$0:=OB_Selection2Json (->[Alumnos:2];->$cols;->$names)
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 