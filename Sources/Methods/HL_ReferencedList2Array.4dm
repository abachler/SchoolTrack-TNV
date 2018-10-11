//%attributes = {}
  // HL_ReferencedList2Array()
  // Por: Alberto Bachler: 26/02/13, 15:06:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_LONGINT:C283($i;$l_IdItem;$l_IdLista;$l_itemsEnLista)
C_POINTER:C301($y_IdsElementos_al;$y_nombresElementos_at)
C_TEXT:C284($t_nombreItem)

If (False:C215)
	C_LONGINT:C283(HL_ReferencedList2Array ;$1)
	C_POINTER:C301(HL_ReferencedList2Array ;$2)
	C_POINTER:C301(HL_ReferencedList2Array ;$3)
End if 

$l_IdLista:=$1
$y_nombresElementos_at:=$2
If (Count parameters:C259=3)
	$y_IdsElementos_al:=$3
End if 

$l_itemsEnLista:=Count list items:C380($l_IdLista)

If (Is nil pointer:C315($y_IdsElementos_al))
	ARRAY TEXT:C222($y_nombresElementos_at->;$l_itemsEnLista)
	For ($i;1;Count list items:C380($l_IdLista))
		GET LIST ITEM:C378($l_IdLista;$i;$l_IdItem;$t_nombreItem)
		$y_nombresElementos_at->{$i}:=$t_nombreItem
	End for 
Else 
	ARRAY TEXT:C222($y_nombresElementos_at->;$l_itemsEnLista)
	ARRAY LONGINT:C221($y_IdsElementos_al->;$l_itemsEnLista)
	For ($i;1;Count list items:C380($l_IdLista))
		GET LIST ITEM:C378($l_IdLista;$i;$l_IdItem;$t_nombreItem)
		$y_nombresElementos_at->{$i}:=$t_nombreItem
		$y_IdsElementos_al->{$i}:=$l_IdItem
	End for 
End if 