//%attributes = {}
  //XS_StartupProcess

vsBWR_CurrentModule:="SchoolTrack"
GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)
CRYPT_Init 
Bash_Init 

If ((Test semaphore:C652("BackupInProcess")) | (Test semaphore:C652("DisconnectingClients")))
	<>vb_MsgON:=True:C214
	CD_Dlog (0;__ ("No es posible iniciar una sesión en este momento.\rPor favor inténtelo nuevamente más tarde.");__ ("");__ ("Salir"))
	QUIT 4D:C291
Else 
	ModernUI_ColoresRGB 
	<>DisplaySplash:=True:C214
	<>vThInicio:=0
	<>Splash:=New process:C317("XS_DisplaySplash";Pila_256K;"$DisplaySplash")
	<>vb_TraceBlobReading:=False:C215
	<>vl_4DDefaultWindow:=Frontmost window:C447
	<>vb_4DWindowVisible:=True:C214
	<>dXS_FechaActual:=Current date:C33(*)
	  //<>syT_AppResourcesPath:=<>syT_PreferenceFolder+Folder separator+"Language_UID0.RES"
	EM_ErrorManager ("Install")
	EM_ErrorManager ("SetMode";"")
	LICENCIA_Descarga 
	LOC_LoadFixedLocalizedStrings 
	dhBWR_LoadLists 
	IT_ShowHide4DWindow 
	dhXS_Before_XShell_startup 
	XS_Startup 
	KRL_UnloadAll 
	
End if 

  //ON EVENT CALL("")

SYS_LogUsoMemoriaEjecucion ("Startup";"Fin XS_StartupProcess")