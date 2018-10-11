If (sMatBus#"")
	SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
	QUERY:C277([Buses_escolares:57];[Buses_escolares:57]Patente:1=sMatBus)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($recs#0)
		QUERY:C277([Buses_escolares:57];[Buses_escolares:57]Patente:1=sMatBus)
		[Alumnos:2]Patente_bus_escolar:37:=[Buses_escolares:57]Patente:1
		vl_NoBus:=[Buses_escolares:57]Numero:10
	Else 
		ok:=CD_Dlog (0;__ ("No existe ningún bus con patente ")+sMatBus+__ (".\r¿Desea Ud. crearlo?");__ ("");__ ("Sí");__ ("No"))
		If (ok=1)
			READ WRITE:C146([Buses_escolares:57])
			FORM SET INPUT:C55([Buses_escolares:57];"Input")
			flagCreacion:=2
			WDW_OpenFormWindow (->[Buses_escolares:57];"Input";-1;Movable form dialog box:K39:8;__ ("Transporte Escolar"))
			ADD RECORD:C56([Buses_escolares:57];*)
			CLOSE WINDOW:C154
			If (ok=1)
				[Alumnos:2]Patente_bus_escolar:37:=[Buses_escolares:57]Patente:1
			Else 
				sMatBus:=[Buses_escolares:57]Patente:1
				vl_NoBus:=[Buses_escolares:57]Numero:10
			End if 
			UNLOAD RECORD:C212([Buses_escolares:57])
			READ ONLY:C145([Buses_escolares:57])
			RELATE ONE:C42([Alumnos:2]Patente_bus_escolar:37)
			vl_NoBus:=[Buses_escolares:57]Numero:10
		Else 
			  //[Alumnos]Patente_bus_escolar:=""
			sMatBus:=[Buses_escolares:57]Patente:1
			vl_NoBus:=[Buses_escolares:57]Numero:10
		End if 
	End if 
Else 
	[Alumnos:2]Patente_bus_escolar:37:=Self:C308->
	vl_NoBus:=[Buses_escolares:57]Numero:10
End if 