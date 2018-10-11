$doc:=xfGetFileName 
If ($doc#"")
	If (SYS_TestPathName ($doc)=1)
		_O_ENABLE BUTTON:C192(bNext)
		_O_ENABLE BUTTON:C192(bImport)
		vt_rutaArchivo:=$doc
		<>vt_rutaArchivo:=vt_rutaArchivo
	Else 
		vt_rutaArchivo:=""
		BEEP:C151
		_O_DISABLE BUTTON:C193(bNext)
		_O_DISABLE BUTTON:C193(bImport)
	End if 
End if 
POST KEY:C465(Character code:C91("+");256)