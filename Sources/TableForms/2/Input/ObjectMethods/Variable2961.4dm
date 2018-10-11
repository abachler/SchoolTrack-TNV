If (Self:C308->#0)
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
	QUERY:C277([Buses_escolares:57];[Buses_escolares:57]Numero:10=vl_NoBus)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($recs>0)
		If ($recs>1)
			QUERY:C277([Buses_escolares:57];[Buses_escolares:57]Numero:10=vl_NoBus)
			SELECTION TO ARRAY:C260([Buses_escolares:57]Patente:1;aPatente)
			ARRAY POINTER:C280(<>aChoicePtrs;2)
			<>aChoicePtrs{1}:=->aPatente
			<>aChoicePtrs{2}:=->aPatente
			TBL_ShowChoiceList (1;"Seleccione el bus")
			[Alumnos:2]Patente_bus_escolar:37:=aPatente{choiceIdx}
			sMatBus:=aPatente{choiceIdx}
			UNLOAD RECORD:C212([Buses_escolares:57])
			READ ONLY:C145([Buses_escolares:57])
			RELATE ONE:C42([Alumnos:2]Patente_bus_escolar:37)
			AT_Initialize (-><>aChoicePtrs;->aPatente)
		Else 
			QUERY:C277([Buses_escolares:57];[Buses_escolares:57]Numero:10=vl_NoBus)
			[Alumnos:2]Patente_bus_escolar:37:=[Buses_escolares:57]Patente:1
			sMatBus:=[Alumnos:2]Patente_bus_escolar:37
		End if 
	Else 
		ok:=CD_Dlog (0;__ ("No existe ningún bus con número ")+String:C10(Self:C308->)+__ (".\r¿Desea Ud. crearlo?");__ ("");__ ("Sí");__ ("No"))
		If (ok=1)
			READ WRITE:C146([Buses_escolares:57])
			FORM SET INPUT:C55([Buses_escolares:57];"Input")
			flagCreacion:=1
			WDW_OpenFormWindow (->[Buses_escolares:57];"Input";-1;Movable form dialog box:K39:8;__ ("Transporte Escolar"))
			  //WDW_Open (415;210;0;-723;"Transporte escolar";"wdwCloseDlog")
			ADD RECORD:C56([Buses_escolares:57];*)
			CLOSE WINDOW:C154
			If (ok=1)
				[Alumnos:2]Patente_bus_escolar:37:=[Buses_escolares:57]Patente:1
				sMatBus:=[Alumnos:2]Patente_bus_escolar:37
			Else 
				RELATE ONE:C42([Alumnos:2]Patente_bus_escolar:37)
				sMatBus:=[Buses_escolares:57]Patente:1
				vl_NoBus:=[Buses_escolares:57]Numero:10
			End if 
			UNLOAD RECORD:C212([Buses_escolares:57])
			READ ONLY:C145([Buses_escolares:57])
			RELATE ONE:C42([Alumnos:2]Patente_bus_escolar:37)
			sMatBus:=[Buses_escolares:57]Patente:1
		Else 
			[Alumnos:2]Patente_bus_escolar:37:=""
			  //Self->:=0
			sMatBus:=[Buses_escolares:57]Patente:1
			vl_NoBus:=[Buses_escolares:57]Numero:10
		End if 
	End if 
Else 
	[Alumnos:2]Patente_bus_escolar:37:=""
End if 