//%attributes = {}
  // CIM_BKP_LeePreferencias()
  // Por: Alberto Bachler K.: 22-09-14, 15:51:48
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_logValido;$b_respaldosActivos)
C_LONGINT:C283($i_propiedad;$l_eliminarRespaldoAntes;$l_Programacion;$l_propiedades;$l_unidadReintentos)
C_POINTER:C301($y_menuCompactacion;$y_menuProgramacion;$y_menuUnidadReintentos;$y_Objeto;$y_OpcionEliminacionRespaldo;$y_programacion;$y_reintentosTiempo;$y_reintentosValor)
C_TEXT:C284($t_backupPlan;$t_modoCompactacion;$t_nombreMaquina;$t_nombreObjeto;$t_refJson;$t_rutaArchivoHistorial;$t_rutaCarpetaRespaldos;$t_uuidDatabase)
C_OBJECT:C1216($ob_objeto)

ARRAY TEXT:C222($at_nombrePropiedades;0)
ARRAY TEXT:C222($at_RutaArchivoHistorial;0)
ARRAY TEXT:C222($at_RutaRespaldos;0)

READ ONLY:C145([xShell_ApplicationData:45])
ALL RECORDS:C47([xShell_ApplicationData:45])
FIRST RECORD:C50([xShell_ApplicationData:45])
$t_uuidDatabase:=[xShell_ApplicationData:45]UUID_database:13
$t_backupPlan:=BKP_LeePlanBackup ($t_uuidDatabase)


If ($t_backupPlan="")
	BKP_VerificaConfig 
End if 


$ob_objeto:=OB_JsonToObject ($t_backupPlan)
$l_propiedades:=OB_GetChildNodes ($ob_objeto;->$at_nombrePropiedades)
For ($i_propiedad;1;Size of array:C274($at_nombrePropiedades))  //MONO: $l_propiedades está devolviendo 0
	$t_nombreObjeto:=$at_nombrePropiedades{$i_propiedad}
	$y_Objeto:=OBJECT Get pointer:C1124(Object named:K67:5;$t_nombreObjeto)
	If (Not:C34(Is nil pointer:C315($y_Objeto)))
		OB_GET ($ob_objeto;$y_Objeto;$t_nombreObjeto)
	End if 
End for 
$y_Objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"BKP_rutaArchivosAdjuntos")
OB_GET ($ob_objeto;$y_Objeto;"BKP_rutaArchivosAdjuntos")

$y_programacion:=OBJECT Get pointer:C1124(Object named:K67:5;"BKP_programacion")
$y_menuProgramacion:=OBJECT Get pointer:C1124(Object named:K67:5;"menuProgramacionSeleccion")
Case of 
	: ($y_programacion->="Hourly")
		$y_menuProgramacion->:=2
	: ($y_programacion->="Daily")
		$y_menuProgramacion->:=3
	: ($y_programacion->="Weekly")
		$y_menuProgramacion->:=4
	: ($y_programacion->="Monthly")
		$y_menuProgramacion->:=1
End case 

