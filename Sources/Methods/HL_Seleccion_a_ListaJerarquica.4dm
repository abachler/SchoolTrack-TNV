//%attributes = {}
  // HL_Seleccion_a_ListaJerarquica()
  // Por: Alberto Bachler: 25/03/13, 16:37:48
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_LONGINT:C283($2)

C_LONGINT:C283($i;$l_ListRef)
C_POINTER:C301($y_campo;$y_Tabla)

ARRAY LONGINT:C221($al_recNums;0)
ARRAY TEXT:C222($at_Items;0)
If (False:C215)
	C_POINTER:C301(HL_Seleccion_a_ListaJerarquica ;$1)
	C_LONGINT:C283(HL_Seleccion_a_ListaJerarquica ;$2)
End if 

$y_campo:=$1
$l_ListRef:=$2
$y_Tabla:=Table:C252(Table:C252($y_campo))

If (Not:C34(Is a list:C621($l_ListRef)))
	$l_listRef:=New list:C375
Else 
	HL_ClearList ($l_listRef)
End if 

SELECTION TO ARRAY:C260($y_tabla->;$al_recNums;$y_campo->;$at_Items)
For ($i;1;Size of array:C274($al_recNums))
	APPEND TO LIST:C376($l_listRef;$at_Items{$i};$al_recNums{$i})
End for 

$0:=$l_listRef