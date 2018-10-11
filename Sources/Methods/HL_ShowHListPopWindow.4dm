//%attributes = {}
  //HL_ShowHListPopWindow

C_TEXT:C284($2;$windowTitle)
C_LONGINT:C283($1;$listRef;$windowPosition;$3;$windowType;hl_popupList)
Case of 
	: (Count parameters:C259=3)
		$windowPosition:=$3
		$windowTitle:=$2
	: (Count parameters:C259=2)
		$windowTitle:=$2
		$windowPosition:=7
End case 
If ($windowTitle="")
	$windowType:=2
Else 
	$windowType:=Palette form window:K39:9
End if 
$windowIsModal:=(Window kind:C445=9)
If ($windowIsModal)
	$windowType:=5
End if 

$listRef:=$1
If (Is a list:C621(hl_popupList))
	CLEAR LIST:C377(hl_popupList;*)
Else 
	hl_popupList:=New list:C375
End if 
hl_popupList:=Copy list:C626($listRef)
SET LIST PROPERTIES:C387(hl_popupList;1;0;18)
hl_DeselectAllElements (hl_popupList)
vlHL_SelectedElementRef:=0
vtHL_SelectedElementText:=""

WDW_OpenFormWindow (->[xShell_Dialogs:114];"hl_popup";$windowPosition;$windowType;$windowTitle)
DIALOG:C40([xShell_Dialogs:114];"hl_popup")
CLOSE WINDOW:C154
If (ok=1)
	$0:=vlHL_SelectedElementRef
Else 
	$0:=0
End if 