//%attributes = {}
  // BUILD_GetTasksList()
  //
  //
  // creado por: Alberto Bachler Klein: 17-08-16, 11:46:34
  // -----------------------------------------------------------
C_OBJECT:C1216($0)

C_BOOLEAN:C305($b_comprimirAppClient32;$b_comprimirAppClient64;$b_comprimirMono32;$b_comprimirMono64;$b_comprimirServer32;$b_comprimirServer64;$b_subirHistorial)
C_LONGINT:C283($l_build;$l_principal)
C_POINTER:C301($y_subirFTP_Beta;$y_subirFTP_Privado;$y_subirFTP_Publico;$y_tareaComentario;$y_tareaDescripcion;$y_tareaProgreso;$y_tareaRutaDestino;$y_tareaRutaOrigen;$y_tareaStatus;$y_tareaTipo)
C_POINTER:C301($y_versionGeneracion_Build;$y_versionGeneracionCompleta;$y_versionMayor;$y_versionMenor)
C_TEXT:C284($t_backupFolder;$t_carpetaDestino;$t_CarpetaFTP;$t_carpetaRespaldoApp;$t_dts;$t_nombreAppClient32;$t_nombreAppClient64;$t_nombreAppMono32;$t_nombreAppMono64;$t_nombreAppServer32)
C_TEXT:C284($t_nombreAppServer64;$t_rutaAppClient32;$t_rutaAppClient64;$t_rutaAppMono32;$t_rutaAppMono64;$t_rutaAppServer32;$t_rutaAppServer64;$t_rutaDestino;$t_rutaDestinoAppClient32_AU;$t_rutaDestinoAppClient64_AU)
C_TEXT:C284($t_nombreDestinoHistorial;$t_rutaDestinoMono32_AU;$t_rutaDestinoMono64_AU;$t_rutaDestinoServer32_AU;$t_rutaDestinoServer64_AU;$t_rutaLocalHistorial;$t_tipoVersion;$t_version)


If (False:C215)
	C_OBJECT:C1216(BUILD_GetTasksList ;$0)
End if 

$y_subirFTP_Privado:=OBJECT Get pointer:C1124(Object named:K67:5;"subirFTP_Privado")
$y_subirFTP_Beta:=OBJECT Get pointer:C1124(Object named:K67:5;"subirFTP_Beta")
$y_subirFTP_Publico:=OBJECT Get pointer:C1124(Object named:K67:5;"subirFTP_Publico")

$y_tareaDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_descripcion")
$y_tareaTipo:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_tipo")
$y_tareaProgreso:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_progreso")
$y_tareaRutaOrigen:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_rutaOrigen")
$y_tareaRutaDestino:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_rutaDestino")
$y_tareaStatus:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_status")
$y_tareaComentario:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_comentario")

$y_versionGeneracionCompleta:=OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_Completa")
$y_versionGeneracion_Build:=OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_Build")
$y_versionMayor:=OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_Mayor")
$y_versionMenor:=OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_Menor")

