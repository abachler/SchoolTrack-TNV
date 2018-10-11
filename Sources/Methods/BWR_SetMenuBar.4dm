//%attributes = {}
  // BWR_SetMenuBar()
  // Por: Alberto Bachler K.: 31-08-15, 09:48:51
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TEXT:C284(vmref_wizardsSubMenuRef)

ARRAY TEXT:C222(atMNU_ModuleReferencesMenus;0)

MNU_LoadModuleMenus 
MNU_SetMenuBar ("XS_Browser";Current process:C322)
BWR_SetSelectionDependantItems 
MNU_SetMenuItemState (False:C215;1;5;2;13;2;14;2;15;2;16)

If (Application type:C494=4D Remote mode:K5:5)
	APPEND MENU ITEM:C411(1;"(-")
	APPEND MENU ITEM:C411(1;"Reiniciar esta aplicación")
	SET MENU ITEM METHOD:C982(1;-1;"MNU_ReiniciaAplicacion")
	APPEND MENU ITEM:C411(1;"Reiniciar servidor SchoolTrack…")
	SET MENU ITEM METHOD:C982(1;-1;"MNU_ReiniciarServidor")
	If (Not:C34(USR_IsGroupMember_by_GrpID (-15001;USR_GetUserID )))
		DISABLE MENU ITEM:C150(1;-1)
	End if 
Else 
	APPEND MENU ITEM:C411(1;"(-")
	APPEND MENU ITEM:C411(1;"Reiniciar esta aplicación")
	SET MENU ITEM METHOD:C982(1;-1;"MNU_ReiniciaAplicacion")
End if 

If (Not:C34(USR_IsGroupMember_by_GrpID (-15001;USR_GetUserID )))
	DISABLE MENU ITEM:C150(1;8)
End if 


  // menú Herramientas (4)
MNU_SetFromTextArray (4;->atXS_ServicesMenuItems;->atXS_ServicesMethods;->alXS_MenuItemIcons)
APPEND MENU ITEM:C411(4;"(-")
APPEND MENU ITEM:C411(4;"TransportTrack")
SET MENU ITEM METHOD:C982(4;-1;"MNU_TransportTrack")

  //submenu asistentes
If (vmref_wizardsSubMenuRef#"")
	RELEASE MENU:C978(vmref_wizardsSubMenuRef)
End if 
vmref_wizardsSubMenuRef:=Create menu:C408
For ($i;1;Size of array:C274(atXS_AssistantsItems))
	APPEND MENU ITEM:C411(vmref_wizardsSubMenuRef;atXS_AssistantsItems{$i})
	SET MENU ITEM METHOD:C982(vmref_wizardsSubMenuRef;-1;atXS_AssistantsMethods{$i})
End for 
APPEND MENU ITEM:C411(4;"(-")
APPEND MENU ITEM:C411(4;__ ("Asistentes");vmref_wizardsSubMenuRef;Current process:C322)

APPEND MENU ITEM:C411(4;__ ("Ejecutar..."))
SET MENU ITEM METHOD:C982(4;-1;"MNU_Execute")
MNU_SetMenuItemState ((Size of array:C274(atXS_AssistantsItems)>0);4;Size of array:C274(atXS_ServicesMenuItems)+2)



MNU_SetApplicationMenu 
MNU_Servicios 
dhBWR_BuildProyectSubMenu 
dhBWR_BuildCommandsPopup 


  // menu Ventanas
MNU_WindowsMenu 
MNU_SetMenuItemState ((Application type:C494=4D Remote mode:K5:5);7;3)  //La mensajeria solo esta activa si estamos en red
  //MNU_SetMenuItemState ((Application type=4D Remote mode);7;4)  //20180717 RCH Habilito solo para grupo administración.. se maneja en MNU_WindowsMenu. Ticket 205461.


  // menu Desarrollo
MNU_CreateDevSubMenu 



dhBWR_SetMenuBar 

PLT_LoadIcons 