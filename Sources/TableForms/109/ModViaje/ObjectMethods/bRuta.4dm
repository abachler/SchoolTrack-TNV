$text:=AT_array2text (->atRuta)
$choice:=Pop up menu:C542($text)

If ($choice>0)
	vtNombreRuta:=atRuta{$choice}
	READ ONLY:C145([BU_Rutas_Recorridos:33])
	QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2;=;alIDRuta{$choice})
	SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]Nombre:3;atRecorrido;[BU_Rutas_Recorridos:33]ID_Recorrido:1;alIDRecorrido)
	vtNombreRec:=""
	If (Size of array:C274(atRecorrido)>0)
		[BU_Viajes:109]Numero_Ruta:3:=alIDRuta{$choice}
	Else 
		ok:=CD_Dlog (1;__ ("No existen recorridos para la Ruta Seleccionada.\rDeben ser creados desde la Ficha de la Ruta.");__ ("");__ ("OK"))
		vtNombreRuta:=""
	End if 
	IT_SetButtonState ((Size of array:C274(atRecorrido)>0);->bRecorrido)
End if 
