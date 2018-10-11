If (sMatBus#"")
	$recNumRuta:=Record number:C243([BU_Rutas:26])
	$vl_CodigoRuta:=[BU_Rutas:26]ID:12
	SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
	QUERY:C277([Buses_escolares:57];[Buses_escolares:57]Patente:1=sMatBus)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($recs#0)
		QUERY:C277([Buses_escolares:57];[Buses_escolares:57]Patente:1=sMatBus)
		$vt_PatenteBus:=[Buses_escolares:57]Capacidad:11
		$valorvalidacion:=BU_ValidaCupo ($vl_CodigoRuta;$vt_PatenteBus)
		If ($recNumRuta>-1)
			READ WRITE:C146([BU_Rutas:26])
			GOTO RECORD:C242([BU_Rutas:26];$recNumRuta)
		End if 
		If ($valorvalidacion#0)
			OK:=CD_Dlog (1;__ ("Existe al menos un recorrido con  un número de inscripciones superior a la capacidad del Bus \rNo se podrá asignar el nuevo bus si no se eliminan las inscripciones");__ ("");__ ("Ok"))
			sMatBus:=[BU_Rutas:26]Patente_Bus:11
		Else 
			QUERY:C277([Buses_escolares:57];[Buses_escolares:57]Patente:1=sMatBus)
			[BU_Rutas:26]Patente_Bus:11:=[Buses_escolares:57]Patente:1
			[BU_Rutas:26]Cupo_Total:3:=[Buses_escolares:57]Capacidad:11
			vl_NoBus:=[Buses_escolares:57]Numero:10
		End if 
	Else 
		ok:=CD_Dlog (0;__ ("No existe ningún bus con patente ")+sMatBus+__ (".\r¿Desea Ud. crearlo?");__ ("");__ ("Sí");__ ("No"))
		If (ok=1)
			READ WRITE:C146([Buses_escolares:57])
			FORM SET INPUT:C55([Buses_escolares:57];"AddModBus")
			flagCreacion:=2
			WDW_OpenFormWindow (->[Buses_escolares:57];"AddModBus";-1;4)
			ADD RECORD:C56([Buses_escolares:57];*)
			CLOSE WINDOW:C154
			If ($recNumRuta=-3)
				$valorvalidacion:=0
			Else 
				$valorvalidacion:=BU_ValidaCupo ($vl_CodigoRuta;[Buses_escolares:57]Capacidad:11)
			End if 
			If ($recNumRuta>-1)
				READ WRITE:C146([BU_Rutas:26])
				GOTO RECORD:C242([BU_Rutas:26];$recNumRuta)
			End if 
			If ($valorvalidacion#0)
				OK:=CD_Dlog (1;__ ("Existe al menos un recorrido con  un número de inscripciones superior a la capacidad del Bus.\rNo se podrá asignar el nuevo bus si no se eliminan las inscripciones");__ ("");__ ("Ok"))
				sMatBus:=[BU_Rutas:26]Patente_Bus:11
			Else 
				If (ok=1)
					[BU_Rutas:26]Patente_Bus:11:=[Buses_escolares:57]Patente:1
					[BU_Rutas:26]Cupo_Total:3:=[Buses_escolares:57]Capacidad:11
				Else 
					sMatBus:=[Buses_escolares:57]Patente:1
					vl_NoBus:=[Buses_escolares:57]Numero:10
				End if 
				KRL_UnloadReadOnly (->[Buses_escolares:57])
				QUERY:C277([Buses_escolares:57];[Buses_escolares:57]Patente:1=sMatBus)
				vl_NoBus:=[Buses_escolares:57]Numero:10
			End if 
		Else 
			sMatBus:=[Buses_escolares:57]Patente:1
			vl_NoBus:=[Buses_escolares:57]Numero:10
		End if 
	End if 
Else 
	[BU_Rutas:26]Patente_Bus:11:=Self:C308->
	[BU_Rutas:26]Cupo_Total:3:=[Buses_escolares:57]Capacidad:11
	vl_NoBus:=[Buses_escolares:57]Numero:10
End if 