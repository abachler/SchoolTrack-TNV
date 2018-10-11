//%attributes = {}
  //XS_ModifyDesigner

GET LIST ITEM:C378(hl_Designers;Selected list items:C379(hl_Designers);$ref;$text)
$parent:=List item parent:C633(hl_Designers;$ref)
If ($parent#0)
	vtXS_Did:=ST_GetWord ($text;1;":")
	vtXS_Dnombre:=ST_GetWord ($text;2;":")
	vtXS_Dlogin:=ST_GetWord ($text;3;":")
	vtXS_Dpass:=ST_GetWord ($text;4;":")
	vtXS_Demail:=ST_GetWord ($text;5;":")
	
	WDW_OpenPopupWindow (->hl_Designers;->[xShell_Dialogs:114];"ModDesigner";2)
	DIALOG:C40([xShell_Dialogs:114];"ModDesigner")
	CLOSE WINDOW:C154
	If (ok=1)
		$listElement:=vtXS_Did+":"+vtXS_Dnombre+":"+vtXS_Dlogin+":"+vtXS_Dpass+":"+vtXS_Demail
		SET LIST ITEM:C385(hl_Designers;$ref;$listElement;Num:C11(vtXS_Did))
	End if 
End if 