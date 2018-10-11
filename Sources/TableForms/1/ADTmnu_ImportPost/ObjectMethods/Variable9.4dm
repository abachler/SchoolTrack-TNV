$path:=xfGetDirName ("Por favor seleccione la carpeta que contiene los archivos a importar")
If ($path#"")
	If (SYS_TestPathName ($path)=Is a folder:K24:2)
		_O_ENABLE BUTTON:C192(bImport)
		vt_g1:=$path
	Else 
		vt_g1:=""
		BEEP:C151
		_O_DISABLE BUTTON:C193(bImport)
	End if 
End if 