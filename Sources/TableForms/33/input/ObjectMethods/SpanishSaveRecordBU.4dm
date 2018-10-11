
Case of 
	: ([BU_Rutas_Recorridos:33]Jornada:4="")
		OK:=CD_Dlog (1;__ ("Debe ingresar la Jornada del Recorrido.");__ ("");__ ("Ok"))
	: ([BU_Rutas_Recorridos:33]Dia_Semana:6="")
		OK:=CD_Dlog (1;__ ("Debe ingresar el Día de la Semana.");__ ("");__ ("Ok"))
	: ([BU_Rutas_Recorridos:33]Hora:5=Time:C179("00:00"))
		OK:=CD_Dlog (1;__ ("Debe ingresar la Hora de Inicio del Recorrido.");__ ("");__ ("Ok"))
	Else 
		$validacion:=BU_ValidaRecorrido 
		
		Case of 
			: ($validacion=0)
				SAVE RECORD:C53([BU_Rutas_Recorridos:33])
				  //KRL_UnloadReadOnly (->[BU_Rutas_Recorridos])
				[BU_Rutas:26]Total_Recorridos:13:=[BU_Rutas:26]Total_Recorridos:13+1
				SAVE RECORD:C53([BU_Rutas:26])
				CANCEL:C270
			: ($validacion=1)
				OK:=CD_Dlog (1;__ ("Ya existe un recorrido para esta Ruta con la misma configuración.");__ ("");__ ("Ok"))
			: ($validacion=2)
				OK:=CD_Dlog (1;__ ("Existen viajes creados para este Recorrido \rNo puede cambiar la Jornada, el día o la hora.");__ ("");__ ("Ok"))
		End case 
End case 