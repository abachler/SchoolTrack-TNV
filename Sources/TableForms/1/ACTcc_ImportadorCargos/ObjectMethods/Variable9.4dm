$doc:=xfGetFileName 
If ($doc#"")
	C_BOOLEAN:C305($b_existe)
	If (SYS_TestPathName ($doc)=1)
		$b_existe:=True:C214
		vt_g1:=$doc
	Else 
		vt_g1:=""
		BEEP:C151
	End if 
	OBJECT SET ENABLED:C1123(bNext;$b_existe)
	OBJECT SET ENABLED:C1123(bImport;$b_existe)
End if 