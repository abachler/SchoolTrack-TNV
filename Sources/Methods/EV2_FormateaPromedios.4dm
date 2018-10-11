//%attributes = {}
  //`Método: EV2_FormateaPromedios

$updateFormats:=True:C214
If (([Alumnos_Calificaciones:208]Año:3=<>gYear) & ([Alumnos_Calificaciones:208]ID_Asignatura:5>0))
	READ ONLY:C145([Asignaturas:18])
	RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
	If ([Asignaturas:18]Numero_de_EstiloEvaluacion:39#0)
		$updateFormats:=True:C214
	Else 
		$updateFormats:=False:C215
	End if 
Else 
	$updateFormats:=False:C215
End if 

If ($updateFormats)
	$iEvaluationMode:=EVS_LeeValorEnMatriz ([Asignaturas:18]Numero_de_EstiloEvaluacion:39;"iEvaluationMode")
	$iPrintMode:=EVS_LeeValorEnMatriz ([Asignaturas:18]Numero_de_EstiloEvaluacion:39;"iPrintMode")
	$iPrintActa:=EVS_LeeValorEnMatriz ([Asignaturas:18]Numero_de_EstiloEvaluacion:39;"iPrintActa")
	Case of 
		: (($iEvaluationMode=Notas) & ($iPrintMode=Notas))  //notas
			$iGradesDecPP:=EVS_LeeValorEnMatriz ([Asignaturas:18]Numero_de_EstiloEvaluacion:39;"iGradesDecPP")
			$iGradesDecPF:=EVS_LeeValorEnMatriz ([Asignaturas:18]Numero_de_EstiloEvaluacion:39;"iGradesDecPF")
			$iGradesDecNF:=EVS_LeeValorEnMatriz ([Asignaturas:18]Numero_de_EstiloEvaluacion:39;"iGradesDecNF")
			$rGradesFrom:=EVS_LeeValorEnMatriz ([Asignaturas:18]Numero_de_EstiloEvaluacion:39;"rGradesFrom")
			[Alumnos_Calificaciones:208]P01_Final_Literal:116:=EV2_Num2Literal ([Alumnos_Calificaciones:208]P01_Final_Nota:113;$iGradesDecPP;$rGradesFrom)
			[Alumnos_Calificaciones:208]P02_Final_Literal:191:=EV2_Num2Literal ([Alumnos_Calificaciones:208]P02_Final_Nota:188;$iGradesDecPP;$rGradesFrom)
			[Alumnos_Calificaciones:208]P03_Final_Literal:266:=EV2_Num2Literal ([Alumnos_Calificaciones:208]P03_Final_Nota:263;$iGradesDecPP;$rGradesFrom)
			[Alumnos_Calificaciones:208]P04_Final_Literal:341:=EV2_Num2Literal ([Alumnos_Calificaciones:208]P04_Final_Nota:338;$iGradesDecPP;$rGradesFrom)
			[Alumnos_Calificaciones:208]P05_Final_Literal:416:=EV2_Num2Literal ([Alumnos_Calificaciones:208]P05_Final_Nota:413;$iGradesDecPP;$rGradesFrom)
			
			[Alumnos_Calificaciones:208]Anual_Literal:15:=EV2_Num2Literal ([Alumnos_Calificaciones:208]Anual_Nota:12;$iGradesDecPF;$rGradesFrom)
			[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:=EV2_Num2Literal ([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;$iGradesDecNF;$rGradesFrom)
			
			If ($iPrintActa=Notas)
				  //20110526 AS. se agrega validacion para cuando se calcula el promedio oficial segun el estilo asignado a la asignatura
				$vb_conv_niv_oficial:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]ConvertirEval_a_EstiloOficial:37)
				If ($vb_conv_niv_oficial)
					$idEstiloOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]EvStyle_oficial:23)
					$iGradesDecNO:=EVS_LeeValorEnMatriz ($idEstiloOficial;"iGradesDecNO")
					$rGradesFrom:=EVS_LeeValorEnMatriz ($idEstiloOficial;"rGradesFrom")
				Else 
					$iGradesDecNO:=EVS_LeeValorEnMatriz ([Asignaturas:18]Numero_de_EstiloEvaluacion:39;"iGradesDecNO")
					$rGradesFrom:=EVS_LeeValorEnMatriz ([Asignaturas:18]Numero_de_EstiloEvaluacion:39;"rGradesFrom")
				End if 
				
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=EV2_Num2Literal ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;$iGradesDecNO;$rGradesFrom)
			End if 
			
		: (($iEvaluationMode=Puntos) & ($iPrintMode=Puntos))  //puntos
			$iPointsDecPP:=EVS_LeeValorEnMatriz ([Asignaturas:18]Numero_de_EstiloEvaluacion:39;"iPointsDecPP")
			$iPointsDecPF:=EVS_LeeValorEnMatriz ([Asignaturas:18]Numero_de_EstiloEvaluacion:39;"iPointsDecPF")
			$iPointsDecNF:=EVS_LeeValorEnMatriz ([Asignaturas:18]Numero_de_EstiloEvaluacion:39;"iPointsDecNF")
			$rPointsFrom:=EVS_LeeValorEnMatriz ([Asignaturas:18]Numero_de_EstiloEvaluacion:39;"rPointsFrom")
			[Alumnos_Calificaciones:208]P01_Final_Literal:116:=EV2_Num2Literal ([Alumnos_Calificaciones:208]P01_Final_Puntos:114;$iPointsDecPP;$rPointsFrom)
			[Alumnos_Calificaciones:208]P02_Final_Literal:191:=EV2_Num2Literal ([Alumnos_Calificaciones:208]P02_Final_Puntos:189;$iPointsDecPP;$rPointsFrom)
			[Alumnos_Calificaciones:208]P03_Final_Literal:266:=EV2_Num2Literal ([Alumnos_Calificaciones:208]P03_Final_Puntos:264;$iPointsDecPP;$rPointsFrom)
			[Alumnos_Calificaciones:208]P04_Final_Literal:341:=EV2_Num2Literal ([Alumnos_Calificaciones:208]P04_Final_Puntos:339;$iPointsDecPP;$rPointsFrom)
			[Alumnos_Calificaciones:208]P05_Final_Literal:416:=EV2_Num2Literal ([Alumnos_Calificaciones:208]P05_Final_Puntos:414;$iPointsDecPP;$rPointsFrom)
			
			[Alumnos_Calificaciones:208]Anual_Literal:15:=EV2_Num2Literal ([Alumnos_Calificaciones:208]Anual_Puntos:13;$iPointsDecPF;$rPointsFrom)
			[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:=EV2_Num2Literal ([Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;$iPointsDecNF;$rPointsFrom)
			
			If ($iPrintActa=Puntos)
				  //20110526 AS. se agrega validacion para cuando se calcula el promedio oficial segun el estilo asignado a la asignatura
				If ([xxSTR_Niveles:6]ConvertirEval_a_EstiloOficial:37)
					$idEstiloOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]EvStyle_oficial:23)
					$iPointsDecNO:=EVS_LeeValorEnMatriz ($idEstiloOficial;"iPointsDecNO")
					$rPointsFrom:=EVS_LeeValorEnMatriz ($idEstiloOficial;"rPointsFrom")
				Else 
					$iPointsDecNO:=EVS_LeeValorEnMatriz ([Asignaturas:18]Numero_de_EstiloEvaluacion:39;"iPointsDecNO")
					$rPointsFrom:=EVS_LeeValorEnMatriz ([Asignaturas:18]Numero_de_EstiloEvaluacion:39;"rPointsFrom")
				End if 
				
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=EV2_Num2Literal ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;$iPointsDecNO;$rPointsFrom)
			End if 
	End case 
End if 