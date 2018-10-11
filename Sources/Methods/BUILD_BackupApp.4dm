//%attributes = {}
  // BUILD_BackupApp()
  //
  //
  // creado por: Alberto Bachler Klein: 17-08-16, 20:19:37
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($i;$l_abajo;$l_anchoMax;$l_arriba;$l_build;$l_derecha;$l_izquierda;$l_principal;$l_progreso)
C_POINTER:C301($y_tareaActual;$y_tareaDescripcion;$y_tareaEjecutada;$y_tareaProgreso;$y_tareaRutaDestino;$y_tareaRutaOrigen;$y_tareaTipo)
C_TEXT:C284($t_backupFolder;$t_carpetaRespaldoApp;$t_destino;$t_dts;$t_estructura;$t_index;$t_nombreCarpeta;$t_nombreObjectoProgreso;$t_ruta;$t_rutaDestino)
C_TEXT:C284($t_version)

ARRAY TEXT:C222($at_rutas;0)



If (False:C215)
	C_TEXT:C284(BUILD_BackupApp ;$1)
	C_TEXT:C284(BUILD_BackupApp ;$2)
End if 

$t_carpetaRespaldoApp:=$1
$t_rutaDestino:=$2


$y_tareaDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_descripcion")
$y_tareaTipo:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_tipo")
$y_tareaProgreso:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_progreso")
$y_tareaRutaOrigen:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_rutaOrigen")
$y_tareaRutaDestino:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_rutaDestino")
$y_tareaEjecutada:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_status")
$y_tareaActual:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_actual")
$l_anchoMax:=IT_Objeto_Ancho ("tareas_listbox")


  // determino los documentos y carpetas a respaldar y los copio en destino
$t_estructura:=SYS_Path2FileName (Structure file:C489)
$t_index:=Replace string:C233($t_estructura;".4DB";".4DIndy")
APPEND TO ARRAY:C911($at_rutas;Get 4D folder:C485(Database folder:K5:14)+"Carpeta Web")
APPEND TO ARRAY:C911($at_rutas;Get 4D folder:C485(Database folder:K5:14)+"Config")
APPEND TO ARRAY:C911($at_rutas;Get 4D folder:C485(Database folder:K5:14)+"Resources")
APPEND TO ARRAY:C911($at_rutas;Get 4D folder:C485(Database folder:K5:14)+$t_estructura)
APPEND TO ARRAY:C911($at_rutas;Get 4D folder:C485(Database folder:K5:14)+$t_index)
SYS_CreateFolder ($t_carpetaRespaldoApp)
For ($i;1;Size of array:C274($at_rutas))
	Case of 
		: (Test path name:C476($at_rutas{$i})=Is a folder:K24:2)
			SYS_CopyFolder ($at_rutas{$i};$t_carpetaRespaldoApp+SYS_Path2FileName ($at_rutas{$i}))
		: (Test path name:C476($at_rutas{$i})=Is a document:K24:1)
			COPY DOCUMENT:C541($at_rutas{$i};$t_carpetaRespaldoApp+SYS_Path2FileName ($at_rutas{$i}))
	End case 
End for 


  // comprimo la carpeta de respaldo
CLEAR VARIABLE:C89(ob_ZIP_Context)
OB SET:C1220(ob_ZIP_Context;"srcPath";$t_carpetaRespaldoApp;"dstPath";$t_rutaDestino;"password";"";"onSuccess";"Zip_SUCCESS";"onError";"Zip_CANCEL")\

Zip_WITH_PROGRESS (ob_ZIP_Context)







