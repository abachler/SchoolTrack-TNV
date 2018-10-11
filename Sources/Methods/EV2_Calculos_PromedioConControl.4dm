//%attributes = {}
  // EV2_Calculos_PromedioConControl()
  //
  //
  // creado por: Alberto Bachler Klein: 21-11-16, 16:55:58
  // -----------------------------------------------------------
C_REAL:C285($0)
C_REAL:C285($1)
C_REAL:C285($2)

C_BOOLEAN:C305($b_pondera)
C_REAL:C285($r_ControlFinPeriodo;$r_controlPeriodo;$r_finalPeriodo;$r_nota;$r_ponderacionControl;$r_PonderacionPresentacion;$r_presentacion;$r_Promedio;$r_PromedioPeriodo;$r_puntos)
C_TEXT:C284($t_simbolo)


If (False:C215)
	C_REAL:C285(EV2_Calculos_PromedioConControl ;$0)
	C_REAL:C285(EV2_Calculos_PromedioConControl ;$1)
	C_REAL:C285(EV2_Calculos_PromedioConControl ;$2)
End if 

$r_presentacion:=$1
$r_ControlFinPeriodo:=$2
$0:=$r_presentacion


If ((vi_UsarControlesFinPeriodo=1) & ($r_ControlFinPeriodo>=vrNTA_MinimoEscalaReferencia) & ($r_presentacion>=vrNTA_MinimoEscalaReferencia))
	If (vi_RoundCPpresent=1)  //si la evaluaciÑn de presentaciÑn a examen deben ser truncada, es reconvertida con troncatura al estilo de evaluaciÑn principal y a partir de ese valor se obtiene el real correspondiente
		Case of 
			: (iEvaluationMode=Notas)
				$r_nota:=EV2_Real_a_Nota ($r_presentacion;0;iGradesDecPP)
				$r_presentacion:=EV2_Nota_a_Real ($r_nota)
			: (iEvaluationMode=Puntos)
				$r_puntos:=EV2_Real_a_Puntos ($r_presentacion;0;iPointsDecPP)
				$r_presentacion:=EV2_Puntos_a_Real ($r_puntos)
			: (iEvaluationMode=Porcentaje)
				$r_presentacion:=Round:C94($r_presentacion;1)
			: (iEvaluationMode=Simbolos)
				$t_simbolo:=EV2_Real_a_Simbolo ($r_presentacion)
				$r_presentacion:=EV2_Simbolo_a_Real ($t_simbolo)
		End case 
	End if 
	
	$b_pondera:=False:C215
	Case of 
		: (c1_PonderacionConstante=1)
			$r_ponderacionControl:=vr_Ctrl_PonderacionConstante/100
			$r_PonderacionPresentacion:=(100-vr_Ctrl_PonderacionConstante)/100
			$b_pondera:=True:C214
		: ((t1_CTRL_INF_Ponderado=1) & (vr_CTRL_INF_Ponderacion>0) & ($r_ControlFinPeriodo<$r_presentacion))  // ponderaciÑn si examen inferior a Promedio final
			$r_ponderacionControl:=vr_CTRL_INF_Ponderacion/100
			$r_PonderacionPresentacion:=(100-vr_CTRL_INF_Ponderacion)/100
			$b_pondera:=True:C214
		: ((u1_CTRL_SUP_Ponderado=1) & (vr_CTRL_SUP_Ponderacion>0) & ($r_ControlFinPeriodo>=$r_presentacion))  // 20170627 RCH ponderaciÑn si examen superior o igual a Promedio final
			$r_ponderacionControl:=vr_CTRL_SUP_Ponderacion/100
			$r_PonderacionPresentacion:=(100-vr_CTRL_SUP_Ponderacion)/100
			$b_pondera:=True:C214
		: ((t3_CTRL_INF_Presentacion=1) & ($r_ControlFinPeriodo<$r_presentacion))  // si examen inferior a Promedio final, Nota final=Promedio
			$r_Promedio:=$r_presentacion
		: ((t2_CTRL_INF_Control=1) & ($r_ControlFinPeriodo<$r_presentacion))  // si examen inferior a Promedio final, Nota final=Examen
			$r_Promedio:=$r_ControlFinPeriodo
		: ((t4_CTRL_INF_Especifico=1) & ($r_ControlFinPeriodo<$r_presentacion))  // si examen inferior a Promedio final, Nota final=Valor Prefijado
			$r_Promedio:=vr_CTRL_INF_Especifico
		: ((U3_CTRL_SUP_Presentacion=1) & ($r_ControlFinPeriodo>=$r_presentacion))  // 20170627 RCH si examen superior o igual a Promedio final, Nota final=Promedio
			$r_Promedio:=$r_presentacion
		: ((u2_CTRL_SUP_Control=1) & ($r_ControlFinPeriodo>=$r_presentacion))  // 20170627 RCH si examen superior o igual a Promedio final, Nota final=Examen
			$r_Promedio:=$r_ControlFinPeriodo
		: ((u4_CTRL_SUP_Especifico=1) & ($r_ControlFinPeriodo>=$r_presentacion))  // 20170627 RCH si examen superior o igual a Promedio final, Nota final=Valor Prefijado
			$r_Promedio:=vr_CTRL_SUP_Especifico
	End case 
	
	If ($b_pondera)
		$r_PromedioPeriodo:=$r_presentacion
		If ($r_PromedioPeriodo>=vrNTA_MinimoEscalaReferencia)
			$r_controlPeriodo:=Round:C94($r_ControlFinPeriodo*$r_ponderacionControl;11)
			$r_PromedioPeriodo:=Round:C94($r_PromedioPeriodo*$r_PonderacionPresentacion;11)
			$r_finalPeriodo:=$r_PromedioPeriodo+$r_controlPeriodo
			If (vi_gTrPAvg=1)
				$r_Promedio:=Trunc:C95($r_finalPeriodo;11)
			Else 
				$r_Promedio:=Round:C94($r_finalPeriodo;11)
			End if 
		Else 
			$r_Promedio:=$r_ControlFinPeriodo
		End if 
	End if 
	$0:=$r_Promedio
Else 
	Case of 
		: ($r_presentacion>=vrNTA_MinimoEscalaReferencia)
			$0:=$r_presentacion
		: (($r_ControlFinPeriodo>=vrNTA_MinimoEscalaReferencia) & (vr_Ctrl_PonderacionConstante>0))  //20170623 ASM  Ticket 183908 Agrego la variable vr_Ctrl_PonderacionConstante a la condición
			$0:=$r_ControlFinPeriodo
		Else 
			$0:=-10
	End case 
	
End if 

