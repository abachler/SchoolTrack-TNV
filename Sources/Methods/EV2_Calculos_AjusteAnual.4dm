//%attributes = {}
  // EV2_Calculos_AjusteAnual()
  // 
  //
  // creado por: Alberto Bachler Klein: 01-12-16, 10:52:08
  // -----------------------------------------------------------
C_REAL:C285($r_PromedioReal)
C_REAL:C285($r_Puntos;$r_Nota)
$r_PromedioReal:=[Alumnos_Calificaciones:208]Anual_Real:11


  // si el promedio es inferior al mínimo requerido y no debe ser truncado
If ((vi_TruncarInferiorRequerido=1) & ($r_PromedioReal<rPctMinimum))
	Case of 
		: (iEvaluationMode=Notas)
			$r_Nota:=EV2_Real_a_Nota ($r_PromedioReal;vi_TruncarInferiorRequerido;iGradesDecPF)
			$r_PromedioReal:=EV2_Nota_a_Real ($r_Nota)
			
		: (iEvaluationMode=Puntos)
			$r_Puntos:=EV2_Real_a_Puntos ($r_PromedioReal;vi_TruncarInferiorRequerido;iGradesDecPF)
			$r_PromedioReal:=EV2_Puntos_a_Real ($r_Puntos)
			
		: (iEvaluationMode=Porcentaje)
			$r_PromedioReal:=Trunc:C95($r_PromedioReal;1)
			
	End case 
End if 


  // Conversión a todos los modos de representación de la calificación
Case of 
	: ($r_PromedioReal=-10)
		
		[Alumnos_Calificaciones:208]Anual_Real:11:=-10
		[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=-10
		[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=-10
		[Alumnos_Calificaciones:208]Anual_Nota:12:=-10
		[Alumnos_Calificaciones:208]Anual_Puntos:13:=-10
		[Alumnos_Calificaciones:208]Anual_Simbolo:14:=""
		[Alumnos_Calificaciones:208]Anual_Literal:15:=""
		
	: ($r_PromedioReal=-2)
		
		[Alumnos_Calificaciones:208]Anual_Real:11:=-2
		[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=-2
		[Alumnos_Calificaciones:208]Anual_Nota:12:=-2
		[Alumnos_Calificaciones:208]Anual_Puntos:13:=-2
		[Alumnos_Calificaciones:208]Anual_Simbolo:14:=""
		[Alumnos_Calificaciones:208]Anual_Literal:15:="P"
		
	: ($r_PromedioReal=-3)
		
		[Alumnos_Calificaciones:208]Anual_Real:11:=-3
		[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=-3
		[Alumnos_Calificaciones:208]Anual_Nota:12:=-3
		[Alumnos_Calificaciones:208]Anual_Puntos:13:=-3
		[Alumnos_Calificaciones:208]Anual_Simbolo:14:=""
		[Alumnos_Calificaciones:208]Anual_Literal:15:="X"
		
	: ($r_PromedioReal=-4)
		
		[Alumnos_Calificaciones:208]Anual_Real:11:=-4
		[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=-4
		[Alumnos_Calificaciones:208]Anual_Nota:12:=-4
		[Alumnos_Calificaciones:208]Anual_Puntos:13:=-4
		[Alumnos_Calificaciones:208]Anual_Simbolo:14:=""
		[Alumnos_Calificaciones:208]Anual_Literal:15:="*"
		
	Else 
		
		
		[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=$r_PromedioReal
		[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502:=$r_PromedioReal
		[Alumnos_Calificaciones:208]Anual_Real:11:=$r_PromedioReal
		Case of 
			: (iEvaluationMode=Notas)
				[Alumnos_Calificaciones:208]Anual_Nota:12:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iGradesDecPF)
				If (vi_BonificarPromedioAnual=1)
					$el:=Find in array:C230(arEVS_ConvGrades;[Alumnos_Calificaciones:208]Anual_Nota:12)
					If ($el>0)
						[Alumnos_Calificaciones:208]Anual_Nota:12:=[Alumnos_Calificaciones:208]Anual_Nota:12+arEVS_ConvGradesOfficial{$el}
					End if 
				End if 
				[Alumnos_Calificaciones:208]Anual_Real:11:=EV2_Nota_a_Real ([Alumnos_Calificaciones:208]Anual_Nota:12)
				[Alumnos_Calificaciones:208]Anual_Simbolo:14:=EV2_Nota_a_Simbolo ([Alumnos_Calificaciones:208]Anual_Nota:12)
				[Alumnos_Calificaciones:208]Anual_Puntos:13:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iPointsDecPF)
				
				
			: (iEvaluationMode=Puntos)
				[Alumnos_Calificaciones:208]Anual_Puntos:13:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iPointsDecPF)
				If (vi_BonificarPromedioAnual=1)
					$el:=Find in array:C230(arEVS_ConvPoints;[Alumnos_Calificaciones:208]Anual_Puntos:13)
					If ($el>0)
						[Alumnos_Calificaciones:208]Anual_Puntos:13:=[Alumnos_Calificaciones:208]Anual_Puntos:13+arEVS_ConvGradesOfficial{$el}
						[Alumnos_Calificaciones:208]Anual_Real:11:=EV2_Puntos_a_Real ([Alumnos_Calificaciones:208]Anual_Puntos:13)
						[Alumnos_Calificaciones:208]Anual_Puntos:13:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iPointsDecPF)
					End if 
				End if 
				[Alumnos_Calificaciones:208]Anual_Real:11:=EV2_Puntos_a_Real ([Alumnos_Calificaciones:208]Anual_Puntos:13)
				[Alumnos_Calificaciones:208]Anual_Simbolo:14:=EV2_Puntos_a_Simbolo ([Alumnos_Calificaciones:208]Anual_Puntos:13)
				[Alumnos_Calificaciones:208]Anual_Nota:12:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iGradesDecPF)
				
				
			: (iEvaluationMode=Simbolos)
				[Alumnos_Calificaciones:208]Anual_Simbolo:14:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]Anual_Real:11)
				If (vi_ConvertSymbolicAverage=1)
					[Alumnos_Calificaciones:208]Anual_Real:11:=EV2_Simbolo_a_Real ([Alumnos_Calificaciones:208]Anual_Simbolo:14)
				End if 
				[Alumnos_Calificaciones:208]Anual_Nota:12:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iGradesDecPF)
				[Alumnos_Calificaciones:208]Anual_Puntos:13:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iPointsDecPF)
				
				
			: (iEvaluationMode=Porcentaje)
				If (vi_gTrFAvg=1)
					[Alumnos_Calificaciones:208]Anual_Real:11:=Trunc:C95([Alumnos_Calificaciones:208]Anual_Real:11;1)
				Else 
					[Alumnos_Calificaciones:208]Anual_Real:11:=Round:C94([Alumnos_Calificaciones:208]Anual_Real:11;1)
				End if 
				[Alumnos_Calificaciones:208]Anual_Nota:12:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iGradesDecPF)
				[Alumnos_Calificaciones:208]Anual_Puntos:13:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iPointsDecPF)
				[Alumnos_Calificaciones:208]Anual_Simbolo:14:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]Anual_Real:11;Simbolos)
		End case 
		If (iPrintMode=Simbolos)
			[Alumnos_Calificaciones:208]Anual_Literal:15:=[Alumnos_Calificaciones:208]Anual_Simbolo:14
		Else 
			[Alumnos_Calificaciones:208]Anual_Literal:15:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]Anual_Real:11;iPrintMode;vlNTA_DecimalesPF)
		End if 
End case 


EV2loc_Ajustes_Anual 
