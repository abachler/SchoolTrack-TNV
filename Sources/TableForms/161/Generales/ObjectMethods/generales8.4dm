  // [SN3_PublicationPrefs].Generales.generales8()
  //
  //
  // creado por: Alberto Bachler Klein: 22/02/17, 16:08:21
  // -----------------------------------------------------------
C_LONGINT:C283($l_proceso)
C_TEXT:C284($t_mensaje;$t_RutaCarpetaFTP)

SN3_SaveGeneralSettings 

$t_RutaCarpetaFTP:="/SchoolFiles3/"

$l_proceso:=IT_UThermometer (1;0;__ ("Probando conexión al servidor FTP…");-1)
SN3_LoadGeneralSettings 

If ((SN3_SendFrom_Server=1) & (Application type:C494=4D Remote mode:K5:5))
	$t_mensaje:=FTP_TestConnection_onServer (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$t_RutaCarpetaFTP)
Else 
	$t_mensaje:=FTP_TestConnection (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$t_RutaCarpetaFTP)
End if 

If ($t_mensaje#"")
	$t_mensaje:=__ ("No fue posible establecer la conexión a causa de un error.\r\r")+$t_mensaje
Else 
	$t_mensaje:=__ ("La prueba de envío de archivos fue exitosa.")
End if 
$l_proceso:=IT_UThermometer (-2;$l_proceso)
ModernUI_Notificacion ("Prueba de conexión al servidor FTP";$t_mensaje)

