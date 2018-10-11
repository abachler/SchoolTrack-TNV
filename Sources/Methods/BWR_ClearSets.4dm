//%attributes = {}
  //BWR_ClearSets



For ($i;1;Count list items:C380(vlXS_BrowserTab))
	GET LIST ITEM:C378(vlXS_BrowserTab;$i;$tableNumber;$tableName)
	SET_ClearSets ("$RecordSet_Table"+String:C10($tableNumber))
End for 