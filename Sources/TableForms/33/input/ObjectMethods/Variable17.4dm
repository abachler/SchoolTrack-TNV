_O_C_INTEGER:C282($r)
$r:=CD_Dlog (0;__ ("¿Desea Ud. realmente eliminar este registro?");__ ("");__ ("No");__ ("Eliminar"))
If ($r=2)
	
	$vl_rec:=[BU_Rutas_Recorridos:33]ID_Recorrido:1
	
	ARRAY LONGINT:C221($viajes;0)
	  //Eliminación de Inscripciones
	
	READ WRITE:C146([BU_Rutas_Inscripciones:35])
	QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4;=;$vl_rec)
	DELETE SELECTION:C66([BU_Rutas_Inscripciones:35])
	READ ONLY:C145([BU_Rutas_Inscripciones:35])
	
	
	  //Eliminación de Viajes
	
	QUERY:C277([BU_Viajes:109];[BU_Viajes:109]Numero_Recorrido:4;=;$vl_rec)
	SELECTION TO ARRAY:C260([BU_Viajes:109]ID:1;$viajes)
	If (Size of array:C274($viajes)>0)
		
		For ($i;1;Size of array:C274($viajes))
			READ WRITE:C146([BU_Viajes_Personas:111])
			QUERY:C277([BU_Viajes_Personas:111];[BU_Viajes_Personas:111]Numero_Viaje:2;=;$viajes{$i})
			DELETE SELECTION:C66([BU_Viajes_Personas:111])
			READ ONLY:C145([BU_Viajes_Personas:111])
		End for 
		
	End if 
	
	  //Eliminación de Viajes
	
	READ WRITE:C146([BU_Viajes:109])
	QUERY:C277([BU_Viajes:109];[BU_Viajes:109]Numero_Recorrido:4;=;$vl_rec)
	DELETE SELECTION:C66([BU_Viajes:109])
	READ ONLY:C145([BU_Viajes:109])
	ARRAY LONGINT:C221($viajes;0)
	
	  //Eliminación del Recorrido
	READ WRITE:C146([BU_Rutas_Recorridos:33])
	QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Recorrido:1;=;$vl_rec)
	DELETE RECORD:C58([BU_Rutas_Recorridos:33])
	READ ONLY:C145([BU_Rutas_Recorridos:33])
	
	BU_Refresh_Recorridos (1;[BU_Rutas:26]ID:12)
	[BU_Rutas:26]Total_Recorridos:13:=[BU_Rutas:26]Total_Recorridos:13-1
	SAVE RECORD:C53([BU_Rutas:26])
End if 
$er:=Size of array:C274(alBU_IdRecorrido)
If ($er>0)
	_O_ENABLE BUTTON:C192(bDel)
	_O_ENABLE BUTTON:C192(bPrintItems)
	
Else 
	
	_O_DISABLE BUTTON:C193(bDel)
	_O_DISABLE BUTTON:C193(bPrintItems)
End if 
CANCEL:C270
