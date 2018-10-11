  // GeneracionAplicacion()
  //
  //
  // creado por: Alberto Bachler Klein: 25-07-16, 18:28:30
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_comprimirMono32;$b_comprimirMono64;$b_comprimirServer32;$b_comprimirServer64;$b_exito)
C_LONGINT:C283($l_abajo;$l_anchoMax;$l_arriba;$l_derecha;$l_izquierda;$l_progreso;$l_version_Mayor;$l_version_Revision)
C_POINTER:C301($y_cargandoFtpBeta;$y_cargandoFtpPrivado;$y_cargandoFtpPublico;$y_comprimirAplicacion;$y_email;$y_generandoMono32;$y_generandoMono64;$y_generandoServer32;$y_generandoServer64;$y_generarLibrerias)
C_POINTER:C301($y_msFTPBeta;$y_msFTPPrivado;$y_msFTPPublico;$y_msMono32;$y_msMono64;$y_msServer32;$y_msServer64;$y_objetoControlador;$y_objetoJsonInfo)
C_POINTER:C301($y_pasosAutoUpdate;$y_pasosFtpBeta;$y_pasosFtpPrivado;$y_pasosFtpPublico;$y_proximaVersion;$y_PullGIT_STWA;$y_ruedaProgresoMono;$y_ruedaProgresoMono64;$y_ruedaProgresoServer32;$y_ruedaProgresoServer64)
C_POINTER:C301($y_subirFTP_Beta;$y_subirFTP_Privado;$y_subirFTP_Publico;$y_tareaActual;$y_tareaComentario;$y_tareaDescripcion;$y_tareaEjecutada;$y_tareaProgreso;$y_tareaRutaDestino;$y_tareaRutaOrigen)
C_POINTER:C301($y_tareaTipo;$y_versionAnteriorBuild;$y_versionAnteriorCompleta;$y_versionAnteriorDTS;$y_versionAnteriorTipo;$y_versionAnteriorMayor;$y_versionAnteriorMenor;$y_versionGeneracionBuild;$y_versionGeneracionCompleta;$y_versionGeneracionDTS;$y_versionGeneracionMayor)
C_POINTER:C301($y_versionGeneracionMenor;$y_versionGeneracionTipo)
C_TEXT:C284($t_carpetaDestino;$t_error;$t_nombreAppMono32;$t_nombreAppMono64;$t_nombreAppServer32;$t_nombreAppServer64;$t_nombreObjectoProgreso;$t_rutaAppMono32;$t_rutaAppMono64;$t_rutaAppServer32)
C_TEXT:C284($t_rutaAppServer64;$t_rutaArchivoComprimido;$t_rutaInfoJson;$t_rutaLog;$t_version_Anterior)

ARRAY TEXT:C222($at_propiedades;0)

C_OBJECT:C1216(ob_Upload_Context;ob_ZIP_CONTEXT)

$y_generarLibrerias:=OBJECT Get pointer:C1124(Object named:K67:5;"generarLibrerias")
$y_comprimirAplicacion:=OBJECT Get pointer:C1124(Object named:K67:5;"comprimirAplicaciones")
$y_subirFTP_Privado:=OBJECT Get pointer:C1124(Object named:K67:5;"subirFTP_Privado")
$y_subirFTP_Beta:=OBJECT Get pointer:C1124(Object named:K67:5;"subirFTP_Beta")
$y_subirFTP_Publico:=OBJECT Get pointer:C1124(Object named:K67:5;"subirFTP_Publico")

$y_versionAnteriorCompleta:=OBJECT Get pointer:C1124(Object named:K67:5;"versionAnterior_Completa")
$y_versionAnteriorMayor:=OBJECT Get pointer:C1124(Object named:K67:5;"versionAnterior_Mayor")
$y_versionAnteriorMenor:=OBJECT Get pointer:C1124(Object named:K67:5;"versionAnterior_Menor")
$y_versionAnteriorBuild:=OBJECT Get pointer:C1124(Object named:K67:5;"versionAnterior_Build")
$y_versionAnteriorDTS:=OBJECT Get pointer:C1124(Object named:K67:5;"versionAnterior_DTS")
$y_versionAnteriorTipo:=OBJECT Get pointer:C1124(Object named:K67:5;"versionAnterior_Tipo")  //20180817 RCH

