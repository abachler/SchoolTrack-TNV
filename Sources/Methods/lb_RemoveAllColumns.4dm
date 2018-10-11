//%attributes = {}
  //lb_RemoveAllColumns

C_TEXT:C284($1;$listBoxName)
$listBoxName:=$1
$columns:=LISTBOX Get number of columns:C831(*;$listBoxName)

For ($i;$columns;1;-1)
	LISTBOX DELETE COLUMN:C830(*;$listBoxName;$i)
End for 