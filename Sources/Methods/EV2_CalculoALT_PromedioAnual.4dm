//%attributes = {}
  // Método: EV2_CalculoALT_PromedioAnual
  //
  // 
  // por Alberto Bachler Klein
  // creación 13/07/17, 11:23:38
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

C_REAL:C285($0)

C_BOOLEAN:C305($b_periodosPonderados)
C_LONGINT:C283($i;$l_Div;$l_evaluaciones)
C_POINTER:C301($y_pointerPonderacion;$y_campoALTAnual)
C_REAL:C285($r_ponderacion;$r_ponderacionesAcumuladas;$r_PromedioReal;$r_sum;$r_sumPonderados;$r_totalPonderaciones;$r_Value)

If (False:C215)
	C_REAL:C285(EV2_Calculos_PromedioAnual ;$0)
End if 



Case of 
	: (iEvaluationMode=Notas)
		$l_modoAlternativo:=Puntos
		$l_decimales:=iPointsDecPF
		$y_campoALTAnual:=->[Alumnos_Calificaciones:208]Anual_Puntos:13
		
	: (iEvaluationMode=Puntos)
		$l_modoAlternativo:=Notas
		$l_decimales:=iGradesDecPF
		$y_campoALTAnual:=->[Alumnos_Calificaciones:208]Anual_Nota:12
End case 

