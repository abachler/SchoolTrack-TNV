//%attributes = {}
  // Método: EV2_CalculoALT_AgregaBonif
  //
  // 
  // por Alberto Bachler Klein
  // creación 12/07/17, 17:30:33
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––



C_REAL:C285($0)
C_REAL:C285($1)
C_REAL:C285($2)

C_REAL:C285($r_bonificacion;$r_Nota;$r_ponderacionBonificacion;$r_ponderacionPeriodo;$r_presentacion)


If (False:C215)
	C_REAL:C285(EV2_CalculoALT_AgregaBonif ;$0)
	C_REAL:C285(EV2_CalculoALT_AgregaBonif ;$1)
	C_REAL:C285(EV2_CalculoALT_AgregaBonif ;$2)
End if 

$r_presentacion:=$1
$r_bonificacion:=$2

$l_modo:=iEvaluationMode
If (Count parameters:C259=3)
	$l_modo:=$3
End if 


$0:=$r_presentacion

  // calculo de la bonificación de fin de período
If ((vi_UsarBonificacion=1) & ($r_bonificacion>0) & (vr_BonificacionPeriodo>=0) & ($r_presentacion>vrNTA_MinimoEscalaReferencia))
	$r_ponderacionBonificacion:=vr_BonificacionPeriodo/100
	$r_ponderacionPeriodo:=(100-vr_BonificacionPeriodo)/100
	$r_presentacion:=Round:C94($r_presentacion*$r_ponderacionPeriodo;11)
	$r_bonificacion:=Round:C94($r_bonificacion*$r_ponderacionBonificacion;11)
	
	
	If (vi_RoundCPpresent=1)  //si la evaluación de presentación a examen deben ser truncada, es reconvertida con troncatura al estilo de evaluaci—n principal y a partir de ese valor se obtiene el real correspondiente
		Case of 
			: (iEvaluationMode=Notas)
				$r_presentacion:=Trunc:C95($r_presentacion;iGradesDecPP)
				$r_bonificacion:=Trunc:C95($r_bonificacion;iGradesDecPP)
				
			: (iEvaluationMode=Puntos)
				$r_presentacion:=Trunc:C95($r_presentacion;iPointsDecPP)
				$r_bonificacion:=Trunc:C95($r_bonificacion;iPointsDecPP)
				
			: (iEvaluationMode=Porcentaje)
				$r_presentacion:=Round:C94($r_presentacion;1)
				$r_bonificacion:=Round:C94($r_bonificacion;1)
				
			: (iEvaluationMode=Simbolos)
				$r_presentacion:=Round:C94($r_presentacion;1)
				$r_bonificacion:=Round:C94($r_bonificacion;1)
				
		End case 
	End if 
	$0:=$r_presentacion+$r_bonificacion
End if 