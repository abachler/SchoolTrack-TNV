//%attributes = {}
  // MÉTODO: EV2_BorraPromedios
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 31/01/12, 10:25:56
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Inicializa los campos de promedios de calificaciones a valores nulos
  //
  // PARÁMETROS
  // EV2_BorraPromedios()
  // ----------------------------------------------------
C_LONGINT:C283($1;$l_recNum)
$l_recNum:=$1




  // CODIGO PRINCIPAL
KRL_GotoRecord (->[Alumnos_Calificaciones:208];$l_recNum;True:C214)

[Alumnos_Calificaciones:208]P01_Presentacion_Real:102:=-10
[Alumnos_Calificaciones:208]P01_Presentacion_Nota:103:=-10
[Alumnos_Calificaciones:208]P01_Presentacion_Puntos:104:=-10
[Alumnos_Calificaciones:208]P01_Presentacion_Simbolo:105:=""
[Alumnos_Calificaciones:208]P01_Presentacion_Literal:106:=""
[Alumnos_Calificaciones:208]P01_Final_Real:112:=-10
[Alumnos_Calificaciones:208]P01_Final_Nota:113:=-10
[Alumnos_Calificaciones:208]P01_Final_Puntos:114:=-10
[Alumnos_Calificaciones:208]P01_Final_Simbolo:115:=""
[Alumnos_Calificaciones:208]P01_Final_Literal:116:=""
[Alumnos_Calificaciones:208]P01_Final_RealNoAproximado:496:=-10


[Alumnos_Calificaciones:208]P02_Presentacion_Real:177:=-10
[Alumnos_Calificaciones:208]P02_Presentacion_Nota:178:=-10
[Alumnos_Calificaciones:208]P02_Presentacion_Puntos:179:=-10
[Alumnos_Calificaciones:208]P02_Presentacion_Simbolo:180:=""
[Alumnos_Calificaciones:208]P02_Presentacion_Literal:181:=""
[Alumnos_Calificaciones:208]P02_Final_Real:187:=-10
[Alumnos_Calificaciones:208]P02_Final_Nota:188:=-10
[Alumnos_Calificaciones:208]P02_Final_Puntos:189:=-10
[Alumnos_Calificaciones:208]P02_Final_Simbolo:190:=""
[Alumnos_Calificaciones:208]P02_Final_Literal:191:=""
[Alumnos_Calificaciones:208]P02_Final_RealNoAproximado:497:=-10

[Alumnos_Calificaciones:208]P03_Presentacion_Real:252:=-10
[Alumnos_Calificaciones:208]P03_Presentacion_Nota:253:=-10
[Alumnos_Calificaciones:208]P03_Presentacion_Puntos:254:=-10
[Alumnos_Calificaciones:208]P03_Presentacion_Simbolo:255:=""
[Alumnos_Calificaciones:208]P03_Presentacion_Literal:256:=""
[Alumnos_Calificaciones:208]P03_Final_Real:262:=-10
[Alumnos_Calificaciones:208]P03_Final_Nota:263:=-10
[Alumnos_Calificaciones:208]P03_Final_Puntos:264:=-10
[Alumnos_Calificaciones:208]P03_Final_Simbolo:265:=""
[Alumnos_Calificaciones:208]P03_Final_Literal:266:=""
[Alumnos_Calificaciones:208]P03_Final_RealNoAproximado:498:=-10

[Alumnos_Calificaciones:208]P04_Presentacion_Real:327:=-10
[Alumnos_Calificaciones:208]P04_Presentacion_Nota:328:=-10
[Alumnos_Calificaciones:208]P04_Presentacion_Puntos:329:=-10
[Alumnos_Calificaciones:208]P04_Presentacion_Simbolo:330:=""
[Alumnos_Calificaciones:208]P04_Presentacion_Literal:331:=""
[Alumnos_Calificaciones:208]P04_Final_Real:337:=-10
[Alumnos_Calificaciones:208]P04_Final_Nota:338:=-10
[Alumnos_Calificaciones:208]P04_Final_Puntos:339:=-10
[Alumnos_Calificaciones:208]P04_Final_Simbolo:340:=""
[Alumnos_Calificaciones:208]P04_Final_Literal:341:=""
[Alumnos_Calificaciones:208]P04_Final_RealNoAproximado:499:=-10

