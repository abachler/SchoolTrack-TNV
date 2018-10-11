//%attributes = {}
  //XS_AddDesigner

GET LIST ITEM:C378(hl_Designers;*;$ref;$text)
$parent:=List item parent:C633(hl_Designers;$ref)
If ($parent#0)
	SELECT LIST ITEMS BY REFERENCE:C630(hl_Designers;$parent)
End if 

GET LIST ITEM:C378(hl_Designers;*;$ref;$text;$subList;$expanded)
If ($subList=0)
	$subList:=New list:C375
	$nextRef:=($ref*-1)-1
	APPEND TO LIST:C376($subList;"";$nextRef)
	SET LIST ITEM:C385(hl_Designers;$ref;$text;$ref;$subList;True:C214)
Else 
	If (Not:C34($expanded))
		SET LIST ITEM:C385(hl_Designers;$ref;$text;$ref;$subList;True:C214)
	End if 
	$nextRef:=1
	For ($i;1;Count list items:C380($subList))
		GET LIST ITEM:C378($subList;$i;$ref;$text)
		If ($ref<$nextRef)
			$nextRef:=$ref
		End if 
	End for 
	$nextRef:=$nextRef-1
	APPEND TO LIST:C376($subList;"";$nextRef)
	_O_REDRAW LIST:C382($subList)
	_O_REDRAW LIST:C382(hl_Designers)
End if 
vtXS_Did:=String:C10($nextRef)
vtXS_Dnombre:=""
vtXS_Dlogin:=""
vtXS_Dpass:=""
vtXS_Demail:=""
WDW_OpenPopupWindow (->hl_Designers;->[xShell_Dialogs:114];"ModDesigner";2)
DIALOG:C40([xShell_Dialogs:114];"ModDesigner")
CLOSE WINDOW:C154
If (ok=1)
	$listElement:=vtXS_Did+":"+vtXS_Dnombre+":"+vtXS_Dlogin+":"+vtXS_Dpass+":"+vtXS_Demail
	SET LIST ITEM:C385(hl_Designers;$nextRef;$listElement;$nextRef)
End if 