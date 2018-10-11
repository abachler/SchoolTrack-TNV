//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 08-10-18, 08:53:03
  // ----------------------------------------------------
  // Método: ACTwa_RegistraLog
  // Descripción
  // Para almacenar log sin el nombre de las variables interproceso
  //
  // Parámetros
  // ----------------------------------------------------


C_LONGINT:C283($l_userID)
C_TEXT:C284($t_userName;$1;$t_modulo;$t_usuario)
C_LONGINT:C283($l_table;$l_recordID;$l_userID)

$l_userID:=<>lUSR_CurrentUserID
$t_userName:=<>tUSR_CurrentUser

$t_modulo:="AccountTrack Web Access"
$t_usuario:="Internet"

LOG_RegisterEvt ($1;$l_table;$l_recordID;$l_userID;$t_modulo;$t_usuario)

If (Application type:C494#4D Server:K5:6)
	<>lUSR_CurrentUserID:=$l_userID
	<>tUSR_CurrentUser:=$t_userName
End if 
