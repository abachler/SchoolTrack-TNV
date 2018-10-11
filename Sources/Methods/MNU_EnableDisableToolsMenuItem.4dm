//%attributes = {}
  //MNU_EnableDisableToolsMenuItem

$Menu:=4
$MenuItem:=$1

If ($MenuItem>0)
	ENABLE MENU ITEM:C149($Menu;$MenuItem)
	abXS_ToolMenuItemsState{$MenuItem}:=True:C214
Else 
	DISABLE MENU ITEM:C150($Menu;Abs:C99($MenuItem))
	abXS_ToolMenuItemsState{Abs:C99($MenuItem)}:=False:C215
End if 