$y_versionGeneracionCompleta:=OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_Completa")
$y_versionGeneracionMayor:=OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_Mayor")
$y_versionGeneracionMenor:=OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_Menor")
$y_versionGeneracionBuild:=OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_Build")
$y_versionGeneracionDTS:=OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_DTS")
$y_versionGeneracionTipo:=OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_Tipo")

$y_email:=OBJECT Get pointer:C1124(Object named:K67:5;"email")
$y_PullGIT_STWA:=OBJECT Get pointer:C1124(Object named:K67:5;"pullGIT_STWA")

$y_objetoJsonInfo:=OBJECT Get pointer:C1124(Object named:K67:5;"jsonInfo")


$t_carpetaDestino:=BUILD_GetPaths ("updateFolder")+Folder separator:K24:12


Case of 
	: (Form event:C388=On Load:K2:1)
		$y_generarLibrerias->:=1
		$y_subirFTP_Privado->:=1
		$y_subirFTP_Publico->:=0
		
		$t_version_Anterior:=SYS_LeeVersionEstructura ("principal";$y_versionAnteriorMayor)
		$t_version_Anterior:=SYS_LeeVersionEstructura ("revision";$y_versionAnteriorMenor)
		$t_version_Anterior:=SYS_LeeVersionEstructura ("build";$y_versionAnteriorBuild)
		$t_version_Anterior:=SYS_LeeVersionEstructura ("dts";$y_versionAnteriorDTS)
		$t_version_Anterior:=SYS_LeeVersionEstructura ("tipo";$y_versionAnteriorTipo)
		$y_versionAnteriorCompleta->:=$t_version_Anterior
		
		$y_versionGeneracionMayor->:=$y_versionAnteriorMayor->
		$y_versionGeneracionMenor->:=$y_versionAnteriorMenor->
		$y_versionGeneracionBuild->:=XSvers_buildNumber 
		$y_versionGeneracionDTS->:=$y_versionAnteriorDTS->
		If ($y_versionGeneracionBuild->>=$y_versionAnteriorBuild->)
			$y_versionGeneracionCompleta->:=String:C10($y_versionGeneracionMayor->)+"."+String:C10($y_versionGeneracionMenor->)+"."+String:C10($y_versionGeneracionBuild->)+" "+$y_versionAnteriorTipo->
		End if 
		
		
		
		If (Version type:C495 ?? 64 bit version:K5:25)
			$t_rutaLog:=Get 4D folder:C485(Logs folder:K5:19)+Choose:C955(SYS_IsMacintosh ;"BuildAppMac_html.xml";"BuildAppWin_html.xml")
		Else 
			$t_rutaLog:=Get 4D folder:C485(Logs folder:K5:19)+Choose:C955(SYS_IsMacintosh ;"BuildAppMac.log.html";"BuildAppWin.log.html")
		End if 
		  //If (Test path name($t_rutaLog)=Is a document)
		  //WA OPEN URL(*;"WA";$t_rutaLog)
		  //End if
		
		OBJECT SET VISIBLE:C603(*;"error";False:C215)
		OBJECT SET VISIBLE:C603(*;"compilador";False:C215)
		OBJECT SET VISIBLE:C603(*;"executeTasks";False:C215)  //20170817 RCH. Para presionar cuando no funcione el postkey
		
		OBJECT SET VISIBLE:C603(*;"noActualizarVersionador";<>lUSR_CurrentUserID=-1)
		OBJECT SET VISIBLE:C603(*;"pagina@";<>lUSR_CurrentUserID=-1)
		$y_generarLibrerias->:=1
		CLEAR VARIABLE:C89(ob_Upload_Context)
		CLEAR VARIABLE:C89(ob_ZIP_CONTEXT)
		$y_email->:=<>tUSR_CurrentUserEmail
		
		
		
		$t_rutaInfoJson:=BUILD_GetPaths ("appInfoJson")
		If (Test path name:C476($t_rutaInfoJson)=Is a document:K24:1)
			$t_error:=OB_JsonDocumentToObject ($t_rutaInfoJson;$y_objetoJsonInfo)
		End if 
		
		BUILD_SetAutoupdateInfos 
		BUILD_GetTasksList 
		
		  //20180117 RCH Cuando la IN no responde, se recibe un -1 de número de versión y se podía continuar con la generación de versión. Se cambia comportamiento.
		If ($y_versionGeneracionBuild->=-1)
			OBJECT SET TITLE:C194(*;"error";"Error al obtener versión desde IN")
			OBJECT SET VISIBLE:C603(*;"error";True:C214)
			OBJECT SET ENABLED:C1123(*;"Generar";False:C215)
		End if 
		
	: (Form event:C388=On Activate:K2:9)
		
	: (Form event:C388=On Deactivate:K2:10)
		
	: (Form event:C388=On Page Change:K2:54)
		
	: (Form event:C388=On Outside Call:K2:11)
		$y_tareaDescripcion:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_descripcion")
		$y_tareaTipo:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_tipo")
		$y_tareaProgreso:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_progreso")
		$y_tareaRutaOrigen:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_rutaOrigen")
		$y_tareaRutaDestino:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_rutaDestino")
		$y_tareaEjecutada:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_status")
		$y_tareaComentario:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_comentario")
		$y_tareaActual:=OBJECT Get pointer:C1124(Object named:K67:5;"tarea_actual")
		$l_anchoMax:=IT_Objeto_Ancho ("tareas_listbox")
		
		$t_nombreObjectoProgreso:="tarea_avance"+String:C10($y_tareaActual->)
		
		
		Case of 
			: ($y_tareaTipo->{$y_tareaActual->}="zip")
				$y_tareaProgreso->{$y_tareaActual->}:=<>ZIP_STATUS  //10
				$y_tareaComentario->{$y_tareaActual->}:="Comprimiendo..."
				
			: ($y_tareaTipo->{$y_tareaActual->}="upload")
				$y_tareaProgreso->{$y_tareaActual->}:=<>UPLOAD_STATUS  //10
				$y_tareaComentario->{$y_tareaActual->}:="Transfiriendo..."
				
			: ($y_tareaTipo->{$y_tareaActual->}="backup")
				$y_tareaProgreso->{$y_tareaActual->}:=<>ZIP_STATUS  ///10
				$y_tareaComentario->{$y_tareaActual->}:="Comprimiendo..."
				
		End case 
		
		$l_progreso:=Round:C94($l_anchoMax*$y_tareaProgreso->{$y_tareaActual->}/1000;0)
		OBJECT GET COORDINATES:C663(*;$t_nombreObjectoProgreso;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		OBJECT SET COORDINATES:C1248(*;$t_nombreObjectoProgreso;$l_izquierda;$l_arriba;$l_izquierda+$l_progreso;$l_abajo)
		
		Case of 
			: ($y_tareaTipo->{$y_tareaActual->}="zip")
				If (OB Is defined:C1231(ob_ZIP_Context;"success"))
					$b_exito:=OB Get:C1224(ob_ZIP_Context;"success")
					$t_error:=OB Get:C1224(ob_ZIP_Context;"error")
					Case of 
						: (($t_error#"") & ($b_exito))
							LISTBOX SET ROW COLOR:C1270(*;"tarea_descripcion";$y_tareaActual->;color RGB red;lk font color:K53:24)
							LISTBOX SET ROW FONT STYLE:C1268(*;"tarea_descripcion";$y_tareaActual->;Bold:K14:2)
							$y_tareaComentario->{$y_tareaActual->}:="Compresión fallida"
							$y_tareaEjecutada->{$y_tareaActual->}:=-1
						: ($b_exito)
							LISTBOX SET ROW FONT STYLE:C1268(*;"tarea_descripcion";$y_tareaActual->;Bold:K14:2)
							$y_tareaComentario->{$y_tareaActual->}:="Compresión exitosa"
							$y_tareaEjecutada->{$y_tareaActual->}:=1
					End case 
				End if 
				
			: ($y_tareaTipo->{$y_tareaActual->}="upload")
				If (OB Is defined:C1231(ob_Upload_Context;"success"))
					$b_exito:=OB Get:C1224(ob_Upload_Context;"success")
					$t_error:=OB Get:C1224(ob_Upload_Context;"error")
					Case of 
						: (($t_error#"") & ($b_exito))
							LISTBOX SET ROW COLOR:C1270(*;"tarea_descripcion";$y_tareaActual->;color RGB red;lk font color:K53:24)
							LISTBOX SET ROW FONT STYLE:C1268(*;"tarea_descripcion";$y_tareaActual->;Bold:K14:2)
							$y_tareaComentario->{$y_tareaActual->}:="Transferencia fallida"
							$y_tareaEjecutada->{$y_tareaActual->}:=-1
						: ($b_exito)
							LISTBOX SET ROW FONT STYLE:C1268(*;"tarea_descripcion";$y_tareaActual->;Bold:K14:2)
							$y_tareaComentario->{$y_tareaActual->}:="Transferencia exitosa"
							$y_tareaEjecutada->{$y_tareaActual->}:=1
					End case 
				End if 
				
			: ($y_tareaTipo->{$y_tareaActual->}="backup")
				If (OB Is defined:C1231(ob_ZIP_Context;"success"))
					$b_exito:=OB Get:C1224(ob_ZIP_Context;"success")
					$t_error:=OB Get:C1224(ob_ZIP_Context;"error")
					Case of 
						: (($t_error#"") & ($b_exito))
							LISTBOX SET ROW COLOR:C1270(*;"tarea_descripcion";$y_tareaActual->;color RGB red;lk font color:K53:24)
							LISTBOX SET ROW FONT STYLE:C1268(*;"tarea_descripcion";$y_tareaActual->;Bold:K14:2)
							$y_tareaComentario->{$y_tareaActual->}:="Respaldo fallido"
							$y_tareaEjecutada->{$y_tareaActual->}:=-1
							DELETE FOLDER:C693($y_tareaRutaOrigen->{$y_tareaActual->};Delete with contents:K24:24)
						: ($b_exito)
							LISTBOX SET ROW FONT STYLE:C1268(*;"tarea_descripcion";$y_tareaActual->;Bold:K14:2)
							$y_tareaComentario->{$y_tareaActual->}:="Respaldo exitoso"
							$y_tareaEjecutada->{$y_tareaActual->}:=1
							DELETE FOLDER:C693($y_tareaRutaOrigen->{$y_tareaActual->};Delete with contents:K24:24)
					End case 
				End if 
		End case 
		
		
		If ($b_exito)
			If ($y_tareaActual-><Size of array:C274($y_tareaDescripcion->))
				$y_tareaActual->:=$y_tareaActual->+1
				BUILD_ExecuteTask ($y_tareaActual->)
				OBJECT SET SCROLL POSITION:C906(*;"tareas_listbox";$y_tareaActual->)
			End if 
		End if 
		
		
		If ($y_tareaActual->=Size of array:C274($y_tareaDescripcion->))
			If ($y_tareaEjecutada->{$y_tareaActual->}=1)
				If (SYS_IsWindows )
					$t_error:=BUILD_SendNotification (1;$y_PullGIT_STWA->)
				Else 
					$t_error:=BUILD_SendNotification (1)
				End if 
				If ($t_error="")
					ACCEPT:C269
				End if 
			Else 
				$t_error:=BUILD_SendNotification (-1)
			End if 
		End if 
		
		
		
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
End case 






