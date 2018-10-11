//%attributes = {}
  //BU_Configuracion

  //EMA --> Transporte Escolar
  //Abre una ventana con las dimensiones del formulario
  //Pirmer argumento: Puntero a la tabla que contiene el formulario
  //Segundo argumento: Nombre del formulario
  //$1=TablePointer; $2=FormName; $3=position; $4=type
  //Posicion : -1
  //Type: para redimensionar para 8, de lo contrario 4

C_PICTURE:C286(vpXS_IconModule)

vsBWR_CurrentModule:="TransportTrack"
GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)

ARRAY TEXT:C222(atBU_NombreRuta;0)
ARRAY LONGINT:C221(alBU_TotRecorridos;0)
ARRAY TEXT:C222(atBU_PatenteRuta;0)
ARRAY LONGINT:C221(alBU_MonitorID;0)
ARRAY LONGINT:C221(alBU_IdRuta;0)

ALL RECORDS:C47([BU_Rutas:26])
SELECTION TO ARRAY:C260([BU_Rutas:26]Nombre:9;atBU_NombreRuta;[BU_Rutas:26]Total_Recorridos:13;alBU_TotRecorridos;[BU_Rutas:26]Patente_Bus:11;atBU_PatenteRuta;[BU_Rutas:26]Numero_Monitor:10;alBU_MonitorID;[BU_Rutas:26]ID:12;alBU_IdRuta)
$reg:=Size of array:C274(alBU_MonitorID)
ARRAY TEXT:C222(atBU_MonitorRuta;0)
ARRAY TEXT:C222(atBU_MonitorRuta;$reg)
READ ONLY:C145([Profesores:4])
For ($i;1;$reg)
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=alBU_MonitorID{$i})
	atBU_MonitorRuta{$i}:=[Profesores:4]Apellidos_y_nombres:28
End for 
LOG_RegisterEvt ("Acceso a TransportTrack.")
WDW_OpenFormWindow (->[xxSTR_Constants:1];"BU_ListaRutas";-1;4;vsBWR_CurrentModule)  //Para abrir la ventana....
DIALOG:C40([xxSTR_Constants:1];"BU_ListaRutas")  //Para abrir el formulario.....
CLOSE WINDOW:C154