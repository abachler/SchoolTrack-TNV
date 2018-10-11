//%attributes = {}
  //XS_SaveDesigners

$items:=Count list items:C380(hl_Designers)
$continue:=True:C214
$itemRef:=0
$count:=1
ARRAY LONGINT:C221($aCollapsedItemRefs;0)  //array for storing collapsed list items
For ($i;1;Count list items:C380(hl_Designers))
	GET LIST ITEM:C378(hl_Designers;$i;$ref;$text;$subList;$expanded)
	If ($subList#0)
		If (Not:C34($expanded))
			APPEND TO ARRAY:C911($aCollapsedItemRefs;$ref)
		End if 
	End if 
End for 

HL_ExpandAll (hl_Designers)
For ($i;Count list items:C380(hl_Designers);1;-1)
	GET LIST ITEM:C378(hl_Designers;$i;$ref;$text)
	$parent:=List item parent:C633(hl_Designers;$ref)
	If ($parent#0)
		$vtXS_Did:=ST_GetWord ($text;1;":")
		$vtXS_Dnombre:=ST_GetWord ($text;2;":")
		$vtXS_Dlogin:=ST_GetWord ($text;3;":")
		$vtXS_Dpass:=ST_GetWord ($text;4;":")
		$vtXS_Demail:=ST_GetWord ($text;5;":")
		If (($vtXS_Did="") | ($vtXS_Dnombre="") | ($vtXS_Dlogin="") | ($vtXS_Dpass="") | ($vtXS_Demail=""))
			DELETE FROM LIST:C624(hl_Designers;$ref)
		End if 
	End if 
End for 

For ($i;1;Size of array:C274($aCollapsedItemRefs))
	SELECT LIST ITEMS BY REFERENCE:C630(hl_Designers;$aCollapsedItemRefs{$i})
	GET LIST ITEM:C378(hl_Designers;Selected list items:C379(hl_Designers);$ref;$label;$sublist;$expanded)
	SET LIST ITEM:C385(hl_Designers;$ref;$label;$ref;$sublist;False:C215)
End for 

_O_REDRAW LIST:C382(hl_Designers)
SAVE LIST:C384(hl_Designers;"XS_Designers")