C_LONGINT:C283($bestheight1;$bestheight2;$bestheight3;$bestwidth1;$bestwidth2;$bestwidth3)
C_LONGINT:C283(r_mostrarCaracteres)
C_BOOLEAN:C305(vb_password)

If (Form event:C388=On Load:K2:1)
	XS_SetInterface 
	WDW_SlideDrawer (->[xShell_Dialogs:114];__ ("cd_Request"))
	OBJECT SET VISIBLE:C603(cdB_btn1;(cdS_Btn1#""))
	OBJECT SET VISIBLE:C603(cdB_Default;(cdS_Btn1#""))
	OBJECT SET VISIBLE:C603(cdB_btn2;(cdS_Btn2#""))
	OBJECT SET VISIBLE:C603(cdB_btn3;(cdS_Btn3#""))
	OBJECT SET TITLE:C194(cdB_btn1;cdS_Btn1)
	OBJECT SET TITLE:C194(cdB_Default;cdS_Btn1)
	OBJECT SET TITLE:C194(cdB_btn2;cdS_Btn2)
	OBJECT SET TITLE:C194(cdB_btn3;cdS_Btn3)
	
	If (vb_password)  //20140710 RCH Para soportar texto password
		OBJECT SET FONT:C164(vt_UserEntry;"%Password")
	End if 
	OBJECT SET VISIBLE:C603(r_mostrarCaracteres;vb_password)
	
	Case of 
		: ((cdS_Btn2="") & (cdS_Btn3=""))
			IT_SetObjectRect (->cdB_Btn1;13;155;485;175)
			IT_SetObjectRect (->cdB_Default;25;355;497;375)
			OBJECT GET COORDINATES:C663(cdB_btn1;$left1;$top1;$right1;$bottom1)
			OBJECT GET BEST SIZE:C717(cdB_Default;$bestwidth1;$bestHeight1)
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
		: ((cdS_Btn1="") & (cdS_Btn3=""))
			IT_SetObjectRect (->cdB_Btn2;13;155;485;175)
			OBJECT GET COORDINATES:C663(cdB_btn2;$left2;$top2;$right2;$bottom2)
			$enlarge2:=$bestwidth2-($right2-$left2)+20
			$newwidth2:=$right2+$enlarge2-$left2
			If ($newwidth2<80)
				$enlarge2:=80-($right2-$left2)
			End if 
			If ($newwidth2>472)
				$enlarge2:=472-($right2-$left2)
			End if 
			If ($enlarge2<0)
				$hormove2:=Abs:C99($enlarge2)
			Else 
				$hormove2:=$enlarge2
			End if 
			OBJECT MOVE:C664(cdB_btn2;$hormove2;0;$enlarge2;0)
		: ((cdS_Btn1="") & (cdS_Btn2=""))
			IT_SetObjectRect (->cdB_Btn3;13;155;485;175)
			OBJECT GET COORDINATES:C663(cdB_btn3;$left3;$top3;$right3;$bottom3)
			$enlarge3:=$bestwidth3-($right3-$left3)+20
			$newwidth3:=$right3+$enlarge3-$left3
			If ($newwidth3<80)
				$enlarge3:=80-($right3-$left3)
			End if 
			If ($newwidth3>472)
				$enlarge3:=472-($right3-$left3)
			End if 
			If ($enlarge3<0)
				$hormove3:=Abs:C99($enlarge3)
			Else 
				$hormove3:=$enlarge3
			End if 
			OBJECT MOVE:C664(cdB_btn3;$hormove3;0;$enlarge3;0)
		: (cdS_Btn3="")
			IT_SetObjectRect (->cdB_Default;245;214;469;234)
			IT_SetObjectRect (->cdB_Btn1;254;153;478;173)
			IT_SetObjectRect (->cdB_Btn2;19;153;243;173)
			OBJECT GET COORDINATES:C663(cdB_btn1;$left1;$top1;$right1;$bottom1)
			OBJECT GET COORDINATES:C663(cdB_btn2;$left2;$top2;$right2;$bottom2)
			OBJECT GET BEST SIZE:C717(cdB_Default;$bestwidth1;$bestHeight1)
			OBJECT GET BEST SIZE:C717(cdB_btn2;$bestwidth2;$bestHeight2)
			$enlarge1:=$bestwidth1-($right1-$left1)+20
			$enlarge2:=$bestwidth2-($right2-$left2)+20
			$newwidth1:=$right1+$enlarge1-$left1
			$newwidth2:=$right2+$enlarge2-$left2
			If ($newwidth1<80)
				$enlarge1:=80-($right1-$left1)
			End if 
			If ($newwidth2<80)
				$enlarge2:=80-($right2-$left2)
			End if 
			If ($newwidth1>224)
				$enlarge1:=224-($right1-$left1)
			End if 
			If ($newwidth2>224)
				$enlarge2:=224-($right2-$left2)
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
			OBJECT MOVE:C664(cdB_btn1;$hormove1;0;$enlarge1;0)
			OBJECT MOVE:C664(cdB_btn2;$hormove1+$hormove2;0;$enlarge2;0)
		: (cdS_Btn2="")
			IT_SetObjectRect (->cdB_Default;245;214;469;234)
			IT_SetObjectRect (->cdB_Btn1;254;153;478;173)
			IT_SetObjectRect (->cdB_Btn3;19;153;243;173)
			OBJECT GET COORDINATES:C663(cdB_btn1;$left1;$top1;$right1;$bottom1)
			OBJECT GET COORDINATES:C663(cdB_btn3;$left3;$top3;$right3;$bottom3)
			OBJECT GET BEST SIZE:C717(cdB_Default;$bestwidth1;$bestHeight1)
			OBJECT GET BEST SIZE:C717(cdB_btn3;$bestwidth3;$bestHeight3)
			$enlarge1:=$bestwidth1-($right1-$left1)+20
			$enlarge3:=$bestwidth3-($right3-$left3)+20
			$newwidth1:=$right1+$enlarge1-$left1
			$newwidth3:=$right3+$enlarge3-$left3
			If ($newwidth1<80)
				$enlarge1:=80-($right1-$left1)
			End if 
			If ($newwidth3<80)
				$enlarge3:=80-($right3-$left3)
			End if 
			If ($newwidth1>224)
				$enlarge1:=224-($right1-$left1)
			End if 
			If ($newwidth3>224)
				$enlarge3:=224-($right3-$left3)
			End if 
			If ($enlarge1<0)
				$hormove1:=Abs:C99($enlarge1)
			Else 
				$hormove1:=$enlarge1
			End if 
			If ($enlarge3<0)
				$hormove3:=Abs:C99($enlarge3)
			Else 
				$hormove3:=$enlarge3
			End if 
			OBJECT MOVE:C664(cdB_btn1;$hormove1;0;$enlarge1;0)
			OBJECT MOVE:C664(cdB_btn3;$hormove1+$hormove3;0;$enlarge3;0)
		: (cdS_Btn1="")
			IT_SetObjectRect (->cdB_Btn3;19;153;243;173)
			IT_SetObjectRect (->cdB_Btn2;254;153;478;173)
			OBJECT GET COORDINATES:C663(cdB_btn2;$left2;$top2;$right2;$bottom2)
			OBJECT GET COORDINATES:C663(cdB_btn3;$left3;$top3;$right3;$bottom3)
			OBJECT GET BEST SIZE:C717(cdB_btn2;$bestwidth2;$bestHeight2)
			OBJECT GET BEST SIZE:C717(cdB_btn3;$bestwidth3;$bestHeight3)
			$enlarge2:=$bestwidth2-($right2-$left2)+20
			$enlarge3:=$bestwidth3-($right3-$left3)+20
			$newwidth2:=$right2+$enlarge2-$left2
			$newwidth3:=$right3+$enlarge3-$left3
			If ($newwidth2<80)
				$enlarge2:=80-($right2-$left2)
			End if 
			If ($newwidth3<80)
				$enlarge3:=80-($right3-$left3)
			End if 
			If ($newwidth2>224)
				$enlarge2:=224-($right2-$left2)
			End if 
			If ($newwidth3>224)
				$enlarge3:=224-($right3-$left3)
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
			OBJECT MOVE:C664(cdB_btn2;$hormove2;0;$enlarge2;0)
			OBJECT MOVE:C664(cdB_btn3;$hormove2+$hormove3;0;$enlarge3;0)
		Else 
			OBJECT GET COORDINATES:C663(cdB_btn1;$left1;$top1;$right1;$bottom1)
			OBJECT GET COORDINATES:C663(cdB_btn2;$left2;$top2;$right2;$bottom2)
			OBJECT GET COORDINATES:C663(cdB_btn3;$left3;$top3;$right3;$bottom3)
			OBJECT GET BEST SIZE:C717(cdB_Default;$bestwidth1;$bestHeight1)
			OBJECT GET BEST SIZE:C717(cdB_btn2;$bestwidth2;$bestHeight2)
			OBJECT GET BEST SIZE:C717(cdB_btn3;$bestwidth3;$bestHeight3)
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
	End case 
End if 