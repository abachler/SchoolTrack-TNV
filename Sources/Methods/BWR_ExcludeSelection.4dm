//%attributes = {}
  //BWR_ExcludeSelection

If (False:C215)
	  // Project method: BWR_ExcludeSelection
	  // Module: 
	  // Purpose:
	  // Syntax: BWR_ExcludeSelection()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 7/1/02  10:39, by Alberto Bachler
	  // 
	  // 
End if 

$searchFile:=yBWR_currentTable
$setName:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
ARRAY LONGINT:C221($aRecNums;Size of array:C274(abrSelect))
For ($i;1;Size of array:C274(abrSelect))
	$aRecNums{$i}:=alBWR_recordNumber{abrSelect{$i}}
End for 
CREATE SELECTION FROM ARRAY:C640(yBWR_currentTable->;$aRecNums)
CREATE SET:C116(yBWR_currentTable->;"2exclude")
DIFFERENCE:C122($setName;"2exclude";$setName)
USE SET:C118($setName)
