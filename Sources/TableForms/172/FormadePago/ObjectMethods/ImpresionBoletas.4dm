If (Self:C308->=1)
	cbImprimirRecPago:=0
	_O_DISABLE BUTTON:C193(bModRecibo)
	_O_ENABLE BUTTON:C192(atACT_Categorias)
Else 
	_O_DISABLE BUTTON:C193(atACT_Categorias)
End if 