$t_version:=SYS_LeeVersionEstructura ("tipo";->$t_tipoVersion)
$t_CarpetaFTP:="v"+Choose:C955($y_versionMenor->=0;String:C10($y_versionMayor->);String:C10($y_versionMayor->)+"."+String:C10($y_versionMenor->))
If ($t_tipoVersion#"")
	$t_CarpetaFTP:=$t_CarpetaFTP+" "+$t_tipoVersion
End if 

AT_Initialize ($y_tareaDescripcion;$y_tareaTipo;$y_tareaProgreso;$y_tareaRutaOrigen;$y_tareaRutaDestino;$y_tareaStatus)

$t_nombreAppMono32:=Choose:C955(SYS_IsMacintosh ;"SchoolTrack 12.app";"SchoolTrack 12")
$t_rutaAppMono32:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Final Application"+Folder separator:K24:12+$t_nombreAppMono32
$b_comprimirMono32:=(Test path name:C476($t_rutaAppMono32)>=Is a folder:K24:2)
$t_rutaDestinoMono32_AU:=Choose:C955($b_comprimirMono32;$t_rutaAppMono32+".zip";"")

$t_nombreAppMono64:=Choose:C955(SYS_IsMacintosh ;"SchoolTrack 12 64-bit.app";"SchoolTrack 12 64-bit")
$t_rutaAppMono64:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Final Application"+Folder separator:K24:12+$t_nombreAppMono64
$b_comprimirMono64:=(Test path name:C476($t_rutaAppMono64)>=Is a folder:K24:2)
$t_rutaDestinoMono64_AU:=Choose:C955($b_comprimirMono64;$t_rutaAppMono64+".zip";"")

$t_nombreAppServer32:=Choose:C955(SYS_IsMacintosh ;"SchoolTrack 12 Server.app";"SchoolTrack 12 Server")
$t_rutaAppServer32:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Client Server executable"+Folder separator:K24:12+$t_nombreAppServer32
$b_comprimirServer32:=(Test path name:C476($t_rutaAppServer32)>=Is a folder:K24:2)
$t_rutaDestinoServer32_AU:=Choose:C955($b_comprimirServer32;$t_rutaAppServer32+".zip";"")

$t_nombreAppServer64:=Choose:C955(SYS_IsMacintosh ;"SchoolTrack 12 64-bit Server.app";"SchoolTrack 12 64-bit Server")
$t_rutaAppServer64:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Client Server executable"+Folder separator:K24:12+$t_nombreAppServer64
$b_comprimirServer64:=(Test path name:C476($t_rutaAppServer64)>=Is a folder:K24:2)
$t_rutaDestinoServer64_AU:=Choose:C955($b_comprimirServer64;$t_rutaAppServer64+".zip";"")

$t_nombreAppClient32:=Choose:C955(SYS_IsMacintosh ;"SchoolTrack 12 Client.app";"SchoolTrack 12 Client")
$t_rutaAppClient32:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Client Server executable"+Folder separator:K24:12+$t_nombreAppClient32
$b_comprimirAppClient32:=(Test path name:C476($t_rutaAppClient32)>=Is a folder:K24:2)
$t_rutaDestinoAppClient32_AU:=Choose:C955($b_comprimirMono32;$t_rutaAppClient32+".zip";"")

$t_nombreAppClient64:=Choose:C955(SYS_IsMacintosh ;"SchoolTrack 12 Client 64-bit.app";"SchoolTrack 12 Client 64-bit")
$t_rutaAppClient64:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"Aplicaciones"+Folder separator:K24:12+"Client Server executable"+Folder separator:K24:12+$t_nombreAppClient64
$b_comprimirAppClient64:=(Test path name:C476($t_rutaAppClient64)>=Is a folder:K24:2)
$t_rutaDestinoAppClient64_AU:=Choose:C955($b_comprimirMono64;$t_rutaAppClient64+".zip";"")

$t_rutaLocalHistorial:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"Historial de cambios"+Folder separator:K24:12+$y_versionGeneracionCompleta->+".xls"
$t_nombreDestinoHistorial:="HistorialCambios_"+$y_versionGeneracionCompleta->+".xls"
$b_subirHistorial:=(Test path name:C476($t_rutaLocalHistorial)=Is a document:K24:1)



If ($b_comprimirMono32)
	APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tCompresión auto-update Monousuario 32-bit")
	APPEND TO ARRAY:C911($y_tareaTipo->;"zip")
	APPEND TO ARRAY:C911($y_tareaProgreso->;0)
	APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaAppMono32)
	APPEND TO ARRAY:C911($y_tareaRutaDestino->;$t_rutaDestinoMono32_AU)
	APPEND TO ARRAY:C911($y_tareaStatus->;0)
	APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
End if 

If ($b_comprimirServer32)
	APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tCompresión auto-update Servidor 32-bit")
	APPEND TO ARRAY:C911($y_tareaTipo->;"zip")
	APPEND TO ARRAY:C911($y_tareaProgreso->;0)
	APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaAppServer32)
	APPEND TO ARRAY:C911($y_tareaRutaDestino->;$t_rutaDestinoServer32_AU)
	APPEND TO ARRAY:C911($y_tareaStatus->;0)
	APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
