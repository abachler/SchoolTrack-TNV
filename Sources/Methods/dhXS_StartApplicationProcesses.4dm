//%attributes = {}
  //dhXS_StartApplicationProcesses

  //xShell, Alberto Bachler
  //Metodo: dhXS_StartApplicationProcesses
  //Por abachler
  //Creada el 29/01/2004, 23:49:46
  //Modificaciones:
If ("INSTRUCCIONES"="")
	  //llamado desde: XS_Startup y XS_CloseSesion
	  //utilizar para iniciar subaplicaciones / procesos al iniciar la aplicacion principal
	  //En el Case of poner las instrucciones necesarias para procesar el evento para cada tabla en que se requiera
	  //Asignar True a $trapped si el evento es procesado
End if 


<>stopDaemons:=False:C215
ARRAY TEXT:C222(<>at_ProcesosFondo_Nombre;0)
ARRAY LONGINT:C221(<>al_ProcesosFondo_Id;0)


If (Application type:C494=4D Server:K5:6)
	<>vl_CNXtracker_ProcessID:=New process:C317("USR_RemoteConnexionTracker";Pila_256K;"Remote Connections Tracker")
	APPEND TO ARRAY:C911(<>at_ProcesosFondo_Nombre;"Remote Connections Tracker")
	APPEND TO ARRAY:C911(<>al_ProcesosFondo_Id;<>vl_CNXtracker_ProcessID)
End if 

If (Application type:C494#4D Server:K5:6)
	  //el procesador batch se inicia en todos los clientes, no en el server
	<>l_BatchProcessID:=New process:C317("BM_MainLoop";Pila_256K;"Batch Tasks Processor";*)
	APPEND TO ARRAY:C911(<>at_ProcesosFondo_Nombre;"Batch Tasks Processor")
	APPEND TO ARRAY:C911(<>al_ProcesosFondo_Id;<>l_BatchProcessID)
End if 

  //20150526 RCH El proceso debe ser lanzado en Mono y server.
  //If ((Application type#4D Server) & (Application type#4D Remote Mode))
If (Application type:C494#4D Remote mode:K5:5)
	$vl_EODTProcessID:=New process:C317("BM_EndOfDayTasks";Pila_512K;"End of the day tasks";*)
	APPEND TO ARRAY:C911(<>at_ProcesosFondo_Nombre;"End of the day tasks")
	APPEND TO ARRAY:C911(<>al_ProcesosFondo_Id;$vl_EODTProcessID)
	LOG_RegisterEvt ("Inicio de SchoolTrack Server: BM_EndOfDayTasks iniciado")
End if 

If ((Application type:C494=4D Server:K5:6) | (Application type:C494=4D Remote mode:K5:5))
	If ((LICENCIA_esModuloAutorizado (1;SchoolNet)) | (LICENCIA_esModuloAutorizado (1;SchoolCenter)))
		If (<>inSN3)
			SN3_LoadGeneralSettings 
			$thisMachine:=Current machine:C483+"/"+Current system user:C484
			If ((SN3_EnvioActivado=1) | (LICENCIA_esModuloAutorizado (1;SchoolCenter)))
				Case of 
					: ((Application type:C494=4D Server:K5:6) & (SN3_SendFrom_Server=1))
						<>lSNT_CtrlProcessID:=New process:C317("SN3_CommController";Pila_512K;"Conexión SchoolNet";*)
					: ((Application type:C494=4D Remote mode:K5:5) & (SN3_SendFrom_Workstation=1) & (SN3_SendFrom_SelectedWS=$thisMachine))
						<>lSNT_CtrlProcessID:=New process:C317("SN3_CommController";Pila_512K;"Conexión SchoolNet";*)
				End case 
				APPEND TO ARRAY:C911(<>at_ProcesosFondo_Nombre;"Conexión SchoolNet")
				APPEND TO ARRAY:C911(<>al_ProcesosFondo_Id;<>lSNT_CtrlProcessID)
			End if 
		Else 
			  //procesos SNT 1 y II no disponibles en v11
		End if 
	End if 
End if 

$userName:=Current system user:C484
$machineName:=Current machine:C483
  //20110309 RCH Envio de datos CMT
  //20110420 RCH Se deja envio automatico desde server y mono...
If ((Application type:C494=4D Server:K5:6) | (Application type:C494=4D Volume desktop:K5:2))
	If (LICENCIA_esModuloAutorizado (1;CommTrack))
		$p:=New process:C317("CMT_CommController";Pila_256K;"Envío de datos Commtrack";*)
		APPEND TO ARRAY:C911(<>at_ProcesosFondo_Nombre;"Envío de datos Commtrack")
		APPEND TO ARRAY:C911(<>al_ProcesosFondo_Id;$p)
	End if 
End if 

  //If ((Application type=4D Server) | (Not(Is compiled mode)))
If (Application type:C494=4D Server:K5:6)
	If (LICENCIA_esModuloAutorizado (1;SchoolTrack Web Access))
		$p:=New process:C317("STWA2_Session_Init";Pila_256K;"STWA 2 Session Manager";*)
		APPEND TO ARRAY:C911(<>at_ProcesosFondo_Nombre;"STWA 2 Session Manager")
		APPEND TO ARRAY:C911(<>al_ProcesosFondo_Id;$p)
	End if 
End if 

  //MONO: ACTUALIZACION DE DATOS SN3
If (Application type:C494=4D Server:K5:6)
	If (LICENCIA_esModuloAutorizado (1;SchoolNet))
		$p:=New process:C317("SN3_ActuaDatos_AutomaticTask";Pila_256K;"Demonio de Actualización de Datos desde SN3";*)
		APPEND TO ARRAY:C911(<>at_ProcesosFondo_Nombre;"Demonio de Actualización de Datos desde SN3")
		APPEND TO ARRAY:C911(<>al_ProcesosFondo_Id;$p)
	End if 
End if 