$y_OpcionEliminacionRespaldo:=OBJECT Get pointer:C1124(Object named:K67:5;"menuRespaldosModoEliminacion")
$l_eliminarRespaldoAntes:=(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_borrarRespaldoAntes"))->
$y_OpcionEliminacionRespaldo->:=$l_eliminarRespaldoAntes+1

$t_rutaCarpetaRespaldos:=(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_rutaCarpetaRespaldos"))->
If ($t_rutaCarpetaRespaldos#"")
	If (SYS_TestPathNameOnServer ($t_rutaCarpetaRespaldos;Server)=Is a folder:K24:2)
		SYS_PathToArray ($t_rutaCarpetaRespaldos;->$at_RutaRespaldos)
		OBJECT SET TITLE:C194(*;"botonRutaRespaldos";$at_RutaRespaldos{1})
	Else 
		SYS_CreaCarpetaServidor ($t_rutaCarpetaRespaldos)
		SYS_PathToArray ($t_rutaCarpetaRespaldos;->$at_RutaRespaldos)
		OBJECT SET TITLE:C194(*;"botonRutaRespaldos";$at_RutaRespaldos{1})
	End if 
End if 

$t_rutaArchivoHistorial:=SYS_GetServerProperty (XS_LogFilePath)
If (SYS_TestPathNameOnServer ($t_rutaArchivoHistorial;Server)=Is a document:K24:1)
	SYS_PathToArray ($t_rutaArchivoHistorial;->$at_RutaArchivoHistorial)
	If (Application type:C494=4D Remote mode:K5:5)
		$t_nombreMaquina:=SYS_GetServerProperty (XS_MachineName)
		OBJECT SET TITLE:C194(*;"seleccionHistorial";$at_RutaArchivoHistorial{1}+__ (" en ")+$t_nombreMaquina)
	Else 
		OBJECT SET TITLE:C194(*;"seleccionHistorial";$at_RutaArchivoHistorial{1}+__ (" en ")+$at_RutaArchivoHistorial{Size of array:C274($at_RutaArchivoHistorial)})
	End if 
Else 
	OBJECT SET TITLE:C194(*;"seleccionHistorial";__ ("No utilizar historial"))
End if 

$y_menuCompactacion:=OBJECT Get pointer:C1124(Object named:K67:5;"menuRespaldosCompresion")
$t_modoCompactacion:=(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_modoCompresion"))->
Case of 
	: ($t_modoCompactacion="None")
		$y_menuCompactacion->:=1
	: ($t_modoCompactacion="Fast")
		$y_menuCompactacion->:=2
	: ($t_modoCompactacion="Compact")
		$y_menuCompactacion->:=3
End case 


$y_reintentosTiempo:=OBJECT Get pointer:C1124(Object named:K67:5;"BKP_tiempoReintento")
$y_menuUnidadReintentos:=OBJECT Get pointer:C1124(Object named:K67:5;"menuUnidadReintentos")
$l_unidadReintentos:=(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_reintentarEn"))->
$y_menuUnidadReintentos->:=$l_unidadReintentos
$y_reintentosValor:=OBJECT Get pointer:C1124(Object named:K67:5;"BKP_ReintentarEnValor")

$l_Programacion:=(OBJECT Get pointer:C1124(Object named:K67:5;"menuProgramacionSeleccion"))->

Case of 
	: ($l_Programacion=1)  // sin respaldos
		OBJECT SET VISIBLE:C603(*;"BKP@";False:C215)
		OBJECT SET VISIBLE:C603(*;"menuProgramacionSeleccion";True:C214)
		(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_programacion"))->:="Never"
		
		
	: ($l_Programacion=2)  // frecuencia horaria (cada X horas)
		OBJECT SET VISIBLE:C603(*;"BKP_@";True:C214)
		OBJECT SET VISIBLE:C603(*;"BKP_semanal@";False:C215)
		OBJECT SET VISIBLE:C603(*;"BKP_frecuenciaDiaria@";False:C215)
		(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_programacion"))->:="Hourly"
		IT_AlineaObjetos (Izquierda;30;"menuProgramacionSeleccion";"BKP_FrecuenciaHoraria@")
		
	: ($l_Programacion=3)  // frecuencia diaria (cada X días)
		OBJECT SET VISIBLE:C603(*;"BKP_@";True:C214)
		OBJECT SET VISIBLE:C603(*;"BKP_semanal@";False:C215)
		OBJECT SET VISIBLE:C603(*;"BKP_frecuenciaHoraria@";False:C215)
		(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_programacion"))->:="Daily"
		IT_AlineaObjetos (Izquierda;30;"menuProgramacionSeleccion";"BKP_FrecuenciaDiaria@")
		
	: ($l_Programacion=4)  // programacion semanal personalizada
		OBJECT SET VISIBLE:C603(*;"BKP_@";True:C214)
		OBJECT SET VISIBLE:C603(*;"BKP_frecuenciaDiaria@";False:C215)
		OBJECT SET VISIBLE:C603(*;"BKP_frecuenciaHoraria@";False:C215)
		(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_programacion"))->:="Weekly"
		IT_AlineaObjetos (Izquierda;15;"menuProgramacionSeleccion";"BKP_Semanal@")
		
End case 

OBJECT SET VISIBLE:C603(*;"menuRespaldosModoEliminacion";$l_programacion>1)
OBJECT SET VISIBLE:C603(*;"menuUnidadReintentos";$l_programacion>1)
OBJECT SET VISIBLE:C603(*;"menuRespaldosCompresion";$l_programacion>1)
OBJECT SET VISIBLE:C603(*;"botonRutaRespaldos";$l_programacion>1)
OBJECT SET VISIBLE:C603(*;"seleccionHistorial";$l_programacion>1)

$b_logValido:=(SYS_GetServerProperty (XS_LogFilePath)#"")
$b_respaldosActivos:=((OBJECT Get pointer:C1124(Object named:K67:5;"menuProgramacionSeleccion"))->>1)
OBJECT SET ENABLED:C1123(*;"BKP_integracionAutomaticaLog";$b_logValido & $b_respaldosActivos)
OBJECT SET ENABLED:C1123(*;"BKP_restauracionAutomatica";$b_logValido & $b_respaldosActivos)
OBJECT SET ENABLED:C1123(*;"verHistorial";$b_logValido)

