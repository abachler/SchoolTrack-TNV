$line:=AL_GetLine (xALP_Buses)
vtPatenteBus:=atBU_BUSPatente{$line}
WDW_OpenFormWindow (->[BU_Buses_Mantencion:32];"input";-1;4)
FORM SET INPUT:C55([BU_Buses_Mantencion:32];"input")
ADD RECORD:C56([BU_Buses_Mantencion:32];*)
CLOSE WINDOW:C154
If (Size of array:C274(alBU_Mantencion)>0)
	_O_ENABLE BUTTON:C192(bDelMantencion)
	_O_ENABLE BUTTON:C192(bDelDoc)
	_O_ENABLE BUTTON:C192(bAddDoc)
Else 
	_O_DISABLE BUTTON:C193(bDelMantencion)
	_O_DISABLE BUTTON:C193(bDelDoc)
	_O_DISABLE BUTTON:C193(bAddDoc)
End if 

If (Size of array:C274(alBU_DocID)>0)
	_O_ENABLE BUTTON:C192(bDelDoc)
Else 
	_O_DISABLE BUTTON:C193(bDelDoc)
End if 