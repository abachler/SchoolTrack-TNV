//%attributes = {}
  // BWR_StartBrowser()
  // Por: Alberto Bachler: 09/03/13, 14:14:04
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($b_continuar)
C_LONGINT:C283($l_IdProcesoNoticiasDT;$l_IdProcesoVerifActualizacion;$l_Posicion)

If (False:C215)
	C_LONGINT:C283(BWR_StartBrowser ;$1)
	C_TEXT:C284(BWR_StartBrowser ;$2)
End if 


C_LONGINT:C283(vlBWR_CurrentModuleRef)
C_LONGINT:C283(xALP_Browser;vlBWR_ALPColumns)
C_TEXT:C284(vsBWR_CurrentModule)
C_LONGINT:C283(vlXS_BrowserWindowID)
ARRAY TEXT:C222(atQR_FormReportNames;0)
ARRAY POINTER:C280(ayBWR_FieldPointers;0)
ARRAY POINTER:C280(ayBWR_ArrayPointers;0)
ARRAY TEXT:C222(atBWR_ArrayNames;0)




KRL_UnloadAll 
MNU_CreateDevSubMenu 

XSvs_LocalizaEstructura 
VS_LoadAutoFormatRefs 

vsBWR_CurrentModule:=$2
vlBWR_CurrentModuleRef:=$1
GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)
GET PICTURE FROM LIBRARY:C565("Config_Back_"+vsBWR_CurrentModule;vp_ModuleIconBack)
$b_continuar:=dhBWR_ModuleInitialisations (vsBWR_CurrentModule)
If ($b_continuar)
	PREF_Set (<>lUSR_CurrentUserID;"lastModule";String:C10(vlBWR_CurrentModuleRef))
	<>vsBWR_Module:=vsBWR_CurrentModule
	<>vlBWR_CurrentModuleRef:=vlBWR_CurrentModuleRef
	<>vlXS_CurrentModuleRef:=vlBWR_CurrentModuleRef
	<>vsXS_CurrentModule:=vsBWR_CurrentModule
	
	USR_RegisterUserEvent (UE_ModuleStart)
	
	MNU_LoadModuleMenus 
	<>iALEnterKey:=2
	BWR_DeclareArrays 
	
	<>DisplaySplash:=False:C215
	<>vThInicio:=100
	  //CALL PROCESS(-1)
	POST OUTSIDE CALL:C329(<>Splash)
	
	OK:=1
	vb_inBrowsingMode:=True:C214
	vlXS_BrowserWindowID:=WDW_OpenFormWindow (->[xShell_Dialogs:114];"xShellBrowser";2;8)
	
	  //$l_IdProcesoNoticiasDT:=New process("TS_ShowNewDocuments";Pila_256K;"TS_Alert")  //20160428 RCH No es compatible con la IN3. Por ahora se comenta según lo solicitado en el ticket 157604
	$l_IdProcesoVerifActualizacion:=New process:C317("UD_VerificaActualizacion";Pila_256K;"UD_VerificaActualizacion")
	
	BRING TO FRONT:C326(Current process:C322)
	DIALOG:C40([xShell_Dialogs:114];"xShellBrowser")
	CLOSE WINDOW:C154
	
Else 
	$l_Posicion:=Find in array:C230(<>alXS_ModuleRef;vlBWR_CurrentModuleRef)
	If ($l_Posicion>0)
		PCS_UnRegisterProcess (<>alXS_ModuleProcessID{$l_Posicion})
		<>alXS_ModuleProcessID{$l_Posicion}:=0
	End if 
End if 