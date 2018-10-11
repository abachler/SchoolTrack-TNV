//%attributes = {}
  // MÉTODO: MB_GetMenuList
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 20/02/12, 16:21:57
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // MB_GetMenuList()
  // ----------------------------------------------------
C_POINTER:C301($1)
C_LONGINT:C283($2)

C_LONGINT:C283($i;$l_processNumber)
C_POINTER:C301($y_arrayMenuTitles)
C_TEXT:C284($t_menuTitle)


  // CODIGO PRINCIPAL
$y_arrayMenuTitles:=$1
If (Count parameters:C259=1)
	$l_processNumber:=$2
End if 

If ($l_processNumber=0)
	$l_processNumber:=Frontmost process:C327
End if 

For ($i;1;Count menus:C404($l_processNumber))
	$t_menuTitle:=Get menu title:C430($i;$l_processNumber)
	APPEND TO ARRAY:C911($y_arrayMenuTitles->;$t_menuTitle)
End for 
