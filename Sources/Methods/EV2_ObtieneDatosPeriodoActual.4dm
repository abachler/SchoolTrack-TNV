//%attributes = {}
  //EV2_ObtieneDatosPeriodoActual


C_LONGINT:C283($startAT;$endAT;$indexNota;$i;$periodo;$1;vPeriodo)

$periodo:=vPeriodo
If (Count parameters:C259=1)
	$periodo:=$1
End if 

If ($periodo=0)
	$periodo:=viSTR_PeriodoActual_Numero
End if 

Case of 
	: ($periodo=1)
		$startAT:=Field:C253(->[Alumnos_Calificaciones:208]P01_Eval01_Real:42)
		$endAT:=Field:C253(->[Alumnos_Calificaciones:208]P01_Final_Literal:116)
		[Alumnos_Calificaciones:208]PeriodoActual_Final_NoAprox:505:=[Alumnos_Calificaciones:208]P01_Final_RealNoAproximado:496
		
	: ($periodo=2)
		$startAT:=Field:C253(->[Alumnos_Calificaciones:208]P02_Eval01_Real:117)
		$endAT:=Field:C253(->[Alumnos_Calificaciones:208]P02_Final_Literal:191)
		[Alumnos_Calificaciones:208]PeriodoActual_Final_NoAprox:505:=[Alumnos_Calificaciones:208]P02_Final_RealNoAproximado:497
		
	: ($periodo=3)
		$startAT:=Field:C253(->[Alumnos_Calificaciones:208]P03_Eval01_Real:192)
		$endAT:=Field:C253(->[Alumnos_Calificaciones:208]P03_Final_Literal:266)
		[Alumnos_Calificaciones:208]PeriodoActual_Final_NoAprox:505:=[Alumnos_Calificaciones:208]P03_Final_RealNoAproximado:498
		
	: ($periodo=4)
		$startAT:=Field:C253(->[Alumnos_Calificaciones:208]P04_Eval01_Real:267)
		$endAT:=Field:C253(->[Alumnos_Calificaciones:208]P04_Final_Literal:341)
		[Alumnos_Calificaciones:208]PeriodoActual_Final_NoAprox:505:=[Alumnos_Calificaciones:208]P04_Final_RealNoAproximado:499
		
	: ($periodo=5)
		$startAT:=Field:C253(->[Alumnos_Calificaciones:208]P05_Eval01_Real:342)
		$endAT:=Field:C253(->[Alumnos_Calificaciones:208]P05_Final_Literal:416)
		[Alumnos_Calificaciones:208]PeriodoActual_Final_NoAprox:505:=[Alumnos_Calificaciones:208]P05_Final_RealNoAproximado:500
		
	: ($periodo=-1)  //MONO Ticket 187803
		$startAT:=Field:C253(->[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
		$endAT:=Field:C253(->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30)
		[Alumnos_Calificaciones:208]PeriodoActual_Final_NoAprox:505:=[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502
End case 

$indexNota:=1
$nextField:=Field:C253(->[Alumnos_Calificaciones:208]PeriodoActual_Eval01_Real:417)
For ($i;$startAT;$endAT;5)
	Field:C253(208;$nextField)->:=Field:C253(208;$i)->
	Field:C253(208;$nextField+1)->:=Field:C253(208;$i+1)->
	Field:C253(208;$nextField+2)->:=Field:C253(208;$i+2)->
	Field:C253(208;$nextField+3)->:=Field:C253(208;$i+3)->
	Field:C253(208;$nextField+4)->:=Field:C253(208;$i+4)->
	$nextField:=$nextField+5
End for 




If ([Alumnos_SintesisAnual:210]Año:2=<>gYear)
	PERIODOS_LoadData ([Alumnos_SintesisAnual:210]NumeroNivel:6)
	[Alumnos_SintesisAnual:210]TotalDiasHabiles:60:=viSTR_Periodos_DiasAgno
	
	Case of 
		: (Size of array:C274(aiSTR_Periodos_Dias)=2)
			[Alumnos_SintesisAnual:210]P01_DiasHabiles:118:=aiSTR_Periodos_Dias{1}
			[Alumnos_SintesisAnual:210]P02_DiasHabiles:147:=aiSTR_Periodos_Dias{2}
		: (Size of array:C274(aiSTR_Periodos_Dias)=3)
			[Alumnos_SintesisAnual:210]P01_DiasHabiles:118:=aiSTR_Periodos_Dias{1}
			[Alumnos_SintesisAnual:210]P02_DiasHabiles:147:=aiSTR_Periodos_Dias{2}
			[Alumnos_SintesisAnual:210]P03_DiasHabiles:176:=aiSTR_Periodos_Dias{3}
		: (Size of array:C274(aiSTR_Periodos_Dias)=4)
			[Alumnos_SintesisAnual:210]P01_DiasHabiles:118:=aiSTR_Periodos_Dias{1}
			[Alumnos_SintesisAnual:210]P02_DiasHabiles:147:=aiSTR_Periodos_Dias{2}
			[Alumnos_SintesisAnual:210]P03_DiasHabiles:176:=aiSTR_Periodos_Dias{3}
			[Alumnos_SintesisAnual:210]P04_DiasHabiles:205:=aiSTR_Periodos_Dias{4}
		: (Size of array:C274(aiSTR_Periodos_Dias)=4)
			[Alumnos_SintesisAnual:210]P01_DiasHabiles:118:=aiSTR_Periodos_Dias{1}
			[Alumnos_SintesisAnual:210]P02_DiasHabiles:147:=aiSTR_Periodos_Dias{2}
			[Alumnos_SintesisAnual:210]P03_DiasHabiles:176:=aiSTR_Periodos_Dias{3}
			[Alumnos_SintesisAnual:210]P04_DiasHabiles:205:=aiSTR_Periodos_Dias{4}
			[Alumnos_SintesisAnual:210]P05_DiasHabiles:234:=aiSTR_Periodos_Dias{5}
	End case 
End if 

Case of 
	: ($periodo=1)
		[Alumnos_SintesisAnual:210]P00_Observaciones_Academicas:85:=[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Negativas:74:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Negativas:103
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Neutras:73:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Neutras:102
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Positivas:72:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Positivas:101
		[Alumnos_SintesisAnual:210]P00_Atrasos_Jornada:78:=[Alumnos_SintesisAnual:210]P01_Atrasos_Jornada:107
		[Alumnos_SintesisAnual:210]P00_Atrasos_Sesiones:79:=[Alumnos_SintesisAnual:210]P01_Atrasos_Sesiones:108
		[Alumnos_SintesisAnual:210]P00_Castigos:81:=[Alumnos_SintesisAnual:210]P01_Castigos:110
		[Alumnos_SintesisAnual:210]P00_Faltas_x_RetardoJornada:83:=[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoJornada:112
		[Alumnos_SintesisAnual:210]P00_HorasEfectivas:70:=[Alumnos_SintesisAnual:210]P01_HorasEfectivas:99
		[Alumnos_SintesisAnual:210]P00_InasistenciasInjustif_Dias:88:=[Alumnos_SintesisAnual:210]P01_InasistenciasInjustif_Dias:117
		[Alumnos_SintesisAnual:210]P00_InasistenciasJustif_Dias:87:=[Alumnos_SintesisAnual:210]P01_InasistenciasJustif_Dias:116
		[Alumnos_SintesisAnual:210]P00_Inasistencias_Dias:68:=[Alumnos_SintesisAnual:210]P01_Inasistencias_Dias:97
		[Alumnos_SintesisAnual:210]P00_Inasistencias_Horas:69:=[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98
		[Alumnos_SintesisAnual:210]P00_Observaciones_Academicas:85:=[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
		[Alumnos_SintesisAnual:210]P00_Observaciones_Actitud:86:=[Alumnos_SintesisAnual:210]P01_Observaciones_Actitud:115
		[Alumnos_SintesisAnual:210]P00_Premios:80:=[Alumnos_SintesisAnual:210]P01_Premios:109
		[Alumnos_SintesisAnual:210]P00_Promedio_Literal:67:=[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96
		[Alumnos_SintesisAnual:210]P00_Promedio_Nota:64:=[Alumnos_SintesisAnual:210]P01_PromedioInterno_Nota:93
		[Alumnos_SintesisAnual:210]P00_Promedio_Puntos:65:=[Alumnos_SintesisAnual:210]P01_PromedioInterno_Puntos:94
		[Alumnos_SintesisAnual:210]P00_Promedio_Real:63:=[Alumnos_SintesisAnual:210]P01_PromedioInterno_Real:92
		[Alumnos_SintesisAnual:210]P00_Promedio_Simbolos:66:=[Alumnos_SintesisAnual:210]P01_PromedioInterno_Simbolo:95
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Real:262:=[Alumnos_SintesisAnual:210]P01_PromedioOficial_Real:237
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Nota:263:=[Alumnos_SintesisAnual:210]P01_PromedioOficial_Nota:238
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Puntos:264:=[Alumnos_SintesisAnual:210]P01_PromedioOficial_Puntos:239
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Simbolo:265:=[Alumnos_SintesisAnual:210]P01_PromedioOficial_Simbolo:240
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Literal:266:=[Alumnos_SintesisAnual:210]P01_PromedioOficial_Literal:241
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Balance:77:=[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Balance:106
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Negativo:76:=[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Negativo:105
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Positivo:75:=[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Positivo:104
		[Alumnos_SintesisAnual:210]P00_Suspensiones:82:=[Alumnos_SintesisAnual:210]P01_Suspensiones:111
		[Alumnos_SintesisAnual:210]P00_DiasHabiles:89:=[Alumnos_SintesisAnual:210]P01_DiasHabiles:118
		
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Actitud:42:=[Alumnos_ComplementoEvaluacion:209]P01_Actitud:17
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Esfuerzo:41:=[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Inasistencias:43:=[Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Obs_Academicas:44:=[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Obs_Conductuales:45:=[Alumnos_ComplementoEvaluacion:209]P01_Obs_Conductuales:20
		
		
	: ($periodo=2)
		[Alumnos_SintesisAnual:210]P00_Observaciones_Academicas:85:=[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Negativas:74:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Negativas:132
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Neutras:73:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Neutras:131
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Positivas:72:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Positivas:130
		[Alumnos_SintesisAnual:210]P00_Atrasos_Jornada:78:=[Alumnos_SintesisAnual:210]P02_Atrasos_Jornada:136
		[Alumnos_SintesisAnual:210]P00_Atrasos_Sesiones:79:=[Alumnos_SintesisAnual:210]P02_Atrasos_Sesiones:137
		[Alumnos_SintesisAnual:210]P00_Castigos:81:=[Alumnos_SintesisAnual:210]P02_Castigos:139
		[Alumnos_SintesisAnual:210]P00_Faltas_x_RetardoJornada:83:=[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoJornada:141
		[Alumnos_SintesisAnual:210]P00_HorasEfectivas:70:=[Alumnos_SintesisAnual:210]P02_HorasEfectivas:128
		[Alumnos_SintesisAnual:210]P00_InasistenciasInjustif_Dias:88:=[Alumnos_SintesisAnual:210]P02_InasistenciasInjustif_Dias:146
		[Alumnos_SintesisAnual:210]P00_InasistenciasJustif_Dias:87:=[Alumnos_SintesisAnual:210]P02_InasistenciasJustif_Dias:145
		[Alumnos_SintesisAnual:210]P00_Inasistencias_Dias:68:=[Alumnos_SintesisAnual:210]P02_Inasistencias_Dias:126
		[Alumnos_SintesisAnual:210]P00_Inasistencias_Horas:69:=[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127
		[Alumnos_SintesisAnual:210]P00_Observaciones_Academicas:85:=[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
		[Alumnos_SintesisAnual:210]P00_Observaciones_Actitud:86:=[Alumnos_SintesisAnual:210]P02_Observaciones_Actitud:144
		[Alumnos_SintesisAnual:210]P00_Premios:80:=[Alumnos_SintesisAnual:210]P02_Premios:138
		[Alumnos_SintesisAnual:210]P00_Promedio_Literal:67:=[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125
		[Alumnos_SintesisAnual:210]P00_Promedio_Nota:64:=[Alumnos_SintesisAnual:210]P02_PromedioInterno_Nota:122
		[Alumnos_SintesisAnual:210]P00_Promedio_Puntos:65:=[Alumnos_SintesisAnual:210]P02_PromedioInterno_Puntos:123
		[Alumnos_SintesisAnual:210]P00_Promedio_Real:63:=[Alumnos_SintesisAnual:210]P02_PromedioInterno_Real:121
		[Alumnos_SintesisAnual:210]P00_Promedio_Simbolos:66:=[Alumnos_SintesisAnual:210]P02_PromedioInterno_Simbolo:124
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Real:262:=[Alumnos_SintesisAnual:210]P02_PromedioOficial_Real:242
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Nota:263:=[Alumnos_SintesisAnual:210]P02_PromedioOficial_Nota:243
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Puntos:264:=[Alumnos_SintesisAnual:210]P02_PromedioOficial_Puntos:244
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Simbolo:265:=[Alumnos_SintesisAnual:210]P02_PromedioOficial_Simbolo:245
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Literal:266:=[Alumnos_SintesisAnual:210]P02_PromedioOficial_Literal:246
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Balance:77:=[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Balance:135
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Negativo:76:=[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Negativo:134
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Positivo:75:=[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Positivo:133
		[Alumnos_SintesisAnual:210]P00_Suspensiones:82:=[Alumnos_SintesisAnual:210]P02_Suspensiones:140
		[Alumnos_SintesisAnual:210]P00_DiasHabiles:89:=[Alumnos_SintesisAnual:210]P02_DiasHabiles:147
		
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Actitud:42:=[Alumnos_ComplementoEvaluacion:209]P02_Actitud:22
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Esfuerzo:41:=[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Inasistencias:43:=[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Obs_Academicas:44:=[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Obs_Conductuales:45:=[Alumnos_ComplementoEvaluacion:209]P02_Obs_Conductuales:25
		
	: ($periodo=3)
		[Alumnos_SintesisAnual:210]P00_Observaciones_Academicas:85:=[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Negativas:74:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Negativas:161
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Neutras:73:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Neutras:160
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Positivas:72:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Positivas:159
		[Alumnos_SintesisAnual:210]P00_Atrasos_Jornada:78:=[Alumnos_SintesisAnual:210]P03_Atrasos_Jornada:165
		[Alumnos_SintesisAnual:210]P00_Atrasos_Sesiones:79:=[Alumnos_SintesisAnual:210]P03_Atrasos_Sesiones:166
		[Alumnos_SintesisAnual:210]P00_Castigos:81:=[Alumnos_SintesisAnual:210]P03_Castigos:168
		[Alumnos_SintesisAnual:210]P00_Faltas_x_RetardoJornada:83:=[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoJornada:170
		[Alumnos_SintesisAnual:210]P00_HorasEfectivas:70:=[Alumnos_SintesisAnual:210]P03_HorasEfectivas:157
		[Alumnos_SintesisAnual:210]P00_InasistenciasInjustif_Dias:88:=[Alumnos_SintesisAnual:210]P03_InasistenciasInjustif_Dias:175
		[Alumnos_SintesisAnual:210]P00_InasistenciasJustif_Dias:87:=[Alumnos_SintesisAnual:210]P03_InasistenciasJustif_Dias:174
		[Alumnos_SintesisAnual:210]P00_Inasistencias_Dias:68:=[Alumnos_SintesisAnual:210]P03_Inasistencias_Dias:155
		[Alumnos_SintesisAnual:210]P00_Inasistencias_Horas:69:=[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156
		[Alumnos_SintesisAnual:210]P00_Observaciones_Academicas:85:=[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
		[Alumnos_SintesisAnual:210]P00_Observaciones_Actitud:86:=[Alumnos_SintesisAnual:210]P03_Observaciones_Actitud:173
		[Alumnos_SintesisAnual:210]P00_Premios:80:=[Alumnos_SintesisAnual:210]P03_Premios:167
		[Alumnos_SintesisAnual:210]P00_Promedio_Literal:67:=[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154
		[Alumnos_SintesisAnual:210]P00_Promedio_Nota:64:=[Alumnos_SintesisAnual:210]P03_PromedioInterno_Nota:151
		[Alumnos_SintesisAnual:210]P00_Promedio_Puntos:65:=[Alumnos_SintesisAnual:210]P03_PromedioInterno_Puntos:152
		[Alumnos_SintesisAnual:210]P00_Promedio_Real:63:=[Alumnos_SintesisAnual:210]P03_PromedioInterno_Real:150
		[Alumnos_SintesisAnual:210]P00_Promedio_Simbolos:66:=[Alumnos_SintesisAnual:210]P03_PromedioInterno_Simbolo:153
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Real:262:=[Alumnos_SintesisAnual:210]P03_PromedioOficial_Real:247
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Nota:263:=[Alumnos_SintesisAnual:210]P03_PromedioOficial_Nota:248
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Puntos:264:=[Alumnos_SintesisAnual:210]P03_PromedioOficial_Puntos:249
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Simbolo:265:=[Alumnos_SintesisAnual:210]P03_PromedioOficial_Simbolo:250
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Literal:266:=[Alumnos_SintesisAnual:210]P03_PromedioOficial_Literal:251
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Balance:77:=[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Balance:164
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Negativo:76:=[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Negativo:163
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Positivo:75:=[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Positivo:162
		[Alumnos_SintesisAnual:210]P00_Suspensiones:82:=[Alumnos_SintesisAnual:210]P03_Suspensiones:169
		[Alumnos_SintesisAnual:210]P00_DiasHabiles:89:=[Alumnos_SintesisAnual:210]P03_DiasHabiles:176
		
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Actitud:42:=[Alumnos_ComplementoEvaluacion:209]P03_Actitud:27
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Esfuerzo:41:=[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Inasistencias:43:=[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Obs_Academicas:44:=[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Obs_Conductuales:45:=[Alumnos_ComplementoEvaluacion:209]P03_Obs_Conductuales:30
		
	: ($periodo=4)
		[Alumnos_SintesisAnual:210]P00_Observaciones_Academicas:85:=[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Negativas:74:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Negativas:190
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Neutras:73:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Neutras:189
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Positivas:72:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Positivas:188
		[Alumnos_SintesisAnual:210]P00_Atrasos_Jornada:78:=[Alumnos_SintesisAnual:210]P04_Atrasos_Jornada:194
		[Alumnos_SintesisAnual:210]P00_Atrasos_Sesiones:79:=[Alumnos_SintesisAnual:210]P04_Atrasos_Sesiones:195
		[Alumnos_SintesisAnual:210]P00_Castigos:81:=[Alumnos_SintesisAnual:210]P04_Castigos:197
		[Alumnos_SintesisAnual:210]P00_Faltas_x_RetardoJornada:83:=[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoJornada:199
		[Alumnos_SintesisAnual:210]P00_HorasEfectivas:70:=[Alumnos_SintesisAnual:210]P04_HorasEfectivas:186
		[Alumnos_SintesisAnual:210]P00_InasistenciasInjustif_Dias:88:=[Alumnos_SintesisAnual:210]P04_InasistenciasInjustif_Dias:204
		[Alumnos_SintesisAnual:210]P00_InasistenciasJustif_Dias:87:=[Alumnos_SintesisAnual:210]P04_InasistenciasJustif_Dias:203
		[Alumnos_SintesisAnual:210]P00_Inasistencias_Dias:68:=[Alumnos_SintesisAnual:210]P04_Inasistencias_Dias:184
		[Alumnos_SintesisAnual:210]P00_Inasistencias_Horas:69:=[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185
		[Alumnos_SintesisAnual:210]P00_Observaciones_Academicas:85:=[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201
		[Alumnos_SintesisAnual:210]P00_Observaciones_Actitud:86:=[Alumnos_SintesisAnual:210]P04_Observaciones_Actitud:202
		[Alumnos_SintesisAnual:210]P00_Premios:80:=[Alumnos_SintesisAnual:210]P04_Premios:196
		[Alumnos_SintesisAnual:210]P00_Promedio_Literal:67:=[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183
		[Alumnos_SintesisAnual:210]P00_Promedio_Nota:64:=[Alumnos_SintesisAnual:210]P04_PromedioInterno_Nota:180
		[Alumnos_SintesisAnual:210]P00_Promedio_Puntos:65:=[Alumnos_SintesisAnual:210]P04_PromedioInterno_Puntos:181
		[Alumnos_SintesisAnual:210]P00_Promedio_Real:63:=[Alumnos_SintesisAnual:210]P04_PromedioInterno_Real:179
		[Alumnos_SintesisAnual:210]P00_Promedio_Simbolos:66:=[Alumnos_SintesisAnual:210]P04_PromedioInterno_Simbolo:182
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Real:262:=[Alumnos_SintesisAnual:210]P04_PromedioOficial_Real:252
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Nota:263:=[Alumnos_SintesisAnual:210]P04_PromedioOficial_Nota:253
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Puntos:264:=[Alumnos_SintesisAnual:210]P04_PromedioOficial_Puntos:254
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Simbolo:265:=[Alumnos_SintesisAnual:210]P04_PromedioOficial_Simbolo:255
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Literal:266:=[Alumnos_SintesisAnual:210]P04_PromedioOficial_Literal:256
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Balance:77:=[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Balance:193
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Negativo:76:=[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Negativo:192
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Positivo:75:=[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Positivo:191
		[Alumnos_SintesisAnual:210]P00_Suspensiones:82:=[Alumnos_SintesisAnual:210]P04_Suspensiones:198
		[Alumnos_SintesisAnual:210]P00_DiasHabiles:89:=[Alumnos_SintesisAnual:210]P04_DiasHabiles:205
		
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Actitud:42:=[Alumnos_ComplementoEvaluacion:209]P04_Actitud:32
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Esfuerzo:41:=[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Inasistencias:43:=[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Obs_Academicas:44:=[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Obs_Conductuales:45:=[Alumnos_ComplementoEvaluacion:209]P04_Obs_Conductuales:35
		
	: ($periodo=5)
		[Alumnos_SintesisAnual:210]P00_Observaciones_Academicas:85:=[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Negativas:74:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Negativas:219
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Neutras:73:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Neutras:218
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Positivas:72:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Positivas:217
		[Alumnos_SintesisAnual:210]P00_Atrasos_Jornada:78:=[Alumnos_SintesisAnual:210]P05_Atrasos_Jornada:223
		[Alumnos_SintesisAnual:210]P00_Atrasos_Sesiones:79:=[Alumnos_SintesisAnual:210]P05_Atrasos_Sesiones:224
		[Alumnos_SintesisAnual:210]P00_Castigos:81:=[Alumnos_SintesisAnual:210]P05_Castigos:226
		[Alumnos_SintesisAnual:210]P00_Faltas_x_RetardoJornada:83:=[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoJornada:228
		[Alumnos_SintesisAnual:210]P00_HorasEfectivas:70:=[Alumnos_SintesisAnual:210]P05_HorasEfectivas:215
		[Alumnos_SintesisAnual:210]P00_InasistenciasInjustif_Dias:88:=[Alumnos_SintesisAnual:210]P05_InasistenciasInjustif_Dias:233
		[Alumnos_SintesisAnual:210]P00_InasistenciasJustif_Dias:87:=[Alumnos_SintesisAnual:210]P05_InasistenciasJustif_Dias:232
		[Alumnos_SintesisAnual:210]P00_Inasistencias_Dias:68:=[Alumnos_SintesisAnual:210]P05_Inasistencias_Dias:213
		[Alumnos_SintesisAnual:210]P00_Inasistencias_Horas:69:=[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214
		[Alumnos_SintesisAnual:210]P00_Observaciones_Academicas:85:=[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230
		[Alumnos_SintesisAnual:210]P00_Observaciones_Actitud:86:=[Alumnos_SintesisAnual:210]P05_Observaciones_Actitud:231
		[Alumnos_SintesisAnual:210]P00_Premios:80:=[Alumnos_SintesisAnual:210]P05_Premios:225
		[Alumnos_SintesisAnual:210]P00_Promedio_Literal:67:=[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212
		[Alumnos_SintesisAnual:210]P00_Promedio_Nota:64:=[Alumnos_SintesisAnual:210]P05_PromedioInterno_Nota:209
		[Alumnos_SintesisAnual:210]P00_Promedio_Puntos:65:=[Alumnos_SintesisAnual:210]P05_PromedioInterno_Puntos:210
		[Alumnos_SintesisAnual:210]P00_Promedio_Real:63:=[Alumnos_SintesisAnual:210]P05_PromedioInterno_Real:208
		[Alumnos_SintesisAnual:210]P00_Promedio_Simbolos:66:=[Alumnos_SintesisAnual:210]P05_PromedioInterno_Simbolo:211
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Real:262:=[Alumnos_SintesisAnual:210]P05_PromedioOficial_Real:257
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Nota:263:=[Alumnos_SintesisAnual:210]P05_PromedioOficial_Nota:258
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Puntos:264:=[Alumnos_SintesisAnual:210]P05_PromedioOficial_Puntos:259
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Simbolo:265:=[Alumnos_SintesisAnual:210]P05_PromedioOficial_Simbolo:260
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Literal:266:=[Alumnos_SintesisAnual:210]P05_PromedioOficial_Literal:261
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Balance:77:=[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Balance:222
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Negativo:76:=[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Negativo:221
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Positivo:75:=[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Positivo:220
		[Alumnos_SintesisAnual:210]P00_Suspensiones:82:=[Alumnos_SintesisAnual:210]P05_Suspensiones:227
		[Alumnos_SintesisAnual:210]P00_DiasHabiles:89:=[Alumnos_SintesisAnual:210]P05_DiasHabiles:234
		
		
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Actitud:42:=[Alumnos_ComplementoEvaluacion:209]P05_Actitud:37
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Esfuerzo:41:=[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Inasistencias:43:=[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Obs_Academicas:44:=[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Obs_Conductuales:45:=[Alumnos_ComplementoEvaluacion:209]P05_Obs_Conductuales:40
		
	: ($periodo=-1)  //MONO Ticket 187803
		[Alumnos_SintesisAnual:210]P00_Observaciones_Academicas:85:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Negativas:74:=[Alumnos_SintesisAnual:210]Anotaciones_Negativas:36
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Neutras:73:=[Alumnos_SintesisAnual:210]Anotaciones_Neutras:35
		[Alumnos_SintesisAnual:210]P00_Anotaciones_Positivas:72:=[Alumnos_SintesisAnual:210]Anotaciones_Positivas:34
		[Alumnos_SintesisAnual:210]P00_Atrasos_Jornada:78:=[Alumnos_SintesisAnual:210]Atrasos_Jornada:40
		[Alumnos_SintesisAnual:210]P00_Atrasos_Sesiones:79:=[Alumnos_SintesisAnual:210]Atrasos_Sesiones:41
		[Alumnos_SintesisAnual:210]P00_Castigos:81:=[Alumnos_SintesisAnual:210]Castigos:43
		[Alumnos_SintesisAnual:210]P00_Faltas_x_RetardoJornada:83:=[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45
		[Alumnos_SintesisAnual:210]P00_HorasEfectivas:70:=[Alumnos_SintesisAnual:210]HorasEfectivas:32
		[Alumnos_SintesisAnual:210]P00_InasistenciasInjustif_Dias:88:=[Alumnos_SintesisAnual:210]InasistenciasInjustif_Dias:50
		[Alumnos_SintesisAnual:210]P00_InasistenciasJustif_Dias:87:=[Alumnos_SintesisAnual:210]InasistenciasJustif_Dias:49
		[Alumnos_SintesisAnual:210]P00_Inasistencias_Dias:68:=[Alumnos_SintesisAnual:210]Inasistencias_Dias:30
		[Alumnos_SintesisAnual:210]P00_Inasistencias_Horas:69:=[Alumnos_SintesisAnual:210]Inasistencias_Horas:31
		[Alumnos_SintesisAnual:210]P00_Observaciones_Academicas:85:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
		[Alumnos_SintesisAnual:210]P00_Observaciones_Actitud:86:=[Alumnos_SintesisAnual:210]Observaciones_Actitud:48
		[Alumnos_SintesisAnual:210]P00_Premios:80:=[Alumnos_SintesisAnual:210]Premios:42
		[Alumnos_SintesisAnual:210]P00_Promedio_Literal:67:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24
		[Alumnos_SintesisAnual:210]P00_Promedio_Nota:64:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Nota:21
		[Alumnos_SintesisAnual:210]P00_Promedio_Puntos:65:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Puntos:22
		[Alumnos_SintesisAnual:210]P00_Promedio_Real:63:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20
		[Alumnos_SintesisAnual:210]P00_Promedio_Simbolos:66:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Simbolo:23
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Real:262:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Nota:263:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Puntos:264:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Puntos:27
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Simbolo:265:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Simbolo:28
		[Alumnos_SintesisAnual:210]P00_PromedioOficial_Literal:266:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Balance:77:=[Alumnos_SintesisAnual:210]PuntajeConductual_Balance:39
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Negativo:76:=[Alumnos_SintesisAnual:210]PuntajeConductual_Negativo:38
		[Alumnos_SintesisAnual:210]P00_PuntajeConductual_Positivo:75:=[Alumnos_SintesisAnual:210]PuntajeConductual_Positivo:37
		[Alumnos_SintesisAnual:210]P00_Suspensiones:82:=[Alumnos_SintesisAnual:210]Suspensiones:44
		[Alumnos_SintesisAnual:210]P00_DiasHabiles:89:=[Alumnos_SintesisAnual:210]P01_DiasHabiles:118+[Alumnos_SintesisAnual:210]P02_DiasHabiles:147+[Alumnos_SintesisAnual:210]P03_DiasHabiles:176+[Alumnos_SintesisAnual:210]P04_DiasHabiles:205+[Alumnos_SintesisAnual:210]P05_DiasHabiles:234
		
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Actitud:42:=""
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Esfuerzo:41:=""
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Inasistencias:43:=[Alumnos_ComplementoEvaluacion:209]TotalInasistencias:10
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Obs_Academicas:44:=""
		[Alumnos_ComplementoEvaluacion:209]PeriodoActual_Obs_Conductuales:45:=""
End case 