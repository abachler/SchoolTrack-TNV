//%attributes = {}
  //USR_UserLogin

If (False:C215)
	  // Project method: XSug_UserLogin
	  // Module: 
	  // Purpose:
	  // Syntax: XSug_UserLogin()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 7/1/02  17:19, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================
C_LONGINT:C283($l_refmodulo;$l_estilos;$l_refIcono)
C_BOOLEAN:C305($b_editable)
C_PICTURE:C286(vpXS_IconModule1;vpXS_IconModule2;vpXS_IconModule3;vpXS_IconModule4;vpXS_IconModule5;vpXS_IconModule6;vpXS_IconModule7;vpXS_IconModule8;vpXS_IconModule9;vpXS_IconModule10;vpXS_IconModule11;vpXS_IconModule12)
C_TEXT:C284($t_nombreModulo;vsXS_ModuleName1;vsXS_ModuleName2;vsXS_ModuleName3;vsXS_ModuleName4;vsXS_ModuleName5;vsXS_ModuleName6;vsXS_ModuleName7;vsXS_ModuleName8;vsXS_ModuleName9;vsXS_ModuleName10;vsXS_ModuleName11;vsXS_ModuleName12)
C_TEXT:C284(<>RegisteredName)


  // INITIALIZATION
  // ============================================
hl_modules:=Load list:C383("XS_Modules")

  // MAIN CODE
  // ============================================

For ($i;1;12)
	$y_iconoModulo:=Get pointer:C304("vpXS_IconModule"+String:C10($i))
	$y_nombreModulo:=Get pointer:C304("vsXS_ModuleName"+String:C10($i))
	$y_iconoModulo->:=$y_iconoModulo->*0
	$y_nombreModulo->:=""
	If ($i<=Count list items:C380(hl_modules))
		GET LIST ITEM:C378(hl_modules;$i;$l_refmodulo;$t_nombreModulo)
		GET LIST ITEM PROPERTIES:C631(hl_modules;$l_refmodulo;$b_editable;$l_estilos;$l_refIcono)
		$y_nombreModulo->:=$t_nombreModulo
		$l_refIcono:=$l_refIcono-Use PicRef:K28:4
		GET PICTURE FROM LIBRARY:C565($l_refIcono;$y_iconoModulo->)
	Else 
	End if 
End for 
<>RegisteredName:=""


vb_ReloadLogin:=False:C215
READ ONLY:C145([xShell_UserGroups:17])
READ ONLY:C145([xShell_Users:47])
WDW_OpenFormWindow (->[xShell_Users:47];"Login";-2;8;__ ("Acceso");"WDW_CloseDlog")
DIALOG:C40([xShell_Users:47];"Login")
CLOSE WINDOW:C154
While (vb_ReloadLogin)
	WDW_OpenFormWindow (->[xShell_Users:47];"Login";-2;8;__ ("Acceso");"WDW_CloseDlog")
	DIALOG:C40([xShell_Users:47];"Login")
	CLOSE WINDOW:C154
End while 

If (ok=1)
	If (<>lUSR_CurrentUserID>0)
		Case of 
			: (([xShell_Users:47]Nb_sesions:8=0) & ([xShell_Users:47]CambiarPassw_PrimeraSesion:25))
				$t_mensajeCambioPassw:=__ ("Es la primera vez que inicia sesión en SchoolTrack.\rPor favor establezca su nueva contraseña.")
				
			: ([xShell_Users:47]CambiarPassw_proximaSesion:26)
				$t_mensajeCambioPassw:=__ ("El administrador de SchoolTrack solicita que cambie contraseña.\rPor favor establezca su nueva contraseña.")
				
			: ((<>dUSR_ExpiresOn>!00-00-00!) & (Current date:C33>=<>dUSR_ExpiresOn))
				$t_mensajeCambioPassw:=__ ("Su contraseña expiró el ^0 \rPor favor establezca su nueva contraseña.")
				$t_mensajeCambioPassw:=Replace string:C233($t_mensajeCambioPassw;"^0";String:C10(<>dUSR_ExpiresOn;7))
			Else 
				$t_mensajeCambioPassw:=""
		End case 
		If ($t_mensajeCambioPassw#"")
			USR_ChangePassword ($t_mensajeCambioPassw)
			If (ok=0)
				QUIT 4D:C291
			End if 
		End if 
	End if 
	
	$0:=<>lUSR_CurrentUserID
	<>RegisteredName:=Substring:C12(String:C10(Connected+1)+" "+String:C10(<>lUSR_CurrentUserID)+" "+<>tUSR_CurrentUser;1;31)
	<>vlXS_SpecialAuthCount:=0  //reseteamos contador de intentos de ingreso de clave de administrador para USR_EmergencyUser
	REGISTER CLIENT:C648(<>RegisteredName)
	SYS_SaveMachineInfos 
	USR_RegisterConnection (<>lUSR_CurrentUserID;<>tUSR_CurrentUser;<>tUSR_CurrentUserName;Current machine:C483;<>RegisteredName)
	USR_QuitOnTimeout 
Else 
	$0:=0
End if 

KRL_ReloadAsReadOnly (->[xShell_UserGroups:17])
KRL_ReloadAsReadOnly (->[xShell_Users:47])

CLEAR LIST:C377(hl_modules)