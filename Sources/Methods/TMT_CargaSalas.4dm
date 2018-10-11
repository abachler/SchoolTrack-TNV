//%attributes = {}
  // TMT_CargaSalas()
  // Por: Alberto Bachler: 10/05/13, 10:53:28
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------




ARRAY TEXT:C222(atTMT_Salas_Nombre;0)
ARRAY INTEGER:C220(aiTMT_Salas_Capacidad;0)
ARRAY LONGINT:C221(alTMT_Salas_ID;0)

ALL RECORDS:C47([TMT_Salas:167])
SELECTION TO ARRAY:C260([TMT_Salas:167]ID_Sala:1;alTMT_Salas_ID;[TMT_Salas:167]NombreSala:2;atTMT_Salas_Nombre;[TMT_Salas:167]Capacidad:3;aiTMT_Salas_Capacidad)
SORT ARRAY:C229(atTMT_Salas_Nombre;aiTMT_Salas_Capacidad;alTMT_Salas_ID;>)