End if 

If ($b_comprimirServer64)
	APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tCompresión auto-update Servidor 64-bit")
	APPEND TO ARRAY:C911($y_tareaTipo->;"zip")
	APPEND TO ARRAY:C911($y_tareaProgreso->;0)
	APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaAppServer64)
	APPEND TO ARRAY:C911($y_tareaRutaDestino->;$t_rutaDestinoServer64_AU)
	APPEND TO ARRAY:C911($y_tareaStatus->;0)
	APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
End if 

If ($b_comprimirMono64)
	APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tCompresión auto-update Monousuario 64-bit")
	APPEND TO ARRAY:C911($y_tareaTipo->;"zip")
	APPEND TO ARRAY:C911($y_tareaProgreso->;0)
	APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaAppMono64)
	APPEND TO ARRAY:C911($y_tareaRutaDestino->;$t_rutaDestinoMono64_AU)
	APPEND TO ARRAY:C911($y_tareaStatus->;0)
	APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
End if 

If ($b_comprimirAppClient32)
	APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tCompresión Cliente 32-bit")
	APPEND TO ARRAY:C911($y_tareaTipo->;"zip")
	APPEND TO ARRAY:C911($y_tareaProgreso->;0)
	APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaAppClient32)
	APPEND TO ARRAY:C911($y_tareaRutaDestino->;$t_rutaDestinoAppClient32_AU)
	APPEND TO ARRAY:C911($y_tareaStatus->;0)
	APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
End if 

If ($b_comprimirAppClient64)
	APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tCompresión Cliente 64-bit")
	APPEND TO ARRAY:C911($y_tareaTipo->;"zip")
	APPEND TO ARRAY:C911($y_tareaProgreso->;0)
	APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaAppClient64)
	APPEND TO ARRAY:C911($y_tareaRutaDestino->;$t_rutaDestinoAppClient64_AU)
	APPEND TO ARRAY:C911($y_tareaStatus->;0)
	APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
End if 


