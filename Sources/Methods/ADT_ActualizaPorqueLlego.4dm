//%attributes = {}
  //ADT_ActualizaPorqueLlego

C_TEXT:C284($1;$text)
C_POINTER:C301($ptr)

$ptr:=$2
$text:=$1

$indice:=Find in array:C230($ptr->;$text)

If ($indice=-1)
	APPEND TO ARRAY:C911($ptr->;$text)
Else 
	DELETE FROM ARRAY:C228($ptr->;$indice;1)
End if 

For ($i;1;Count list items:C380(hl_porqueLlego))
	GET LIST ITEM:C378(hl_porqueLlego;$i;$ref;$texto)
	
	If (Find in array:C230($ptr->;$texto)#-1)
		  //esta
		SET LIST ITEM PROPERTIES:C386(hl_porqueLlego;$ref;False:C215;Bold:K14:2;0;0x00FF)
	Else 
		  //no esta
		SET LIST ITEM PROPERTIES:C386(hl_porqueLlego;$ref;False:C215;Plain:K14:1;0;0x00FF)
	End if 
End for 
_O_REDRAW LIST:C382(hl_porqueLlego)