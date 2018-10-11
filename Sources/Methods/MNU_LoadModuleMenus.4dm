//%attributes = {}
  //MNU_LoadModuleMenus

C_LONGINT:C283(hl_Servicesmenu;hl_Assistants)
ARRAY TEXT:C222(atXS_AssistantsItems;0)
ARRAY TEXT:C222(atXS_AssistantsMethods;0)
ARRAY TEXT:C222(atXS_ServicesMenuItems;0)
ARRAY TEXT:C222(atXS_ServicesMethods;0)
ARRAY LONGINT:C221(alXS_MenuItemIcons;0)
ARRAY BOOLEAN:C223(abXS_ToolMenuItemsState;0)

  // Herramientas de la aplicación
QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Class:1;=;"ToolsMenuItem";*)
QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]ModuleRef:8;=<>vlXS_CurrentModuleRef;*)
QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6;=<>vtXS_CountryCode;*)
QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7;=<>vtXS_langage)
ORDER BY:C49([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Order:11;>;[XShell_ExecutableObjects:280]Object_Alias:5)

SELECTION TO ARRAY:C260([XShell_ExecutableObjects:280]Object_Alias:5;atXS_ServicesMenuItems;[XShell_ExecutableObjects:280]Object_MethodName:3;atXS_ServicesMethods;[XShell_ExecutableObjects:280]MenuIconRef:15;alXS_MenuItemIcons)
$MenuItems:=Size of array:C274(atXS_ServicesMenuItems)
ARRAY BOOLEAN:C223(abXS_ToolMenuItemsState;$MenuItems)
For ($i;1;$menuItems)
	If (Substring:C12(atXS_ServicesMenuItems{$i};1;1)="(")
		abXS_ToolMenuItemsState{$i}:=False:C215
	Else 
		abXS_ToolMenuItemsState{$i}:=True:C214
	End if 
End for 


  // Asistentes de la aplicación
QUERY:C277([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Class:1;=;"Wizard";*)
QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]ModuleRef:8;=<>vlXS_CurrentModuleRef;*)
QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]CountryCode:6;=<>vtXS_CountryCode;*)
QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]LangageCode:7;=<>vtXS_langage)
ORDER BY:C49([XShell_ExecutableObjects:280];[XShell_ExecutableObjects:280]Order:11;>;[XShell_ExecutableObjects:280]Object_Alias:5)

SELECTION TO ARRAY:C260([XShell_ExecutableObjects:280]Object_Alias:5;atXS_AssistantsItems;[XShell_ExecutableObjects:280]Object_MethodName:3;atXS_AssistantsMethods;[XShell_ExecutableObjects:280]MenuIconRef:15;atXS_AssistantsItemsIconRef)
