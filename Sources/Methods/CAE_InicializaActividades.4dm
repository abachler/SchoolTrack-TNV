//%attributes = {}
  //CAE_InicializaActividades

C_LONGINT:C283($i)
ARRAY LONGINT:C221($idActividad;0)

ALL RECORDS:C47([Actividades:29])
SELECTION TO ARRAY:C260([Actividades:29]ID:1;$idActividad)

For ($i;1;Size of array:C274($idActividad))
	READ WRITE:C146([Actividades:29])
	QUERY:C277([Actividades:29];[Actividades:29]ID:1=$idActividad{$i})
	[Actividades:29]Inscritos_P1:15:=0
	[Actividades:29]Inscritos_P2:16:=0
	[Actividades:29]Inscritos_P3:17:=0
	[Actividades:29]Inscritos_P4:18:=0
	[Actividades:29]Inscritos_P5:19:=0
	[Actividades:29]NumeroAlumnosInscritos:14:=0
	SAVE RECORD:C53([Actividades:29])
End for 

KRL_UnloadReadOnly (->[Actividades:29])

