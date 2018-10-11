//%attributes = {}
  //MNU_IsSchortcutAvailable


  // ----------------------------------------------------
  // Usuario (SO): Alberto Bachler
  // Fecha y hora: 01/10/09, 19:04:11
  // ----------------------------------------------------
  // Método: MNU_IsSchortcutAvailable (sólo para v11)
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

$key:=$1
$modifiers:=$2
If ($modifiers=256)
	$modifiers:=0
End if 

$0:=True:C214

$menus:=Count menus:C404
For ($iMenus;1;$menus)
	$items:=Count menu items:C405($iMenus)
	For ($iItems;1;$items)
		$itemKey:=Get menu item key:C424($iMenus;$iItems)
		$itemModifiers:=Get menu item modifiers:C980($iMenus;$iItems)
		If (($itemKey=$key) & ($itemModifiers=$modifiers))
			$iItems:=$items
			$iMenus:=$menus
			$0:=False:C215
		End if 
	End for 
End for 

If ($0)
	$menus:=Size of array:C274(atMNU_ModuleReferencesMenus)
	For ($iMenus;1;Size of array:C274(atMNU_ModuleReferencesMenus))
		$items:=Count menu items:C405(atMNU_ModuleReferencesMenus{$iMenus})
		For ($iItems;1;$items)
			$itemKey:=Get menu item key:C424(atMNU_ModuleReferencesMenus{$iMenus};$iItems)
			$itemModifiers:=Get menu item modifiers:C980(atMNU_ModuleReferencesMenus{$iMenus};$iItems)
			If ($itemModifiers=256)
				$itemModifiers:=0
			End if 
			If (($itemKey=$key) & ($itemModifiers=$modifiers))
				$iItems:=$items
				$iMenus:=$menus
				$0:=False:C215
			End if 
		End for 
	End for 
End if 