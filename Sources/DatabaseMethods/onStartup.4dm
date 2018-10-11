  // On Startup()
  // Por: Alberto Bachler K.: 07-02-14, 11:12:16
  //  ---------------------------------------------
  //  ---------------------------------------------

C_BOOLEAN:C305($b_BDenMantencion;$b_BDenVerificacion;$b_bloquearRespaldo;$b_Integrar_v12;$b_ReiniciarAplicacion;$b_semaforo)
C_LONGINT:C283($hl_Aplicacion;$hl_version;$l_año;$l_IdProceso;$l_processID;$l_refAplicacion;$l_refVersionCompleta;$l_siglo)
C_TIME:C306($h_refDocImagenesEnRecursos)
C_TEXT:C284($t_carpetaRecursos;$t_nombreAplicacion;$t_nombreVersionCompleta;$t_ruta)
ARRAY TEXT:C222($t_nombreComponentes;0)
C_BOOLEAN:C305(<>vb_ImportHistoricos_STX;<>vb_AvoidTriggerExecution;<>vb_BDinReconstruction)
C_LONGINT:C283(<>l_ResultadoVerificacion)
If (Application type:C494#4D Remote mode:K5:5)
	$b_bloquearRespaldo:=Semaphore:C143("BloqueoRespaldo")
End if 




If ((Macintosh command down:C546 & Shift down:C543) | (Windows Ctrl down:C562 & Shift down:C543))
	TRACE:C157
End if 
SYS_Infos 
4D_DesignModeTasks 


$b_clearCompleted:=SYS_ClearFolderContent (Temporary folder:C486+"4D"+Folder separator:K24:12+"PrintPreview")



If (Not:C34(Is compiled mode:C492))
	Compiler_All 
End if 

KRL_LoadTableAndFieldPointers 
READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"icons"+Folder separator:K24:12+"server_32.png";<>p_iconoColegium)


If (Application type:C494=4D Remote mode:K5:5)
	$b_BDenMantencion:=Test semaphore:C652("CompactandoBD") | Test semaphore:C652("ReconstruyendoBD")
	If ($b_BDenMantencion)
		ALERT:C41("La base de datos está en mantenimiento en este momento. Por favor intente nuevamente dentro de algunos minutos.")
		QUIT 4D:C291
	End if 
End if 




If (Application type:C494#4D Remote mode:K5:5)
	  //LOG_AbreDocumento //20170126 RCH Se comenta según lo solicitado por ABK
End if 

LICENCIA_ObtieneUUIDinstitucion 
If (Application type:C494#4D Remote mode:K5:5)
	$b_ReiniciarAplicacion:=CIM_ReconstruyeBD ("check")
	If (Not:C34($b_ReiniciarAplicacion))
		BKP_VerificaConfig 
		CLEAR SEMAPHORE:C144("BloqueoRespaldo")
	End if 
End if 



CIM_CuentaRegistros ("")
If (Not:C34($b_ReiniciarAplicacion))
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
			
			  // no fue necesario reparar ni compactar
			  //JHB 20130503 para desde el cliente saber si el servidor es oficial
			GET PROCESS VARIABLE:C371(-1;<>bXS_esServidorOficial;<>bXS_esServidorOficial)
			IP_Init 
			SET DATABASE PARAMETER:C642(Debug log recording:K37:34;0)
			  //instalación del gestionario de eventos por defecto
			ON EVENT CALL:C190("EVT_OnEventHandler";"$GestionDeEventos")
			C_LONGINT:C283(error)
			C_TEXT:C284(<>vt_SessionStartedAt)
			<>vt_SessionStartedAt:=String:C10(Current date:C33(*);Internal date long:K1:5)+", "+String:C10(Current time:C178(*);HH MM SS:K7:1)
			<>vb_TraceBlobReading:=False:C215
			HIDE TOOL BAR:C434
			HLPR_RegisterExternals 
			
			
			SYS_Infos 
			UTIL_ImpresoraPDF 
			
			
			
			If (Not:C34(Is compiled mode:C492))
				COMPONENT LIST:C1001($t_nombreComponentes)
				If (Find in array:C230($t_nombreComponentes;"4DPop")>0)
					EXECUTE METHOD:C1007("4DPop_Palette")
				End if 
				EXECUTE METHOD:C1007("VC4D_onStartup")
			End if 
			
			PERIODOS_Init 
			EVS_initialize 
			  // precison de la comparación de reales
			SET REAL COMPARISON LEVEL:C623(10^-11)
			
			
			  //fijacion del siglo para compración de fechas con años a 4 digitos
			$l_siglo:=Num:C11(Substring:C12(String:C10(Year of:C25(Current date:C33));1;2))
			$l_año:=Num:C11(Substring:C12(String:C10(Year of:C25(Current date:C33));3))
			If ($l_año+10<100)
				SET DEFAULT CENTURY:C392($l_siglo-1;$l_año+10)
			Else 
				SET DEFAULT CENTURY:C392($l_siglo;$l_año+10-100)
			End if 
			If (Application type:C494#4D Remote mode:K5:5)
				SQ_CargaDatos 
			End if 
			KRL_UnloadAll 
			STWA2_LoadPrefs 
			SYS_SetFormatResources   //20170630 RCH setea formatos escribiendo archivos
			$l_IdProceso:=New process:C317("XS_StartupProcess";128*1024;"Startup")
	End case 
Else 
	$l_IdProceso:=New process:C317("CIM_ReiniciaAplicacion";Pila_1024K;"Reinicio aplicación")
End if 