//%attributes = {}
  //SYS_isSpanishOrder


ARRAY TEXT:C222($aText1;4)
ARRAY LONGINT:C221($aLong;4)
$aText1{1}:="Nazar"
$aText1{2}:="Nuñez"
$aText1{3}:="Ñandu"
$aText1{4}:="Zamora"
SORT ARRAY:C229($aText1;>)
If (Find in array:C230($aText1;"Ñandu")#3)
	$0:=False:C215
Else 
	$0:=True:C214
End if 