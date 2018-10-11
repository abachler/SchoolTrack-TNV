//%attributes = {}
  // EV2_Calculos_Oficial()
  // 
  //
  // creado por: Alberto Bachler Klein: 01-12-16, 10:25:16
  // -----------------------------------------------------------


C_LONGINT:C283($1)

C_BOOLEAN:C305($b_bonificar;$b_convertir_a_EstiloOficial)
C_LONGINT:C283($l_elemento;$l_elementoEquivalencia;$l_idEstiloEvaluacionOficial;$l_modoEvaluacionAsignatura;$l_modoImpresionActa)
C_POINTER:C301($y_arregloModoEvaluacion;$y_Campo)
C_REAL:C285($r_Evaluacion;$r_max;$r_min;$r_Nota;$r_Puntos;$r_resultado)
C_TEXT:C284($t_metodo;$t_simbolo)


If (False:C215)
	C_LONGINT:C283(EV2_Calculos_Oficial ;$1)
End if 


$l_modoImpresionActa:=$1

Case of 
	: ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26=-2)
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:="P"
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-2
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-2
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=-2
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:="P"
		
	: ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26=-3)
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:="X"
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-2
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-2
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=-2
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:="P"
		
		
	Else 
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=""
		
		
		$b_convertir_a_EstiloOficial:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]ConvertirEval_a_EstiloOficial:37)
		$l_idEstiloEvaluacionOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]EvStyle_oficial:23)
		$b_convertir_a_EstiloOficial:=$b_convertir_a_EstiloOficial & (Not:C34([Asignaturas:18]NotaOficial_conEstiloAsignatura:95)) & (([Asignaturas:18]Incide_en_promedio:27) | ([Asignaturas:18]Incluida_en_Actas:44))
		
		$l_modoEvaluacionAsignatura:=iEvaluationMode
		If (($b_convertir_a_EstiloOficial) & (Not:C34([Asignaturas:18]NotaOficial_conEstiloAsignatura:95)) & (([Asignaturas:18]Incide_en_promedio:27) | ([Asignaturas:18]Incluida_en_Actas:44)))
			EVS_ReadStyleData ($l_idEstiloEvaluacionOficial)
		Else 
			EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		End if 
		  // ******************************************
		
		  //determino si hay bonificaciones a aplicar en la tabla de bonificaciones del estilo de la asignatura
		$r_max:=Max:C3(arEVS_ConvGradesOfficial)
		$r_min:=Min:C4(arEVS_ConvGradesOfficial)
		$b_bonificar:=(vi_BonificarNotaOficial=1) & (($r_Max>0) | ($r_min<0))
		
		
		If ((iConversionTable=1) & ($l_modoEvaluacionAsignatura#$l_modoImpresionActa))
			Case of 
				: ($l_modoImpresionActa=Notas)
					Case of 
						: ($l_modoEvaluacionAsignatura=Notas)
							$y_arregloModoEvaluacion:=->arEVS_ConvGrades
							$y_Campo:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27
							$t_metodo:="EV2_Nota_a_Real"
						: ($l_modoEvaluacionAsignatura=Puntos)
							$y_arregloModoEvaluacion:=->arEVS_ConvPoints
							$y_Campo:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28
							$t_metodo:="EV2_Puntos_a_Real"
						Else 
							$y_arregloModoEvaluacion:=->arEVS_ConvPoints
							$y_Campo:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
					End case 
					$l_elementoEquivalencia:=Find in array:C230($y_arregloModoEvaluacion->;$y_Campo->)
			End case 
			If ($l_elementoEquivalencia>0)
				$r_Evaluacion:=$y_arregloModoEvaluacion->{$l_elementoEquivalencia}
				EXECUTE METHOD:C1007($t_metodo;$r_resultado;$r_Evaluacion)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=$r_resultado
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;vi_gTroncarNotaFinal;iGradesDecNO)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;vi_gTroncarNotaFinal;iPointsDecNO)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;Porcentaje;1)
			End if 
			
			
		Else 
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=""
		End if 
		
		
		If ($b_bonificar)
			Case of 
				: ($l_modoImpresionActa=Notas)
					[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;vi_gTroncarNotaFinal;iGradesDecNO)
					$l_elemento:=Find in array:C230(arEVS_ConvGrades;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33)
					If ($l_elemento>0)
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33+arEVS_ConvGradesOfficial{$l_elemento}
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=EV2_Nota_a_Real ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33)
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;vi_gTroncarNotaFinal;iGradesdecNO)
					End if 
					
				: ($l_modoImpresionActa=Puntos)
					[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;vi_gTroncarNotaFinal;iPointsDecNO)
					$l_elemento:=Find in array:C230(arEVS_ConvPoints;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34)
					If ($l_elemento>0)
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34+arEVS_ConvGradesOfficial{$l_elemento}
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=EV2_Puntos_a_Real ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34)
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;vi_gTroncarNotaFinal;iPointsdecNO)
					End if 
					If ($b_convertir_a_EstiloOficial)
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32)
					Else 
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=EV2_Puntos_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34)
					End if 
			End case 
		End if 
		
		
		
		Case of 
			: ($l_modoImpresionActa=Notas)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;vi_gTroncarNotaFinal;iGradesDecNO)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=EV2_Nota_a_Real ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33)
				If ($b_convertir_a_EstiloOficial)
					[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32)
				Else 
					[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=EV2_Nota_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33)
				End if 
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;vi_gTroncarNotaFinal;iPointsdecNO)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;$l_modoImpresionActa;iGradesDecNO)
				
			: ($l_modoImpresionActa=Puntos)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;vi_gTroncarNotaFinal;iPointsDecNO)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=EV2_Puntos_a_Real ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34)
				If ($b_convertir_a_EstiloOficial)
					[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32)
				Else 
					[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=EV2_Puntos_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34)
				End if 
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;vi_gTroncarNotaFinal;iGradesdecNO)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;$l_modoImpresionActa;iPointsDecNO)
				
				
			: ($l_modoImpresionActa=Simbolos)
				Case of 
					: ((iEvaluationMode=Notas) & (Not:C34($b_convertir_a_EstiloOficial)))
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=EV2_Nota_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33)
					: ((iEvaluationMode=Puntos) & (Not:C34($b_convertir_a_EstiloOficial)))
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=EV2_Puntos_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34)
					Else 
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32)
				End case 
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35
				If (vi_ConvertSymbolicAverage=1)
					[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=EV2_Simbolo_a_Real ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35)
				End if 
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;vi_gTroncarNotaFinal;iPointsdecNO)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;vi_gTroncarNotaFinal;iGradesDecNO)
				
				
			: ($l_modoImpresionActa=Porcentaje)
				If (vi_gTroncarNotaFinal=1)
					[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=Trunc:C95([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;1)
				Else 
					[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;1)
				End if 
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;vi_gTroncarNotaFinal;iGradesDecNO)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;vi_gTroncarNotaFinal;iPointsDecNO)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;Porcentaje;1)
		End case 
		
		If ((vi_TruncarInferiorRequerido=1) & ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32<rPctMinimum))
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;vi_TruncarInferiorRequerido;iGradesDecNO)
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;vi_TruncarInferiorRequerido;iPointsDecNO)
			Case of 
				: ($l_modoImpresionActa=Notas)
					[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=EV2_Nota_a_Real ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33)
				: ($l_modoImpresionActa=Puntos)
					[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=EV2_Puntos_a_Real ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34)
				: ($l_modoImpresionActa=Porcentaje)
					[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=Trunc:C95([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;1)
			End case 
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32)
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;$l_modoImpresionActa;vlNTA_DecimalesNO)
		End if 
		
		If ($l_modoImpresionActa=Simbolos)
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35
		End if 
		
		Case of 
			: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32<-4)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=-10
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-10
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=""
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=""
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=""
				
			: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32=-4)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=-10
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-10
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=""
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=""
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=""
				
			: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32=-3)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=-3
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-3
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:="EX"
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:="EX"
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=""
				
			: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32=-2)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34:=-2
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-2
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:="P"
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:="P"
				
			: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32<vrNTA_MinimoEscalaReferencia)
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-10
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33:=-10
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35:=""
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=""
				[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=""
		End case 
		
		  //End case 
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=NTA_Grade2LongText ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36)
		EV2loc_Ajustes_Oficial 
		
		EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
End case 

