If (Form event:C388=On Display Detail:K2:22)
	If ([xShell_Reports:54]MainTable:3#0)
		vtQR_MainTableName:=Table name:C256(Abs:C99([xShell_Reports:54]MainTable:3))
	End if 
End if 