//%attributes = {}
  // EV2_Calculos_AjusteFinal()
  //
  //
  // creado por: Alberto Bachler Klein: 25-11-16, 18:24:16
  // -----------------------------------------------------------
C_LONGINT:C283($l_posicion)
C_REAL:C285($r_nota;$r_puntos)
C_TEXT:C284($t_simbolo)

If ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26<rPctMinimum)
	Case of 
		: (iEvaluationMode=Notas)
			$r_nota:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_TruncarInferiorRequerido;iGradesDecNF)
			If ((vi_TruncarInferiorRequerido=1) & ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26<rPctMinimum))
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Nota_a_Real ($r_nota)
			End if 
			
			If (vi_BonificarNotaFinalInterna=1)
				$l_posicion:=Find in array:C230(arEVS_ConvGradesPercent;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
				If ($l_posicion>0)
					$r_nota:=$r_nota+arEVS_ConvGradesOfficial{$l_posicion}
					[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Nota_a_Real ($r_nota)
				End if 
			End if 
			[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Nota_a_Real ($r_nota)
			[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=EV2_Nota_a_Simbolo ($r_nota)
			
			
		: (iEvaluationMode=Puntos)
			$r_puntos:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_TruncarInferiorRequerido;iPointsDecNF)
			If ((vi_TruncarInferiorRequerido=1) & ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26<rPctMinimum))
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Puntos_a_Real ($r_puntos)
			End if 
			
			If (vi_BonificarNotaFinalInterna=1)
				$l_posicion:=Find in array:C230(arEVS_ConvPointsPercent;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
				If ($l_posicion>0)
					$r_puntos:=$r_puntos+arEVS_ConvGradesOfficial{$l_posicion}
					[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Puntos_a_Real ($r_puntos)
				End if 
			End if 
			[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Puntos_a_Real ($r_puntos)
			[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=EV2_Puntos_a_Simbolo ($r_puntos)
			
			
		: (iEvaluationMode=Porcentaje)
			If ((vi_TruncarInferiorRequerido=1) & ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26<rPctMinimum))
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=Trunc:C95([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;1)
			Else 
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;1)
			End if 
			$t_simbolo:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
			
			
		: (iEvaluationMode=Simbolos)
			If (vi_ConvertSymbolicAverage=1)
				$t_simbolo:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Simbolo_a_Real ($t_simbolo)
			Else 
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502
			End if 
			  //MONO ticket 207220
			[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
	End case 
	
	
Else 
	
	Case of 
		: (iEvaluationMode=Notas)
			$r_nota:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iGradesDecNF)
			If ((vi_TruncarInferiorRequerido=1) & ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26<rPctMinimum))
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Nota_a_Real ($r_nota)
			End if 
			
			If (vi_BonificarNotaFinalInterna=1)
				$l_posicion:=Find in array:C230(arEVS_ConvGradesPercent;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
				If ($l_posicion>0)
					$r_nota:=$r_nota+arEVS_ConvGradesOfficial{$l_posicion}
					[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Nota_a_Real ($r_nota)
				End if 
			End if 
			[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Nota_a_Real ($r_nota)
			[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=EV2_Nota_a_Simbolo ($r_nota)
			
			
		: (iEvaluationMode=Puntos)
			$r_puntos:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iPointsDecNF)
			If ((vi_TruncarInferiorRequerido=1) & ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26<rPctMinimum))
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Puntos_a_Real ($r_puntos)
			End if 
			
			If (vi_BonificarNotaFinalInterna=1)
				$l_posicion:=Find in array:C230(arEVS_ConvPointsPercent;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
				If ($l_posicion>0)
					$r_puntos:=$r_puntos+arEVS_ConvGradesOfficial{$l_posicion}
					[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Puntos_a_Real ($r_puntos)
				End if 
			End if 
			[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Puntos_a_Real ($r_puntos)
			[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=EV2_Puntos_a_Simbolo ($r_puntos)
			
			
		: (iEvaluationMode=Porcentaje)
			If ((vi_TruncarInferiorRequerido=1) & ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26<rPctMinimum))
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=Trunc:C95([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;1)
			Else 
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;1)
			End if 
			[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
			
			
		: (iEvaluationMode=Simbolos)
			If (vi_ConvertSymbolicAverage=1)
				$t_simbolo:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=EV2_Simbolo_a_Real ($t_simbolo)
			Else 
				[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502
			End if 
			[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
	End case 
	
	
End if 

If ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26>=vrNTA_MinimoEscalaReferencia)
	[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iGradesDecNF)
	[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;vi_gTroncarNotaFinal;iPointsDecNF)
Else 
	[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=[Alumnos_Calificaciones:208]Anual_Nota:12
	[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=[Alumnos_Calificaciones:208]Anual_Real:11
End if 

If (iPrintMode=Simbolos)
	[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:=[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29
Else 
	[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;iPrintMode;vlNTA_DecimalesNF)
End if 


  //RELATE ONE([Alumnos_Calificaciones]Llave_principal)
Case of 
	: (([Alumnos_Calificaciones:208]ExamenAnual_Real:16=-10) | ([Alumnos_Calificaciones:208]ExamenExtra_Real:21=-10))
		KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
		[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95:=-10
		[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96:=-10
		[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97:=-10
		[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98:=""
		[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99:=""
		SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
		KRL_ReloadAsReadOnly (->[Alumnos_ComplementoEvaluacion:209])
End case 

If ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95>=vrNTA_MinimoEscalaReferencia)
	[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26:=[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95
	[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27:=[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96
	[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28:=[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97
	[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29:=[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98
	[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30:=[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99
End if 



EV2loc_Ajustes_Final 

