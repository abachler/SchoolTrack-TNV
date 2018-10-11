//%attributes = {}
  // Método: EV2_CalculoALT_PP_conControl
  //
  //
  // por Alberto Bachler Klein
  // creación 11/07/17, 18:03:57
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_REAL:C285($0)
C_REAL:C285($1)
C_REAL:C285($2)

C_BOOLEAN:C305($b_pondera)
C_LONGINT:C283($l_modoAlternativo)
C_REAL:C285($r_ControlFinPeriodo;$r_controlPeriodo;$r_finalPeriodo;$r_ponderacionControl;$r_PonderacionPresentacion;$r_presentacion;$r_Promedio;$r_PromedioPeriodo)


If (False:C215)
	C_REAL:C285(EV2_CalculoALT_PP_conControl ;$0)
	C_REAL:C285(EV2_CalculoALT_PP_conControl ;$1)
	C_REAL:C285(EV2_CalculoALT_PP_conControl ;$2)
End if 

$r_presentacion:=$1
$r_ControlFinPeriodo:=$2
$0:=$r_presentacion

Case of 
	: (iEvaluationMode=Notas)
		$l_modoAlternativo:=Puntos
		vrNTA_MinimoEscalaReferencia:=rPointsFrom
	: (iEvaluationMode=Puntos)
		$l_modoAlternativo:=Notas
		vrNTA_MinimoEscalaReferencia:=rGradesFrom
End case 

If ((vi_UsarControlesFinPeriodo=1) & ($r_ControlFinPeriodo>=vrNTA_MinimoEscalaReferencia) & ($r_presentacion>=vrNTA_MinimoEscalaReferencia))
	If (vi_RoundCPpresent=1)  //si la evaluaciÑn de presentaciÑn a examen deben ser truncada, es reconvertida con troncatura al estilo de evaluaciÑn principal y a partir de ese valor se obtiene el real correspondiente
		Case of 
			: ($l_modoAlternativo=Notas)
				$r_presentacion:=Trunc:C95($r_presentacion;iGradesDecPP)
			: (iEvaluationMode=Puntos)
				$r_presentacion:=Trunc:C95($r_presentacion;iPointsDecPP)
		End case 
	End if 
	
	$b_pondera:=False:C215
	Case of 
		: ((c1_PonderacionConstante=1) & (vr_Ctrl_PonderacionConstante>0))
			$r_ponderacionControl:=vr_Ctrl_PonderacionConstante/100
			$r_PonderacionPresentacion:=(100-vr_Ctrl_PonderacionConstante)/100
			$b_pondera:=True:C214
		: ((t1_CTRL_INF_Ponderado=1) & (vr_CTRL_INF_Ponderacion>0) & ($r_ControlFinPeriodo<$r_presentacion))  // ponderaciÑn si examen inferior a Promedio final
			$r_ponderacionControl:=vr_CTRL_INF_Ponderacion/100
			$r_PonderacionPresentacion:=(100-vr_CTRL_INF_Ponderacion)/100
			$b_pondera:=True:C214
		: ((u1_CTRL_SUP_Ponderado=1) & (vr_CTRL_SUP_Ponderacion>0) & ($r_ControlFinPeriodo>$r_presentacion))  // ponderaciÑn si examen superior a Promedio final
			$r_ponderacionControl:=vr_CTRL_SUP_Ponderacion/100
			$r_PonderacionPresentacion:=(100-vr_CTRL_SUP_Ponderacion)/100
			$b_pondera:=True:C214
		: ((t3_CTRL_INF_Presentacion=1) & ($r_ControlFinPeriodo<$r_presentacion))  // si examen inferior a Promedio final, Nota final=Promedio
			$r_Promedio:=$r_presentacion
		: ((t2_CTRL_INF_Control=1) & ($r_ControlFinPeriodo<$r_presentacion))  // si examen inferior a Promedio final, Nota final=Examen
			$r_Promedio:=$r_ControlFinPeriodo
		: ((t4_CTRL_INF_Especifico=1) & ($r_ControlFinPeriodo<$r_presentacion))  // si examen inferior a Promedio final, Nota final=Valor Prefijado
			$r_Promedio:=vr_CTRL_INF_Especifico
		: ((U3_CTRL_SUP_Presentacion=1) & ($r_ControlFinPeriodo>$r_presentacion))  // si examen superior a Promedio final, Nota final=Promedio
			$r_Promedio:=$r_presentacion
		: ((u2_CTRL_SUP_Control=1) & ($r_ControlFinPeriodo>$r_presentacion))  // si examen superior a Promedio final, Nota final=Examen
			$r_Promedio:=$r_ControlFinPeriodo
		: ((u4_CTRL_SUP_Especifico=1) & ($r_ControlFinPeriodo>$r_presentacion))  // si examen superior a Promedio final, Nota final=Valor Prefijado
			$r_Promedio:=vr_CTRL_SUP_Especifico
	End case 
	
	If ($b_pondera)
		$r_PromedioPeriodo:=$r_presentacion
		If ($r_PromedioPeriodo>=vrNTA_MinimoEscalaReferencia)
			$r_controlPeriodo:=Round:C94($r_ControlFinPeriodo*$r_ponderacionControl;11)
			$r_PromedioPeriodo:=Round:C94($r_PromedioPeriodo*$r_PonderacionPresentacion;11)
			$r_finalPeriodo:=$r_PromedioPeriodo+$r_controlPeriodo
		Else 
			$r_Promedio:=$r_ControlFinPeriodo
		End if 
	Else 
		$r_Promedio:=$r_presentacion
	End if 
	$0:=$r_Promedio
Else 
	Case of 
		: ($r_presentacion>=vrNTA_MinimoEscalaReferencia)
			$0:=$r_presentacion
		: ($r_ControlFinPeriodo>=vrNTA_MinimoEscalaReferencia)
			$0:=$r_ControlFinPeriodo
		Else 
			$0:=-10
	End case 
End if 

