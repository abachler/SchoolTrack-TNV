//%attributes = {}
  //PLT_AdjustBrowserSize

$iconCounter:=$1
_O_PLATFORM PROPERTIES:C365($platform)
If ($platform=3)
	OBJECT MOVE:C664(vlXS_BrowserTab;0;0;2;0)
End if 
If (($iconCounter=0) & (Size of array:C274(atBWR_CommandsPopup)=0))
	OBJECT MOVE:C664(vlXS_BrowserTab;0;0;29;0)  //29
	OBJECT MOVE:C664(xALP_Browser;0;0;27;0)  //27
	OBJECT SET VISIBLE:C603(*;"PLT_PopUpImage";False:C215)
	OBJECT SET VISIBLE:C603(bPLT_BtnPopUp;False:C215)
Else 
	PLT_SetPopUpState 
End if 