//%attributes = {}
  //CD_AutoCloseAlert


C_TEXT:C284($1;cdT_Msg;vtext;$font)
C_LONGINT:C283($platform;$width;$height;vl_SecondsToClose)
_O_PLATFORM PROPERTIES:C365($platForm)



If (<>vb_MsgON)
	If ($platForm=3)
		$FONT:="Tahoma"
	Else 
		$font:="Tahoma"
	End if 
	$size:=9
	$lineHeight:=12
	$style:=0
	
	cdT_Msg2:=""
	vl_SecondsToClose:=0
	cdT_Msg:=$1
	Case of 
		: (Count parameters:C259=2)
			vl_SecondsToClose:=$2
		: (Count parameters:C259=3)
			vl_SecondsToClose:=$2
			cdT_Msg2:=$3
	End case 
	
	
	WDW_OpenFormWindow (->[xShell_Dialogs:114];"CD_AutoCloseAlert";4;Palette form window:K39:9)
	BEEP:C151
	DIALOG:C40([xShell_Dialogs:114];"CD_AutoCloseAlert")
	CLOSE WINDOW:C154
	
	
	
	
	  //WDW_OpenFormWindow (->[xShell_Dialogs];"CD_AutoCloseAlert";4;palette form Window)
	  //BEEP
	  //DIALOG([xShell_Dialogs];"CD_AutoCloseAlert")
	  //CLOSE WINDOW
	
End if 


