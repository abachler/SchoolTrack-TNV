BU_SaveViajesPersonas 
dViaje:=DT_PopCalendar 
If (dViaje>Current date:C33(*))
	ok:=CD_Dlog (1;__ ("No puede ingresar una fecha posterior a la actual  \r debe ingresar otra fecha");__ ("");__ ("OK"))
	dViaje:=!00-00-00!
End if 
  //ok:=CD_Dlog (0;"¿Desea Ud. modificar la fecha del viaje?";"";RP_GetIdxString (21102;1);RP_GetIdxString (21102;2))
If (ok=1)
	  //[BU_Viajes]Fecha:=dViaje
	  //Else 
	AL_UpdateArrays (xALP_BURecorridos;0)
	AL_UpdateArrays (xALP_BUAsistentes;0)
	BU_InicializaArrayViajes 
	ARRAY LONGINT:C221(aRutas;0)
	ARRAY TEXT:C222(atRuta;0)
	ARRAY LONGINT:C221(alIDRuta;0)
	QUERY:C277([BU_Viajes:109];[BU_Viajes:109]Fecha:2;=;dViaje)
	AT_DistinctsFieldValues (->[BU_Viajes:109]Numero_Ruta:3;->aRutas;1)
	QRY_QueryWithArray (->[BU_Rutas:26]ID:12;->aRutas)
	AT_Initialize (->aRutas)
	SELECTION TO ARRAY:C260([BU_Rutas:26]Nombre:9;atRuta;[BU_Rutas:26]ID:12;alIDRuta)
	vtNombreRuta:=""
End if 