Case of 
	: ($l_modoAlternativo=Notas)
		Case of 
			: (vlSTR_Periodos_Tipo=5 Bimestres)
				$r_totalPonderaciones:=vrEVS_PonderacionQ1+vrEVS_PonderacionQ2+vrEVS_PonderacionQ3+vrEVS_PonderacionQ4+vrEVS_PonderacionQ5
				ARRAY REAL:C219($ar_FinalesPeriodos;5)
				$ar_FinalesPeriodos{1}:=[Alumnos_Calificaciones:208]P01_Final_Nota:113
				$ar_FinalesPeriodos{2}:=[Alumnos_Calificaciones:208]P02_Final_Nota:188
				$ar_FinalesPeriodos{3}:=[Alumnos_Calificaciones:208]P03_Final_Nota:263
				$ar_FinalesPeriodos{4}:=[Alumnos_Calificaciones:208]P04_Final_Nota:338
				$ar_FinalesPeriodos{5}:=[Alumnos_Calificaciones:208]P05_Final_Nota:413
				
			: (vlSTR_Periodos_Tipo=4 Bimestres)
				$r_totalPonderaciones:=vrEVS_PonderacionB1+vrEVS_PonderacionB2+vrEVS_PonderacionB3+vrEVS_PonderacionB4
				ARRAY REAL:C219($ar_FinalesPeriodos;4)
				$ar_FinalesPeriodos{1}:=[Alumnos_Calificaciones:208]P01_Final_Nota:113
				$ar_FinalesPeriodos{2}:=[Alumnos_Calificaciones:208]P02_Final_Nota:188
				$ar_FinalesPeriodos{3}:=[Alumnos_Calificaciones:208]P03_Final_Nota:263
				$ar_FinalesPeriodos{4}:=[Alumnos_Calificaciones:208]P04_Final_Nota:338
				
			: (vlSTR_Periodos_Tipo=3 Trimestres)
				$r_totalPonderaciones:=vrEVS_PonderacionT1+vrEVS_PonderacionT2+vrEVS_PonderacionT3
				ARRAY REAL:C219($ar_FinalesPeriodos;3)
				$ar_FinalesPeriodos{1}:=[Alumnos_Calificaciones:208]P01_Final_Nota:113
				$ar_FinalesPeriodos{2}:=[Alumnos_Calificaciones:208]P02_Final_Nota:188
				$ar_FinalesPeriodos{3}:=[Alumnos_Calificaciones:208]P03_Final_Nota:263
				
			: (vlSTR_Periodos_Tipo=2 Semestres)
				$r_totalPonderaciones:=vrEVS_PonderacionS1+vrEVS_PonderacionS2
				ARRAY REAL:C219($ar_FinalesPeriodos;2)
				$ar_FinalesPeriodos{1}:=[Alumnos_Calificaciones:208]P01_Final_Nota:113
				$ar_FinalesPeriodos{2}:=[Alumnos_Calificaciones:208]P02_Final_Nota:188
				
			: (vlSTR_Periodos_Tipo=Anual)  //anual
				$r_totalPonderaciones:=0
				ARRAY REAL:C219($ar_FinalesPeriodos;1)
				$ar_FinalesPeriodos{1}:=[Alumnos_Calificaciones:208]P01_Final_Nota:113
		End case 
		
		
	: ($l_modoAlternativo=Puntos)
		Case of 
			: (vlSTR_Periodos_Tipo=5 Bimestres)
				$r_totalPonderaciones:=vrEVS_PonderacionQ1+vrEVS_PonderacionQ2+vrEVS_PonderacionQ3+vrEVS_PonderacionQ4+vrEVS_PonderacionQ5
				ARRAY REAL:C219($ar_FinalesPeriodos;5)
				$ar_FinalesPeriodos{1}:=[Alumnos_Calificaciones:208]P01_Final_Puntos:114
				$ar_FinalesPeriodos{2}:=[Alumnos_Calificaciones:208]P02_Final_Puntos:189
				$ar_FinalesPeriodos{3}:=[Alumnos_Calificaciones:208]P03_Final_Puntos:264
				$ar_FinalesPeriodos{4}:=[Alumnos_Calificaciones:208]P04_Final_Puntos:339
				$ar_FinalesPeriodos{5}:=[Alumnos_Calificaciones:208]P05_Final_Puntos:414
				
			: (vlSTR_Periodos_Tipo=4 Bimestres)
				$r_totalPonderaciones:=vrEVS_PonderacionB1+vrEVS_PonderacionB2+vrEVS_PonderacionB3+vrEVS_PonderacionB4
				ARRAY REAL:C219($ar_FinalesPeriodos;4)
				$ar_FinalesPeriodos{1}:=[Alumnos_Calificaciones:208]P01_Final_Puntos:114
				$ar_FinalesPeriodos{2}:=[Alumnos_Calificaciones:208]P02_Final_Puntos:189
				$ar_FinalesPeriodos{3}:=[Alumnos_Calificaciones:208]P03_Final_Puntos:264
				$ar_FinalesPeriodos{4}:=[Alumnos_Calificaciones:208]P04_Final_Puntos:339
				
			: (vlSTR_Periodos_Tipo=3 Trimestres)
				$r_totalPonderaciones:=vrEVS_PonderacionT1+vrEVS_PonderacionT2+vrEVS_PonderacionT3
				ARRAY REAL:C219($ar_FinalesPeriodos;3)
				$ar_FinalesPeriodos{1}:=[Alumnos_Calificaciones:208]P01_Final_Puntos:114
				$ar_FinalesPeriodos{2}:=[Alumnos_Calificaciones:208]P02_Final_Puntos:189
				$ar_FinalesPeriodos{3}:=[Alumnos_Calificaciones:208]P03_Final_Puntos:264
				
			: (vlSTR_Periodos_Tipo=2 Semestres)
				$r_totalPonderaciones:=vrEVS_PonderacionS1+vrEVS_PonderacionS2
				ARRAY REAL:C219($ar_FinalesPeriodos;2)
				$ar_FinalesPeriodos{1}:=[Alumnos_Calificaciones:208]P01_Final_Puntos:114
				$ar_FinalesPeriodos{2}:=[Alumnos_Calificaciones:208]P02_Final_Puntos:189
				
			: (vlSTR_Periodos_Tipo=Anual)  //anual
				$r_totalPonderaciones:=0
				ARRAY REAL:C219($ar_FinalesPeriodos;1)
				$ar_FinalesPeriodos{1}:=[Alumnos_Calificaciones:208]P01_Final_Puntos:114
		End case 
End case 




If ($r_totalPonderaciones=100)
	$b_periodosPonderados:=True:C214
Else 
	$b_periodosPonderados:=False:C215
End if 

