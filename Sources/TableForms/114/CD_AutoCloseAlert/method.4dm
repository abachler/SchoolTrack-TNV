C_LONGINT:C283($bestW;$bestH;$right;$left;$top;$bottom)

Case of 
	: (Form event:C388=On Timer:K2:25)
		vl_SecondsToClose:=vl_SecondsToClose-1
		
		
		cdt_Msg2:=Replace string:C233(cdt_MSG2_Original;"<timer>";String:C10(vl_SecondsToClose))
		REDRAW:C174(cdt_Msg2)
		
		If (vl_SecondsToClose<=0)
			CANCEL:C270
		End if 
		
		
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		
		OBJECT GET BEST SIZE:C717(cdt_Msg;$bestW;$bestH;430)
		OBJECT GET COORDINATES:C663(cdt_Msg;$left;$top;$right;$bottom)
		
		If (vl_SecondsToClose>0)
			cdt_MSG2_Original:=cdt_Msg2
			SET TIMER:C645(60)
			cdt_Msg2:=Replace string:C233(cdt_MSG2_Original;"<timer>";String:C10(vl_SecondsToClose))
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		ACCEPT:C269
		
	: ((Form event:C388=On Deactivate:K2:10) | (Form event:C388=On Before Keystroke:K2:6))
		ACCEPT:C269
		
		
		
End case 
