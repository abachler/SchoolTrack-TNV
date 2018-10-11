//%attributes = {}
  // MNU_ArrayToMenu()
  // Por: Alberto Bachler K.: 27-03-14, 18:51:38
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_POINTER:C301($1)
C_POINTER:C301($2)

_O_C_INTEGER:C282($i_item)
C_POINTER:C301($y_atItems;$y_atParametros)
C_TEXT:C284($t_refMenu)

If (False:C215)
	C_TEXT:C284(MNU_ArrayToMenu ;$0)
	C_POINTER:C301(MNU_ArrayToMenu ;$1)
	C_POINTER:C301(MNU_ArrayToMenu ;$2)
End if 

ARRAY TEXT:C222($at_parametrosMenu;0)


$y_atItems:=$1
If (Count parameters:C259=2)
	$y_atParametros:=$2
	COPY ARRAY:C226($y_atParametros->;$at_parametrosMenu)
Else 
	$y_atParametros:=$1
	COPY ARRAY:C226($y_atItems->;$at_parametrosMenu)
End if 

$t_refMenu:=Create menu:C408
For ($i_item;1;Size of array:C274($y_atItems->))
	If (Position:C15("(";$y_atItems->{$i_item})>0)
		$y_atItems->{$i_item}:=Char:C90(1)+$y_atItems->{$i_item}
	End if 
	APPEND MENU ITEM:C411($t_refMenu;$y_atItems->{$i_item})
	SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;$at_parametrosMenu{$i_item})
End for 

$0:=$t_refMenu

