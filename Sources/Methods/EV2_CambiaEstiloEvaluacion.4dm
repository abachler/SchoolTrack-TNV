//%attributes = {}
  //Metodo: EV2_CambiaEstiloEvaluacion
  //Por abachler
  //Creada el 25/08/2008, 20:02:38
  // ----------------------------------------------------
  // Descripción
  //
  //
  // ----------------------------------------------------
  // Parámetros
  //
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($iEvaluaciones;$iFields;$l_EstiloNuevo_ID;$l_EstiloNuevo_ModoEvaluacion;$l_EstiloNuevo_usaTablaConversio;$r_EstiloActual_MaximoEscala;$r_EstiloActual_MinimoEscala;$r_EstiloNuevo_MaximoEscala;$r_EstiloNuevo_MinimoEscala)
C_POINTER:C301($y_campoLiteralInterno;$y_campoNota;$y_campoPuntos;$y_campoSimbolos)
C_REAL:C285($r_Calificacion;$r_EstiloNuevo_MinimoAprobacion)

ARRAY LONGINT:C221($al_recNumCalificaciones;0)
ARRAY LONGINT:C221($l_EstiloActual_ID;0)
ARRAY LONGINT:C221($l_EstiloActual_ModoEvaluacion;0)
ARRAY LONGINT:C221($l_EstiloActual_usaTablaConversi;0)
ARRAY LONGINT:C221($r_EstiloActual_MinimoAprobacion;0)
If (False:C215)
	C_LONGINT:C283(EV2_CambiaEstiloEvaluacion ;$1)
	C_LONGINT:C283(EV2_CambiaEstiloEvaluacion ;$2)
End if 

  //CODIGO PRINCIPAL
$l_EstiloActual_ID:=$1
$l_EstiloNuevo_ID:=$2
vi_LastGradeView:=iEvaluationMode

EVS_ReadStyleData ($l_EstiloNuevo_ID)
$l_EstiloNuevo_ModoEvaluacion:=iEvaluationMode
EVS_ReadStyleData ($l_EstiloActual_ID)
Case of 
	: ($l_EstiloNuevo_ModoEvaluacion=Notas)
		$r_EstiloActual_MinimoEscala:=rGradesFrom
		$r_EstiloActual_MaximoEscala:=rGradesTo
	: ($l_EstiloNuevo_ModoEvaluacion=Puntos)
		$r_EstiloActual_MinimoEscala:=rPointsFrom
		$r_EstiloActual_MaximoEscala:=rPointsTo
End case 
$r_EstiloActual_MinimoAprobacion:=Round:C94(rpctMinimum;11)
$l_EstiloActual_usaTablaConversi:=iConversionTable
$l_EstiloActual_ModoEvaluacion:=iEvaluationMode

EVS_ReadStyleData ($l_EstiloNuevo_ID)
Case of 
	: ($l_EstiloNuevo_ModoEvaluacion=Notas)
		$r_EstiloNuevo_MinimoEscala:=rGradesFrom
		$r_EstiloNuevo_MaximoEscala:=rGradesTo
	: ($l_EstiloNuevo_ModoEvaluacion=Puntos)
		$r_EstiloNuevo_MinimoEscala:=rPointsFrom
		$r_EstiloNuevo_MaximoEscala:=rPointsTo
End case 
$r_EstiloNuevo_MinimoAprobacion:=Round:C94(rpctMinimum;11)
$l_EstiloNuevo_usaTablaConversio:=iConversionTable
$l_EstiloNuevo_ModoEvaluacion:=iEvaluationMode

PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)

