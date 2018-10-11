//%attributes = {}
  // Método: EV2_CalculoALT_IntegraEsfuerzo
  //
  //
  // por Alberto Bachler Klein
  // creación 13/07/17, 19:38:25
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_REAL:C285($0)
C_REAL:C285($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_LONGINT:C283($l_ItemEsfuerzo;$l_modo)
C_REAL:C285($r_BonificacionEsfuerzo;$r_factorEsfuerzo;$r_finalPeriodo;$r_promedio)
C_TEXT:C284($t_esfuerzo)


If (False:C215)
	C_REAL:C285(EV2_CalculoALT_IntegraEsfuerzo ;$0)
	C_REAL:C285(EV2_CalculoALT_IntegraEsfuerzo ;$1)
	C_TEXT:C284(EV2_CalculoALT_IntegraEsfuerzo ;$2)
	C_LONGINT:C283(EV2_CalculoALT_IntegraEsfuerzo ;$3)
End if 

$r_promedio:=$1
$t_esfuerzo:=$2


$l_modo:=iEvaluationMode
If (Count parameters:C259=3)
	$l_modo:=$3
End if 

Case of 
	: (([Asignaturas:18]Ingresa_Esfuerzo:40) & ($r_promedio>=vrNTA_MinimoEscalaReferencia) & (r1_EvEsfuerzoIndicadores=1) & ([Asignaturas:18]Pondera_Esfuerzo:61))
		$l_ItemEsfuerzo:=Find in array:C230(aIndEsfuerzo;$t_esfuerzo)
		If ($l_ItemEsfuerzo>0)
			$r_factorEsfuerzo:=aFactorEsfuerzo{$l_ItemEsfuerzo}/100
			$r_finalPeriodo:=$r_promedio*($r_factorEsfuerzo+1)
			If ($r_finalPeriodo>100)
				$r_promedio:=100
			Else 
				$r_promedio:=$r_finalPeriodo
			End if 
		End if 
		
	: (([Asignaturas:18]Ingresa_Esfuerzo:40) & (r2_EvEsfuerzoBonificacion=1) & ($r_promedio>=vrNTA_MinimoEscalaReferencia))
		$r_BonificacionEsfuerzo:=Num:C11($t_esfuerzo)
		Case of 
			: ($l_modo=Notas)
				If (($r_BonificacionEsfuerzo#0) & ($r_BonificacionEsfuerzo<=100))
					$r_promedio:=$r_promedio+Round:C94($r_BonificacionEsfuerzo/rGradesTo*100;11)
				End if 
				
			: ($l_modo=Puntos)
				If (($r_BonificacionEsfuerzo#0) & ($r_BonificacionEsfuerzo<=rPointsTo))
					$r_promedio:=$r_promedio+Round:C94($r_BonificacionEsfuerzo/rPointsTo*100;11)
				End if 
				
			: ($l_modo=Porcentaje)
				If (($r_BonificacionEsfuerzo#0) & ($r_BonificacionEsfuerzo<=100))
					$r_promedio:=$r_promedio+$r_BonificacionEsfuerzo
				End if 
		End case 
		
		If ($r_promedio>100)
			$r_promedio:=100
		End if 
		
End case 

$0:=$r_promedio

