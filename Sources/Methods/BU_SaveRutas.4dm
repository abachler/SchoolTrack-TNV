//%attributes = {}
  //BU_SaveRutas

AL_UpdateArrays (xalp_Rutas;0)
ARRAY TEXT:C222(atBU_NombreRuta;0)
ARRAY LONGINT:C221(alBU_TotRecorridos;0)
ARRAY TEXT:C222(atBU_PatenteRuta;0)
ARRAY LONGINT:C221(alBU_MonitorID;0)
ARRAY LONGINT:C221(alBU_IdRuta;0)

ALL RECORDS:C47([BU_Rutas:26])
SELECTION TO ARRAY:C260([BU_Rutas:26]Nombre:9;atBU_NombreRuta;[BU_Rutas:26]Total_Recorridos:13;alBU_TotRecorridos;[BU_Rutas:26]Patente_Bus:11;atBU_PatenteRuta;[BU_Rutas:26]Numero_Monitor:10;alBU_MonitorID;[BU_Rutas:26]ID:12;alBU_IdRuta)
$reg:=Size of array:C274(alBU_MonitorID)
ARRAY TEXT:C222(atBU_MonitorRuta;$reg)
READ ONLY:C145([Profesores:4])
For ($i;1;$reg)
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=alBU_MonitorID{$i})
	atBU_MonitorRuta{$i}:=[Profesores:4]Apellidos_y_nombres:28
End for 
AL_UpdateArrays (xalp_Rutas;-2)
