$doc:=xfGetFileName 
If ($doc#"")
	If (SYS_TestPathName ($doc)=Is a document:K24:1)
		_O_ENABLE BUTTON:C192(bImport)
		vt_g1:=$doc
	Else 
		vt_g1:=""
		BEEP:C151
		_O_DISABLE BUTTON:C193(bImport)
	End if 
End if 