_O_C_INTEGER:C282($r)
$r:=CD_Dlog (0;__ ("¿Desea Ud. realmente eliminar este registro?");__ ("");__ ("No");__ ("Eliminar"))
If ($r=2)
	$line:=AL_GetLine (xalp_Recorridos)
	$vl_ruta:=[BU_Rutas:26]ID:12
	ARRAY LONGINT:C221($viajes;0)
	  //Eliminación de Inscripciones
	
	READ WRITE:C146([BU_Rutas_Inscripciones:35])
	QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4;=;alBU_IdRecorrido{$line})
	DELETE SELECTION:C66([BU_Rutas_Inscripciones:35])
	READ ONLY:C145([BU_Rutas_Inscripciones:35])
	
	
	  //Eliminación de Viajes
	
	QUERY:C277([BU_Viajes:109];[BU_Viajes:109]Numero_Recorrido:4;=;alBU_IdRecorrido{$line})
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
	QUERY:C277([BU_Viajes:109];[BU_Viajes:109]Numero_Recorrido:4;=;alBU_IdRecorrido{$line})
	DELETE SELECTION:C66([BU_Viajes:109])
	READ ONLY:C145([BU_Viajes:109])
	ARRAY LONGINT:C221($viajes;0)
	
	  //Eliminación del Recorrido
	READ WRITE:C146([BU_Rutas_Recorridos:33])
	QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Recorrido:1;=;alBU_IdRecorrido{$line})
	DELETE RECORD:C58([BU_Rutas_Recorridos:33])
	READ ONLY:C145([BU_Rutas_Recorridos:33])
	
	BU_Refresh_Recorridos (1;$vl_ruta)
	$er:=Size of array:C274(alBU_IdRecorrido)
	IT_SetButtonState (($er>0);->bDel;->bPrintItems)
	If ($er=0)
		AL_UpdateArrays (xALP_Inscripciones;0)
		AT_Initialize (->atBU_ALProf;->atBU_Nombre;->atBU_Curso;->atBU_NomRec;->alBU_IdRec;->alBU_IdAlumno;->alBU_IdProfesor)
	End if 
	[BU_Rutas:26]Total_Recorridos:13:=[BU_Rutas:26]Total_Recorridos:13-1
	SAVE RECORD:C53([BU_Rutas:26])
End if 