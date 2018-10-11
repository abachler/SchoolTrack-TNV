//%attributes = {}
  //XS_Startup

If (False:C215)
	  // Project method: XS_Startup
	  // Module: 
	  // Purpose:
	  // Syntax: XS_Startup()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 29/12/01  15:39, by Alberto Bachler
	  // 
	  // 
End if 


  // DECLARATIONS
  // ============================================

  // INITIALIZATION
  // ============================================
<>vbUSR_Use4DSecurity:=False:C215
<>vi_ReservedOP:=Num:C11(PREF_fGet (0;"Reserved Licences";"0"))
C_TEXT:C284(<>vsXS_CurrentModule;<>vtXS_AppName)
C_LONGINT:C283(<>vlXS_CurrentModuleRef)
C_PICTURE:C286(vpXS_IconModule)

  // MAIN CODE
  // ============================================

LIST TO ARRAY:C288("XS_Modules";$atXS_ModuleNames;$alXS_ModuleRef)
If (Size of array:C274($atXS_ModuleNames)>0)
	<>vsXS_CurrentModule:=$atXS_ModuleNames{1}
	<>vlXS_CurrentModuleRef:=$alXS_ModuleRef{1}
	vsBWR_CurrentModule:=<>vsXS_CurrentModule
	GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)
Else 
	vsBWR_CurrentModule:=""
	vpXS_IconModule:=vpXS_IconModule*0
End if 

  //paths and various system informations
LICENCIA_ListaMacAddress 
  //SYS_Infos 
SN3_SetControlVariable 

XS_ReadCustomerData 

If (False:C215)
	  //Alberto Bachler K.
	  //09-08-2015, 11:05:55
	  //SYS_ReadPreferencesFile 
	  //SYS_OpenLangageResource (<>vtXS_DefaultProfileLanguage)
	  //LOC_SetLanguage 
	  //LOC_ChangeLanguage 
End if 

  //LOC_LoadFixedLocalizedStrings movido a xs_startupProcess para cargar las listas antes junto a dhBWR_LoadLists
LOC_BuildCountryLangMenus 

  //initialize shell variables
XS_InitVariables 
WS_InitWebServicesVariables 

  //punteros para relaciones entre tablas xShell y tablas de la aplicacion
HLPR_xShell2ApplicationTables 
XS_MapeoTablas_AppColegio 


  //initializing modules
xs_InitModules 

  //XShell_configuration
XS_ShellSetup 

  //getting app and data version and handling updates
SYS_READVERSION 

  //loading shell lists
TBL_LoadListsArrays 

KRL_UnloadAll 

If ((Application type:C494#4D Remote mode:K5:5) & (Application type:C494#4D Server:K5:6))
	XSusr_ListaSuperUsuarios_in 
End if 

  //logging in
PAUSE PROCESS:C319(<>Splash)
HIDE PROCESS:C324(<>Splash)
If ((Test semaphore:C652("BackupInProcess")) | (Test semaphore:C652("DisconnectingClients")))
	<>vb_MsgON:=True:C214
	<>vl_interface:=1
	CD_Dlog (0;__ ("No es posible iniciar una sesión en este momento.\rPor favor inténtelo nuevamente más tarde.");__ ("");__ ("Salir"))
	QUIT 4D:C291
Else 
	USR_login 
	SYS_OpenLangageResource 
End if 

DELAY PROCESS:C323(Current process:C322;30)

SHOW PROCESS:C325(<>Splash)
RESUME PROCESS:C320(<>Splash)
  //inicialización de variables para el uso del corrector ortográfico
Spell_InitDefaults 
  //
  //  //instalación del gestionario de eventos por defecto
  //ON EVENT CALL("EVT_OnEventHandler";"$GestionDeEventos")


  // initialización y configuracion
XS_Init 
ST_LoadModuleFormatExceptions ("xShell")

<>toolBar:=0
<>onServer:=False:C215

SET ABOUT:C316("Acerca de "+<>vtXS_AppName;"XS_About")

dhXS_Startup 

KRL_UnloadAll 

  // proceso de monitoreo de tareas programadas
If (Application type:C494#4D Server:K5:6)
	BM_BatchTasksManager 
End if 



pCALL_BWR_StartBrowser (vlBWR_CurrentModuleRef)



  //If (Application version<"13000")
  //$err:=SR Set Script Callback (0;"SR_ExecuteScript")
$err:=SR Set Script Callback (0;"SRdh_ExecuteScript")  //20170509 RCH
  //End if 

dhXS_StartApplicationProcesses 

If (Application type:C494=4D Local mode:K5:1)
	  // obtengo estadísticas sobre el arhivo de datos actual (se actualizan todos los días en dhBM_EndOfTheDayTasks)
	  //$p:=New process("CIM_GetDatabaseStats";64000;"CIM_GetDatabaseStats")
End if 


$position:=Find in array:C230(<>alXS_ModuleRef;vlBWR_CurrentModuleRef)
BRING TO FRONT:C326(<>alXS_ModuleProcessID{$Position})





