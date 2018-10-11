Case of 
	: (Form event:C388=On Load:K2:1)
		C_TEXT:C284(vt_EditedText)
		vl_SelectedListItemRef:=0
		vt_SelectedListItemText:=""
		vl_SelectedListItem:=0
		GET WINDOW RECT:C443($left;$top;$right;$bottom)
		If (vt_EditedText#"")
			$pos:=HL_FindElement (hl_choiceList;vt_EditedText+"@")
			If ($pos>0)
				SELECT LIST ITEMS BY POSITION:C381(hl_choiceList;$pos)
				SET LIST ITEM PROPERTIES:C386(hl_choiceList;*;False:C215;1;0)
				vl_SelectedListItem:=$pos
			End if 
		End if 
		GOTO OBJECT:C206(hl_choiceList)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Deactivate:K2:10)
		  //CANCEL
		
	: (Form event:C388=On Unload:K2:2)
		CLEAR LIST:C377(hl_choiceList)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 