[Alumnos_Calificaciones:208]P05_Presentacion_Real:402:=-10
[Alumnos_Calificaciones:208]P05_Presentacion_Nota:403:=-10
[Alumnos_Calificaciones:208]P05_Presentacion_Puntos:404:=-10
[Alumnos_Calificaciones:208]P05_Presentacion_Simbolo:405:=""
[Alumnos_Calificaciones:208]P05_Presentacion_Literal:406:=""
[Alumnos_Calificaciones:208]P05_Final_Real:412:=-10
[Alumnos_Calificaciones:208]P05_Final_Nota:413:=-10
[Alumnos_Calificaciones:208]P05_Final_Puntos:414:=-10
[Alumnos_Calificaciones:208]P05_Final_Simbolo:415:=""
[Alumnos_Calificaciones:208]P05_Final_Literal:416:=""
[Alumnos_Calificaciones:208]P05_Final_RealNoAproximado:500:=-10


[Alumnos_Calificaciones:208]Anual_Real:11:=-10
[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=-10
[Alumnos_Calificaciones:208]Anual_Nota:12:=-10
[Alumnos_Calificaciones:208]Anual_Puntos:13:=-10
[Alumnos_Calificaciones:208]Anual_Literal:15:=""
[Alumnos_Calificaciones:208]Anual_Simbolo:14:=""

[Alumnos_Calificaciones:208]Anual_Real:11:=-10
[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=-10
[Alumnos_Calificaciones:208]Anual_Nota:12:=-10
[Alumnos_Calificaciones:208]Anual_Puntos:13:=-10
[Alumnos_Calificaciones:208]Anual_Literal:15:=""
[Alumnos_Calificaciones:208]Anual_Simbolo:14:=""

[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=-10
[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=-10
[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=-10
[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=-10
[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:=""
[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=""

[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-10
[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=""
[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-10
[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=-10
[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=""
[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=""

[Alumnos_Calificaciones:208]PeriodoActual_Final_Real:487:=-10
[Alumnos_Calificaciones:208]PeriodoActual_Final_NoAprox:505:=-10
[Alumnos_Calificaciones:208]PeriodoActual_Final_Nota:488:=-10
[Alumnos_Calificaciones:208]PeriodoActual_Final_Puntos:489:=-10
[Alumnos_Calificaciones:208]PeriodoActual_Final_Literal:491:=""
[Alumnos_Calificaciones:208]PeriodoActual_Final_Simbolo:490:=""

[Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477:=-10
[Alumnos_Calificaciones:208]PeriodoActual_Present_Nota:478:=-10
[Alumnos_Calificaciones:208]PeriodoActual_Present_Puntos:479:=-10
[Alumnos_Calificaciones:208]PeriodoActual_Present_Literal:481:=""
[Alumnos_Calificaciones:208]PeriodoActual_Present_Simbolo:480:=""

$b_promediosModificados:=EV2_PromediosModificados (0)
If (Not:C34($b_promediosModificados))
	$b_promediosModificados:=(EV2_PromediosModificados (1) | EV2_PromediosModificados (2) | EV2_PromediosModificados (3) | EV2_PromediosModificados (4) | EV2_PromediosModificados (5))
	SAVE RECORD:C53([Alumnos_Calificaciones:208])
Else 
	SAVE RECORD:C53([Alumnos_Calificaciones:208])
End if 
$0:=$b_promediosModificados

If ($b_promediosModificados)
	
End if 


KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Real:57:=-10
[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Literal:62:=""
[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Nota:67:=-10
[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Puntos:72:=-10
[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Simbolo:77:=""

[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Real:58:=-10
[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Literal:63:=""
[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Nota:68:=-10
[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Puntos:73:=-10
[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Simbolo:78:=""

[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Real:59:=-10
[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Literal:64:=""
[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Nota:69:=-10
[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Puntos:74:=-10
[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Simbolo:79:=""

[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Real:60:=-10
[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Literal:65:=""
[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Nota:70:=-10
[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Puntos:75:=-10
[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Simbolo:80:=""

[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Real:61:=-10
[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Literal:66:=""
[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Nota:71:=-10
[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Puntos:76:=-10
[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Simbolo:81:=""


SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])



