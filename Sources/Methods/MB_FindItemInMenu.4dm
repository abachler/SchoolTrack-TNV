//%attributes = {}
  // MÉTODO: MB_FindItemInMenu
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 20/02/12, 15:03:52
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MB_FindItemInMenu()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_LONGINT:C283($l_menuNumber;$l_processNumber)
C_TEXT:C284($t_menuItemTitle)

ARRAY TEXT:C222($at_menuItems;0)
If (False:C215)
	C_LONGINT:C283(MB_FindItemInMenu ;$1)
	C_TEXT:C284(MB_FindItemInMenu ;$2)
	C_LONGINT:C283(MB_FindItemInMenu ;$3)
End if 

$l_menuNumber:=$1
$t_menuItemTitle:=$2

If (Count parameters:C259=3)
	$l_processNumber:=$3
End if 

If ($l_processNumber=0)
	$l_processNumber:=Frontmost process:C327
End if 

  // CODIGO PRINCIPAL
MB_GetMenuItemList ($l_menuNumber;->$at_menuItems;$l_processNumber)
$0:=Find in array:C230($at_menuItems;$t_menuItemTitle)