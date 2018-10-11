//%attributes = {}
  //BU_Refresh_Recorridos

  //EMA --> Transporte Escolar
  //Método creado para actualizar el xalp_Recorridos de BU_Rutas_Input
  //$1
  //0= Llamado desde Formulario  BU_Listas_Rutas, inicialiación del Area List
  //1= Llamado desde otros métodos
  //$2
  //Id de la Ruta

If ($1=0)
	  //Declaración de Arreglos a utilizar en el formulario
	ARRAY TEXT:C222(atBU_RecNombre;0)
	ARRAY TEXT:C222(atBU_Jornada;0)
	ARRAY LONGINT:C221(aBU_Hora;0)
	ARRAY TEXT:C222(atBU_Dia;0)
	ARRAY BOOLEAN:C223(abBU_ES;0)
	ARRAY LONGINT:C221(alBU_IdRecorrido;0)  //oculto
	ARRAY LONGINT:C221(alBU_Ruta;0)  //oculto
	  //Cargar datos de los arreglos
	READ ONLY:C145([BU_Rutas_Recorridos:33])
	QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2=$2)
	SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]Nombre:3;atBU_RecNombre;[BU_Rutas_Recorridos:33]Jornada:4;atBU_Jornada;[BU_Rutas_Recorridos:33]Hora:5;alBU_Hora;[BU_Rutas_Recorridos:33]Dia_Semana:6;atBU_Dia;[BU_Rutas_Recorridos:33]Ida_o_vuelta:7;abBU_ES;[BU_Rutas_Recorridos:33]ID_Recorrido:1;alBU_IdRecorrido;[BU_Rutas_Recorridos:33]ID_Ruta:2;alBU_Ruta)
Else 
	AL_UpdateArrays (xalp_Recorridos;0)
	  //Declaración de Arreglos a utilizar en el formulario
	ARRAY TEXT:C222(atBU_RecNombre;0)
	ARRAY TEXT:C222(atBU_Jornada;0)
	ARRAY LONGINT:C221(alBU_Hora;0)
	ARRAY TEXT:C222(atBU_Dia;0)
	ARRAY BOOLEAN:C223(abBU_ES;0)
	ARRAY LONGINT:C221(alBU_IdRecorrido;0)  //oculto
	ARRAY LONGINT:C221(alBU_Ruta;0)  //oculto
	  //Cargar datos de los arreglos
	READ ONLY:C145([BU_Rutas_Recorridos:33])
	QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2=$2)
	SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]Nombre:3;atBU_RecNombre;[BU_Rutas_Recorridos:33]Jornada:4;atBU_Jornada;[BU_Rutas_Recorridos:33]Hora:5;alBU_Hora;[BU_Rutas_Recorridos:33]Dia_Semana:6;atBU_Dia;[BU_Rutas_Recorridos:33]Ida_o_vuelta:7;abBU_ES;[BU_Rutas_Recorridos:33]ID_Recorrido:1;alBU_IdRecorrido;[BU_Rutas_Recorridos:33]ID_Ruta:2;alBU_Ruta)
	AL_UpdateArrays (xalp_Recorridos;-2)
End if 
