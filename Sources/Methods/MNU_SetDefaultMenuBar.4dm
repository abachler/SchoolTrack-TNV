//%attributes = {}
  // MÉTODO: MNU_SetDefaultMenuBar
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 23/02/12, 15:21:51
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // MNU_CreateDefaultMenuBar()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284(<>t_defaultMenuBarRef;<>t_defaultFileMenu;<>t_defaultEditMenu;<>t_defaultWindowsMenu;$t_MenuBarRef)


  // CODIGO PRINCIPAL

  //obtengo la referencia de la barra de menu actual
$t_MenuBarRef:=Get menu bar reference:C979

  //si no hay barra de menu asociada al proceso en ejecución
  //creo una barra de menu por defecto 
  //If ($t_MenuBarRef="")
  //<>t_defaultMenuBarRef:=Create menu
  //End if 
  //
  //$l_windowsMenuId:=MB_FindMenuInMenuBar (__ ("Ventanas"))
  //If ($l_windowsMenuId=-1)

RELEASE MENU:C978(<>t_defaultMenuBarRef)
RELEASE MENU:C978(<>t_defaultFileMenu)
RELEASE MENU:C978(<>t_defaultEditMenu)
RELEASE MENU:C978(<>t_defaultWindowsMenu)

<>t_defaultMenuBarRef:=""
<>t_defaultFileMenu:=""
<>t_defaultEditMenu:=""
<>t_defaultWindowsMenu:=""

SET MENU BAR:C67("XS_Browser")


