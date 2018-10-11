C_LONGINT:C283($growHeight;$bestheight1;$bestheight2;$bestheight3;$bestwidth1;$bestwidth2;$bestwidth3;$textWidth;$TextHeight)
If (Form event:C388=On Load:K2:1)
	WDW_SlideDrawer (->[xShell_Dialogs:114];"cd_3Btns")
	OBJECT SET TITLE:C194(cdB_btn1;cdS_Btn1)
	OBJECT SET TITLE:C194(cdB_Default;cdS_Btn1)
	OBJECT SET TITLE:C194(cdB_btn2;cdS_Btn2)
	OBJECT SET TITLE:C194(cdB_btn3;cdS_Btn3)
	OBJECT GET COORDINATES:C663(cdB_btn1;$left1;$top1;$right1;$bottom1)
	OBJECT GET COORDINATES:C663(cdB_btn2;$left2;$top2;$right2;$bottom2)
	OBJECT GET COORDINATES:C663(cdB_btn3;$left3;$top3;$right3;$bottom3)
	OBJECT GET BEST SIZE:C717(cdB_btn1;$bestwidth1;$bestHeight1)
	OBJECT GET BEST SIZE:C717(cdB_btn2;$bestwidth2;$bestHeight2)
	OBJECT GET BEST SIZE:C717(cdB_btn3;$bestwidth3;$bestHeight3)
	
	OBJECT GET BEST SIZE:C717(cdT_Msg;$textWidth;$TextHeight;400)
	If ($TextHeight>80)
		$growHeight:=$TextHeight-80
		GET WINDOW RECT:C443($left;$top;$right;$bottom)
		SET WINDOW RECT:C444($left;$top;$right;$bottom+$growHeight)
	End if 
	
	$enlarge1:=$bestwidth1-($right1-$left1)+20
	$enlarge2:=$bestwidth2-($right2-$left2)+20
	$enlarge3:=$bestwidth3-($right3-$left3)+20
	$newwidth1:=$right1+$enlarge1-$left1
	$newwidth2:=$right2+$enlarge2-$left2
	$newwidth3:=$right3+$enlarge3-$left3
	If ($newwidth1<80)
		$enlarge1:=80-($right1-$left1)
	End if 
	If ($newwidth2<80)
		$enlarge2:=80-($right2-$left2)
	End if 
	If ($newwidth3<80)
		$enlarge3:=80-($right3-$left3)
	End if 
	If ($newwidth1>148)
		$enlarge1:=148-($right1-$left1)
	End if 
	If ($newwidth2>148)
		$enlarge2:=148-($right2-$left2)
	End if 
	If ($newwidth3>148)
		$enlarge3:=148-($right3-$left3)
	End if 
	If ($enlarge1<0)
		$hormove1:=Abs:C99($enlarge1)
	Else 
		$hormove1:=$enlarge1
	End if 
	If ($enlarge2<0)
		$hormove2:=Abs:C99($enlarge2)
	Else 
		$hormove2:=$enlarge2
	End if 
	If ($enlarge3<0)
		$hormove3:=Abs:C99($enlarge3)
	Else 
		$hormove3:=$enlarge3
	End if 
	OBJECT MOVE:C664(cdB_btn1;$hormove1;0;$enlarge1;0)
	OBJECT MOVE:C664(cdB_btn2;$hormove1+$hormove2;0;$enlarge2;0)
	OBJECT MOVE:C664(cdB_btn3;$hormove1+$hormove2+$hormove3;0;$enlarge3;0)
	
	If ($growHeight>0)
		OBJECT GET COORDINATES:C663(*;"fondo";$oLeft;$oTop;$oRight;$oBottom)
		IT_SetNamedObjectRect ("fondo";$oLeft;$oTop;$oRight;$oBottom+$growHeight)
		OBJECT GET COORDINATES:C663(cdT_Msg;$oLeft;$oTop;$oRight;$oBottom)
		IT_SetObjectRect (->cdT_Msg;$oLeft;$oTop;$oRight;$oBottom+$growHeight)
		OBJECT GET COORDINATES:C663(cdB_btn1;$oLeft;$oTop;$oRight;$oBottom)
		IT_SetObjectRect (->cdB_btn1;$oLeft;$oTop+$growHeight;$oRight;$oBottom+$growHeight)
		OBJECT GET COORDINATES:C663(cdB_btn2;$oLeft;$oTop;$oRight;$oBottom)
		IT_SetObjectRect (->cdB_btn2;$oLeft;$oTop+$growHeight;$oRight;$oBottom+$growHeight)
		OBJECT GET COORDINATES:C663(cdB_btn3;$oLeft;$oTop;$oRight;$oBottom)
		IT_SetObjectRect (->cdB_btn3;$oLeft;$oTop+$growHeight;$oRight;$oBottom+$growHeight)
	End if 
End if 