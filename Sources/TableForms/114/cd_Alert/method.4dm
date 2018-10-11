C_LONGINT:C283($bestheight1;$bestwidth1;$growHeight;$textWidth;$TextHeight)

If (Form event:C388=On Load:K2:1)
	WDW_SlideDrawer (->[xShell_Dialogs:114];"cd_Alert")
	OBJECT SET TITLE:C194(cdB_btn1;cdS_Btn1)
	OBJECT SET TITLE:C194(cdB_Default;cdS_Btn1)
	OBJECT GET COORDINATES:C663(cdB_btn1;$left1;$top1;$right1;$bottom1)
	OBJECT GET BEST SIZE:C717(cdB_Default;$bestwidth1;$bestHeight1)
	OBJECT GET BEST SIZE:C717(cdT_Msg;$textWidth;$TextHeight;400)
	If ($TextHeight>80)
		$growHeight:=$TextHeight-80
		OBJECT GET COORDINATES:C663(cdT_Msg;$oLeft;$oTop;$oRight;$oBottom)
		IT_SetObjectRect (->cdT_Msg;$oLeft;$oTop;$oRight;$oBottom+$growHeight)
		GET WINDOW RECT:C443($left;$top;$right;$bottom)
		SET WINDOW RECT:C444($left;$top;$right;$bottom+$growHeight)
	End if 
	$enlarge1:=$bestwidth1-($right1-$left1)+20
	$newwidth1:=$right1+$enlarge1-$left1
	If ($newwidth1<80)
		$enlarge1:=80-($right1-$left1)
	End if 
	If ($newwidth1>472)
		$enlarge1:=472-($right1-$left1)
	End if 
	If ($enlarge1<0)
		$hormove1:=Abs:C99($enlarge1)
	Else 
		$hormove1:=$enlarge1
	End if 
	OBJECT MOVE:C664(cdB_btn1;$hormove1;0;$enlarge1;0)
	If ($growHeight>0)
		OBJECT GET COORDINATES:C663(*;"fondo";$oLeft;$oTop;$oRight;$oBottom)
		IT_SetNamedObjectRect ("fondo";$oLeft;$oTop;$oRight;$oBottom+$growHeight)
		OBJECT GET COORDINATES:C663(cdT_Msg;$oLeft;$oTop;$oRight;$oBottom)
		IT_SetObjectRect (->cdT_Msg;$oLeft;$oTop;$oRight;$oBottom+$growHeight)
		OBJECT GET COORDINATES:C663(cdB_btn1;$oLeft;$oTop;$oRigth;$oBottom)
		IT_SetObjectRect (->cdB_btn1;$oLeft;$oTop+$growHeight;$oRight;$oBottom+$growHeight)
	End if 
End if 
