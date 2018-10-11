If (atACT_ModelosAviso>0)
	vtACT_ModeloAviso:=atACT_ModelosAviso{atACT_ModelosAviso}
	_O_ENABLE BUTTON:C192(bEditarModelo)
	_O_ENABLE BUTTON:C192(bBorrarModelo)
	_O_ENABLE BUTTON:C192(bGuardarModelo)
Else 
	_O_DISABLE BUTTON:C193(bEditarModelo)
	_O_DISABLE BUTTON:C193(bBorrarModelo)
	_O_DISABLE BUTTON:C193(bGuardarModelo)
End if 