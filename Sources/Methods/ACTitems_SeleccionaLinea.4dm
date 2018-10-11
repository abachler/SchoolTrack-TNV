//%attributes = {}
C_LONGINT:C283($l_idItem;$1)

$l_idItem:=$1

KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$l_idItem)
If ($l_idItem#0)
	$l_line:=Find in array:C230(alACT_IdItem;[xxACT_Items:179]ID:1)
	If ($l_line#0)
		vi_lastLine:=$l_line
		AL_SetLine (xALP_Items;$l_line)
	End if 
End if 