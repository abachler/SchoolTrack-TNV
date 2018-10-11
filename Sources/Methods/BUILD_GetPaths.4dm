//%attributes = {}
  // BUILD_GetPaths()
  //
  //
  // creado por: Alberto Bachler Klein: 27-07-16, 09:49:43
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_POINTER:C301($y_objetoJsonInfo)
C_TEXT:C284($t_carpeta;$t_dts;$t_nombreApp;$t_nombreAppMono;$t_nombreAppServidor;$t_ruta;$t_tipoRuta;$t_vacio;$t_version)
C_OBJECT:C1216($ob_appInfo;$ob_appsMacOS;$ob_appsWindows)


If (False:C215)
	C_TEXT:C284(BUILD_GetPaths ;$0)
	C_TEXT:C284(BUILD_GetPaths ;$1)
End if 

$t_tipoRuta:=$1

Case of 
	: ($t_tipoRuta="carpetaGeneracion")
		$0:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"
		
	: ($t_tipoRuta="updateFolder")
		$0:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Auto-update"
		
	: ($t_tipoRuta="serverApp")
		$t_nombreApp:=Choose:C955(Folder separator:K24:12=":";"SchoolTrack 12 Server.app:";"SchoolTrack 12 Server")
		$0:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Client Server executable"+Folder separator:K24:12+$t_nombreApp
		
	: ($t_tipoRuta="serverApp64")
		$t_nombreApp:=Choose:C955(Folder separator:K24:12=":";"SchoolTrack 12 Server 64-bit.app:";"SchoolTrack 12 Server 64-bit")
		$0:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Client Server executable"+Folder separator:K24:12+$t_nombreApp
		
	: ($t_tipoRuta="monoApp")
		$t_nombreApp:=Choose:C955(Folder separator:K24:12=":";"SchoolTrack 12.app:";"SchoolTrack 12")
		$0:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Final application"+Folder separator:K24:12+$t_nombreApp
		
	: ($t_tipoRuta="monoApp64")
		$t_nombreApp:=Choose:C955(Folder separator:K24:12=":";"SchoolTrack 12 64-bit.app:";"SchoolTrack 12 64.bit")
		$0:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Final application"+Folder separator:K24:12+$t_nombreApp
		
	: ($t_tipoRuta="serverAutoUpdate")
		$t_carpeta:=BUILD_GetPaths ("updateFolder")
		$t_nombreApp:=Choose:C955(Folder separator:K24:12=":";BUILD_Aplicacion_Servidor+".app";BUILD_Aplicacion_Servidor)
		$0:=$t_carpeta+Folder separator:K24:12+$t_nombreApp+".zip"
		
	: ($t_tipoRuta="serverAutoUpdate64")
		$t_carpeta:=BUILD_GetPaths ("updateFolder")
		$t_nombreApp:=Choose:C955(Folder separator:K24:12=":";BUILD_Aplicacion_server_64bit+".app";BUILD_Aplicacion_server_64bit)
		$0:=$t_carpeta+Folder separator:K24:12+$t_nombreApp+".zip"
		
	: ($t_tipoRuta="monoAutoUpdate")
		$t_carpeta:=BUILD_GetPaths ("updateFolder")
		$t_nombreApp:=Choose:C955(Folder separator:K24:12=":";BUILD_Aplicacion_monousuario+".app";BUILD_Aplicacion_monousuario)
		$0:=$t_carpeta+Folder separator:K24:12+$t_nombreApp+".zip"
		
	: ($t_tipoRuta="monoAutoUpdate64")
		$t_carpeta:=BUILD_GetPaths ("updateFolder")
		$t_nombreApp:=Choose:C955(Folder separator:K24:12=":";BUILD_Aplicacion_monousuario_64bit+".app";BUILD_Aplicacion_monousuario_64bit)
		$0:=$t_carpeta+Folder separator:K24:12+$t_nombreApp+".zip"
		
	: ($t_tipoRuta="appInfoJson")
		$0:=Get 4D folder:C485(Current resources folder:K5:16)+BUILD_ArchivoInfoVersion+".json"
		If (Test path name:C476($0)#Is a document:K24:1)
			$t_vacio:=""
			$ob_appInfo:=OB_Create 
			$ob_appsMacOS:=OB_Create 
			$ob_appsWindows:=OB_Create 
			OB_SET ($ob_appsMacOS;->$t_vacio;"Mono32_version")
			OB_SET ($ob_appsMacOS;->$t_vacio;"Mono64_version")
			OB_SET ($ob_appsMacOS;->$t_vacio;"Server32_version")
			OB_SET ($ob_appsMacOS;->$t_vacio;"Server64_version")
			OB_SET ($ob_appsMacOS;->$t_vacio;"Mono32_dts")
			OB_SET ($ob_appsMacOS;->$t_vacio;"Mono64_dts")
			OB_SET ($ob_appsMacOS;->$t_vacio;"Server32_dts")
			OB_SET ($ob_appsMacOS;->$t_vacio;"Server64_dts")
			$ob_appsWindows:=OB Copy:C1225($ob_appsMacOS)
			OB_SET ($ob_appInfo;->$ob_appsMacOS;"macOS")
			OB_SET ($ob_appInfo;->$ob_appsWindows;"Windows")
			OB_ObjectToJsonDocument ($ob_appInfo;$0;True:C214)
		End if 
End case 