//%attributes = {}
  // EV2_EsAlumnoEximido()
  // 
  //
  // creado por: Alberto Bachler Klein: 04-12-16, 12:36:23
  // -----------------------------------------------------------


KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1)
If ([Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8#0)
	[Alumnos_Calificaciones:208]Anual_Real:11:=-3
	[Alumnos_Calificaciones:208]Anual_Nota:12:=-3
	[Alumnos_Calificaciones:208]Anual_Puntos:13:=-3
	[Alumnos_Calificaciones:208]Anual_Literal:15:="X"
	[Alumnos_Calificaciones:208]Anual_Simbolo:14:="X"
	[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=-3
	[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=-3
	[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=-3
	[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:="X"
	[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:="X"
	[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-3
	[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-3
	[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=-3
	[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:="EX"
	[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:="EX"
	PERIODOS_LoadData 
	For ($i_periodo;1;viSTR_Periodos_NumeroPeriodos)
		(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Presentacion_Real"))->:=-3
		(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Presentacion_Nota"))->:=-3
		(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Presentacion_Puntos"))->:=-3
		(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Presentacion_Literal"))->:="X"
		(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Presentacion_Simbolo"))->:="X"
		(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Final_Real"))->:=-3
		(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Final_RealNoAproximado"))->:=-3
		(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Final_Puntos"))->:=-3
		(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Final_Nota"))->:=-3
		(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Final_Literal"))->:="X"
		(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($i_periodo)+"_Final_Simbolo"))->:="X"
	End for 
	$0:=True:C214
Else 
	$0:=False:C215
End if 