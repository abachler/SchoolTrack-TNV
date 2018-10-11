If (Self:C308->=1)
	vt_DirectorioLocal:=Select folder:C670
	If (vt_DirectorioLocal="")
		Self:C308->:=0
	Else 
		_O_ENABLE BUTTON:C192(bOK)
	End if 
Else 
	vt_DirectorioLocal:=""
End if 