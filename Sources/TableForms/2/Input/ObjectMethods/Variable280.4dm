$lastObject:=Focus object:C278
RESOLVE POINTER:C394(Focus object:C278;$varName;$tableNum;$fieldnum)
If ($varName="xALP_@")
	AL_ExitCell ($lastObject->)
End if 
GET LIST ITEM:C378(hlTab_STR_alumnos;Selected list items:C379(hlTab_STR_alumnos);$itemRef;$itemText)
AL_OnRecordLoad ($itemRef)