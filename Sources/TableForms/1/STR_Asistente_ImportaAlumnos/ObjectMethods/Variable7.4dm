$ref:=Open document:C264("";"TEXT";Read mode:K24:5)
If (($ref#?00:00:00?) & (document#""))
	CLOSE DOCUMENT:C267($ref)
	vtIOstr_FilePath:=document
	If (Test path name:C476(vtIOstr_FilePath)=1)
		  //If (Document type(document)="TEXT")
		  //If (Document type(document)="TEXT") | (Document type(document)="TXT")
		If (_o_Document type:C528(document)="TEXT") | (_o_Document type:C528(document)="TXT") | (Substring:C12(document;Length:C16(document)-3;4)=".txt")  //20171122 RCH
			_O_ENABLE BUTTON:C192(bNext)
			vt_errorStatus:=""
		Else 
			OBJECT SET COLOR:C271(vt_errorStatus;-3)
			BEEP:C151
			vt_errorStatus:="El archivo indicado no es de tipo texto."
			_O_DISABLE BUTTON:C193(bNext)
		End if 
	Else 
		vtIOstr_FilePath:=""
		vt_errorStatus:="Debe indicar un nombre de archivo existente y donde fue originado."
		OBJECT SET COLOR:C271(vt_errorStatus;-3)
		BEEP:C151
		_O_DISABLE BUTTON:C193(bNext)
	End if 
Else 
	vtIOstr_FilePath:=""
	OBJECT SET COLOR:C271(vt_errorStatus;-3)
	BEEP:C151
	vt_errorStatus:="Debe indicar un nombre de archivo existente y donde fue originado."
	_O_DISABLE BUTTON:C193(bNext)
End if 