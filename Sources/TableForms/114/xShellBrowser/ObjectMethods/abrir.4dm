If (vtBWR_OnDClickMethod#"")
	If (API Does Method Exist (vtBWR_OnDClickMethod)=1)
		KRL_ExecuteMethod (vtBWR_OnDClickMethod)
	End if 
Else 
	BWR_OpenRecord 
End if 