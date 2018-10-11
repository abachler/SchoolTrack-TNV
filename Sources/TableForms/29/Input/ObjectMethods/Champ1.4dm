Self:C308->:=ST_Format (Self:C308)
$r:=XCR_fExist 

If ([Actividades:29]Nombre:2#"")
	_O_ENABLE BUTTON:C192(bInscribir)
Else 
	_O_DISABLE BUTTON:C193(bInscribir)
End if 