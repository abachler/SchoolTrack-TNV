//%attributes = {}
  // BUILD_ExecuteTask()
  //
  //
  // creado por: Alberto Bachler Klein: 17-08-16, 16:36:17
  // -----------------------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($i;$l_abajo;$l_arriba;$l_derecha;$l_fila;$l_izquierda;$l_tarea)
C_POINTER:C301($y_tareaActual;$y_tareaDescripcion;$y_tareaEjecutada;$y_tareaProgreso;$y_tareaRutaDestino;$y_tareaRutaOrigen;$y_tareaTipo)
C_TEXT:C284($t_nombreObjectoProgreso;$t_password;$t_rutaDestinoAppInfo;$t_rutaOrigenAppInfo;$t_usuario)


If (False:C215)
	C_LONGINT:C283(BUILD_ExecuteTask ;$1)
End if 
C_OBJECT:C1216(ob_ZIP_Context;ob_Upload_Context)

If (Count parameters:C259=1)
	$l_tarea:=$1
Else 
	$l_tarea:=1
End if 

$y_tareaDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_descripcion")
$y_tareaTipo:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_tipo")
$y_tareaProgreso:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_progreso")
$y_tareaRutaOrigen:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_rutaOrigen")
$y_tareaRutaDestino:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_rutaDestino")
$y_tareaEjecutada:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_status")
$y_tareaActual:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_actual")

If (($l_tarea>0) & ($l_tarea<=Size of array:C274($y_tareaDescripcion->)))
	$t_nombreObjectoProgreso:="tarea_avance"+String:C10($l_tarea)
	
	
	
	Case of 
		: ($y_tareaTipo->{$l_tarea}="zip")
			$y_tareaActual->:=$l_tarea
			OBJECT DUPLICATE:C1111(*;"tarea_avance";$t_nombreObjectoProgreso)
			OBJECT GET COORDINATES:C663(*;$t_nombreObjectoProgreso;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
			LISTBOX GET CELL COORDINATES:C1330(*;"tareas_listbox";1;$l_tarea;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
			OBJECT SET COORDINATES:C1248(*;$t_nombreObjectoProgreso;$l_izquierda;$l_arriba;$l_izquierda+10;$l_abajo-1)
			CLEAR VARIABLE:C89(ob_ZIP_Context)
			OB SET:C1220(ob_ZIP_Context;\
				"srcPath";$y_tareaRutaOrigen->{$l_tarea};\
				"dstPath";$y_tareaRutaDestino->{$l_tarea};\
				"password";"";\
				"onSuccess";"Zip_SUCCESS";\
				"onError";"Zip_CANCEL")
			Zip_WITH_PROGRESS (ob_ZIP_Context)
			
			
		: ($y_tareaTipo->{$l_tarea}="upload")
			$y_tareaActual->:=$l_tarea
			OBJECT DUPLICATE:C1111(*;"tarea_avance";$t_nombreObjectoProgreso)
			OBJECT GET COORDINATES:C663(*;$t_nombreObjectoProgreso;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
			LISTBOX GET CELL COORDINATES:C1330(*;"tareas_listbox";1;$l_tarea;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
			OBJECT SET COORDINATES:C1248(*;$t_nombreObjectoProgreso;$l_izquierda;$l_arriba;$l_izquierda+10;$l_abajo-1)
			
			$t_usuario:="schooltrackapp"
			$t_password:="pLqfr6NWzb"
			
			CLEAR VARIABLE:C89(ob_Upload_Context)
			OB SET:C1220(ob_Upload_Context;\
				"srcPath";$y_tareaRutaOrigen->{$l_tarea};"dstPath";$y_tareaRutaDestino->{$l_tarea};\
				"srcTimestampPath";$t_rutaOrigenAppInfo;"dstTimestampPath";$t_rutaDestinoAppInfo;\
				"user";$t_usuario;"pass";$t_password;\
				"onSuccess";"Upload_SUCCESS";\
				"onError";"Upload_CANCEL")
			Upload_WITH_PROGRESS (ob_Upload_Context)
			
			
			
		: ($y_tareaTipo->{$l_tarea}="backup")
			OBJECT DUPLICATE:C1111(*;"tarea_avance";$t_nombreObjectoProgreso)
			OBJECT GET COORDINATES:C663(*;$t_nombreObjectoProgreso;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
			LISTBOX GET CELL COORDINATES:C1330(*;"tareas_listbox";1;$l_tarea;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
			OBJECT SET COORDINATES:C1248(*;$t_nombreObjectoProgreso;$l_izquierda;$l_arriba;$l_izquierda+10;$l_abajo-1)
			$y_tareaActual->:=$l_tarea
			BUILD_BackupApp ($y_tareaRutaOrigen->{$l_tarea};$y_tareaRutaDestino->{$l_tarea})
			
	End case 
End if 