$proc:=IT_UThermometer (1;0;__ ("Configurando CommTrack..."))
PREF_Set (0;"CMT_ONOFF";String:C10(<>vl_CMT_OnOff))

If (Self:C308->=1)
	_O_ENABLE BUTTON:C192(bUpdateAll)
	_O_ENABLE BUTTON:C192(bUpdateMod)
	$vt_modulo:=String:C10(CommTrack)
	CMT_Transferencia ("CargaLibreria";->$vt_modulo)
Else 
	_O_DISABLE BUTTON:C193(bUpdateAll)
	_O_DISABLE BUTTON:C193(bUpdateMod)
	CMT_Transferencia ("LimpiaTabla")
End if 

IT_UThermometer (-2;$proc)