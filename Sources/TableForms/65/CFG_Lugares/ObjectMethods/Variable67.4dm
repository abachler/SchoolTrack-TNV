
scode:=ST_Uppercase (Substring:C12(sCode;1;3))
If ([xxBBL_Preferencias:65]Lugar principal:29="")
	[xxBBL_Preferencias:65]Lugar principal:29:=sCode
End if 