$r_sum:=0
$l_Div:=0
$l_evaluaciones:=0
Case of 
	: ($b_periodosPonderados=True:C214)
		$r_ponderacionesAcumuladas:=0
		$r_sumPonderados:=0
		For ($i;1;Size of array:C274($ar_FinalesPeriodos))
			Case of 
				: (viSTR_Periodos_NumeroPeriodos=1)
				: (viSTR_Periodos_NumeroPeriodos=2)
					$y_pointerPonderacion:=Get pointer:C304("vrEVS_PonderacionS"+String:C10($i))
				: (viSTR_Periodos_NumeroPeriodos=3)
					$y_pointerPonderacion:=Get pointer:C304("vrEVS_PonderacionT"+String:C10($i))
				: (viSTR_Periodos_NumeroPeriodos=4)
					$y_pointerPonderacion:=Get pointer:C304("vrEVS_PonderacionB"+String:C10($i))
				: (viSTR_Periodos_NumeroPeriodos=5)
					$y_pointerPonderacion:=Get pointer:C304("vrEVS_PonderacionQ"+String:C10($i))
			End case 
			$r_Value:=$ar_FinalesPeriodos{$i}
			$r_ponderacion:=$y_pointerPonderacion->
			
			If ($r_Value=-2)
				$r_sum:=$r_Value
				$i:=Size of array:C274($ar_FinalesPeriodos)
			End if 
			If (Not:C34(Is nil pointer:C315($y_pointerPonderacion)))
				If (($r_Value>=vrNTA_MinimoEscalaReferencia) & ($r_ponderacion>0))
					$r_ponderacion:=$y_pointerPonderacion->
					$r_ponderacionesAcumuladas:=$r_ponderacionesAcumuladas+$r_ponderacion
					$r_sumPonderados:=$r_sumPonderados+Round:C94($r_Value*($r_ponderacion/100);$l_decimales)
					$l_evaluaciones:=$l_evaluaciones+1
				End if 
			Else 
				$r_ponderacionesAcumuladas:=100
			End if 
		End for 
		If ($l_evaluaciones>0)
			If ($r_ponderacionesAcumuladas<=100)
				If ($r_sumPonderados>0)
					$r_sumPonderados:=Round:C94(Round:C94($r_sumPonderados/$r_ponderacionesAcumuladas;11)*100;$l_decimales)
					$r_PromedioReal:=$r_sumPonderados
				Else 
					$r_PromedioReal:=-10
				End if 
			End if 
		Else 
			If (($r_sum=-1) | ($r_sum=-2) | ($r_sum=-3))
				$r_PromedioReal:=$r_sum
			Else 
				$r_PromedioReal:=-10
			End if 
		End if 
		
	: ($b_periodosPonderados=False:C215)
		$r_PromedioReal:=-10
		For ($i;1;Size of array:C274($ar_FinalesPeriodos))
			$r_Value:=$ar_FinalesPeriodos{$i}
			Case of 
				: ($r_Value=-2)
					$r_sum:=$r_Value
					$i:=Size of array:C274($ar_FinalesPeriodos)+1
				: ($r_Value>=vrNTA_MinimoEscalaReferencia)
					$r_sum:=$r_sum+$r_Value
					$l_Div:=$l_Div+1
					$l_evaluaciones:=$l_evaluaciones+1
			End case 
			
		End for 
		If ($l_evaluaciones>0)
			Case of 
				: (($r_sum>=vrNTA_MinimoEscalaReferencia) & ($l_Div>0))
					$r_PromedioReal:=Round:C94($r_sum/$l_Div;$l_decimales)
				: ($r_sum=-2)
					$r_PromedioReal:=-2
				: ($r_sum=-3)
					$r_PromedioReal:=-3
				: (($r_sum=0) & ($l_Div>0))
					$r_PromedioReal:=-10
			End case 
		Else 
			If (($r_sum=-1) | ($r_sum=-2) | ($r_sum=-3))
				$r_PromedioReal:=$r_sum
			Else 
				$r_PromedioReal:=-10
			End if 
		End if 
End case 

$y_campoALTAnual->:=$r_PromedioReal
If (vi_BonificarPromedioAnual=1)
	If ($l_modoAlternativo=Notas)
		$el:=Find in array:C230(arEVS_ConvGrades;$y_campoALTAnual->)
		If ($el>0)
			$y_campoALTAnual->:=$y_campoALTAnual->+arEVS_ConvGradesOfficial{$el}
		End if 
	Else 
		$el:=Find in array:C230(arEVS_ConvPoints;$y_campoALTAnual->)
		If ($el>0)
			$y_campoALTAnual->:=$y_campoALTAnual->+arEVS_ConvGradesOfficial{$el}
		End if 
	End if 
End if 


