$continue:=True:C214
Case of 
	: (atSTR_Periodos_Nombre<=0)
		CD_Dlog (0;__ ("Seleccione un período."))
		$continue:=False:C215
	: (atSTR_Evaluaciones<=0)
		CD_Dlog (0;__ ("Seleccione una evaluación."))
		$continue:=False:C215
End case 
If ($continue)
	If (atSTR_Evaluaciones<=14)
		Case of 
			: (atSTR_Periodos_Nombre=1)
				ap_evaluaciones{1}:=->[Alumnos_Calificaciones:208]P01_Eval01_Real:42
				ap_evaluaciones{2}:=->[Alumnos_Calificaciones:208]P01_Eval02_Real:47
				ap_evaluaciones{3}:=->[Alumnos_Calificaciones:208]P01_Eval03_Real:52
				ap_evaluaciones{4}:=->[Alumnos_Calificaciones:208]P01_Eval04_Real:57
				ap_evaluaciones{5}:=->[Alumnos_Calificaciones:208]P01_Eval01_Real:42
				ap_evaluaciones{6}:=->[Alumnos_Calificaciones:208]P01_Eval06_Real:67
				ap_evaluaciones{7}:=->[Alumnos_Calificaciones:208]P01_Eval07_Real:72
				ap_evaluaciones{8}:=->[Alumnos_Calificaciones:208]P01_Eval08_Real:77
				ap_evaluaciones{9}:=->[Alumnos_Calificaciones:208]P01_Eval09_Real:82
				ap_evaluaciones{10}:=->[Alumnos_Calificaciones:208]P01_Eval10_Real:87
				ap_evaluaciones{11}:=->[Alumnos_Calificaciones:208]P01_Eval11_Real:92
				ap_evaluaciones{12}:=->[Alumnos_Calificaciones:208]P01_Eval12_Real:97
				ap_evaluaciones{14}:=->[Alumnos_Calificaciones:208]P01_Control_Real:107
			: (atSTR_Periodos_Nombre=2)
				ap_evaluaciones{1}:=->[Alumnos_Calificaciones:208]P02_Eval01_Real:117
				ap_evaluaciones{2}:=->[Alumnos_Calificaciones:208]P02_Eval02_Real:122
				ap_evaluaciones{3}:=->[Alumnos_Calificaciones:208]P02_Eval03_Real:127
				ap_evaluaciones{4}:=->[Alumnos_Calificaciones:208]P02_Eval04_Real:132
				ap_evaluaciones{5}:=->[Alumnos_Calificaciones:208]P02_Eval02_Real:122
				ap_evaluaciones{6}:=->[Alumnos_Calificaciones:208]P02_Eval06_Real:142
				ap_evaluaciones{7}:=->[Alumnos_Calificaciones:208]P02_Eval07_Real:147
				ap_evaluaciones{8}:=->[Alumnos_Calificaciones:208]P02_Eval08_Real:152
				ap_evaluaciones{9}:=->[Alumnos_Calificaciones:208]P02_Eval09_Real:157
				ap_evaluaciones{10}:=->[Alumnos_Calificaciones:208]P02_Eval10_Real:162
				ap_evaluaciones{11}:=->[Alumnos_Calificaciones:208]P02_Eval11_Real:167
				ap_evaluaciones{12}:=->[Alumnos_Calificaciones:208]P02_Eval12_Real:172
				ap_evaluaciones{14}:=->[Alumnos_Calificaciones:208]P02_Control_Real:182
			: (atSTR_Periodos_Nombre=3)
				ap_evaluaciones{1}:=->[Alumnos_Calificaciones:208]P03_Eval01_Real:192
				ap_evaluaciones{2}:=->[Alumnos_Calificaciones:208]P03_Eval02_Real:197
				ap_evaluaciones{3}:=->[Alumnos_Calificaciones:208]P03_Eval03_Real:202
				ap_evaluaciones{4}:=->[Alumnos_Calificaciones:208]P03_Eval04_Real:207
				ap_evaluaciones{5}:=->[Alumnos_Calificaciones:208]P03_Eval03_Real:202
				ap_evaluaciones{6}:=->[Alumnos_Calificaciones:208]P03_Eval06_Real:217
				ap_evaluaciones{7}:=->[Alumnos_Calificaciones:208]P03_Eval07_Real:222
				ap_evaluaciones{8}:=->[Alumnos_Calificaciones:208]P03_Eval08_Real:227
				ap_evaluaciones{9}:=->[Alumnos_Calificaciones:208]P03_Eval09_Real:232
				ap_evaluaciones{10}:=->[Alumnos_Calificaciones:208]P03_Eval10_Real:237
				ap_evaluaciones{11}:=->[Alumnos_Calificaciones:208]P03_Eval11_Real:242
				ap_evaluaciones{12}:=->[Alumnos_Calificaciones:208]P03_Eval12_Real:247
				ap_evaluaciones{14}:=->[Alumnos_Calificaciones:208]P03_Control_Real:257
			: (atSTR_Periodos_Nombre=4)
				ap_evaluaciones{1}:=->[Alumnos_Calificaciones:208]P04_Eval01_Real:267
				ap_evaluaciones{2}:=->[Alumnos_Calificaciones:208]P04_Eval02_Real:272
				ap_evaluaciones{3}:=->[Alumnos_Calificaciones:208]P04_Eval03_Real:277
				ap_evaluaciones{4}:=->[Alumnos_Calificaciones:208]P04_Eval04_Real:282
				ap_evaluaciones{5}:=->[Alumnos_Calificaciones:208]P04_Eval04_Real:282
				ap_evaluaciones{6}:=->[Alumnos_Calificaciones:208]P04_Eval06_Real:292
				ap_evaluaciones{7}:=->[Alumnos_Calificaciones:208]P04_Eval07_Real:297
				ap_evaluaciones{8}:=->[Alumnos_Calificaciones:208]P04_Eval08_Real:302
				ap_evaluaciones{9}:=->[Alumnos_Calificaciones:208]P04_Eval09_Real:307
				ap_evaluaciones{10}:=->[Alumnos_Calificaciones:208]P04_Eval10_Real:312
				ap_evaluaciones{11}:=->[Alumnos_Calificaciones:208]P04_Eval11_Real:317
				ap_evaluaciones{12}:=->[Alumnos_Calificaciones:208]P04_Eval12_Real:322
				ap_evaluaciones{14}:=->[Alumnos_Calificaciones:208]P04_Control_Real:332
			: (atSTR_Periodos_Nombre=5)
				ap_evaluaciones{1}:=->[Alumnos_Calificaciones:208]P05_Eval01_Real:342
				ap_evaluaciones{2}:=->[Alumnos_Calificaciones:208]P05_Eval02_Real:347
				ap_evaluaciones{3}:=->[Alumnos_Calificaciones:208]P05_Eval03_Real:352
				ap_evaluaciones{4}:=->[Alumnos_Calificaciones:208]P05_Eval04_Real:357
				ap_evaluaciones{5}:=->[Alumnos_Calificaciones:208]P05_Eval05_Real:362
				ap_evaluaciones{6}:=->[Alumnos_Calificaciones:208]P05_Eval06_Real:367
				ap_evaluaciones{7}:=->[Alumnos_Calificaciones:208]P05_Eval07_Real:372
				ap_evaluaciones{8}:=->[Alumnos_Calificaciones:208]P05_Eval08_Real:377
				ap_evaluaciones{9}:=->[Alumnos_Calificaciones:208]P05_Eval09_Real:382
				ap_evaluaciones{10}:=->[Alumnos_Calificaciones:208]P05_Eval10_Real:387
				ap_evaluaciones{11}:=->[Alumnos_Calificaciones:208]P05_Eval11_Real:392
				ap_evaluaciones{12}:=->[Alumnos_Calificaciones:208]P05_Eval12_Real:397
				ap_evaluaciones{14}:=->[Alumnos_Calificaciones:208]P05_Control_Real:407
		End case 
		
	Else 
		ap_evaluaciones{15}:=->[Alumnos_Calificaciones:208]Anual_Real:11
		ap_evaluaciones{16}:=->[Alumnos_Calificaciones:208]ExamenAnual_Real:16
		ap_evaluaciones{17}:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
	End if 
	If ((atSTR_Evaluaciones>=1) & (atSTR_Evaluaciones<=17) & (atSTR_Evaluaciones#13))
		ptr2Grade:=ap_evaluaciones{atSTR_Evaluaciones}
		ACCEPT:C269
	Else 
		BEEP:C151
		CANCEL:C270
	End if 
End if 