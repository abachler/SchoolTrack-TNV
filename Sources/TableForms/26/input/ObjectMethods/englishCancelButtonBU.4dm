BU_SaveRutas 

If (Size of array:C274(alBU_IdRuta)>0)
	_O_ENABLE BUTTON:C192(bDelRuta)
	_O_ENABLE BUTTON:C192(bConfig)
Else 
	_O_DISABLE BUTTON:C193(bDelRuta)
	_O_DISABLE BUTTON:C193(bConfig)
End if 