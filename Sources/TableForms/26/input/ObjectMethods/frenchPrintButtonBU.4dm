If (Records in table:C83([BU_Rutas:26])>0)
	$line:=AL_GetLine (xalp_Recorridos)
	vl_RecorridoNumero:=alBU_IdRecorrido{$line}
	vl_NumeroRuta:=[BU_Rutas:26]ID:12
	vl_NumeroMonitor:=[BU_Rutas:26]Numero_Monitor:10
	vt_NombreRuta:=[BU_Rutas:26]Nombre:9
	vt_Patente:=[BU_Rutas:26]Patente_Bus:11
	
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1;=;vl_NumeroMonitor)
	vt_NombreMonitor:=[Profesores:4]Apellidos_y_nombres:28
	QUERY:C277([Buses_escolares:57];[Buses_escolares:57]Patente:1;=;vt_Patente)
	vt_Chofer:=[Buses_escolares:57]Chofer:5
	QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Recorrido:1;=;vl_RecorridoNumero)
	
	If (([BU_Rutas_Recorridos:33]Total_Alumnos:10=0) & ([BU_Rutas_Recorridos:33]Total_Profesores:11=0))
		CD_Dlog (0;__ ("No hay registros de inscripciones para imprimir, seleccione otro recorrido."))
	Else 
		vt_NombreRecorrido:=[BU_Rutas_Recorridos:33]Nombre:3
		vt_Dia:=[BU_Rutas_Recorridos:33]Dia_Semana:6
		vt_Desde:=[BU_Rutas_Recorridos:33]Calle_Desde:8
		vt_Hasta:=[BU_Rutas_Recorridos:33]Calle_Hasta:9
		vt_TotalAlumnos:=[BU_Rutas_Recorridos:33]Total_Alumnos:10
		vt_TotalFuncionarios:=[BU_Rutas_Recorridos:33]Total_Profesores:11
		
		READ ONLY:C145([BU_Rutas_Inscripciones:35])
		QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4;=;vl_RecorridoNumero)
		ORDER BY:C49([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Alumno_o_Profesor:8;>)
		FORM SET OUTPUT:C54([BU_Rutas_Inscripciones:35];"HojaRuta")
		PRINT SELECTION:C60([BU_Rutas_Inscripciones:35])
	End if 
End if 
QUERY:C277([BU_Rutas:26];[BU_Rutas:26]ID:12;=;vl_NumeroRuta)
