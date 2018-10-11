//%attributes = {}
  //MNU_SetFromTextArray


  // ----------------------------------------------------
  // Usuario (SO): Alberto Bachler
  // Fecha y hora: 01/10/09, 18:35:28
  // ----------------------------------------------------
  // Método: MNU_SetFromTextArray
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($item;$menuItemName;$menuItemShortcut;$method)
C_LONGINT:C283($modifiers;$keyCode)
C_BOOLEAN:C305($isShortCutAvailable)
C_POINTER:C301($y_aitemIconRef;$yMenuItemsName)
$menu:=$1
$yMenuItemsName:=$2
$yMenuItemsMethods:=$3
If (Count parameters:C259=4)
	$y_aitemIconRef:=$4
End if 

If (Application version:C493>="11@")
	For ($i;1;Size of array:C274($yMenuItemsName->))
		$item:=ST_GetWord ($yMenuItemsName->{$i};1;";")
		$menuItemName:=ST_GetWord ($item;1;"/")
		$menuItemShortcut:=ST_GetWord ($item;2;"/")
		$method:=$yMenuItemsMethods->{$i}
		$isShortCutAvailable:=True:C214
		$keyCode:=0
		If ($menuItemShortcut#"")
			If (Length:C16($menuItemShortcut)=1)
				$modifiers:=Command key mask:K16:1
				$key:=$menuItemShortcut
			Else 
				$key:=$menuItemShortcut[[Length:C16($menuItemShortcut)]]
				$modifers:=(Shift key mask:K16:3*Position:C15("^";$menuItemShortcut))+(Option key mask:K16:7*Position:C15("~";$menuItemShortcut))
			End if 
			$keyCode:=Character code:C91($key)
			$isShortCutAvailable:=MNU_IsSchortcutAvailable ($keyCode;$modifiers)
		End if 
		
		$menuItem:=$yMenuItemsName->{$i}
		If ($menuItem="-")
			$menuItem:="(-"
		End if 
		APPEND MENU ITEM:C411(4;$menuItem)
		
		If (Not:C34(Is nil pointer:C315($y_aitemIconRef)))
			$icon:=$y_aitemIconRef->{$i}
			If ($icon#0)
				  //SET MENU ITEM ICON($menu;$i;$icon)
			Else 
				  //SET MENU ITEM ICON($menu;$i;17611)
			End if 
		End if 
		SET MENU ITEM METHOD:C982($menu;-1;$method)
		If (($isShortCutAvailable) & ($keyCode>0))
			SET MENU ITEM SHORTCUT:C423($menu;-1;$keyCode;$modifiers)
		Else 
			SET MENU ITEM SHORTCUT:C423($menu;-1;0)
		End if 
	End for 
Else 
	$toolsMenuItems:=AT_array2text ($yMenuItemsName;";")
	$toolsMenuItems:=Replace string:C233($toolsMenuItems;"^";"")
	$toolsMenuItems:=Replace string:C233($toolsMenuItems;"~";"")
	If ($toolsMenuItems="")
		DISABLE MENU ITEM:C150($menu;0;Current process:C322)
	Else 
		APPEND MENU ITEM:C411($menu;$toolsMenuItems;Current process:C322)
	End if 
End if 


