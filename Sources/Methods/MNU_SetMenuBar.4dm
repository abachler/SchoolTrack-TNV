//%attributes = {}
  //MNU_SetMenuBar

C_TEXT:C284($menuBarName;$1)
C_LONGINT:C283($process;$2)

$menuBarName:=$1
$process:=Current process:C322
If (Count parameters:C259=2)
	$process:=$2
End if 
  //$menuBarName:=$menuBarName+"_"+◊vtXS_Langage
SET MENU BAR:C67($menuBarName;$process)