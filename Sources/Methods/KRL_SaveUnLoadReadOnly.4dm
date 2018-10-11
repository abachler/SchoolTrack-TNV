//%attributes = {}
  //KRL_UnloadReadOnly

If (Type:C295($1)=Is pointer:K8:14)
	RESOLVE POINTER:C394($1;$varName;$tableNum;$fieldNum)
	If ($tableNum#-1)
		SAVE RECORD:C53($1->)
		KRL_UnloadReadOnly ($1)
	Else 
		ALERT:C41("Invalid table pointer.")
	End if 
Else 
	ALERT:C41("Parameter must be a pointer to a table.")
End if 