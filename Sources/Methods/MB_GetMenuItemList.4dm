//%attributes = {}
  // MÉTODO: MB_GetMenuItemList
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 20/02/12, 15:01:13
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MB_GetMenuItemList()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)

C_LONGINT:C283($i;$l_MenuNumber;$l_processNumber)
C_POINTER:C301($y_arrayMenuItems)
C_TEXT:C284($t_menuItemTitle)

If (False:C215)
	C_LONGINT:C283(MB_GetMenuItemList ;$1)
	C_POINTER:C301(MB_GetMenuItemList ;$2)
	C_LONGINT:C283(MB_GetMenuItemList ;$3)
End if 

  // CODIGO PRINCIPAL
$l_MenuNumber:=$1
$y_arrayMenuItems:=$2
If (Count parameters:C259=3)
	$l_processNumber:=$3
End if 

If ($l_processNumber=0)
	$l_processNumber:=Frontmost process:C327
End if 

For ($i;1;Count menu items:C405($l_MenuNumber;$l_processNumber))
	$t_menuItemTitle:=Get menu item:C422($l_MenuNumber;$i;$l_processNumber)
	APPEND TO ARRAY:C911($y_arrayMenuItems->;$t_menuItemTitle)
End for 