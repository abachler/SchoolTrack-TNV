//%attributes = {}
  //MNU_SetWindowMenuItemMark

$windowID:=$1
$pos:=Find in array:C230(<>alXS_OpenWindows;$windowID)
$pos1:=$pos
If ($pos>0)
	For ($i;1;Count menu items:C405(7))
		SET MENU ITEM MARK:C208(7;$i;"";<>alXS_OpenWindowsProcessID{$pos})
	End for 
	If ((<>lUSR_CurrentUserID>-99) & (<>lUSR_CurrentUserID<0))
		$pos1:=$pos1+13
	Else 
		$pos1:=$pos1+8
	End if 
	SET MENU ITEM MARK:C208(7;$pos1;Char:C90(18);<>alXS_OpenWindowsProcessID{$pos})
End if 