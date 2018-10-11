//%attributes = {}
  //MNU_SetApplicationMenu

$modules:=Load list:C383("XS_Modules")
$items:=Count list items:C380($modules)
If ($items>1)
	APPEND MENU ITEM:C411(5;"(-";Current process:C322)
	For ($i;1;$items)
		GET LIST ITEM:C378($modules;$i;$itemRef;$itemText)
		APPEND MENU ITEM:C411(5;$itemText;Current process:C322)
		SET MENU ITEM METHOD:C982(5;-1;"MNU_Modulos")
		SET MENU ITEM PARAMETER:C1004(5;-1;String:C10($itemRef))
	End for 
End if 

