//%attributes = {}
  // 0xDev_BuildApplications_v13()
  // Por: Alberto Bachler K.: 24-06-14, 14:40:18
  //  ---------------------------------------------
  //  ---------------------------------------------
C_LONGINT:C283($i_licencias;$i_tags;$l_error;$l_idProceso;$l_nuevoBuildNumber;$l_puerto;$l_version_BuildNumber;$l_version_Mayor;$l_version_Revision)
C_TIME:C306($h_referencia)
C_TEXT:C284($t_bloqueLicencias;$t_build;$t_carpetaLicenciasActiva;$t_carpetaLicenciasOEM;$t_Error;$t_etiqueta;$t_rutaDestino;$t_rutaDocumento;$t_rutaEstructura;$t_rutaExtras)
C_TEXT:C284($t_rutaOrigen;$t_rutaScriptGeneracion;$t_ScriptGeneracion;$t_valorEtiqueta;$t_version;$t_version_Anterior;$t_version_DTSanterior;$t_version_SinBuild;$t_versionGenerada;$t_versionLarga)
ARRAY TEXT:C222($at_BloqueLicencias;0)
ARRAY TEXT:C222($at_nombresDocumentos;0)
ARRAY TEXT:C222($at_rutaDocumentos;0)
ARRAY TEXT:C222($at_valoresEtiquetas;0)
vsBWR_CurrentModule:="Colegium Systems"
GET PICTURE FROM LIBRARY:C565("Module SchoolTrack";vpXS_IconModule)

If (Application type:C494#4D Local mode:K5:1)
	
	CD_Dlog (0;__ ("La generación de aplicaciones sólo puede ser realizada en 4th Dimension."))
	
Else 
	
	$t_version_Anterior:=SYS_LeeVersionEstructura ("principal";->$l_version_Mayor)
	$t_version_Anterior:=SYS_LeeVersionEstructura ("revision";->$l_version_Revision)
	$t_version_Anterior:=SYS_LeeVersionEstructura ("build";->$l_version_BuildNumber)
	$t_version_Anterior:=SYS_LeeVersionEstructura ("dts";->$t_version_DTSanterior)
	$t_version_SinBuild:=String:C10($l_version_Mayor)+"."+String:C10($l_version_Revision;"00")
	
	If (False:C215)
		  // reactivar cuando estemos listos para generar betas oficiales
	End if 
	
	$l_nuevoBuildNumber:=$l_version_BuildNumber
	$l_nuevoBuildNumber:=XSvers_buildNumber 
	
	If ($l_nuevoBuildNumber>=$l_version_BuildNumber)
		
		$t_versionGenerada:=$t_version_SinBuild+"."+String:C10($l_nuevoBuildNumber)
		CONFIRM:C162("Las aplicaciones serán generadas con versión "+$t_versionGenerada+"\rPresiona ALT si no quieres regenerar los archivos de configuración";"Generar";"Cancelar")
		
		If (OK=1)
			
			  //cambio del puerto 19814 (desarrollo) al puerto estaíndar de 4D : 19813
			$l_puerto:=Get database parameter:C643(Client Server port ID:K37:35)
			$l_puertoHTTP:=Get database parameter:C643(Port ID:K37:15)
			SET DATABASE PARAMETER:C642(Client Server port ID:K37:35;19813)
			SET DATABASE PARAMETER:C642(Client Server port ID:K37:35;80)
			
			If (Not:C34(IT_AltKeyIsDown ))
				
				$l_idProceso:=IT_UThermometer (1;0;__ ("Actualizando estructura virtual..."))
				
				  // Restauro las localizaciones desde los archivos almacenados en /config/virtual/
				  // Las localizaciones creadas o modificadas con posterioridad a la generación de los archivos localizacionTablas.txt y localizacionCampos.txt
				  // serán preservadas
				XSvs_RestauraLocalizaciones 
				
				  // actualizo la estructura virtual cuando es necesario
				XSvs_ActualizaEstructuraVirtual 
				IT_UThermometer (-2;$l_idProceso)
				
				  //guardando librerias
				$l_idProceso:=IT_UThermometer (1;0;__ ("Guardando librerías..."))
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
				CONFIRM:C162("Las librerías estándar del sistema han sido guardadas. Recuerde llamar los métodos de carga necesarios en UD_Handler y actualizar el método ACTinit_CreateUFTables cuando sea necesario.\r¿Continuar con la generación?";"Generar";"Cancelar")
				
			Else 
				
				OK:=1
				
			End if 
			
			If (OK=1)
				BUILD_ClearPluginHelpFiles 
				
				$t_build:=String:C10($l_nuevoBuildNumber)
				SYS_EstableceVersionEstructura ("build";$t_build)
				SYS_EstableceVersionEstructura ("dts";DTS_Get_GMT_TimeStamp )
				
				OK:=0xDev_BuildApplications_x32 
				If ((OK=1) & (SYS_IsWindows ))
					OK:=0xDev_BuildApplications_x64 
				End if 
			End if 
			
			If (OK=1)
				$t_rutaCacheExtras:=Get 4D folder:C485(_o_Extras folder:K5:12)+"Cache"
				If (Test path name:C476($t_rutaCacheExtras)=Is a folder:K24:2)
					SYS_DeleteFolder ($t_rutaCacheExtras)
				End if 
				
				If (False:C215)
					  //  //debe ser reactivado cuando implemente el control e versiones
					  //$t_Error:=XSvers_EnviaObjetosModificados ($t_version_DTSanterior)
					  //If (Length($t_Error)#0)
					  //ALERT("Al parecer la lista de metodos modificados entre esta versión y la anterior no pudo ser enviada a la Intranet.")
					  //End if 
				End if 
				
				$l_error:=XSvers_GuardaRegistro ($t_version_SinBuild;$l_nuevoBuildNumber)
				
				If ($l_error=0)
					ALERT:C41("Generación de aplicaciones terminada exitosamente.\rVersión: "+$t_versionGenerada+"\r\rRecuerde eliminar código compilado y luego compactar y respaldar la estructura y archivos asociados.")
				End if 
				
			Else 
				SYS_EstableceVersionEstructura ("build";String:C10($l_version_BuildNumber))
				SYS_EstableceVersionEstructura ("dts";$t_version_DTSanterior)
				ALERT:C41("Las aplicaciones no pudieron ser generadas. Se mantuvieron las referencias de versión: "+$t_version_Anterior+"\r\rRecuerde eliminar código compilado y luego compactar y respaldar la estructura y archivos asociados.")
			End if 
		End if 
		
		SET DATABASE PARAMETER:C642(Client Server port ID:K37:35;$l_puerto)
		SET DATABASE PARAMETER:C642(Port ID:K37:15;$l_puertoHTTP)
	End if 
End if 