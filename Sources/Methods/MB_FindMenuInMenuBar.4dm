//%attributes = {}
  // MÉTODO: MB_FindMenuInMenuBar
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 20/02/12, 16:25:50
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // MB_FindMenuInMenuBar()
  // ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($l_menuNumber)
C_TEXT:C284($t_menuTitle;$t_menuBarRef)

ARRAY TEXT:C222($at_menuTitles;0)
ARRAY TEXT:C222($at_menuRefs;0)


$t_menuTitle:=$1
If (Count parameters:C259=2)
	$t_menuBarRef:=$2
Else 
	$t_menuBarRef:=Get menu bar reference:C979
End if 


  // CODIGO PRINCIPAL
GET MENU ITEMS:C977($t_menuBarRef;$at_MenuTitles;$at_menuRefs)
$0:=Find in array:C230($at_menuTitles;$t_menuTitle)