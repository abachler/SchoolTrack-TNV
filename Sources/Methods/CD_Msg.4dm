//%attributes = {}
  //CD_Msg

If (Count parameters:C259=2)
	$winPos:=$2
Else 
	$winPos:=0
End if 
If (<>vb_msgON)
	WDW_OpenFormWindow (->[xShell_Dialogs:114];"WaitingMessage";$winPos;Palette form window:K39:9;__ (""))
	sMess:=$1
	FORM SET INPUT:C55([xShell_Dialogs:114];"WaitingMessage")
	READ ONLY:C145([xShell_Dialogs:114])
	ALL RECORDS:C47([xShell_Dialogs:114])
	FIRST RECORD:C50([xShell_Dialogs:114])
	If (Records in selection:C76([xShell_Dialogs:114])=0)
		CREATE RECORD:C68([xShell_Dialogs:114])
	End if 
	DISPLAY RECORD:C105([xShell_Dialogs:114])
End if 