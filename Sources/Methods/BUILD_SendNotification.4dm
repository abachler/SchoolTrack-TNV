//%attributes = {}
  // BUILD_SendNotification()
  //
  //
  // creado por: Alberto Bachler Klein: 18-08-16, 11:07:21
  // -----------------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($i;$l_abajo;$l_altoVentana;$l_arriba;$l_derecha;$l_error;$l_ignorar;$l_izquierda;$l_status)
C_POINTER:C301($y_tareaActual;$y_tareaComentario;$y_tareaDescripcion;$y_tareaEjecutada;$y_tareaProgreso;$y_tareaRutaDestino;$y_tareaRutaOrigen;$y_tareaTipo)
C_TEXT:C284($t_asunto;$t_email;$t_error;$t_mensaje;$t_rutaLog;$t_textoAdicional;$t_version;$t_versionAnterior)

ARRAY TEXT:C222($at_rutaAdjuntos;0)



If (False:C215)
	C_LONGINT:C283(BUILD_SendNotification ;$1)
	C_TEXT:C284(BUILD_SendNotification ;$2)
End if 

$y_tareaDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_descripcion")
$y_tareaTipo:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_tipo")
$y_tareaProgreso:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_progreso")
$y_tareaRutaOrigen:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_rutaOrigen")
$y_tareaRutaDestino:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_rutaDestino")
$y_tareaEjecutada:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_status")
$y_tareaActual:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_actual")
$y_tareaComentario:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_comentario")


$l_status:=$1
If (Count parameters:C259=2)
	$t_textoAdicional:=$2
End if 

$t_versionAnterior:=(OBJECT Get pointer:C1124(Object named:K67:5;"versionAnterior_completa"))->
$t_version:=(OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_completa"))->
$t_email:=(OBJECT Get pointer:C1124(Object named:K67:5;"email"))->
If ($t_email#"")
	$t_asunto:="Reporte de generación de versión STv"+$t_version
	Case of 
		: ($l_status=1)
			$t_mensaje:="La generación de versión "+$t_version+" fue completada\r\r\rLas siguientes acciones fueron ejecutadas exitosamente:\r"
			For ($i;1;Size of array:C274($y_tareaDescripcion->))
				$t_mensaje:=$t_mensaje+Uppercase:C13($y_tareaDescripcion->{$i})+": "+$y_tareaComentario->{$i}+"\rEn: "+$y_tareaRutaDestino->{$i}+"\r\r"
			End for 
			$t_mensaje:=$t_mensaje+"\r\rRESULTADO DEL PULL GIT:\r"+$t_textoAdicional
			$t_error:=Mail_EnviaNotificacion ("Reporte de generación de versión STv12";$t_mensaje;$t_email)
			
		: ($l_status=-1)
			$t_mensaje:="La generación de versión "+$t_version+" se completó exitosamente, pero otras tareas no fueron completadas.\rDetalles de ejecución:\r\r"
			For ($i;1;Size of array:C274($y_tareaDescripcion->))
				$t_mensaje:=$t_mensaje+Uppercase:C13($y_tareaDescripcion->{$i})+": "+$y_tareaComentario->{$i}+"\r\r"
			End for 
			$t_error:=Mail_EnviaNotificacion ("Reporte de generación de versión STv12";$t_mensaje;$t_email)
			
		: ($l_status=-2)
			If (Version type:C495 ?? 64 bit version:K5:25)
				$t_rutaLog:=Get 4D folder:C485(Logs folder:K5:19)+Choose:C955(SYS_IsMacintosh ;"BuildAppMac_html.xml";"BuildAppWin_html.xml")
			Else 
				$t_rutaLog:=Get 4D folder:C485(Logs folder:K5:19)+Choose:C955(SYS_IsMacintosh ;"BuildAppMac.log.html";"BuildAppWin.log.html")
			End if 
			If (Test path name:C476($t_rutaLog)=Is a document:K24:1)
				$t_mensaje:="No fue posible generar la versión"+$t_version+" a causa de un error en la generación de aplicaciones:\r\r"
				$t_mensaje:=$t_mensaje+"Detalles en SchoolTrack v12 en la herramienta de generación de aplicaciones"
				$t_error:=Mail_EnviaNotificacion ("Reporte de generación de versión STv12";$t_mensaje;$t_email)
			End if 
		: ($l_status=-3)
			$t_mensaje:="No fue posible generar la versión"+$t_version+" a causa de errores de compilación:\r\r"
			$t_error:=Mail_EnviaNotificacion ("Reporte de generación de versión STv12";$t_mensaje;$t_email)
			
		: ($l_status=-4)
			$t_mensaje:="No fue posible generar la versión"+$t_version+" a causa de errores en el Pull GIT:\r\r"+$t_textoAdicional
			$t_error:=Mail_EnviaNotificacion ("Reporte de generación de versión STv12";$t_mensaje;$t_email)
	End case 
	
	
End if 

$0:=$t_error

