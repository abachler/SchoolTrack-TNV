If (vb_validaObsVacia)
	If (vtACT_ObsDocs="")
		GOTO OBJECT:C206(vtACT_ObsDocs)
		CD_Dlog (0;vt_Dlog)
	Else 
		ACCEPT:C269
	End if 
Else 
	ACCEPT:C269
End if 