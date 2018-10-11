//%attributes = {}
  //IT_DisplayUnlimitedThermo

  //Creates a process to display unlimited thermometers
C_TEXT:C284($1;$4)
C_LONGINT:C283($2;$3)
C_TEXT:C284(<>vtXS_AppName)

  //$form:=$1  `Form name to use
  //vPictureNb:=$2  `Picture number
  //vPictureItems:=$3  `Number of lines to display
vThermoText:=$1
  //HIDE PROCESS(Current process)

If (Count parameters:C259=2)
	$winPos:=$2
Else 
	$winPos:=5
End if 

Fl_Blink:=True:C214
BRING TO FRONT:C326(Current process:C322)
$TherWinRef:=WDW_OpenFormWindow (->[xShell_Dialogs:114];"UnlimitedThermometer";$winPos;Palette form window:K39:9;<>vtXS_AppName)
DIALOG:C40([xShell_Dialogs:114];"UnlimitedThermometer")
CLOSE WINDOW:C154($TherWinRef)