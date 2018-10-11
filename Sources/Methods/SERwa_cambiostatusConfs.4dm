//%attributes = {}
C_TEXT:C284($0)
C_POINTER:C301($y_Names;$y_Data;$1;$2)

$y_Names:=$1
$y_Data:=$2

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave;$t_useruuid)
C_LONGINT:C283($idAlumno)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
$t_useruuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"usuario")
$t_alumnouuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"alumno")
$t_statusNuevo:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"statusnuevo")
$idAlumno:=KRL_GetNumericFieldData (->[Alumnos:2]auto_uuid:72;->$t_alumnouuid;->[Alumnos:2]numero:1)
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	$idProf:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_useruuid;->[Profesores:4]Numero:1)
	$idUser:=KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$idProf;->[xShell_Users:47]No:1)
	If (STWA2_Priv_GetMethodAccess ("AL_CambiaStatusAlumno";$idUser))
		$0:=AL_CambiaStatusConfirmaciones ($idAlumno;$t_statusNuevo)
	Else 
		$0:=SERwa_GeneraRespuesta ("-1";"Lo siento, Ud. no está autorizado para utilizar esta función.")
	End if 
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 