//%attributes = {}
  // 4D_openMethodEditor()
  // Por: Alberto Bachler: 18/11/13, 16:17:07
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$l_IdMetodo:=$1
$l_linea:=0
If (Count parameters:C259=2)
	$l_linea:=$2
End if 

ARRAY LONGINT:C221($al_IdMetodos;0)
ARRAY TEXT:C222($at_NombresMetodos;0)
hmFree_GET METHOD LIST ($at_NombresMetodos;$al_IdMetodos)

$l_posicionMetodo:=Find in array:C230($al_IdMetodos;$l_IdMetodo)
If ($l_posicionMetodo>0)
	$t_nombreMetodo:=$at_NombresMetodos{$l_posicionMetodo}
End if 

$l_error:=hmFree_OpenMethodEditor ($t_nombreMetodo;$l_linea)


$0:=$l_error

