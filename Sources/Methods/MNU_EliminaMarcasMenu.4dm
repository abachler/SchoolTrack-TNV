//%attributes = {}
  // MNU_EliminaMarcasMenu()
  // Por: Alberto Bachler: 01/10/13, 18:11:16
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

_O_C_INTEGER:C282($i_items)
C_TEXT:C284($t_refMenu)

If (False:C215)
	C_TEXT:C284(MNU_EliminaMarcasMenu ;$1)
End if 
$t_refMenu:=$1
For ($i_items;1;Count menu items:C405($t_refMenu))
	SET MENU ITEM MARK:C208($t_refMenu;$i_items;"")
End for 