$t_MenuBarRef:=Get menu bar reference:C979
If ($t_MenuBarRef="")
	
	
	If (<>t_defaultMenuBarRef="")
		<>t_defaultMenuBarRef:=Create menu:C408
		
		
		
		
		  // creación del menu Archivo
		<>t_defaultFileMenu:=Create menu:C408
		APPEND MENU ITEM:C411(<>t_defaultMenuBarRef;__ ("Archivo");<>t_defaultFileMenu)
		APPEND MENU ITEM:C411(<>t_defaultFileMenu;__ ("(Nuevo/n"))
		APPEND MENU ITEM:C411(<>t_defaultFileMenu;__ ("(Abrir/O"))
		APPEND MENU ITEM:C411(<>t_defaultFileMenu;"-")
		APPEND MENU ITEM:C411(<>t_defaultFileMenu;__ ("Cerrar/W"))
		SET MENU ITEM METHOD:C982(<>t_defaultFileMenu;-1;"WDW_CloseDlog")
		APPEND MENU ITEM:C411(<>t_defaultFileMenu;"-")
		APPEND MENU ITEM:C411(<>t_defaultFileMenu;"(Salir/Q")
		
		
		
		
		
		  // creación del menu Edición
		<>t_defaultEditMenu:=Create menu:C408
		APPEND MENU ITEM:C411(<>t_defaultMenuBarRef;__ ("Edición");<>t_defaultEditMenu)
		
		APPEND MENU ITEM:C411(<>t_defaultEditMenu;__ ("(Deshacer/z"))  // L1 - undo
		SET MENU ITEM PROPERTY:C973(<>t_defaultEditMenu;-1;Associated standard action:K56:1;_o_Undo action:K59:16)
		APPEND MENU ITEM:C411(<>t_defaultEditMenu;"-")
		
		APPEND MENU ITEM:C411(<>t_defaultEditMenu;__ ("Cortar/x"))  // L3 - cut
		SET MENU ITEM PROPERTY:C973(<>t_defaultEditMenu;-1;Associated standard action:K56:1;_o_Cut action:K59:18)
		
		APPEND MENU ITEM:C411(<>t_defaultEditMenu;__ ("Copiar/c"))  // L5 - copy
		SET MENU ITEM PROPERTY:C973(<>t_defaultEditMenu;-1;Associated standard action:K56:1;_o_Copy action:K59:19)
		
		APPEND MENU ITEM:C411(<>t_defaultEditMenu;__ ("Pegar/v"))  // L6 - paste 
		SET MENU ITEM PROPERTY:C973(<>t_defaultEditMenu;-1;Associated standard action:K56:1;_o_Paste action:K59:20)
		
		APPEND MENU ITEM:C411(<>t_defaultEditMenu;__ ("Borrar"))  // L7 - clear
		SET MENU ITEM PROPERTY:C973(<>t_defaultEditMenu;-1;Associated standard action:K56:1;_o_Clear action:K59:21)
		
		APPEND MENU ITEM:C411(<>t_defaultEditMenu;__ ("Seleccionar todo/a"))  // L8 - Select All
		SET MENU ITEM PROPERTY:C973(<>t_defaultEditMenu;-1;Associated standard action:K56:1;_o_Select all action:K59:22)
		
		APPEND MENU ITEM:C411(<>t_defaultEditMenu;"-")
		
		APPEND MENU ITEM:C411(<>t_defaultEditMenu;__ ("Mostrar portapapeles"))  //L9 - show clipboard
		SET MENU ITEM PROPERTY:C973(<>t_defaultEditMenu;-1;Associated standard action:K56:1;_o_Show clipboard action:K59:23)
		
		APPEND MENU ITEM:C411(<>t_defaultEditMenu;"-")
		
		APPEND MENU ITEM:C411(<>t_defaultEditMenu;__ ("Corrector ortográfico"))  //L10 - spellchecker
		SET MENU ITEM METHOD:C982(<>t_defaultEditMenu;-1;"SPELL_SpellCheckPreferences")
		
		
		
		
		  //  Creación del menú Ventanas
		<>t_defaultWindowsMenu:=Create menu:C408
		APPEND MENU ITEM:C411(<>t_defaultMenuBarRef;__ ("Ventanas");<>t_defaultWindowsMenu)
		
		APPEND MENU ITEM:C411(<>t_defaultWindowsMenu;__ ("Información de procesos"))  // menu procesos
		SET MENU ITEM METHOD:C982(<>t_defaultWindowsMenu;-1;"MNU_ShowProcessesInfos")
		SET MENU ITEM SHORTCUT:C423(<>t_defaultWindowsMenu;-1;"p";Command key mask:K16:1+Option key mask:K16:7)
		
		APPEND MENU ITEM:C411(<>t_defaultWindowsMenu;__ ("Tareas programadas"))  // menu tareas programadas
		SET MENU ITEM METHOD:C982(<>t_defaultWindowsMenu;-1;"BM_BatchTasksManager")
		SET MENU ITEM SHORTCUT:C423(<>t_defaultWindowsMenu;-1;"t";Command key mask:K16:1+Option key mask:K16:7)
		
		GET SERIAL INFORMATION:C696($l_serial;$t_currentuser;$t_organization;$l_connectedUsers;$l_maxUsers)  // menu usuarios conectados
		If ($l_connectedUsers>1)
			APPEND MENU ITEM:C411(<>t_defaultWindowsMenu;__ ("Usuarios conectados"))
			SET MENU ITEM METHOD:C982(<>t_defaultWindowsMenu;-1;"MNU_InternalMsn")
			  //SET MENU ITEM SHORTCUT(<>t_defaultWindowsMenu;-1;"u";Command key mask+Option key mask)
		Else 
			APPEND MENU ITEM:C411(<>t_defaultWindowsMenu;__ ("(Usuarios conectados"))
			  //SET MENU ITEM SHORTCUT(<>t_defaultWindowsMenu;-1;"u";Command key mask+Option key mask)
		End if 
		
		APPEND MENU ITEM:C411(<>t_defaultWindowsMenu;__ ("Registro de actividades"))  // menu tareas programadas
		SET MENU ITEM METHOD:C982(<>t_defaultWindowsMenu;-1;"MNU_showlog")
		  //SET MENU ITEM SHORTCUT(<>t_defaultWindowsMenu;-1;"l";Command key mask+Option key mask)
		
		APPEND MENU ITEM:C411(<>t_defaultWindowsMenu;"-")
		
		APPEND MENU ITEM:C411(<>t_defaultWindowsMenu;__ ("Soporte"))  // menu Soporte
		SET MENU ITEM METHOD:C982(<>t_defaultWindowsMenu;-1;"MNU_Soporte")
		SET MENU ITEM SHORTCUT:C423(<>t_defaultWindowsMenu;-1;"?";Command key mask:K16:1+Shift key mask:K16:3)
		
		APPEND MENU ITEM:C411(<>t_defaultWindowsMenu;__ ("Manuales"))  // menu Manuales
		SET MENU ITEM METHOD:C982(<>t_defaultWindowsMenu;-1;"")
		  //SET MENU ITEM SHORTCUT(<>t_defaultWindowsMenu;-1;"d";Command key mask+Shift key mask)
		
		If ((<>lUSR_CurrentUserID>=-101) & (<>lUSR_CurrentUserID<0))
			If (vtMNU_DevelopperMenu="")
				MNU_CreateDevSubMenu 
			End if 
			APPEND MENU ITEM:C411(<>t_defaultWindowsMenu;"(-")
			APPEND MENU ITEM:C411(<>t_defaultWindowsMenu;"Editor de recursos")
			SET MENU ITEM SHORTCUT:C423(<>t_defaultWindowsMenu;-1;"R";Shift key mask:K16:3+Option key mask:K16:7+Command key mask:K16:1)
			SET MENU ITEM METHOD:C982(<>t_defaultWindowsMenu;-1;"MNU_ResourceEditor")
			
			APPEND MENU ITEM:C411(<>t_defaultWindowsMenu;"Editor de listas")
			SET MENU ITEM SHORTCUT:C423(<>t_defaultWindowsMenu;-1;"L";Shift key mask:K16:3+Option key mask:K16:7+Command key mask:K16:1)
			SET MENU ITEM METHOD:C982(<>t_defaultWindowsMenu;-1;"MNU_ListEditor")
			
			APPEND MENU ITEM:C411(<>t_defaultWindowsMenu;"Editor de metadatos")
			SET MENU ITEM SHORTCUT:C423(<>t_defaultWindowsMenu;-1;"M";Shift key mask:K16:3+Command key mask:K16:1)
			SET MENU ITEM METHOD:C982(<>t_defaultWindowsMenu;-1;"MDATA_Configuracion")
			
			APPEND MENU ITEM:C411(<>t_defaultWindowsMenu;"(-")
			APPEND MENU ITEM:C411(<>t_defaultWindowsMenu;"Entorno diseño";vtMNU_DevelopperMenu)
		Else 
			  //APPEND MENU ITEM(<>t_defaultWindowsMenu;"(-")
		End if 
		
	End if 
	
	
	SET MENU BAR:C67(<>t_defaultMenuBarRef)
End if 

DISABLE MENU ITEM:C150(2;13)
DISABLE MENU ITEM:C150(2;14)
DISABLE MENU ITEM:C150(2;15)
DISABLE MENU ITEM:C150(2;16)
DISABLE MENU ITEM:C150(2;18)

DISABLE MENU ITEM:C150(3;0)

APPEND MENU ITEM:C411(4;__ ("Asistentes"))
APPEND MENU ITEM:C411(4;__ ("Ejecutar"))

DISABLE MENU ITEM:C150(4;0)


