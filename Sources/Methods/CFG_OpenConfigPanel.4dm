//%attributes = {}
  //CFG_OpenConfigPanel

C_POINTER:C301($tablePtr;$1)
C_TEXT:C284($form;$2)

$tablePtr:=$1
$form:=$2
$openingMethod:=0
$title:=Get window title:C450
If (Count parameters:C259=3)
	$openingMethod:=$3
End if 
If (Count parameters:C259=4)
	$openingMethod:=$3
	$title:=$4
End if 

If (Not:C34(Is nil pointer:C315($tablePtr)))
	FORM GET PROPERTIES:C674($tablePtr->;$form;$width;$height)
Else 
	FORM GET PROPERTIES:C674($form;$width;$height)
End if 
GET WINDOW RECT:C443($left;$top;$right;$bottom)
$add2Right:=0
$substract2Left:=0
$substract2Top:=0
$newLeft:=($left-$width+$right)/2
$newTop:=$top
$newRight:=($left+$width+$right)/2
$newBottom:=$height+$top
If ($newLeft<=0)
	$add2Right:=Abs:C99($newLeft)+3
	$newLeft:=3
	$newRight:=$newRight+$add2Right
End if 
If ($newRight>=Screen width:C187)
	$substract2Left:=$newRight-Screen width:C187+3
	$newRight:=Screen width:C187-3
	$newLeft:=$newLeft-$substract2Left
End if 
If ($newBottom>=Screen height:C188)
	$substract2Top:=$newBottom-Screen height:C188+3
	$newBottom:=Screen height:C188-3
	$newTop:=$newTop-$substract2Top
End if 

SET WINDOW RECT:C444($newLeft;$newTop;$newRight;$newBottom)
SET WINDOW TITLE:C213($title)
If ($openingMethod=0)
	If (Not:C34(Is nil pointer:C315($tablePtr)))
		DIALOG:C40($tablePtr->;$form)
	Else 
		DIALOG:C40($form)
	End if 
Else 
	KRL_ModifyRecord ($tablePtr;$form)
End if 