If ($y_subirFTP_Privado->=1)
	
	$t_carpetaDestino:=BUILD_FTP_Private+$t_CarpetaFTP+"/"+"ST_v12_"+String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33);"00")+String:C10(Day of:C23(Current date:C33);"00")+"_"+String:C10($y_versionGeneracion_Build->)+"/"+Choose:C955(SYS_IsWindows ;"Windows";"macOS")
	
	If ($b_subirHistorial)
		$t_CarpetaRaiz:=BUILD_FTP_Private+$t_CarpetaFTP+"/"+"ST_v12_"+String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33);"00")+String:C10(Day of:C23(Current date:C33);"00")+"_"+String:C10($y_versionGeneracion_Build->)
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tEnvío de Historial de cambios…")
		APPEND TO ARRAY:C911($y_tareaTipo->;"upload")
		APPEND TO ARRAY:C911($y_tareaProgreso->;0)
		APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaLocalHistorial)
		APPEND TO ARRAY:C911($y_tareaRutaDestino->;$t_CarpetaRaiz+"/"+$t_nombreDestinoHistorial)
		APPEND TO ARRAY:C911($y_tareaStatus->;0)
		APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
	End if 
	
	
	If ($b_comprimirMono32)
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tEnvío del auto-update Monousuario 32-bit a FTP Privado")
		APPEND TO ARRAY:C911($y_tareaTipo->;"upload")
		APPEND TO ARRAY:C911($y_tareaProgreso->;0)
		APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaDestinoMono32_AU)
		APPEND TO ARRAY:C911($y_tareaRutaDestino->;$t_carpetaDestino+"/"+Choose:C955(SYS_IsMacintosh ;BUILD_Aplicacion_monousuario+".app.zip";BUILD_Aplicacion_monousuario+".zip"))
		APPEND TO ARRAY:C911($y_tareaStatus->;0)
		APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
	End if 
	
	If ($b_comprimirServer32)
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tEnvío del auto-update Servidor 32-bit a FTP Privado")
		APPEND TO ARRAY:C911($y_tareaTipo->;"upload")
		APPEND TO ARRAY:C911($y_tareaProgreso->;0)
		APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaDestinoServer32_AU)
		APPEND TO ARRAY:C911($y_tareaRutaDestino->;$t_carpetaDestino+"/"+Choose:C955(SYS_IsMacintosh ;BUILD_Aplicacion_Servidor+".app.zip";BUILD_Aplicacion_Servidor+".zip"))
		APPEND TO ARRAY:C911($y_tareaStatus->;0)
		APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
	End if 
	
	If ($b_comprimirServer64)
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tEnvío del auto-update Servidor 64-bit a FTP Privado")
		APPEND TO ARRAY:C911($y_tareaTipo->;"upload")
		APPEND TO ARRAY:C911($y_tareaProgreso->;0)
		APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaDestinoServer64_AU)
		APPEND TO ARRAY:C911($y_tareaRutaDestino->;$t_carpetaDestino+"/"+Choose:C955(SYS_IsMacintosh ;BUILD_Aplicacion_server_64bit+".app.zip";BUILD_Aplicacion_server_64bit+".zip"))
		APPEND TO ARRAY:C911($y_tareaStatus->;0)
		APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
	End if 
	
	If ($b_comprimirMono64)
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tEnvío del auto-update Monousuario 64-bit a FTP Privado")
		APPEND TO ARRAY:C911($y_tareaTipo->;"upload")
		APPEND TO ARRAY:C911($y_tareaProgreso->;0)
		APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaDestinoMono64_AU)
		APPEND TO ARRAY:C911($y_tareaRutaDestino->;$t_carpetaDestino+"/"+Choose:C955(SYS_IsMacintosh ;BUILD_Aplicacion_monousuario_64bit+".app.zip";BUILD_Aplicacion_monousuario_64bit+".zip"))
		APPEND TO ARRAY:C911($y_tareaStatus->;0)
		APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
	End if 
	
	If ($b_comprimirAppClient32)
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tEnvío del Cliente 32-bit a FTP Privado")
		APPEND TO ARRAY:C911($y_tareaTipo->;"upload")
		APPEND TO ARRAY:C911($y_tareaProgreso->;0)
		APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaDestinoAppClient32_AU)
		APPEND TO ARRAY:C911($y_tareaRutaDestino->;$t_carpetaDestino+"/"+Choose:C955(SYS_IsMacintosh ;BUILD_Aplicacion_Cliente+".app.zip";BUILD_Aplicacion_Cliente+".zip"))
		APPEND TO ARRAY:C911($y_tareaStatus->;0)
		APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
	End if 
	
	If ($b_comprimirAppClient64)
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tEnvío del Cliente 64-bit a FTP Privado")
		APPEND TO ARRAY:C911($y_tareaTipo->;"upload")
		APPEND TO ARRAY:C911($y_tareaProgreso->;0)
		APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaDestinoAppClient64_AU)
		APPEND TO ARRAY:C911($y_tareaRutaDestino->;$t_carpetaDestino+"/"+Choose:C955(SYS_IsMacintosh ;BUILD_Aplicacion_Cliente_64bit+".app.zip";BUILD_Aplicacion_Cliente_64bit+".zip"))
		APPEND TO ARRAY:C911($y_tareaStatus->;0)
		APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
	End if 
End if 

