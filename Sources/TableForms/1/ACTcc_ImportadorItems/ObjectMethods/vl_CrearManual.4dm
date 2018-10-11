If (vl_CrearManual=1)
	vb_manual:=True:C214
	_O_DISABLE BUTTON:C193(vt_g1)
	_O_DISABLE BUTTON:C193(bExplore)
Else 
	vb_manual:=False:C215
	_O_ENABLE BUTTON:C192(vt_g1)
	_O_ENABLE BUTTON:C192(bExplore)
End if 