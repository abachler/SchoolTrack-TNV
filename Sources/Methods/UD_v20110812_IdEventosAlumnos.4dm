//%attributes = {}
  // UD_v20110812_IdEventosAlumnos()
  // 01/09/2011
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



MESSAGES OFF:C175
$p:=IT_UThermometer (1;0;"Actualizando identificadores...")
READ WRITE:C146([Alumnos_EventosOrientacion:21])
ALL RECORDS:C47([Alumnos_EventosOrientacion:21])
APPLY TO SELECTION:C70([Alumnos_EventosOrientacion:21];[Alumnos_EventosOrientacion:21]ID:24:=SQ_SeqNumber (->[Alumnos_EventosOrientacion:21]ID:24))
KRL_UnloadReadOnly (->[Alumnos_EventosOrientacion:21])

READ WRITE:C146([Alumnos_EventosPersonales:16])
ALL RECORDS:C47([Alumnos_EventosPersonales:16])
APPLY TO SELECTION:C70([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]ID:26:=SQ_SeqNumber (->[Alumnos_EventosPersonales:16]ID:26))
KRL_UnloadReadOnly (->[Alumnos_EventosPersonales:16])
IT_UThermometer (-2;$p)
MESSAGES ON:C181