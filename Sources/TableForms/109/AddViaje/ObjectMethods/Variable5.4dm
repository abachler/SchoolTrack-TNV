If (Self:C308->>0)
	vtNombreRuta:=Self:C308->{Self:C308->}
	READ ONLY:C145([BU_Rutas_Recorridos:33])
	QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2;=;alIDRuta{Self:C308->})
	SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]Nombre:3;atRecorrido;[BU_Rutas_Recorridos:33]ID_Recorrido:1;alIDRecorrido)
	vtNombreRec:=""
	If (Size of array:C274(atRecorrido)>0)
		_O_ENABLE BUTTON:C192(atRecorrido)
		[BU_Viajes:109]Numero_Ruta:3:=alIDRuta{Self:C308->}
	Else 
		ok:=CD_Dlog (1;__ ("No existen recorridos para la Ruta Seleccionada\rDeben ser creados desde la Ficha de la Ruta");__ ("");__ ("OK"))
		vtNombreRuta:=""
	End if 
	
End if 