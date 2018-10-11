//%attributes = {}
  //HL_SelectListItemByLabel

If (False:C215)
	  //Method: hl_SelectItemByLabel
	  //Written by  Alberto Bachler on 12/1/99
	  //Module: 
	  //Purpose: 
	  //Syntax:  hl_SelectItemByLabel()
	  //Parameters:
	  //Copyright 1999 Transeo Chile
	<>ST_v524:=False:C215
End if 



  //DECLARATIONS
C_LONGINT:C283($list;$itemRef;$count;$0;$sublist;$items;$ref;$1)
C_BOOLEAN:C305($expanded)
_O_C_STRING:C293(255;$label)


  //INITIALIZATION
$originalListRef:=$1
$labelToSearch:=$2
$label:=""

  //MAIN CODE
$tempListRef:=Copy list:C626($originalListRef)
$items:=Count list items:C380($tempListRef)
$continue:=True:C214
$itemRef:=0
$count:=1
While (($count<$items) | ($label=$labelToSearch))
	GET LIST ITEM:C378($list;$count;$ref;$label;$sublist;$expanded)
	If (($sublist>0) & ($label#$labelToSearch))
		If ($expanded=False:C215)
			SET LIST ITEM:C385($list;$ref;$label;$ref;$sublist;True:C214)
			GET LIST ITEM:C378($list;$count;$ref;$label;$sublist;$expanded)
			$items:=Count list items:C380($list)
		End if 
	End if 
	If ($label=$labelToSearch)
		$refFounded:=$ref
	End if 
	$count:=$count+1
End while 
If ($label=$labelToSearch)
	$refFounded:=$ref
	$0:=$refFounded
Else 
	$0:=-1
End if 

  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 