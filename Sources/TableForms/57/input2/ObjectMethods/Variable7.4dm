sMatBus:=""
WDW_OpenFormWindow (->[Buses_escolares:57];"AddModBus";-1;4)  //Para abrir la ventana....
FORM SET INPUT:C55([Buses_escolares:57];"AddModBus")
ADD RECORD:C56([Buses_escolares:57];*)
CLOSE WINDOW:C154
AL_UpdateArrays (xalp_Buses;0)
BU_RefreshBuses 
AL_UpdateArrays (xalp_Buses;-2)

If (Size of array:C274(atBU_BUSPatente)>0)
	_O_ENABLE BUTTON:C192(bDelBus)
	_O_ENABLE BUTTON:C192(bAddMantencion)
Else 
	_O_DISABLE BUTTON:C193(bDelBus)
	_O_DISABLE BUTTON:C193(bAddMantencion)
End if 
