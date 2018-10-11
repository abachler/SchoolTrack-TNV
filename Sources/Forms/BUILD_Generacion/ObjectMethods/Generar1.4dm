  // GeneracionAplicacion.Botón()
  //
  //
  // creado por: Alberto Bachler Klein: 25-07-16, 19:13:29
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_errorPullGit)
C_LONGINT:C283($i;$l_abajo;$l_abajoObjeto;$l_altoVentana;$l_arriba;$l_derecha;$l_idProceso;$l_ignorar;$l_izquierda;$l_nuevoBuildNumber)
C_LONGINT:C283($l_puerto;$l_puertoHTTP;$l_version_BuildNumber)
C_POINTER:C301($y_comprimirAplicacion;$y_generarLibrerias;$y_noActualizarVersion;$y_subirFTP_Privado;$y_subirFTP_Publico;$y_versionAnteriorBuild;$y_versionAnteriorCompleta;$y_versionAnteriorDTS;$y_versionAnteriorTipo;$y_versionAnteriorMayor;$y_versionAnteriorMenor)
C_POINTER:C301($y_versionGeneracionBuild;$y_versionGeneracionCompleta;$y_versionGeneracionDTS;$y_versionGeneracionMayor;$y_versionGeneracionMenor)
C_TEXT:C284($t_build;$t_respuestaPull;$t_rutaCarpetaAutoUpdates;$t_rutaCarpetaGeneracion;$t_rutaLog;$t_rutaLog_html;$t_rutaLog_html64;$t_rutaLog_xml;$t_rutaLog_xml64;$t_version_SinBuild)
C_TEXT:C284($t_versionGenerada)

ARRAY LONGINT:C221($al_paginas;0)
ARRAY POINTER:C280($ay_variables;0)
ARRAY TEXT:C222($at_objetos;0)

$y_generarLibrerias:=OBJECT Get pointer:C1124(Object named:K67:5;"generarLibrerias")
$y_comprimirAplicacion:=OBJECT Get pointer:C1124(Object named:K67:5;"comprimirAplicaciones")
$y_subirFTP_Privado:=OBJECT Get pointer:C1124(Object named:K67:5;"subirFTP_Privado")
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

$y_PullGIT_STWA:=OBJECT Get pointer:C1124(Object named:K67:5;"pullGIT_STWA")

vsBWR_CurrentModule:="Colegium Systems"
GET PICTURE FROM LIBRARY:C565("Module SchoolTrack";vpXS_IconModule)

FORM GET OBJECTS:C898($at_objetos;$ay_variables;$al_paginas;Form current page:K67:6)
For ($i;1;Size of array:C274($at_objetos))
	OBJECT SET ENABLED:C1123(*;$at_objetos{$i};False:C215)
End for 
REDRAW WINDOW:C456

  //20180320 RCH Verifica fuentes en objetos
C_TEXT:C284($t_objetosSinFuente)
If (SYS_IsWindows )  //20180406 RCH
	$t_objetosSinFuente:=4D_BuscaObjetos ("SinFuente")
