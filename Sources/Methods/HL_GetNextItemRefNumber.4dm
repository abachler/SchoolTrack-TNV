//%attributes = {}
  //HL_GetNextItemRefNumber

If (False:C215)
	  //Method: hl_GetNextItemRefNumber
	  //Written by  Alberto Bachler on 11/1/99
	  //Module: Hierarchical List
	  //Purpose: 
	  //Syntax:  hl_GetNextItemRefNumber(&L)
	  //Parameters: 
	  //   $1: list reference
	  //Copyright 1999 Transeo Chile
	<>ST_v524:=False:C215
End if 


  //DECLARATIONS
C_LONGINT:C283($list;$itemRef;$count;$nextItemRefNumber;$0;$sublist;$items;$ref)
C_BOOLEAN:C305($expanded)
_O_C_STRING:C293(255;$label)

  //INITIALIZATION
$list:=$1
$nextItemRefNumber:=0

  //MAIN CODE
$items:=Count list items:C380($list)
$continue:=True:C214
$itemRef:=0
$count:=1
ARRAY LONGINT:C221($aCollapsedItemRefs;0)  //array for storing collapsed list items
While ($count<=$items)
	GET LIST ITEM:C378($list;$count;$ref;$label;$sublist;$expanded)
	If ($ref>$itemRef)
		$itemRef:=$Ref
	End if 
	If ($sublist>0)
		If ($expanded=False:C215)
			SET LIST ITEM:C385($list;$ref;$label;$ref;$sublist;True:C214)
			GET LIST ITEM:C378($list;$count;$ref;$label;$sublist;$expanded)
			$items:=Count list items:C380($list)
			INSERT IN ARRAY:C227($aCollapsedItemRefs;Size of array:C274($aCollapsedItemRefs)+1)  //adding collapsed item
			$aCollapsedItemRefs{Size of array:C274($aCollapsedItemRefs)}:=$ref
		End if 
	End if 
	$count:=$count+1
End while 
$nextItemRefNumber:=$itemRef+1
$0:=$nextItemRefNumber

  //restoring list to its original state
For ($i;1;Size of array:C274($aCollapsedItemRefs))
	SELECT LIST ITEMS BY REFERENCE:C630($list;$aCollapsedItemRefs{$i})
	GET LIST ITEM:C378($list;Selected list items:C379($list);$ref;$label;$sublist;$expanded)
	SET LIST ITEM:C385($list;$ref;$label;$ref;$sublist;False:C215)
End for 

  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 



