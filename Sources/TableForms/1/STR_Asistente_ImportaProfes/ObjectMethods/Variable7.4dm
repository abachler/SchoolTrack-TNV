$ref:=Open document:C264("";"TEXT")
If (($ref#?00:00:00?) & (document#""))
	vt_errorStatus:="Presione Flecha Derecha para continuar"
	OBJECT SET COLOR:C271(vt_errorStatus;-15)
	CLOSE DOCUMENT:C267($ref)
	vtIOstr_FilePath:=document
	_O_ENABLE BUTTON:C192(bNext)
Else 
	OBJECT SET COLOR:C271(vt_errorStatus;-3)
	vt_errorStatus:="Debe indicar un nombre de archivo existente y donde fue originado."
End if 