End if 
If ($t_objetosSinFuente#"")
	  //20180320 RCH Si hay objetos sin fuente, no se continúa
	SET TEXT TO PASTEBOARD:C523($t_objetosSinFuente)
	OBJECT SET TITLE:C194(*;"error";"Objetos sin fuente, revise el detalle en el portapapeles")
	OBJECT SET VISIBLE:C603(*;"error";True:C214)
Else 
	If (SYS_IsWindows )
		$b_errorPullGit:=GIT_PullSTWA ($y_PullGIT_STWA)
	End if 
	If ($b_errorPullGit)
		BUILD_SendNotification (-4;$y_PullGIT_STWA->)
		OBJECT SET VISIBLE:C603(*;"error";True:C214)
		OBJECT SET VISIBLE:C603(*;"compilador";True:C214)
		OBJECT SET TITLE:C194(*;"error";"Generación fallida\rErrores en el GIT-Pull STWAsw")
		
	Else 
		
		$l_ok:=Num:C11(STWA2_CreaImagenAlumnosEnDisco ("eliminaCarpeta"))  //20180616 ASM Ticket 206719 
		
		If ($l_ok=0)
			OBJECT SET VISIBLE:C603(*;"error";True:C214)
			OBJECT SET VISIBLE:C603(*;"compilador";True:C214)
			OBJECT SET TITLE:C194(*;"error";"Generación fallida\rNo se pudo eliminar la carpeta alumnos desde el proyecto STWA")
		Else 
			
			  //20180125 RCH//$l_nuevoBuildNumber:=XSvers_buildNumber 
			$l_nuevoBuildNumber:=$y_versionGeneracionBuild->
			
			PICTLib_ConvertPICTs   // para volver a convertir imagenes PICT en el caso que hayan sido copiadas al copiar formularios desde 4D v13 
			
			If ($l_nuevoBuildNumber>=$l_version_BuildNumber)
				$t_versionGenerada:=$t_version_SinBuild+"."+String:C10($l_nuevoBuildNumber)
				
				  //cambio del puerto 19814 (desarrollo) al puerto estaíndar de 4D : 19813
				$l_puerto:=Get database parameter:C643(Client Server port ID:K37:35)
				$l_puertoHTTP:=Get database parameter:C643(Port ID:K37:15)
				SET DATABASE PARAMETER:C642(Client Server port ID:K37:35;19813)
				SET DATABASE PARAMETER:C642(Port ID:K37:15;80)
				
				If ($y_generarLibrerias->=1)
					$l_idProceso:=IT_UThermometer (1;0;__ ("Actualizando estructura virtual...");-1)
					
					  // Restauro las localizaciones desde los archivos almacenados en /config/virtual/
					  // Las localizaciones creadas o modificadas con posterioridad a la generación de los archivos localizacionTablas.txt y localizacionCampos.txt
					  // serán preservadas
					XSvs_RestauraLocalizaciones 
					
					  // actualizo la estructura virtual cuando es necesario
					XSvs_ActualizaEstructuraVirtual 
					IT_UThermometer (-2;$l_idProceso)
					
					  //guardando librerias
					$l_idProceso:=IT_UThermometer (1;0;__ ("Guardando librerías...");-5)
					EXE_SaveCommandLibrary 
					XS_SaveExecutableObjects 
					QR_SaveReportLibrary 
					QRY_SaveStandardQueries 
					TBL_SaveLibrary 
					RObj_SaveLibrary 
					ACTtrf_SaveLibrary 
					ACTwtrf_SaveLibrary   //se almacena solamente al modificar los campos disponibles
					IN_ACT_SaveTablaBancos 
					IT_UThermometer (-2;$l_idProceso)
					  //CONFIRM("Las librerías estándar del sistema han sido guardadas. Recuerde llamar los métodos de carga necesarios en UD_Handler y actualizar el método ACTinit_CreateUFTables cuando sea necesario.\r¿Continuar con la generación?";"Generar";"Cancelar")
				End if 
				
				  // limpio la carpeta en la que se egeneran las aplicaciones para asegurarme que quedemos con una versión anterior
				$t_rutaCarpetaGeneracion:=BUILD_GetPaths ("carpetaGeneracion")
				DELETE FOLDER:C693($t_rutaCarpetaGeneracion;Delete with contents:K24:24)
				
				
				$y_versionGeneracionDTS->:=String:C10(Current date:C33;ISO date GMT:K1:10;Current time:C178)
				SYS_EstableceVersionEstructura ("aplicacion";String:C10($y_versionGeneracionCompleta->))
				SYS_EstableceVersionEstructura ("principal";String:C10($y_versionGeneracionMayor->))
				SYS_EstableceVersionEstructura ("revision";String:C10($y_versionGeneracionMenor->))
				SYS_EstableceVersionEstructura ("build";String:C10($y_versionGeneracionBuild->))
				SYS_EstableceVersionEstructura ("dts";$y_versionGeneracionDTS->)
				
				
				If (Version type:C495 ?? 64 bit version:K5:25)
					$t_rutaLog_html:=Get 4D folder:C485(Logs folder:K5:19)+Choose:C955(SYS_IsMacintosh ;"BuildAppMac_html.xml";"BuildAppWin_html.xml")
					$t_rutaLog_html64:=Get 4D folder:C485(Logs folder:K5:19)+Choose:C955(SYS_IsMacintosh ;"BuildAppMac64_html.xml";"BuildAppWin64_html.xml")
				Else 
					$t_rutaLog_html:=Get 4D folder:C485(Logs folder:K5:19)+Choose:C955(SYS_IsMacintosh ;"BuildAppMac.log.html";"BuildAppWin.log.html")
					$t_rutaLog_xml:=Get 4D folder:C485(Logs folder:K5:19)+Choose:C955(SYS_IsMacintosh ;"BuildAppMac.log.xml";"BuildAppWin.log.xml")
					$t_rutaLog_html64:=Get 4D folder:C485(Logs folder:K5:19)+Choose:C955(SYS_IsMacintosh ;"BuildAppMac64.log.html";"BuildAppWin64.log.html")
					$t_rutaLog_xml64:=Get 4D folder:C485(Logs folder:K5:19)+Choose:C955(SYS_IsMacintosh ;"BuildAppMac64.log.xml";"BuildAppWin64.log.xml")
				End if 
				If (Test path name:C476($t_rutaLog_html)=Is a document:K24:1)
					DELETE DOCUMENT:C159($t_rutaLog_html)
				End if 
				If (Test path name:C476($t_rutaLog_xml)=Is a document:K24:1)
					DELETE DOCUMENT:C159($t_rutaLog_xml)
				End if 
				If (Test path name:C476($t_rutaLog_html64)=Is a document:K24:1)
					DELETE DOCUMENT:C159($t_rutaLog_html64)
				End if 
				If (Test path name:C476($t_rutaLog_xml)=Is a document:K24:1)
					DELETE DOCUMENT:C159($t_rutaLog_xml64)
				End if 
				
				BUILD_ClearPluginHelpFiles 
				
				
				OK:=BUILD_Apps_32Bit 
				If ((OK=1) & (SYS_IsWindows ))
					BUILD_AppWin64_Server_UDCl32 
				End if 
				
				If (OK=1)
					SYS_EstableceVersionEstructura ("aplicacion";String:C10($y_versionGeneracionCompleta->))
					SYS_EstableceVersionEstructura ("principal";String:C10($y_versionGeneracionMayor->))
					SYS_EstableceVersionEstructura ("revision";String:C10($y_versionGeneracionMenor->))
					SYS_EstableceVersionEstructura ("build";String:C10($y_versionGeneracionBuild->))
					  //XSvers_GuardaRegistro (String($y_versionGeneracionMayor->)+"."+String($y_versionGeneracionMenor->);$y_versionGeneracionBuild->)
					XSvers_GuardaRegistro (String:C10($y_versionGeneracionMayor->)+"."+String:C10($y_versionGeneracionMenor->);$y_versionGeneracionBuild->;$y_versionAnteriorTipo->)  //20180817 RCH
					$l_marcadorCodigo:=VC4D_CodeModifAfterAppBuild 
					SYS_EstableceVersionEstructura ("dts";$y_versionGeneracionDTS->)
					SYS_EstableceVersionEstructura ("marcadorCodigo";String:C10($l_marcadorCodigo))
					
					
					BUILD_GetTasksList 
					BUILD_SetAutoupdateInfos 
					OBJECT SET ENABLED:C1123(*;"Generar1";True:C214)
					OBJECT SET ENABLED:C1123(*;"showLog";True:C214)
					OBJECT SET ENABLED:C1123(*;"executeTasks";True:C214)
					OBJECT SET ENABLED:C1123(*;"compilador";True:C214)
					
					OBJECT SET VISIBLE:C603(*;"executeTasks";True:C214)  //20170817 RCH. Para presionar cuando no funcione el postkey
					
					POST KEY:C465(Character code:C91("1");Command key mask:K16:1+Option key mask:K16:7)
					
					
				Else 
					SYS_EstableceVersionEstructura ("aplicacion";String:C10($y_versionAnteriorCompleta->))
					SYS_EstableceVersionEstructura ("principal";String:C10($y_versionAnteriorMayor->))
					SYS_EstableceVersionEstructura ("revision";String:C10($y_versionAnteriorMenor->))
					SYS_EstableceVersionEstructura ("build";String:C10($y_versionAnteriorBuild->))
					SYS_EstableceVersionEstructura ("dts";$y_versionAnteriorDTS->)
					
					
					GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
					OBJECT GET COORDINATES:C663(*;"tareas_listBox";$l_ignorar;$l_ignorar;$l_ignorar;$l_abajoObjeto)
					SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha;$l_arriba+$l_abajoObjeto)
					
					If (Version type:C495 ?? 64 bit version:K5:25)
						$t_rutaLog:=Get 4D folder:C485(Logs folder:K5:19)+Choose:C955(SYS_IsMacintosh ;"BuildAppMac_html.xml";"BuildAppWin_html.xml")
					Else 
						$t_rutaLog:=Get 4D folder:C485(Logs folder:K5:19)+Choose:C955(SYS_IsMacintosh ;"BuildAppMac.log.html";"BuildAppWin.log.html")
					End if 
					If (Test path name:C476($t_rutaLog)=Is a document:K24:1)
						GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
						OBJECT GET COORDINATES:C663(*;"tareas_listBox";$l_ignorar;$l_ignorar;$l_ignorar;$l_abajoObjeto)
						SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha;$l_arriba+$l_abajoObjeto)
						FORM GOTO PAGE:C247(2)
						WA OPEN URL:C1020(*;"WA";$t_rutaLog)
						OBJECT SET VISIBLE:C603(*;"error";True:C214)
						OBJECT SET VISIBLE:C603(*;"compilador";False:C215)
						OBJECT SET TITLE:C194(*;"error";"Generación fallida\rErrores en la generación")
						BUILD_SendNotification (-2)
						
					Else 
						OBJECT SET VISIBLE:C603(*;"error";True:C214)
						OBJECT SET VISIBLE:C603(*;"compilador";True:C214)
						OBJECT SET TITLE:C194(*;"error";"Generación fallida\rErrores de compilación")
						BUILD_SendNotification (-3)
					End if 
				End if 
				
				SET DATABASE PARAMETER:C642(Client Server port ID:K37:35;$l_puerto)
				SET DATABASE PARAMETER:C642(Port ID:K37:15;$l_puertoHTTP)
				
			Else 
				  //20180123 RCH Se informa cuando hubo problema de comunicación con la IN3
				OBJECT SET TITLE:C194(*;"error";"Error al obtener versión desde IN")
				OBJECT SET VISIBLE:C603(*;"error";True:C214)
				
			End if 
		End if 
	End if 
End if 