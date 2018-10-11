//%attributes = {}
  //BU_RefreshBuses

ARRAY TEXT:C222(atBU_BUSPatente;0)
ARRAY LONGINT:C221(alBU_BUSNumero;0)
READ ONLY:C145([Buses_escolares:57])
ALL RECORDS:C47([Buses_escolares:57])
SELECTION TO ARRAY:C260([Buses_escolares:57]Patente:1;atBU_BUSPatente;[Buses_escolares:57]Numero:10;alBU_BUSNumero)