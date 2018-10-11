If (Self:C308->>0)
	  //Valida si el día de la semana de la fecha coincide con el día de la semana del Recorrido
	$dayIngresado:=DT_GetDayNumber_ISO8601 (dFrom)
	READ ONLY:C145([BU_Rutas_Recorridos:33])
	QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Recorrido:1;=;alIDRecorrido{Self:C308->})
	$dayRecorrido:=[BU_Rutas_Recorridos:33]Dia_Semana_Num:12
	
	  //Valida si el recorrido tiene inscripciones de alumnos
	READ ONLY:C145([BU_Rutas_Inscripciones:35])
	SET QUERY DESTINATION:C396(Into variable:K19:4;$inscripciones)
	QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4;=;alIDRecorrido{Self:C308->})
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	  //Valida si existen viajes para el recorrido y la fecha seleccionadas
	SET QUERY DESTINATION:C396(Into variable:K19:4;$viajes)
	QUERY:C277([BU_Viajes:109];[BU_Viajes:109]Numero_Recorrido:4;=;alIDRecorrido{Self:C308->};*)
	QUERY:C277([BU_Viajes:109]; & ;[BU_Viajes:109]Fecha:2;=;dFrom)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	If ($dayIngresado#$dayRecorrido)  //Primera Validación x día 
		ok:=CD_Dlog (1;__ ("El día de la fecha seleccionada no corresponde \ral día del Recorrido seleccionado");__ ("");__ ("OK"))
		dFrom:=!00-00-00!
		vtNombreRec:=""
	Else 
		If (($inscripciones>0) & ($viajes=0))  //Segunda Validación por Inscripciones y Viajes
			vtNombreRec:=Self:C308->{Self:C308->}
			[BU_Viajes:109]Numero_Recorrido:4:=alIDRecorrido{Self:C308->}
		Else 
			If ($inscripciones=0)
				ok:=CD_Dlog (1;__ ("No existen Inscripciones para el Recorrido Seleccionado\rDeben ser creados desde la Ficha de la Ruta");__ ("");__ ("OK"))
				vtNombreRec:=""
			Else 
				ok:=CD_Dlog (1;__ ("Ya existe un viaje creado para la Fecha y Recorrido seleccionados");__ ("");__ ("OK"))
				vtNombreRec:=""
			End if 
			
		End if 
		
	End if 
	
End if 