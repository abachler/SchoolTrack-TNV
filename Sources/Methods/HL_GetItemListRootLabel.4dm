//%attributes = {}
  //HL_GetItemListRootLabel

If (False:C215)
	  //Method: hl_GetItemListRootLabel
	  //Written by  Alberto Bachler on 11/1/99
	  //Module: 
	  //Purpose: 
	  //Syntax:  hl_GetItemListRoot()
	  //Parameters:
	  //Copyright 1999 Transeo Chile
	<>ST_v524:=False:C215
End if 


  //DECLARATIONS
C_BOOLEAN:C305($expanded)
C_LONGINT:C283($subList;$ref;$1)
_O_C_STRING:C293(255;$label)

  //INITIALIZATION
$list:=$1
$rootLabel:=""
$parentLabel:=""

  //MAIN CODE
GET LIST ITEM:C378($list;Selected list items:C379($list);$ref;$label;$sublist;$expanded)
$itemLabel:=$label
$parent:=List item parent:C633($list;$ref)
If ($parent>0)
	$pos:=List item position:C629($list;$parent)
	GET LIST ITEM:C378($list;$pos;$ref;$label;$sublist;$expanded)
	$parentLabel:=$label
	While ($parent>0)
		$pos:=List item position:C629($list;$parent)
		GET LIST ITEM:C378($list;$pos;$ref;$label;$sublist;$expanded)
		$itemlabel:=$label+":"+$itemLabel
		$rootLabel:=$label
		$parent:=List item parent:C633($list;$ref)
	End while 
End if 
If ($rootLabel="")
	$rootLabel:=$itemLabel
End if 
$0:=$rootLabel
  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 