If ($y_subirFTP_Beta->=1)
	$t_carpetaDestino:=BUILD_FTP_Beta+$t_CarpetaFTP+"/"+"ST_v12_"+String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33);"00")+String:C10(Day of:C23(Current date:C33);"00")+"_"+String:C10($y_versionGeneracion_Build->)+"/"+Choose:C955(SYS_IsWindows ;"Windows";"macOS")
	If ($b_comprimirMono32)
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tEnvío del auto-update Monousuario 32-bit a FTP Beta")
		APPEND TO ARRAY:C911($y_tareaTipo->;"upload")
		APPEND TO ARRAY:C911($y_tareaProgreso->;0)
		APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaDestinoMono32_AU)
		APPEND TO ARRAY:C911($y_tareaRutaDestino->;BUILD_FTP_Beta+"/"+Choose:C955(SYS_IsMacintosh ;BUILD_Aplicacion_monousuario+".app.zip";BUILD_Aplicacion_monousuario+".zip"))
		APPEND TO ARRAY:C911($y_tareaStatus->;0)
		APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
	End if 
	
	If ($b_comprimirServer32)
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tEnvío del auto-update Servidor 32-bit a FTP Beta")
		APPEND TO ARRAY:C911($y_tareaTipo->;"upload")
		APPEND TO ARRAY:C911($y_tareaProgreso->;0)
		APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaDestinoServer32_AU)
		APPEND TO ARRAY:C911($y_tareaRutaDestino->;BUILD_FTP_Beta+"/"+Choose:C955(SYS_IsMacintosh ;BUILD_Aplicacion_Servidor+".app";BUILD_Aplicacion_Servidor+".zip"))
		APPEND TO ARRAY:C911($y_tareaStatus->;0)
		APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
	End if 
	
	If ($b_comprimirServer64)
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tEnvío del auto-update Servidor 64-bit a FTP Beta")
		APPEND TO ARRAY:C911($y_tareaTipo->;"upload")
		APPEND TO ARRAY:C911($y_tareaProgreso->;0)
		APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaDestinoServer64_AU)
		APPEND TO ARRAY:C911($y_tareaRutaDestino->;BUILD_FTP_Beta+"/"+Choose:C955(SYS_IsMacintosh ;BUILD_Aplicacion_server_64bit+".app.zip";BUILD_Aplicacion_server_64bit+".zip"))
		APPEND TO ARRAY:C911($y_tareaStatus->;0)
		APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
	End if 
	
	If ($b_comprimirMono64)
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tEnvío del auto-update Monousuario 64-bit a FTP Beta")
		APPEND TO ARRAY:C911($y_tareaTipo->;"upload")
		APPEND TO ARRAY:C911($y_tareaProgreso->;0)
		APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaDestinoMono64_AU)
		APPEND TO ARRAY:C911($y_tareaRutaDestino->;BUILD_FTP_Beta+"/"+Choose:C955(SYS_IsMacintosh ;BUILD_Aplicacion_monousuario_64bit+".app.zip";BUILD_Aplicacion_monousuario_64bit+".zip"))
		APPEND TO ARRAY:C911($y_tareaStatus->;0)
		APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
	End if 
End if 

