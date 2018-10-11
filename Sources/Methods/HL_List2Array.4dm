//%attributes = {}
  //HL_List2Array

$Lista:=$1
$Array:=$2

$ListaRef:=Load list:C383($Lista)
$Items:=Count list items:C380($ListaRef)

ARRAY TEXT:C222($Array->;$Items)

For ($i;1;Count list items:C380($ListaRef))
	GET LIST ITEM:C378($ListaRef;$i;$ItemRef;$ItemText)
	$Array->{$i}:=$ItemText
End for 