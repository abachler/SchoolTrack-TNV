If (Form event:C388=On Losing Focus:K2:8)
	If (Test path name:C476(vtIOstr_FilePath)=1)
		  //If (Document type(document)="TEXT")
		  //20141106 ASM Document type en v13, devuelve la extensión.
		If (_o_Document type:C528(document)="TEXT") | (_o_Document type:C528(document)="TXT")
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
		  //CD_Dlog (0;"No se encontró ningún archivo en el camino indicado.")
	End if 
End if 