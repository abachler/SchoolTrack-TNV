  // On Server Startup()
  // Por: Alberto Bachler K.: 15-07-14, 06:49:50
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_continuar;$b_detenerInicio)
C_DATE:C307($d_fechaActual)
C_LONGINT:C283(<>l_ResultadoVerificacion)
C_TIME:C306($currentTime)

$b_bloquearRespaldo:=Semaphore:C143("BloqueoRespaldo")

SYS_Infos 
4D_DesignModeTasks 

If ((Macintosh command down:C546 & Shift down:C543) | (Windows Ctrl down:C562 & Shift down:C543))
	TRACE:C157
End if 


If (Not:C34(Is compiled mode:C492))
	Compiler_All 
End if 

KRL_LoadTableAndFieldPointers 
READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"icons"+Folder separator:K24:12+"server_32.png";<>p_iconoColegium)


  //LOG_AbreDocumento //20170126 RCH Se comenta según lo solicitado por ABK
LICENCIA_ObtieneUUIDinstitucion 
$b_ReiniciarAplicacion:=CIM_ReconstruyeBD ("check")
If (Not:C34($b_ReiniciarAplicacion))
	BKP_VerificaConfig 
	CLEAR SEMAPHORE:C144("BloqueoRespaldo")
	CIM_CuentaRegistros ("")
	
	
	$l_processID:=New process:C317("XS_Verificacion_y_Compactaje";Pila_1024K;"VerificacionBD")
	DELAY PROCESS:C323(Current process:C322;60)
	$b_BDenVerificacion:=Test semaphore:C652("VerificacionBD")
	While ($b_BDenVerificacion)
		DELAY PROCESS:C323(Current process:C322;60)
		$b_BDenVerificacion:=Test semaphore:C652("VerificacionBD")
	End while 
	Case of 
		: (<>l_ResultadoVerificacion=-4)
			  // reconstrucción de index, reiniciamos la aplicación
			$l_IdProceso:=New process:C317("CIM_ReiniciaAplicacion";Pila_1024K;"Reinicio aplicación")
			
		: (<>l_ResultadoVerificacion=-3)
			  // se reconstruyó la BD, reiniciamos la aplicación
			$l_IdProceso:=New process:C317("CIM_ReiniciaAplicacion";Pila_1024K;"Reinicio aplicación")
			
		: (<>l_ResultadoVerificacion=-2)
			  // verificación abortada. Se cierra la aplicación
			$l_IdProceso:=New process:C317("CIM_CerrarAplicacion";Pila_1024K;"Cierre")
			
		: (<>l_ResultadoVerificacion=-1)
			  // apertura CSM
			$t_ruta:=Get 4D folder:C485(Current resources folder:K5:16)+"Images"+Folder separator:K24:12+"InstruccionesReparacion BD.jpg"
			OPEN URL:C673($t_ruta)
			$b_semaforo:=Semaphore:C143("BD_Corrupta")
			  //$l_IdProceso:=New process("CIM_AbreCSM4D";Pila_1024K;"Cierre")
			
		: (<>l_ResultadoVerificacion=1)
			  // se abrió el archivo de compactación de datos
			$l_IdProceso:=New process:C317("CIM_ReiniciaAplicacion";Pila_1024K;"Reinicio aplicación")
			
			
		: (<>l_ResultadoVerificacion=0)
			EXECUTE METHOD:C1007("VC4D_onStartup")
			
			SYS_DBprop_Validate 
			WS_InitWebServicesVariables 
			STR_ReadGlobals 
			XS_ReadCustomerData 
			
			
			$l_resultado:=XS_VerificaRegistroServidor 
			<>bXS_esServidorOficial:=($l_resultado>=0)
			If ($l_resultado#-3)  //-3 = salir de la aplicacion 
				Sync_LeeRefSincronizacion 
				
				  //20150224 RCH Se desactiva Direct2D. Ticket 141013
				SET DATABASE PARAMETER:C642(Direct2D status:K37:61;Direct2D disabled:K37:63)
				
				LOG_RegisterEvt ("Inicio de SchoolTrack Server.")
				Compiler_All 
				IP_Init 
				<>vb_TraceBlobReading:=False:C215
				
				
				$d_fechaActual:=Current date:C33(*)
				$h_horaActual:=Current time:C178(*)
				BLOB_Variables2Blob (->$x_blob;0;->$d_fechaActual;->$currentTime)
				PREF_SetBlob (0;"LastServerStart";$x_blob)
				
				  //Mono: 04-07-2011 Temporalmente se detendrá el server de SQL Ticket 101194
				STOP SQL SERVER:C963
				
				LOG_RegisterEvt ("Inicio de SchoolTrack Server: Compiler_All ejecutado.")
				
				HLPR_RegisterExternals 
				LOG_RegisterEvt ("Inicio de SchoolTrack Server: Registro de plugins ejecutado.")
				
				SYS_Infos 
				UTIL_ImpresoraPDF 
				
				SYS_OpenLangageResource 
				LOG_RegisterEvt ("Inicio de SchoolTrack Server: SYS_OpenLangageResource ejecutado.")
				
				SQ_CargaDatos 
				LOG_RegisterEvt ("Inicio de SchoolTrack Server: SQ_CargaDatos ejecutado.")
				
				EM_ErrorManager ("Install")
				CRYPT_Init 
				Bash_Init 
				EM_ErrorManager ("Install")
				
				$b_continuar:=dhXS_Before_XShell_startup 
				LOG_RegisterEvt ("Inicio de SchoolTrack Server: dhXS_Before_XShell_startup ejecutado.")
				
				If ($b_continuar)  //MONO TICKET 213250
					
					LOC_VerificaFormatos   //20171226 RCH
					LOG_RegisterEvt ("Inicio de SchoolTrack Server: LOC_VerificaFormatos ejecutado.")
					
					$b_continuar:=XS_ServerStartup 
					If ($b_continuar)
						LOG_RegisterEvt ("Inicio de SchoolTrack Server: XS_ServerStartup ejecutado.")
						
						dhXS_ServerStartUp 
						LOG_RegisterEvt ("Inicio de SchoolTrack Server: dhXS_ServerStartUp ejecutado.")
						
						CLSV_InitClientProcessStatus 
						LOG_RegisterEvt ("Inicio de SchoolTrack Server terminado.")
					End if 
					
					ST_EjecutaProcesoServidor ("dbu_CreaSesiones";"CreacionDeSesiones")  //Para verificar la creación de sesiones
				End if 
				
				KRL_UnloadAll 
				
			Else 
				
			End if 
	End case 
Else 
	$l_IdProceso:=New process:C317("CIM_ReiniciaAplicacion";Pila_1024K;"Reinicio aplicación")
End if 

