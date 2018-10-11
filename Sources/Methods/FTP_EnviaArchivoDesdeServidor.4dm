//%attributes = {}
  // FTP_EnviaArchivoDesdeServidor()
  // Por: Alberto Bachler K.: 02-11-14, 15:56:35
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
  //$t_urlFTP:=$1
  //$t_nombreUsuario:=$2
  //$t_contraseña:=$3
$t_rutaArchivo:=$1
$t_nombreArchivo:=SYS_Path2FileName ($t_rutaArchivo)

WS_GetFtpLoginInfo 
$l_error:=FTP_Progress (-1;-1;"Enviando respaldo \""+$t_nombreArchivo;"*";"*")
$l_error:=FTP_Login ("ftp.colegium.com";vtWS_ftpLoginName;vtWS_ftpPassword;$l_ftpID;$t_texto)
If ($l_error=0)
	$l_error:=FTP_Send ($l_ftpID;$t_rutaArchivo;$t_nombreArchivo;1)
	$l_error:=FTP_Logout ($l_ftpID)
End if 


