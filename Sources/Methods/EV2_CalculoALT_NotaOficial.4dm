//%attributes = {}
  // Método: EV2_CalculoALT_NotaOficial
  //
  //
  // por Alberto Bachler Klein
  // creación 13/07/17, 17:22:26
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_bonificar;$b_convertir_a_EstiloOficial)
C_LONGINT:C283($l_decimales;$l_elemento;$l_elementoEquivalencia;$l_idEstiloEvaluacionOficial;$l_modoAlternativo;$l_modoEvaluacionAsignatura;$l_modoImpresionActa)
C_POINTER:C301($y_arregloModoEvaluacion;$y_Campo;$y_campoALT_Final;$y_campoALT_Oficial)
C_REAL:C285($r_Evaluacion;$r_max;$r_min;$r_MinimoEscalaReferencia;$r_Nota;$r_Puntos;$r_resultado)
C_TEXT:C284($t_metodo;$t_simbolo)


If (False:C215)
	C_LONGINT:C283(EV2_CalculoALT_NotaOficial ;$1)
End if 

$l_modoImpresionActa:=$1


Case of 
	: ((iEvaluationMode=Notas) & ($l_modoImpresionActa=Puntos))
		$l_modoAlternativo:=Puntos
		$l_decimales:=iPointsDecNO
		$y_campoALT_Oficial:=->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34
		$y_campoALT_Final:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28
		$y_arregloModoEvaluacion:=->arEVS_ConvPoints
		$r_MinimoEscalaReferencia:=rPointsFrom
		$r_maximoEscala:=rPointsTo
		
	: ((iEvaluationMode=Puntos) & ($l_modoImpresionActa=Notas))
		$l_modoAlternativo:=Notas
		$l_decimales:=iGradesDecNO
		$y_campoALT_Oficial:=->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33
		$y_campoALT_Final:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27
		$y_arregloModoEvaluacion:=->arEVS_ConvGrades
		$r_MinimoEscalaReferencia:=rGradesFrom
		$r_maximoEscala:=rGradesTo
	Else 
		$l_modoAlternativo:=0
End case 
$t_formato:=EV2_ALT_FormatoString ($l_decimales)


If ($l_modoAlternativo>0)
	Case of 
		: ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26=-2)
			$y_campoALT_Oficial->:=-2
			
		: ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26=-3)
			$y_campoALT_Oficial->:=-2
			
			
		Else 
			$y_campoALT_Oficial->:=$y_campoALT_Final->
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=""
			
			
			
			$b_convertir_a_EstiloOficial:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]ConvertirEval_a_EstiloOficial:37)
			$l_idEstiloEvaluacionOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]EvStyle_oficial:23)
			
			
			$l_modoEvaluacionAsignatura:=iEvaluationMode
			If ($b_convertir_a_EstiloOficial & (Not:C34([Asignaturas:18]NotaOficial_conEstiloAsignatura:95)))
				EVS_ReadStyleData ($l_idEstiloEvaluacionOficial)
			Else 
				EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			End if 
			  // ******************************************
			
			  //determino si hay bonificaciones a aplicar en la tabla de bonificaciones del estilo de la asignatura
			$r_max:=Max:C3(arEVS_ConvGradesOfficial)
			$r_min:=Min:C4(arEVS_ConvGradesOfficial)
			$b_bonificar:=(vi_BonificarNotaOficial=1) & (($r_Max>0) | ($r_min<0))
			
			
			
			If ($b_bonificar)
				$l_elemento:=Find in array:C230($y_arregloModoEvaluacion->;$y_campoALT_Oficial->)
				If ($l_elemento>0)
					$y_campoALT_Oficial->:=$y_campoALT_Oficial->+arEVS_ConvGradesOfficial{$l_elemento}
				End if 
				
			Else 
				If (($b_convertir_a_EstiloOficial) & ([Asignaturas:18]NotaOficial_conEstiloAsignatura:95=False:C215))
					EVS_ReadStyleData ($l_idEstiloEvaluacionOficial)
				Else 
					EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
				End if 
				
				
				If ((vi_TruncarInferiorRequerido=1) & ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32<rPctMinimum))
					$y_campoALT_Oficial->:=Trunc:C95($y_campoALT_Oficial->;1)
				End if 
				
				Case of 
					: ($y_campoALT_Oficial-><=-4)
						$y_campoALT_Oficial->:=-10
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=""
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-10
						
					: ($y_campoALT_Oficial->=-3)
						$y_campoALT_Oficial->:=-3
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=""
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-3
						
					: ($y_campoALT_Oficial->=-2)
						$y_campoALT_Oficial->:=-2
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=""
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-10
						
						
					: ($y_campoALT_Oficial-><$r_MinimoEscalaReferencia)
						$y_campoALT_Oficial->:=-10
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=""
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=-10
						
					Else 
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=String:C10($y_campoALT_Oficial->;$t_formato)
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32:=Round:C94($y_campoALT_Oficial->/$r_maximoEscala*100;11)
						[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=NTA_Grade2LongText (String:C10($y_campoALT_Oficial->))
				End case 
				
			End if 
			
			
			EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	End case 
End if 

