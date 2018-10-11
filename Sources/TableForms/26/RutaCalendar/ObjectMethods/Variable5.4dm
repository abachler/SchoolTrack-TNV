If (Self:C308->>0)
	vt_Lunes:=""
	vt_Martes:=""
	vt_Miercoles:=""
	vt_Jueves:=""
	vt_Viernes:=""
	vt_Sabado:=""
	vt_Domingo:=""
	
	vt_NombreRuta:=Self:C308->{Self:C308->}
	READ ONLY:C145([BU_Rutas:26])
	QUERY:C277([BU_Rutas:26];[BU_Rutas:26]ID:12;=;al_RutaNumber{Self:C308->})
	vt_placaBus:=[BU_Rutas:26]Patente_Bus:11
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1;=;[BU_Rutas:26]Numero_Monitor:10)
	vt_NombreMonitor:=[Profesores:4]Apellidos_y_nombres:28
	QUERY:C277([Buses_escolares:57];[Buses_escolares:57]Patente:1;=;vt_placaBus)
	vt_NombreConductor:=[Buses_escolares:57]Chofer:5
	READ ONLY:C145([BU_Rutas_Recorridos:33])
	QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2;=;al_RutaNumber{Self:C308->})
	ORDER BY:C49([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]Hora:5)
	
	FIRST RECORD:C50([BU_Rutas_Recorridos:33])
	For ($i;1;Records in selection:C76([BU_Rutas_Recorridos:33]))
		Case of 
				
			: ([BU_Rutas_Recorridos:33]Dia_Semana:6="Lunes")
				vt_Lunes:=vt_Lunes+[BU_Rutas_Recorridos:33]Nombre:3+" "+String:C10([BU_Rutas_Recorridos:33]Hora:5;HH MM:K7:2)+"\r"
				
			: ([BU_Rutas_Recorridos:33]Dia_Semana:6="Martes")
				vt_Martes:=vt_Martes+[BU_Rutas_Recorridos:33]Nombre:3+" "+String:C10([BU_Rutas_Recorridos:33]Hora:5;HH MM:K7:2)+"\r"
				
			: ([BU_Rutas_Recorridos:33]Dia_Semana:6="Miércoles")
				vt_Miercoles:=vt_Miercoles+[BU_Rutas_Recorridos:33]Nombre:3+" "+String:C10([BU_Rutas_Recorridos:33]Hora:5;HH MM:K7:2)+"\r"
				
			: ([BU_Rutas_Recorridos:33]Dia_Semana:6="Jueves")
				vt_Jueves:=vt_Jueves+[BU_Rutas_Recorridos:33]Nombre:3+" "+String:C10([BU_Rutas_Recorridos:33]Hora:5;HH MM:K7:2)+"\r"
				
			: ([BU_Rutas_Recorridos:33]Dia_Semana:6="Viernes")
				vt_Viernes:=vt_Viernes+[BU_Rutas_Recorridos:33]Nombre:3+" "+String:C10([BU_Rutas_Recorridos:33]Hora:5;HH MM:K7:2)+"\r"
				
			: ([BU_Rutas_Recorridos:33]Dia_Semana:6="Sabado")
				vt_Sabado:=vt_Sabado+[BU_Rutas_Recorridos:33]Nombre:3+" "+String:C10([BU_Rutas_Recorridos:33]Hora:5;HH MM:K7:2)+"\r"
				
			: ([BU_Rutas_Recorridos:33]Dia_Semana:6="Domingo")
				vt_Domingo:=vt_Domingo+[BU_Rutas_Recorridos:33]Nombre:3+" "+String:C10([BU_Rutas_Recorridos:33]Hora:5;HH MM:K7:2)+"\r"
				
				
		End case 
		
		NEXT RECORD:C51([BU_Rutas_Recorridos:33])
	End for 
	
End if 