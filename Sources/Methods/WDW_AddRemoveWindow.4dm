//%attributes = {}
  //WDW_AddRemoveWindow

C_TEXT:C284($1;$3;$4;$selector;$windowTitle;$processMethod)
C_LONGINT:C283($windowID;$2)


$selector:=$1
$windowID:=$2

Case of 
	: (Count parameters:C259=3)
		$windowTitle:=$3
	: (Count parameters:C259=4)
		$windowTitle:=$3
		$processMethod:=$4
End case 

$Menus:=Count menus:C404
For ($i;1;$menus)
	$menuTitle:=Get menu title:C430($i)
	If (($menuTitle="Windows") | ($menuTitle="Ventanas") | ($menuTitle="Fenêtres") | ($menuTitle="Finestre") | ($menuTitle="Janelas") | ($menuTitle="Fenster"))
		$windowMenu:=$i
		$i:=$menus
	End if 
End for 


If ($windowTitle="")
	$windowTitle:=Replace string:C233(Replace string:C233(Get window title:C450($windowID);"(";"");")";"")
End if 
Case of 
	: ($selector="Add")
		$pos:=Find in array:C230(<>atXS_OpenWindows;$windowTitle)
		If ($pos=-1)
			$pos:=Size of array:C274(<>alXS_OpenWindows)+1
			AT_Insert ($pos;1;-><>alXS_OpenWindows;-><>atXS_OpenWindows;-><>alXS_OpenWindowsProcessID;-><>atXS_ProcessMethod;-><>atXS_ProcessName)
		End if 
		PROCESS PROPERTIES:C336(Current process:C322;$processName;$processState;$processTime)
		<>alXS_OpenWindows{$pos}:=$windowID
		<>atXS_OpenWindows{$pos}:=$windowTitle
		<>alXS_OpenWindowsProcessID{$pos}:=Current process:C322
		<>atXS_ProcessMethod{$pos}:=$processMethod
		<>atXS_ProcessName{$pos}:=$processName
	: ($selector="Remove")
		$pos:=Find in array:C230(<>atXS_OpenWindows;$windowTitle)
		If ($pos>0)
			AT_Delete ($pos;1;-><>alXS_OpenWindows;-><>atXS_OpenWindows;-><>alXS_OpenWindowsProcessID;-><>atXS_ProcessMethod;-><>atXS_ProcessName)
			$Items:=Count menu items:C405($windowMenu)
			For ($i;1;$items)
				$itemText:=Get menu item:C422($windowMenu;$i)
				If ($itemText=<>atXS_OpenWindows{$pos})
					DELETE MENU ITEM:C413($windowMenu;$pos)
					$i:=$items
				End if 
			End for 
		End if 
End case 
<>vtXS_WindowsMenu:=AT_array2text (-><>atXS_OpenWindows;";")
