//%attributes = {}
  //BWR_ReduceSelection

If (False:C215)
	  // Project method: BWR_ReduceSelection
	  // Module: 
	  // Purpose:
	  // Syntax: BWR_ReduceSelection()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 7/1/02  10:27, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================


  // INITIALIZATION
  // ============================================


  // MAIN CODE
  // ============================================
$searchFile:=yBWR_currentTable
ARRAY LONGINT:C221($aRecNums;Size of array:C274(abrSelect))
For ($i;1;Size of array:C274(abrSelect))
	$aRecNums{$i}:=alBWR_recordNumber{abrSelect{$i}}
End for 
CREATE SELECTION FROM ARRAY:C640(yBWR_currentTable->;$aRecNums)

  // END OF METHOD
