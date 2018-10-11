
If (Test path name:C476(vtIOstr_FilePath)>=0)
	If (_o_Document type:C528(document)="TEXT")
		_O_ENABLE BUTTON:C192(bNext)
		vt_errorStatus:="Presione Flecha Derecha para continuar"
		OBJECT SET COLOR:C271(vt_errorStatus;-15)
	Else 
		OBJECT SET COLOR:C271(vt_errorStatus;-3)
		vt_errorStatus:="El archivo indicado no es de tipo texto."
	End if 
Else 
	vtIOstr_FilePath:=""
	vt_errorStatus:="Debe indicar un nombre de archivo existente y donde fue originado."
	OBJECT SET COLOR:C271(vt_errorStatus;-3)
	CD_Dlog (0;__ ("No se encontró ningún archivo en el camino indicado."))
End if 