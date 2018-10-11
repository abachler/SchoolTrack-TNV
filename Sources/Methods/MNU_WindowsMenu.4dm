//%attributes = {}
  // Método: MNU_WindowsMenu
  //
  //
  // por Alberto Bachler Klein
  // creación 27/05/17, 11:16:04
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($i;$l_activeWindowInMenu;$l_connectedUsers;$l_designProcessNumber;$l_itemUsuariosConectados;$l_maxUsers;$l_serial;$l_windowsMenuId;$l_winProc;$l_administracion)
C_TEXT:C284($t_currentuser;$t_MenuBarRef;$t_organization;$t_windowTitle;$t_winTitle)

ARRAY LONGINT:C221($al_WindowProcess;0)
ARRAY LONGINT:C221($al_WindowRefs;0)
ARRAY TEXT:C222($at_WindowTitles;0)

C_TEXT:C284(vtMNU_DevelopperMenu)
C_TEXT:C284(<>t_defaultMenuBarRef)


  // CODIGO PRINCIPAL

$t_MenuBarRef:=Get menu bar reference:C979  //obtengo la referencia de la barra de menu actual


  //si no hay barra de menu asociada al proceso en ejecución
  //creo una barra de menu por defecto
If ($t_MenuBarRef="")
	MNU_SetDefaultMenuBar 
End if 
  //

$l_windowsMenuId:=MB_FindMenuInMenuBar (__ ("Ventanas"))


  // obtengo el ID de los procesos diseño y aplicación para evitar agregar al menú las ventanas de esos procesos ventanas
  // los nombres de las ventanas que puedan estar abiertas en el proceso diseño
$l_designProcessNumber:=Process number:C372("Proceso Diseño")
If ($l_designProcessNumber<=0)
	$l_designProcessNumber:=Process number:C372("Design Process")
End if 



WINDOW LIST:C442($al_WindowRefs)  // obtengo la lista de ventanas actuales

  // inicializo los arreglos para referenciar las ventanas abiertas y válidas
For ($i;Size of array:C274($al_WindowRefs);1;-1)
	$t_winTitle:=Get window title:C450($al_WindowRefs{$i})
	$l_winProc:=Window process:C446($al_WindowRefs{$i})
	If (($l_winProc=$l_designProcessNumber) | ($l_winProc=1))  // si la ventana referenciada está abierta en el proceso diseño o en el proceso aplicacion la excluyo de la lista
		DELETE FROM ARRAY:C228($al_WindowRefs;$i)
	Else 
		APPEND TO ARRAY:C911($at_WindowTitles;$t_winTitle)
		APPEND TO ARRAY:C911($al_WindowProcess;$l_winProc)
	End if 
End for 
SORT ARRAY:C229($at_WindowTitles;$al_WindowRefs;$al_WindowProcess;>)  // ordeno alfabéticamente los items del menu ventanas (exceptuando los items por defecto)



  // agrego al menu ventanas las ventanas válidas
If (Size of array:C274($at_WindowTitles)>0)
	APPEND MENU ITEM:C411($l_windowsMenuID;"-")
	For ($i;1;Size of array:C274($at_WindowTitles))
		If (($al_WindowProcess#Current process:C322) & (MB_FindItemInMenu ($l_windowsMenuID;$at_WindowTitles{$i})=-1))
			APPEND MENU ITEM:C411($l_windowsMenuID;$at_WindowTitles{$i};"";Current process:C322;*)  // agrego eltítulo de la ventana...
			SET MENU ITEM METHOD:C982($l_windowsMenuID;-1;"BWR_BringWindowToFront")  // ...el método de activación de la ventana
			SET MENU ITEM PARAMETER:C1004($l_windowsMenuID;-1;String:C10($al_WindowRefs{$i})+"."+String:C10($al_WindowProcess{$i}))  // ...la referencia de la ventana y el ID del proceso
		End if 
	End for 
	$t_windowTitle:=Get window title:C450(Frontmost window:C447)
	$l_activeWindowInMenu:=MB_FindItemInMenu (MB_FindMenuInMenuBar (__ ("Ventanas"));$t_windowTitle)
	SET MENU ITEM MARK:C208($l_windowsMenuID;$l_activeWindowInMenu;Char:C90(18))
End if 





  // menu item usuarios conectados se inactiva en monousuario o con un solo usuario conectado
$l_itemUsuariosConectados:=MB_FindItemInMenu (MB_FindMenuInMenuBar (__ ("Ventanas"));__ ("Usuarios conectados"))
GET SERIAL INFORMATION:C696($l_serial;$t_currentuser;$t_organization;$l_connectedUsers;$l_maxUsers)
If ($l_connectedUsers<1)
	DISABLE MENU ITEM:C150($l_windowsMenuId;$l_itemUsuariosConectados)
End if 

  //20180717 RCH Habilito solo para grupo administración y en cliente. Ticket 205461
$l_administracion:=MB_FindItemInMenu (MB_FindMenuInMenuBar (__ ("Ventanas"));__ ("Administración del servidor…"))
If ((Not:C34(USR_IsGroupMember_by_GrpID (-15001))) | (Application type:C494#4D Remote mode:K5:5))
	DISABLE MENU ITEM:C150($l_windowsMenuId;$l_administracion)
End if 

  //ENABLE MENU ITEM(7;8)
