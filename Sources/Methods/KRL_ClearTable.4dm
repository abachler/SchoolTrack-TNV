//%attributes = {}
  //KRL_ClearTable

$wasReadOnly:=False:C215
If (Read only state:C362($1->))
	$wasReadOnly:=True:C214
	READ WRITE:C146($1->)
End if 
ALL RECORDS:C47($1->)
DELETE SELECTION:C66($1->)

If ($wasReadOnly)
	READ ONLY:C145($1->)
End if 