//%attributes = {}
  // UD_v20121016_PromAsigSinCalc()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 16/10/12, 19:34:04
  // ---------------------------------------------


  // CODIGO




SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
QUERY:C277([Alumnos_Calificaciones:208];[Asignaturas:18]Resultado_no_calculado:47=True:C214)

<>vb_ImportHistoricos_STX:=True:C214
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([Alumnos_Calificaciones:208])
	GOTO RECORD:C242([Alumnos_Calificaciones:208];$aRecNums{$i})
	[Alumnos_Calificaciones:208]P01_Final_RealNoAproximado:496:=[Alumnos_Calificaciones:208]P01_Final_Real:112
	[Alumnos_Calificaciones:208]P02_Final_RealNoAproximado:497:=[Alumnos_Calificaciones:208]P02_Final_Real:187
	[Alumnos_Calificaciones:208]P03_Final_RealNoAproximado:498:=[Alumnos_Calificaciones:208]P03_Final_Real:262
	[Alumnos_Calificaciones:208]P04_Final_RealNoAproximado:499:=[Alumnos_Calificaciones:208]P04_Final_Real:337
	[Alumnos_Calificaciones:208]P05_Final_RealNoAproximado:500:=[Alumnos_Calificaciones:208]P05_Final_Real:412
	[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=[Alumnos_Calificaciones:208]Anual_Real:11
	[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
	SAVE RECORD:C53([Alumnos_Calificaciones:208])
End for 
KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])


QUERY:C277([Asignaturas:18];[Asignaturas:18]Resultado_no_calculado:47=True:C214)

ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([Asignaturas:18])
	GOTO RECORD:C242([Asignaturas:18];$aRecNums{$i})
	EV2_ResultadosAsignatura 
End for 
KRL_UnloadReadOnly (->[Asignaturas:18])
<>vb_ImportHistoricos_STX:=False:C215


SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
