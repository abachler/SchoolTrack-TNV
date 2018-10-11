//%attributes = {}
  //XS_ServerStartup

  // INITIALIZATION
  // ============================================
C_BOOLEAN:C305($0;$vb_continuar)
<>vbUSR_Use4DSecurity:=False:C215
<>vi_ReservedOP:=Num:C11(PREF_fGet (0;"Reserved Licences";"0"))
<>Splash:=0  //En el server no hay splash screen
  // MAIN CODE
  // ============================================

<>vtXS_Langage:="es"
LOC_LoadFixedLocalizedStrings 

  //paths and various system informations
_O_PLATFORM PROPERTIES:C365(<>lXS_ServerPlatform)
LOG_RegisterEvt ("Inicio de SchoolTrack Server: SYS_Infos ejecutado.")

LICENCIA_ListaMacAddress 
LOG_RegisterEvt ("Inicio de SchoolTrack Server: DL_GetMacAddress ejecutado.")

SYS_OpenLangageResource (<>vtXS_langage)
LOG_RegisterEvt ("Inicio de SchoolTrack Server: SYS_OpenLangageResource ejecutado.")

SN3_SetControlVariable 
LOG_RegisterEvt ("Inicio de SchoolTrack Server: SN3_SetControlVariable ejecutado.")

  //initializing modules
xs_InitModules 
LOG_RegisterEvt ("Inicio de SchoolTrack Server: xs_InitModules ejecutado.")

  //initialize shell variables
XS_InitVariables 
LOG_RegisterEvt ("Inicio de SchoolTrack Server: XS_InitVariables ejecutado.")

WS_InitWebServicesVariables 
LOG_RegisterEvt ("Inicio de SchoolTrack Server: WS_InitWebServicesVariables ejecutado.")

$t_resultado:=LICENCIA_Descarga 
LOG_RegisterEvt ("Inicio de SchoolTrack Server: DL_INIT ejecutado.")

  // licencia
HLPR_xShell2ApplicationTables 
LOG_RegisterEvt ("Inicio de SchoolTrack Server: HLPR_xShell2ApplicationTables ejecutado.")

XS_MapeoTablas_AppColegio 
LOG_RegisterEvt ("Inicio de SchoolTrack Server: dhDL_AppFields2CustomFields ejecutado.")

XSusr_ListaSuperUsuarios_in 

XS_ReadCustomerData 
LOG_RegisterEvt ("Inicio de SchoolTrack Server: XS_ReadCustomerData ejecutado.")

STWA2_LoadPrefs 
  //getting app and data version and handling updates
  //SYS_READVERSION 
$vb_continuar:=SYS_READVERSION 
If ($vb_continuar)
	LOG_RegisterEvt ("Inicio de SchoolTrack Server: SYS_READVERSION ejecutado.")
	
	  //loading shell lists
	TBL_LoadListsArrays 
	LOG_RegisterEvt ("Inicio de SchoolTrack Server: TBL_LoadListsArrays ejecutado.")
	
	SYS_SaveMachineInfos 
	LOG_RegisterEvt ("Inicio de SchoolTrack Server: SYS_SaveMachineInfos ejecutado.")
	
Else 
	LOG_RegisterEvt ("Inicio de SchoolTrack Server: SYS_READVERSION cerró la aplicación.")
End if 
$0:=$vb_continuar