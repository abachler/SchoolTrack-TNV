If (sMatBus#"")
	flagCreacion:=3
	  //WDW_Open (415;210;0;4;"Transporte escolar")
	WDW_OpenFormWindow (->[Buses_escolares:57];"Input";0;4;__ ("Transporte Escolar"))
	KRL_ModifyRecord (->[Buses_escolares:57];"Input")
	CLOSE WINDOW:C154
	If ([Buses_escolares:57]Patente:1#"")
		[Alumnos:2]Patente_bus_escolar:37:=[Buses_escolares:57]Patente:1
	Else 
		[Alumnos:2]Patente_bus_escolar:37:=""
		sMatBus:=""
	End if 
	UNLOAD RECORD:C212([Buses_escolares:57])
	READ ONLY:C145([Buses_escolares:57])
	RELATE ONE:C42([Alumnos:2]Patente_bus_escolar:37)
	sMatBus:=[Buses_escolares:57]Patente:1
	vl_NoBus:=[Buses_escolares:57]Numero:10
End if 