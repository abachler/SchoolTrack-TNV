//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 07-05-18, 20:27:04
  // ----------------------------------------------------
  // Método: SERwa_CalendarioEliminaEvento
  // Descripción
  // Método que centraliza la eliminación de eventos del calendario desde STWA y desde Cóndor
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($0)
C_POINTER:C301($y_Names;$y_Data;$1;$2)
C_LONGINT:C283($l_idApp)
C_TEXT:C284($t_autenticacion)

$y_Names:=$1
$y_Data:=$2

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	
	C_TEXT:C284($t_uuidAs;$t_uuidEvento)
	C_LONGINT:C283($l_idUsuario;$l_idProf)
	C_BOOLEAN:C305($b_desdeSTWA)
	
	READ ONLY:C145([Profesores:4])
	READ ONLY:C145([xShell_Users:47])
	
	$t_uuidEvento:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuidevento")
	$t_uuidUser:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuidusuario")
	$l_idUsuario:=KRL_GetNumericFieldData (->[xShell_Users:47]Auto_UUID:24;->$t_uuidUser;->[xShell_Users:47]No:1)
	$b_desdeSTWA:=False:C215
	
	$l_idProf:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_uuidUser;->[Profesores:4]Numero:1)
	$l_idUsuario:=KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$l_idProf;->[xShell_Users:47]No:1)
	
	$0:=Calendario_EliminaEvento ($t_uuidEvento;$l_idUsuario;$b_desdeSTWA)
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 