//%attributes = {}

READ ONLY:C145([ADT_Candidatos_Observaciones:154])
QUERY:C277([ADT_Candidatos_Observaciones:154];[ADT_Candidatos_Observaciones:154]IDAlumno:5=[Alumnos:2]numero:1)

SELECTION TO ARRAY:C260([ADT_Candidatos_Observaciones:154]FechaIngreso:3;adFechaObservacion;[ADT_Candidatos_Observaciones:154]Observaciones:2;atTextoObservacion;[ADT_Candidatos_Observaciones:154]IngresadaPor:4;atUsuarioObservacion;[ADT_Candidatos_Observaciones:154]ID_Observacion:1;aiIDObservacion)
KRL_UnloadReadOnly (->[ADT_Candidatos_Observaciones:154])