If ($y_subirFTP_Publico->=1)
	$t_carpetaDestino:=BUILD_FTP_Publica+$t_CarpetaFTP+"/"+"ST_v12_"+String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33);"00")+String:C10(Day of:C23(Current date:C33);"00")+"_"+String:C10($y_versionGeneracion_Build->)+"/"+Choose:C955(SYS_IsWindows ;"Windows";"macOS")
	If ($b_comprimirMono32)
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tEnvío del auto-update Monousuario 32-bit a FTP Público")
		APPEND TO ARRAY:C911($y_tareaTipo->;"upload")
		APPEND TO ARRAY:C911($y_tareaProgreso->;0)
		APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaDestinoMono32_AU)
		APPEND TO ARRAY:C911($y_tareaRutaDestino->;BUILD_FTP_Publica+"/"+Choose:C955(SYS_IsMacintosh ;BUILD_Aplicacion_monousuario+".app.zip";BUILD_Aplicacion_monousuario+".zip"))
		APPEND TO ARRAY:C911($y_tareaStatus->;0)
		APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
	End if 
	
	If ($b_comprimirServer32)
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tEnvío del auto-update Servidor 32-bit a FTP Público")
		APPEND TO ARRAY:C911($y_tareaTipo->;"upload")
		APPEND TO ARRAY:C911($y_tareaProgreso->;0)
		APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaDestinoServer32_AU)
		APPEND TO ARRAY:C911($y_tareaRutaDestino->;BUILD_FTP_Publica+"/"+Choose:C955(SYS_IsMacintosh ;BUILD_Aplicacion_Servidor+".app";BUILD_Aplicacion_Servidor+".zip"))
		APPEND TO ARRAY:C911($y_tareaStatus->;0)
		APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
	End if 
	
	If ($b_comprimirServer64)
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tEnvío del auto-update Servidor 64-bit a FTP Público")
		APPEND TO ARRAY:C911($y_tareaTipo->;"upload")
		APPEND TO ARRAY:C911($y_tareaProgreso->;0)
		APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaDestinoServer64_AU)
		APPEND TO ARRAY:C911($y_tareaRutaDestino->;BUILD_FTP_Publica+"/"+Choose:C955(SYS_IsMacintosh ;BUILD_Aplicacion_server_64bit+".app.zip";BUILD_Aplicacion_server_64bit+".zip"))
		APPEND TO ARRAY:C911($y_tareaStatus->;0)
		APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")
	End if 
	
	If ($b_comprimirMono64)
		APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tEnvío del auto-update Monousuario 64-bit a FTP Público")
		APPEND TO ARRAY:C911($y_tareaTipo->;"upload")
		APPEND TO ARRAY:C911($y_tareaProgreso->;0)
		APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaDestinoMono64_AU)
		APPEND TO ARRAY:C911($y_tareaRutaDestino->;BUILD_FTP_Publica+"/"+Choose:C955(SYS_IsMacintosh ;BUILD_Aplicacion_monousuario_64bit+".app.zip";BUILD_Aplicacion_monousuario_64bit+".zip"))
		APPEND TO ARRAY:C911($y_tareaStatus->;0)
		APPEND TO ARRAY:C911($y_tareaComentario->;"En espera")
	End if 
	
	
End if 

$t_backupFolder:=Get 4D folder:C485(Database folder:K5:14)
$t_carpetaRespaldoApp:=Get 4D folder:C485(Database folder:K5:14)+"_Respaldos"+Folder separator:K24:12
$t_version:=SYS_LeeVersionEstructura ("principal";->$l_principal)
$t_version:=SYS_LeeVersionEstructura ("build";->$l_build)
$t_dts:=String:C10(Current date:C33;ISO date:K1:8;Current time:C178)
$t_dts:=Replace string:C233($t_dts;":";"")
$t_dts:=Replace string:C233($t_dts;"-";"")
$t_carpetaRespaldoApp:=$t_carpetaRespaldoApp+"STv"+String:C10($l_principal)+"_"+String:C10($l_build)+"_"+$t_dts+Folder separator:K24:12
$t_rutaDestino:=Get 4D folder:C485(Database folder:K5:14)+"_Respaldos"+Folder separator:K24:12+"STv"+String:C10($l_principal)+"_"+String:C10($l_build)+"_"+$t_dts+".zip"

APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tRespaldo local de la aplicación")
APPEND TO ARRAY:C911($y_tareaTipo->;"backup")
APPEND TO ARRAY:C911($y_tareaProgreso->;0)
APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_carpetaRespaldoApp)
APPEND TO ARRAY:C911($y_tareaRutaDestino->;$t_rutaDestino)
APPEND TO ARRAY:C911($y_tareaStatus->;0)
APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")


APPEND TO ARRAY:C911($y_tareaDescripcion->;"\tEnvío del respaldo al FTP interno")
APPEND TO ARRAY:C911($y_tareaTipo->;"upload")
APPEND TO ARRAY:C911($y_tareaProgreso->;0)
APPEND TO ARRAY:C911($y_tareaRutaOrigen->;$t_rutaDestino)
APPEND TO ARRAY:C911($y_tareaRutaDestino->;"ftp://ftp.colegium.com//interno/desarrollo/comun/Respaldos_ST"+$t_CarpetaFTP+"/"+"STv"+String:C10($l_principal)+"_"+String:C10($l_build)+"_"+$t_dts+".zip")
APPEND TO ARRAY:C911($y_tareaStatus->;0)
APPEND TO ARRAY:C911($y_tareaComentario->;"En espera...")