Case of 
	: ((($r_EstiloActual_MinimoAprobacion=$r_EstiloNuevo_MinimoAprobacion) & ($l_EstiloNuevo_usaTablaConversio=0) & ($l_EstiloActual_usaTablaConversi=0)) | ($l_EstiloActual_ModoEvaluacion=Porcentaje))
		EVS_ReadStyleData ($l_EstiloNuevo_ID)
		AS_UpdateStyleSettings ($l_EstiloNuevo_ID)
		SAVE RECORD:C53([Asignaturas:18])
		EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
		EVS_ReadStyleData ($l_EstiloNuevo_ID)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$al_recNumCalificaciones;"")
		For ($iEvaluaciones;1;Size of array:C274($al_recNumCalificaciones))
			READ WRITE:C146([Alumnos_Calificaciones:208])
			GOTO RECORD:C242([Alumnos_Calificaciones:208];$al_recNumCalificaciones{$iEvaluaciones})
			
			KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
			$r_Calificacion:=[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95
			[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96:=EV2_Real_a_Nota ($r_Calificacion;0;iGradesDec)
			[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97:=EV2_Real_a_Puntos ($r_Calificacion;0;iPointsDec)
			[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98:=EV2_Real_a_Simbolo ($r_Calificacion)
			[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesParciales)
			SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
			
			$r_Calificacion:=[Alumnos_Calificaciones:208]Anual_Real:11
			[Alumnos_Calificaciones:208]Anual_Nota:12:=EV2_Real_a_Nota ($r_Calificacion;vi_gTrFAvg;iGradesDecPF)
			[Alumnos_Calificaciones:208]Anual_Puntos:13:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTrFAvg;iPointsDecPF)
			[Alumnos_Calificaciones:208]Anual_Simbolo:14:=EV2_Real_a_Simbolo ($r_Calificacion)
			[Alumnos_Calificaciones:208]Anual_Literal:15:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPF)
			
			$r_Calificacion:=[Alumnos_Calificaciones:208]ExamenAnual_Real:16
			[Alumnos_Calificaciones:208]ExamenAnual_Nota:17:=EV2_Real_a_Nota ($r_Calificacion;0;iGradesDec)
			[Alumnos_Calificaciones:208]ExamenAnual_Puntos:18:=EV2_Real_a_Puntos ($r_Calificacion;0;iPointsDec)
			[Alumnos_Calificaciones:208]ExamenAnual_Simbolo:19:=EV2_Real_a_Simbolo ($r_Calificacion)
			[Alumnos_Calificaciones:208]ExamenAnual_Literal:20:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesParciales)
			
			$r_Calificacion:=[Alumnos_Calificaciones:208]ExamenExtra_Real:21
			[Alumnos_Calificaciones:208]ExamenExtra_Nota:22:=EV2_Real_a_Nota ($r_Calificacion;0;iGradesDec)
			[Alumnos_Calificaciones:208]ExamenExtra_Puntos:23:=EV2_Real_a_Puntos ($r_Calificacion;0;iPointsDec)
			[Alumnos_Calificaciones:208]ExamenExtra_Simbolo:24:=EV2_Real_a_Simbolo ($r_Calificacion)
			[Alumnos_Calificaciones:208]ExamenExtra_Literal:25:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesParciales)
			
			$r_Calificacion:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
			[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=EV2_Real_a_Nota ($r_Calificacion;vi_gTroncarNotaFinal;iGradesDecNF)
			[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTroncarNotaFinal;iPointsDecNF)
			[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=EV2_Real_a_Simbolo ($r_Calificacion)
			[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesNF)
			
			For ($iFields;42;412;5)
				$r_Calificacion:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields)->
				$y_campoNota:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+1)
				$y_campoNota->:=EV2_Real_a_Nota ($r_Calificacion;0;iGradesDEC)
				$y_campoPuntos:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+2)
				$y_campoPuntos->:=EV2_Real_a_Puntos ($r_Calificacion;0;iPointsDec)
				$y_campoSimbolos:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+3)
				$y_campoSimbolos->:=EV2_Real_a_Simbolo ($r_Calificacion)
				$y_campoLiteralInterno:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+4)
				$y_campoLiteralInterno->:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesParciales)
			End for 
			
			$r_Calificacion:=[Alumnos_Calificaciones:208]P01_Final_Real:112
			[Alumnos_Calificaciones:208]P01_Final_Nota:113:=EV2_Real_a_Nota ($r_Calificacion;vi_gTrPAvg;iGradesDecPP)
			[Alumnos_Calificaciones:208]P01_Final_Puntos:114:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTrPAvg;iPointsDecPP)
			[Alumnos_Calificaciones:208]P01_Final_Simbolo:115:=EV2_Real_a_Simbolo ($r_Calificacion)
			[Alumnos_Calificaciones:208]P01_Final_Literal:116:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPP)
			
			$r_Calificacion:=[Alumnos_Calificaciones:208]P02_Final_Real:187
			[Alumnos_Calificaciones:208]P02_Final_Nota:188:=EV2_Real_a_Nota ($r_Calificacion;vi_gTrPAvg;iGradesDecPP)
			[Alumnos_Calificaciones:208]P02_Final_Puntos:189:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTrPAvg;iPointsDecPP)
			[Alumnos_Calificaciones:208]P02_Final_Simbolo:190:=EV2_Real_a_Simbolo ($r_Calificacion)
			[Alumnos_Calificaciones:208]P02_Final_Literal:191:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPP)
			
			$r_Calificacion:=[Alumnos_Calificaciones:208]P03_Final_Real:262
			[Alumnos_Calificaciones:208]P03_Final_Nota:263:=EV2_Real_a_Nota ($r_Calificacion;vi_gTrPAvg;iGradesDecPP)
			[Alumnos_Calificaciones:208]P03_Final_Puntos:264:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTroncarNotaFinal;iPointsDecPP)
			[Alumnos_Calificaciones:208]P03_Final_Simbolo:265:=EV2_Real_a_Simbolo ($r_Calificacion)
			[Alumnos_Calificaciones:208]P03_Final_Literal:266:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPP)
			
			$r_Calificacion:=[Alumnos_Calificaciones:208]P04_Final_Real:337
			[Alumnos_Calificaciones:208]P04_Final_Nota:338:=EV2_Real_a_Nota ($r_Calificacion;vi_gTrPAvg;iGradesDecPP)
			[Alumnos_Calificaciones:208]P04_Final_Puntos:339:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTrPAvg;iPointsDecPP)
			[Alumnos_Calificaciones:208]P04_Final_Simbolo:340:=EV2_Real_a_Simbolo ($r_Calificacion)
			[Alumnos_Calificaciones:208]P04_Final_Literal:341:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPP)
			
			$r_Calificacion:=[Alumnos_Calificaciones:208]P05_Final_Real:412
			[Alumnos_Calificaciones:208]P05_Final_Nota:413:=EV2_Real_a_Nota ($r_Calificacion;vi_gTrPAvg;iGradesDecPP)
			[Alumnos_Calificaciones:208]P05_Final_Puntos:414:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTrPAvg;iPointsDecPP)
			[Alumnos_Calificaciones:208]P05_Final_Simbolo:415:=EV2_Real_a_Simbolo ($r_Calificacion)
			[Alumnos_Calificaciones:208]P05_Final_Literal:416:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPP)
			
			SAVE RECORD:C53([Alumnos_Calificaciones:208])
			
		End for 
		
	Else 
		EVS_ReadStyleData ($l_EstiloNuevo_ID)
		EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$al_recNumCalificaciones;"")
		For ($iEvaluaciones;1;Size of array:C274($al_recNumCalificaciones))
			READ WRITE:C146([Alumnos_Calificaciones:208])
			GOTO RECORD:C242([Alumnos_Calificaciones:208];$al_recNumCalificaciones{$iEvaluaciones})
			If (($r_EstiloActual_MinimoAprobacion#$r_EstiloNuevo_MinimoAprobacion) & (Not:C34(vb_ConvierteNotas)))
				
				Case of 
					: (iEvaluationMode=Notas)
						KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
						[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96:=EV2_Real_a_Nota ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;0;iGradesDec)
						[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95:=EV2_Nota_a_Real ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96)
						[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97:=EV2_Real_a_Puntos ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;0;iPointsDec)
						[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98:=EV2_Real_a_Simbolo ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95)
						[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99:=EV2_Real_a_Literal ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;iPrintMode;vlNTA_DecimalesParciales)
						SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
						
						[Alumnos_Calificaciones:208]Anual_Nota:12:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iGradesDecPF)
						[Alumnos_Calificaciones:208]Anual_Real:11:=EV2_Nota_a_Real ([Alumnos_Calificaciones:208]Anual_Nota:12)
						[Alumnos_Calificaciones:208]Anual_Puntos:13:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iPointsDecPF)
						[Alumnos_Calificaciones:208]Anual_Simbolo:14:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]Anual_Real:11)
						[Alumnos_Calificaciones:208]Anual_Literal:15:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]Anual_Real:11;iPrintMode;vlNTA_DecimalesPF)
						
						[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iGradesDecNF)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Nota_a_Real ([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iPointsDecNF)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]Anual_Real:11;iPrintMode;vlNTA_DecimalesNF)
						
						[Alumnos_Calificaciones:208]ExamenAnual_Nota:17:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]ExamenAnual_Real:16;0;iGradesDec)
						[Alumnos_Calificaciones:208]ExamenAnual_Real:16:=EV2_Nota_a_Real ([Alumnos_Calificaciones:208]ExamenAnual_Nota:17)
						[Alumnos_Calificaciones:208]ExamenAnual_Puntos:18:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]ExamenAnual_Real:16;0;iPointsDec)
						[Alumnos_Calificaciones:208]ExamenAnual_Simbolo:19:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]ExamenAnual_Real:16)
						[Alumnos_Calificaciones:208]ExamenAnual_Literal:20:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]ExamenAnual_Real:16;iPrintMode;vlNTA_DecimalesParciales)
						
						[Alumnos_Calificaciones:208]ExamenExtra_Nota:22:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]ExamenExtra_Real:21;0;iGradesDec)
						[Alumnos_Calificaciones:208]ExamenExtra_Real:21:=EV2_Nota_a_Real ([Alumnos_Calificaciones:208]ExamenExtra_Nota:22)
						[Alumnos_Calificaciones:208]ExamenExtra_Puntos:23:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]ExamenExtra_Real:21;0;iPointsDec)
						[Alumnos_Calificaciones:208]ExamenExtra_Simbolo:24:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]ExamenExtra_Real:21)
						[Alumnos_Calificaciones:208]ExamenExtra_Literal:25:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]ExamenExtra_Real:21;iPrintMode;vlNTA_DecimalesParciales)
						
					: (iEvaluationMode=Puntos)
						KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
						[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97:=EV2_Real_a_Puntos ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;0;iPointsDec)
						[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95:=EV2_Puntos_a_Real ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97)
						[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96:=EV2_Real_a_Nota ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;0;iGradesDec)
						[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98:=EV2_Real_a_Simbolo ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95)
						[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99:=EV2_Real_a_Literal ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;iPrintMode;vlNTA_DecimalesParciales)
						SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
						
						[Alumnos_Calificaciones:208]Anual_Puntos:13:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iPointsDecPF)
						[Alumnos_Calificaciones:208]Anual_Real:11:=EV2_Puntos_a_Real ([Alumnos_Calificaciones:208]Anual_Puntos:13)
						[Alumnos_Calificaciones:208]Anual_Nota:12:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iPointsDecPF)
						[Alumnos_Calificaciones:208]Anual_Simbolo:14:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]Anual_Real:11)
						[Alumnos_Calificaciones:208]Anual_Literal:15:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]Anual_Real:11;iPrintMode;vlNTA_DecimalesPF)
						
						[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iPointsDecNF)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Puntos_a_Real ([Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iPointsDecNF)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]Anual_Real:11;iPrintMode;vlNTA_DecimalesNF)
						
						[Alumnos_Calificaciones:208]ExamenAnual_Puntos:18:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]ExamenAnual_Real:16;0;iPointsDec)
						[Alumnos_Calificaciones:208]ExamenAnual_Real:16:=EV2_Puntos_a_Real ([Alumnos_Calificaciones:208]ExamenAnual_Puntos:18)
						[Alumnos_Calificaciones:208]ExamenAnual_Nota:17:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]ExamenAnual_Real:16;0;iGradesDec)
						[Alumnos_Calificaciones:208]ExamenAnual_Simbolo:19:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]ExamenAnual_Real:16)
						[Alumnos_Calificaciones:208]ExamenAnual_Literal:20:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]ExamenAnual_Real:16;iPrintMode;vlNTA_DecimalesParciales)
						
						[Alumnos_Calificaciones:208]ExamenExtra_Puntos:23:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]ExamenExtra_Real:21;0;iPointsDec)
						[Alumnos_Calificaciones:208]ExamenExtra_Real:21:=EV2_Puntos_a_Real ([Alumnos_Calificaciones:208]ExamenExtra_Puntos:23)
						[Alumnos_Calificaciones:208]ExamenExtra_Nota:22:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]ExamenExtra_Real:21;0;iGradesDec)
						[Alumnos_Calificaciones:208]ExamenExtra_Simbolo:24:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]ExamenExtra_Real:21)
						[Alumnos_Calificaciones:208]ExamenExtra_Literal:25:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]ExamenExtra_Real:21;iPrintMode;vlNTA_DecimalesParciales)
						
					: (iEvaluationMode=Simbolos)
						
						KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
						[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98:=EV2_Real_a_Simbolo ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95)
						[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95:=EV2_Simbolo_a_Real ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98)
						[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96:=EV2_Real_a_Nota ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;0;iGradesDec)
						[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97:=EV2_Real_a_Puntos ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;0;iPointsDec)
						[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99:=EV2_Real_a_Literal ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;iPrintMode;vlNTA_DecimalesParciales)
						SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
						
						[Alumnos_Calificaciones:208]Anual_Simbolo:14:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]Anual_Real:11)
						[Alumnos_Calificaciones:208]Anual_Real:11:=EV2_Simbolo_a_Real ([Alumnos_Calificaciones:208]Anual_Simbolo:14)
						[Alumnos_Calificaciones:208]Anual_Nota:12:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iGradesDecPF)
						[Alumnos_Calificaciones:208]Anual_Puntos:13:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iPointsDecPF)
						[Alumnos_Calificaciones:208]Anual_Literal:15:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]Anual_Real:11;iPrintMode)
						
						[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Simbolo_a_Real ([Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iGradesDecNF)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iPointsDecNF)
						[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]Anual_Real:11;iPrintMode)
						
						[Alumnos_Calificaciones:208]ExamenAnual_Simbolo:19:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]ExamenAnual_Real:16)
						[Alumnos_Calificaciones:208]ExamenAnual_Real:16:=EV2_Simbolo_a_Real ([Alumnos_Calificaciones:208]ExamenAnual_Simbolo:19)
						[Alumnos_Calificaciones:208]ExamenAnual_Nota:17:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]ExamenAnual_Real:16;0;iGradesDec)
						[Alumnos_Calificaciones:208]ExamenAnual_Puntos:18:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]ExamenAnual_Real:16;0;iPointsDec)
						[Alumnos_Calificaciones:208]ExamenAnual_Literal:20:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]ExamenAnual_Real:16;iPrintMode;vlNTA_DecimalesParciales)
						
						[Alumnos_Calificaciones:208]ExamenExtra_Simbolo:24:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]ExamenExtra_Real:21)
						[Alumnos_Calificaciones:208]ExamenExtra_Real:21:=EV2_Simbolo_a_Real ([Alumnos_Calificaciones:208]ExamenExtra_Simbolo:24)
						[Alumnos_Calificaciones:208]ExamenExtra_Nota:22:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]ExamenExtra_Real:21;0;iGradesDec)
						[Alumnos_Calificaciones:208]ExamenExtra_Puntos:23:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]ExamenExtra_Real:21;0;iPointsDec)
						[Alumnos_Calificaciones:208]ExamenExtra_Literal:25:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]ExamenExtra_Real:21;iPrintMode;vlNTA_DecimalesParciales)
				End case 
				
				For ($iFields;42;412;5)
					$r_Calificacion:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields)->
					$y_campoNota:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+1)
					$y_campoNota->:=EV2_Real_a_Nota ($r_Calificacion;0;iGradesDEC)
					$y_campoPuntos:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+2)
					$y_campoPuntos->:=EV2_Real_a_Puntos ($r_Calificacion;0;iPointsDec)
					$y_campoSimbolos:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+3)
					$y_campoSimbolos->:=EV2_Real_a_Simbolo ($r_Calificacion)
					$y_campoLiteralInterno:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+4)
					$y_campoLiteralInterno->:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesParciales)
				End for 
				
				$r_Calificacion:=[Alumnos_Calificaciones:208]P01_Final_Real:112
				[Alumnos_Calificaciones:208]P01_Final_Nota:113:=EV2_Real_a_Nota ($r_Calificacion;vi_gTroncarNotaFinal;iGradesDecPP)
				[Alumnos_Calificaciones:208]P01_Final_Puntos:114:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTroncarNotaFinal;iPointsDecPP)
				[Alumnos_Calificaciones:208]P01_Final_Simbolo:115:=EV2_Real_a_Simbolo ($r_Calificacion)
				[Alumnos_Calificaciones:208]P01_Final_Literal:116:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPP)
				
				$r_Calificacion:=[Alumnos_Calificaciones:208]P02_Final_Real:187
				[Alumnos_Calificaciones:208]P02_Final_Nota:188:=EV2_Real_a_Nota ($r_Calificacion;vi_gTroncarNotaFinal;iGradesDecPP)
				[Alumnos_Calificaciones:208]P02_Final_Puntos:189:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTroncarNotaFinal;iPointsDecPP)
				[Alumnos_Calificaciones:208]P02_Final_Simbolo:190:=EV2_Real_a_Simbolo ($r_Calificacion)
				[Alumnos_Calificaciones:208]P02_Final_Literal:191:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPP)
				
				$r_Calificacion:=[Alumnos_Calificaciones:208]P03_Final_Real:262
				[Alumnos_Calificaciones:208]P03_Final_Nota:263:=EV2_Real_a_Nota ($r_Calificacion;vi_gTroncarNotaFinal;iGradesDecPP)
				[Alumnos_Calificaciones:208]P03_Final_Puntos:264:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTroncarNotaFinal;iPointsDecPP)
				[Alumnos_Calificaciones:208]P03_Final_Simbolo:265:=EV2_Real_a_Simbolo ($r_Calificacion)
				[Alumnos_Calificaciones:208]P03_Final_Literal:266:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPP)
				
				$r_Calificacion:=[Alumnos_Calificaciones:208]P04_Final_Real:337
				[Alumnos_Calificaciones:208]P04_Final_Nota:338:=EV2_Real_a_Nota ($r_Calificacion;vi_gTroncarNotaFinal;iGradesDecPP)
				[Alumnos_Calificaciones:208]P04_Final_Puntos:339:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTroncarNotaFinal;iPointsDecPP)
				[Alumnos_Calificaciones:208]P04_Final_Simbolo:340:=EV2_Real_a_Simbolo ($r_Calificacion)
				[Alumnos_Calificaciones:208]P04_Final_Literal:341:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPP)
				
				$r_Calificacion:=[Alumnos_Calificaciones:208]P05_Final_Real:412
				[Alumnos_Calificaciones:208]P05_Final_Nota:413:=EV2_Real_a_Nota ($r_Calificacion;vi_gTroncarNotaFinal;iGradesDecPP)
				[Alumnos_Calificaciones:208]P05_Final_Puntos:414:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTroncarNotaFinal;iPointsDecPP)
				[Alumnos_Calificaciones:208]P05_Final_Simbolo:415:=EV2_Real_a_Simbolo ($r_Calificacion)
				[Alumnos_Calificaciones:208]P05_Final_Literal:416:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPP)
				
				SAVE RECORD:C53([Alumnos_Calificaciones:208])
			Else 
				
				EVS_ReadStyleData ($l_EstiloNuevo_ID)
				
				$r_Calificacion:=[Alumnos_Calificaciones:208]Anual_Real:11
				[Alumnos_Calificaciones:208]Anual_Nota:12:=EV2_Real_a_Nota ($r_Calificacion;vi_gTrFAvg;iGradesDecPF)
				[Alumnos_Calificaciones:208]Anual_Puntos:13:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTrFAvg;iPointsDecPF)
				[Alumnos_Calificaciones:208]Anual_Simbolo:14:=EV2_Real_a_Simbolo ($r_Calificacion)
				[Alumnos_Calificaciones:208]Anual_Literal:15:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPF)
				
				$r_Calificacion:=[Alumnos_Calificaciones:208]ExamenAnual_Real:16
				[Alumnos_Calificaciones:208]ExamenAnual_Nota:17:=EV2_Real_a_Nota ($r_Calificacion;0;iGradesDec)
				[Alumnos_Calificaciones:208]ExamenAnual_Puntos:18:=EV2_Real_a_Puntos ($r_Calificacion;0;iPointsDec)
				[Alumnos_Calificaciones:208]ExamenAnual_Simbolo:19:=EV2_Real_a_Simbolo ($r_Calificacion)
				[Alumnos_Calificaciones:208]ExamenAnual_Literal:20:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesParciales)
				
				$r_Calificacion:=[Alumnos_Calificaciones:208]ExamenExtra_Real:21
				[Alumnos_Calificaciones:208]ExamenExtra_Nota:22:=EV2_Real_a_Nota ($r_Calificacion;0;iGradesDec)
				[Alumnos_Calificaciones:208]ExamenExtra_Puntos:23:=EV2_Real_a_Puntos ($r_Calificacion;0;iPointsDec)
				[Alumnos_Calificaciones:208]ExamenExtra_Simbolo:24:=EV2_Real_a_Simbolo ($r_Calificacion)
				[Alumnos_Calificaciones:208]ExamenExtra_Literal:25:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesParciales)
				
				$r_Calificacion:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
				[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=EV2_Real_a_Nota ($r_Calificacion;vi_gTroncarNotaFinal;iGradesDecNF)
				[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTroncarNotaFinal;iPointsDecNF)
				[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=EV2_Real_a_Simbolo ($r_Calificacion)
				[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesNF)
				
				For ($iFields;42;412;5)
					$r_Calificacion:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields)->
					$y_campoNota:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+1)
					$y_campoNota->:=EV2_Real_a_Nota ($r_Calificacion;0;iGradesDEC)
					$y_campoPuntos:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+2)
					$y_campoPuntos->:=EV2_Real_a_Puntos ($r_Calificacion;0;iPointsDec)
					$y_campoSimbolos:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+3)
					$y_campoSimbolos->:=EV2_Real_a_Simbolo ($r_Calificacion)
					$y_campoLiteralInterno:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$iFields+4)
					$y_campoLiteralInterno->:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesParciales)
				End for 
				
				$r_Calificacion:=[Alumnos_Calificaciones:208]P01_Final_Real:112
				[Alumnos_Calificaciones:208]P01_Final_Nota:113:=EV2_Real_a_Nota ($r_Calificacion;vi_gTrPAvg;iGradesDecPP)
				[Alumnos_Calificaciones:208]P01_Final_Puntos:114:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTrPAvg;iPointsDecPP)
				[Alumnos_Calificaciones:208]P01_Final_Simbolo:115:=EV2_Real_a_Simbolo ($r_Calificacion)
				[Alumnos_Calificaciones:208]P01_Final_Literal:116:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPP)
				
				$r_Calificacion:=[Alumnos_Calificaciones:208]P02_Final_Real:187
				[Alumnos_Calificaciones:208]P02_Final_Nota:188:=EV2_Real_a_Nota ($r_Calificacion;vi_gTrPAvg;iGradesDecPP)
				[Alumnos_Calificaciones:208]P02_Final_Puntos:189:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTrPAvg;iPointsDecPP)
				[Alumnos_Calificaciones:208]P02_Final_Simbolo:190:=EV2_Real_a_Simbolo ($r_Calificacion)
				[Alumnos_Calificaciones:208]P02_Final_Literal:191:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPP)
				
				$r_Calificacion:=[Alumnos_Calificaciones:208]P03_Final_Real:262
				[Alumnos_Calificaciones:208]P03_Final_Nota:263:=EV2_Real_a_Nota ($r_Calificacion;vi_gTrPAvg;iGradesDecPP)
				[Alumnos_Calificaciones:208]P03_Final_Puntos:264:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTrPAvg;iPointsDecPP)
				[Alumnos_Calificaciones:208]P03_Final_Simbolo:265:=EV2_Real_a_Simbolo ($r_Calificacion)
				[Alumnos_Calificaciones:208]P03_Final_Literal:266:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPP)
				
				$r_Calificacion:=[Alumnos_Calificaciones:208]P04_Final_Real:337
				[Alumnos_Calificaciones:208]P04_Final_Nota:338:=EV2_Real_a_Nota ($r_Calificacion;vi_gTrPAvg;iGradesDecPP)
				[Alumnos_Calificaciones:208]P04_Final_Puntos:339:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTrPAvg;iPointsDecPP)
				[Alumnos_Calificaciones:208]P04_Final_Simbolo:340:=EV2_Real_a_Simbolo ($r_Calificacion)
				[Alumnos_Calificaciones:208]P04_Final_Literal:341:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPP)
				
				$r_Calificacion:=[Alumnos_Calificaciones:208]P05_Final_Real:412
				[Alumnos_Calificaciones:208]P05_Final_Nota:413:=EV2_Real_a_Nota ($r_Calificacion;vi_gTrPAvg;iGradesDecPP)
				[Alumnos_Calificaciones:208]P05_Final_Puntos:414:=EV2_Real_a_Puntos ($r_Calificacion;vi_gTrPAvg;iPointsDecPP)
				[Alumnos_Calificaciones:208]P05_Final_Simbolo:415:=EV2_Real_a_Simbolo ($r_Calificacion)
				[Alumnos_Calificaciones:208]P05_Final_Literal:416:=EV2_Real_a_Literal ($r_Calificacion;iPrintMode;vlNTA_DecimalesPP)
				
				SAVE RECORD:C53([Alumnos_Calificaciones:208])
				
			End if 
			
		End for 
		
		EVS_ReadStyleData ($l_EstiloNuevo_ID)
		AS_UpdateStyleSettings ($l_EstiloNuevo_ID)
		SAVE RECORD:C53([Asignaturas:18])
		
End case 