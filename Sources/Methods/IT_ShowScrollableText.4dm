//%attributes = {}
  //IT_ShowScrollableText

C_TEXT:C284($windowTitle)
vt_ScrollableText:=$1
If (Count parameters:C259=2)
	$windowTitle:=$2
End if 
WDW_OpenFormWindow (->[xShell_Dialogs:114];"ShowScrollableText";7;Palette form window:K39:9;$windowTitle)
DIALOG:C40([xShell_Dialogs:114];"ShowScrollableText")
CLOSE WINDOW:C154