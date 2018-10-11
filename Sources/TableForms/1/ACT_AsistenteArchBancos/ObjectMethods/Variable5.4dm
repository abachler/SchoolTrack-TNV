Case of 
	: (vi_PageNumber=1)
		  //If (cbPAC=1)
		If (vlACT_id_modo_pago=-10)
			vi_PageNumber:=2
		Else 
			vi_PageNumber:=3
		End if 
	: (vi_PageNumber=2)
		If (cb_LoadUniFile=1)
			ACTwiz_LoadUnivFile 
		End if 
		vi_PageNumber:=3
End case 
  //If ((vi_PageNumber=3) & (cbPAT=1))
If ((vi_PageNumber=3) & (vlACT_id_modo_pago=-9))
	OBJECT SET VISIBLE:C603(*;"btn_@";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"btn_@";False:C215)
End if 
_O_ENABLE BUTTON:C192(bPrev)
FORM GOTO PAGE:C247(vi_PageNumber)
POST KEY:C465(Character code:C91("+");256)