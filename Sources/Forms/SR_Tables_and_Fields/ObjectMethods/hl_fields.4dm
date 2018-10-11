If (Form event:C388=On Double Clicked:K2:5)
	GET LIST ITEM:C378(hl_Tables;*;vyTableNumber->;$tableName)
	GET LIST ITEM:C378(hl_Fields;*;vyFieldNumber->;$fieldName)
	ACCEPT:C269
End if 


