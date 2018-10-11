//%attributes = {}
C_TEXT:C284($0)
C_POINTER:C301($y_Names;$y_Data;$1;$2)

$y_Names:=$1
$y_Data:=$2

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave;$t_useruuid)
ARRAY TEXT:C222($a_alumnosuuids;0)
ARRAY LONGINT:C221($a_alumnosids;0)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
$t_useruuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"usuario")
$t_alumnosuuids:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"alumnos")
$t_cursoOrigen:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"cursoorigen")
$t_cursoDestino:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"cursodestino")
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	$idProf:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_useruuid;->[Profesores:4]Numero:1)
	$idUser:=KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$idProf;->[xShell_Users:47]No:1)
	If (STWA2_Priv_GetMethodAccess ("CU_Reorganizacion";$idUser))
		If (<>vb_BloquearModifSituacionFinal)
			$0:=SERwa_GeneraRespuesta ("-2";"Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del "+String:C10(<>vd_FechaBloqueoSchoolTrack;5))
		Else 
			ARRAY TEXT:C222($a_alumnosuuids;0)
			JSON PARSE ARRAY:C1219($t_alumnosuuids;$a_alumnosuuids)
			ARRAY LONGINT:C221($a_alumnosids;Size of array:C274($a_alumnosuuids))
			For ($i;1;Size of array:C274($a_alumnosuuids))
				$a_alumnosids{$i}:=KRL_GetNumericFieldData (->[Alumnos:2]auto_uuid:72;->$a_alumnosuuids{$i};->[Alumnos:2]numero:1)
			End for 
			$0:=AL_TransfiereConfirmaciones (->$a_alumnosids;$t_cursoOrigen;$t_cursoDestino)
		End if 
	Else 
		$0:=SERwa_GeneraRespuesta ("-1";"Lo siento, Ud. no está autorizado para utilizar esta función.")
	End if 
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 