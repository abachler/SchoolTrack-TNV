_O_C_INTEGER:C282($r)
$r:=CD_Dlog (0;__ ("¿Desea Ud. realmente eliminar este registro?");__ ("");__ ("No");__ ("Eliminar"))
If ($r=2)
	
	  //Eliminación de Inscripciones
	
	$vl_Ruta:=AL_GetLine (xalp_Rutas)
	ARRAY LONGINT:C221($recorridos;0)
	ARRAY LONGINT:C221($viajes;0)
	QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2;=;alBU_IdRuta{$vl_Ruta})
	SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]ID_Recorrido:1;$recorridos)
	$er:=Size of array:C274($recorridos)
	If ($er>0)
		
		For ($i;1;$er)
			READ WRITE:C146([BU_Rutas_Inscripciones:35])
			QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4;=;$recorridos{$i})
			DELETE SELECTION:C66([BU_Rutas_Inscripciones:35])
			READ ONLY:C145([BU_Rutas_Inscripciones:35])
		End for 
		
	End if 
	
	  //Eliminacion de Registros de Viajes para Alumnos y Profesores
	QUERY:C277([BU_Viajes:109];[BU_Viajes:109]Numero_Ruta:3;=;alBU_IdRuta{$vl_Ruta})
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
	QUERY:C277([BU_Viajes:109];[BU_Viajes:109]Numero_Ruta:3;=;alBU_IdRuta{$vl_Ruta})
	DELETE SELECTION:C66([BU_Viajes:109])
	READ ONLY:C145([BU_Viajes:109])
	ARRAY LONGINT:C221($viajes;0)
	
	  //Eliminación de Recorridos
	READ WRITE:C146([BU_Rutas_Recorridos:33])
	QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2;=;alBU_IdRuta{$vl_Ruta})
	DELETE SELECTION:C66([BU_Rutas_Recorridos:33])
	READ ONLY:C145([BU_Rutas_Recorridos:33])
	ARRAY LONGINT:C221($recorridos;0)
	
	  //Eliminación de Comunas
	READ WRITE:C146([BU_Rutas_Comunas:27])
	QUERY:C277([BU_Rutas_Comunas:27];[BU_Rutas_Comunas:27]Numero_Ruta:1;=;alBU_IdRuta{$vl_Ruta})
	DELETE SELECTION:C66([BU_Rutas_Comunas:27])
	READ ONLY:C145([BU_Rutas_Comunas:27])
	
	  //Eliminación de la Ruta
	READ WRITE:C146([BU_Rutas:26])
	QUERY:C277([BU_Rutas:26];[BU_Rutas:26]ID:12;=;alBU_IdRuta{$vl_Ruta})
	DELETE RECORD:C58([BU_Rutas:26])
	READ ONLY:C145([BU_Rutas:26])
	
	BU_SaveRutas 
End if 

