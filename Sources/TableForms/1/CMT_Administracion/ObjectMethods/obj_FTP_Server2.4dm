  // [xxSTR_Constants].CMT_Administracion.obj_FTP_Server2()
  //
  //
  // creado por: Alberto Bachler Klein: 22/02/17, 15:18:20
  // -----------------------------------------------------------
C_LONGINT:C283($l_proceso)
C_TEXT:C284($t_mensaje;$t_RutaCarpetaFTP)

$t_RutaCarpetaFTP:="/CommTrack/Test/"

$l_proceso:=IT_UThermometer (1;0;__ ("Probando conexión al servidor FTP…");-1)
NET_Configuration ("Read")
$t_mensaje:=FTP_TestConnection_onServer (<>vt_CMT_FTP_ServerAddres;<>vt_CMT_FTP_Login;<>vt_CMT_FTP_Password;$t_RutaCarpetaFTP;<>ftp_UsePassive)
If ($t_mensaje#"")
	$t_mensaje:=__ ("No fue posible establecer la conexión a causa de un error.\r\r")+$t_mensaje
Else 
	$t_mensaje:=__ ("La prueba de envío de archivos fue exitosa.")
End if 
$l_proceso:=IT_UThermometer (-2;$l_proceso)
ModernUI_Notificacion ("Prueba de conexión al servidor FTP";$t_mensaje)


