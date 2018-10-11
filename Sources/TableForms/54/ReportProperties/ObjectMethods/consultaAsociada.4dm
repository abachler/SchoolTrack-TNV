If (Self:C308->=0)
	SET BLOB SIZE:C606([xShell_Reports:54]AssociatedQuery:21;0)
Else 
	If (BLOB size:C605([xShell_Reports:54]AssociatedQuery:21)=0)
		QR_AssociateQuery 
	End if 
	If (ok=0)
		Self:C308->:=0
	End if 
End if 
