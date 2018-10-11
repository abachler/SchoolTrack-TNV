//%attributes = {}
If (Count parameters:C259=1)
	$wref:=$1
Else 
	$wref:=Frontmost window:C447
End if 

GET WINDOW RECT:C443($left;$top;$right;$bottom;$wref)
$step:=8
For ($i;1;6)
	SET WINDOW RECT:C444($left-$step;$top;$right-$step;$bottom;$wref)
	DELAY PROCESS:C323(Current process:C322;2)
	SET WINDOW RECT:C444($left+$step;$top;$right+$step;$bottom;$wref)
	DELAY PROCESS:C323(Current process:C322;2)
End for 

SET WINDOW RECT:C444($left;$top;$right;$bottom;$wref)