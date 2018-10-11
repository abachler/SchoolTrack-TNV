//%attributes = {}
  // BUILD_GetUpdate()
  //
  //
  // creado por: Alberto Bachler Klein: 19-08-16, 12:53:55
  // -----------------------------------------------------------
C_BLOB:C604($x_In;$x_Out)
C_DATE:C307($d_fechaGeneracion)
C_LONGINT:C283($l_error)
C_TIME:C306($h_HoraGeneracion)
C_TEXT:C284($t_dts;$t_dtsAU;$t_infoUpdates;$t_password;$t_rutaOrigen;$t_User;$t_version;$t_versionAU)
C_OBJECT:C1216($ob_infoUpdates;$ob_macOS)

ARRAY LONGINT:C221($at_NombreOpcionesCURL;0)
ARRAY TEXT:C222($at_ValorOpcionesCURL;0)

$t_User:="abachler"
$t_password:="gamine"
$t_rutaOrigen:="ftp://ftp.colegium.com/interno/desarrollo/autoupdate/SchoolTrackInfo.json"

APPEND TO ARRAY:C911($at_NombreOpcionesCURL;CURLOPT_USERNAME)
APPEND TO ARRAY:C911($at_ValorOpcionesCURL;$t_user)
APPEND TO ARRAY:C911($at_NombreOpcionesCURL;CURLOPT_PASSWORD)
APPEND TO ARRAY:C911($at_ValorOpcionesCURL;$t_password)
APPEND TO ARRAY:C911($at_NombreOpcionesCURL;CURLOPT_USE_SSL)
APPEND TO ARRAY:C911($at_ValorOpcionesCURL;"1")
APPEND TO ARRAY:C911($at_NombreOpcionesCURL;CURLOPT_SSL_VERIFYPEER)
APPEND TO ARRAY:C911($at_ValorOpcionesCURL;"0")
APPEND TO ARRAY:C911($at_NombreOpcionesCURL;CURLOPT_SSL_VERIFYHOST)
APPEND TO ARRAY:C911($at_ValorOpcionesCURL;"0")

$l_error:=cURL ($t_rutaOrigen;$at_NombreOpcionesCURL;$at_ValorOpcionesCURL;$x_In;$x_Out)

If ($l_error=0)
	$t_infoUpdates:=Convert to text:C1012($x_Out;"utf-8")
	
	If (ERROR=0)
		ON ERR CALL:C155("GLOBAL_ERROR")
		$ob_infoUpdates:=JSON Parse:C1218($t_infoUpdates)
		ON ERR CALL:C155("")
		
		$t_rutaCarpetaAutoUpdates:=Get 4D folder:C485(Active 4D Folder:K5:10)+"SchoolTrack-Autoupdate"
		SYS_CreaCarpetaServidor ($t_rutaCarpetaAutoUpdates)
		$t_rutaInfoAutoUpdate:=$t_rutaCarpetaAutoUpdates+Folder separator:K24:12+"SchoolTrackInfo.json"
		OB_ObjectToJsonDocument ($ob_infoUpdates;$t_rutaInfoAutoUpdate;True:C214)
		
		Case of 
			: (SYS_IsMacintosh )
				Case of 
					: (Application type:C494=4D Local mode:K5:1)  // solo para pruebas, la actualización aplica solo
						OB_GET ($ob_infoUpdates;->$t_version;"macOS.Mono32_version")
						OB_GET ($ob_infoUpdates;->$t_dts;"macOS.Mono32_dts")
						DT_ParseDateISO ($t_dts;->$d_fechaGeneracion;->$h_HoraGeneracion)
					: (Application type:C494=4D Remote mode:K5:5)
						
					: (Application type:C494=4D Server:K5:6)
						
					: (Application type:C494=4D Volume desktop:K5:2)
						
						
				End case 
		End case 
		
		
		
	End if 
	
End if 






