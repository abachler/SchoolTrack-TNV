//%attributes = {}
  //WDW_ResizeWindow

C_LONGINT:C283($winRef;$1;$2)
$winRef:=Frontmost window:C447
$newWidth:=$1
$newHeight:=$2

$behindWinRef:=Next window:C448($winRef)
If ($behindWinRef>0)
	GET WINDOW RECT:C443($left;$top;$rigth;$bottom;$behindWinRef)
Else 
	SCREEN COORDINATES:C438($left;$top;$rigth;$bottom)
End if 
$centerH:=Int:C8(($rigth-$left)/2)+$left
$centerV:=Int:C8(($bottom-$top)/2)+$top
$left:=$centerH-(Int:C8($newWidth/2))
$rigth:=$centerH+(Int:C8($newWidth/2))
$top:=$centerV-(Int:C8($newheight/2))
$bottom:=$centerV+(Int:C8($newheight/2))


SET WINDOW RECT:C444($left;$top;$rigth;$bottom;$winRef)