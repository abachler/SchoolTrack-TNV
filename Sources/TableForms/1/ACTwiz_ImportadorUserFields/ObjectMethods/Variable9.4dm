  //$doc:=xfGetFileName 
$ref:=Open document:C264("";"";Read mode:K24:5)
If (ok=1)
	CLOSE DOCUMENT:C267($ref)
	$doc:=document
	If ($doc#"")
		If (SYS_TestPathName ($doc)=1)
			_O_ENABLE BUTTON:C192(bImport)
			vt_g1:=$doc
		Else 
			vt_g1:=""
			BEEP:C151
			_O_DISABLE BUTTON:C193(bImport)
		End if 
	End if 
End if 