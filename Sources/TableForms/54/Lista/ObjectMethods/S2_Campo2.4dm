If (Form event:C388=On Display Detail:K2:22)
	If ([xShell_Reports:54]RelatedTable:14>0)
		vtQR_RelatedTableName:=Table name:C256([xShell_Reports:54]RelatedTable:14)
	Else 
		vtQR_RelatedTableName:=""
	End if 
End if 