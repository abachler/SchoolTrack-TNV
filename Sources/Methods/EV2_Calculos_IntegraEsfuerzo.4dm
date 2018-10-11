//%attributes = {}
  // EV2_Calculos_integraEsfuerzo()
  //
  //
  // creado por: Alberto Bachler Klein: 21-11-16, 17:06:57
  // -----------------------------------------------------------
C_REAL:C285($0)
C_REAL:C285($1)
C_TEXT:C284($2)

C_LONGINT:C283($l_ItemEsfuerzo)
C_REAL:C285($r_BonificacionEsfuerzo;$r_factorEsfuerzo;$r_finalPeriodo;$r_promedio)
C_TEXT:C284($t_esfuerzo)


If (False:C215)
	C_REAL:C285(EV2_Calculos_IntegraEsfuerzo ;$0)
	C_REAL:C285(EV2_Calculos_IntegraEsfuerzo ;$1)
	C_TEXT:C284(EV2_Calculos_IntegraEsfuerzo ;$2)
End if 

$r_promedio:=$1
$t_esfuerzo:=$2


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
			: (iEvaluationMode=Notas)
				If (($r_BonificacionEsfuerzo#0) & ($r_BonificacionEsfuerzo<=100))
					$r_promedio:=$r_promedio+Round:C94($r_BonificacionEsfuerzo/rGradesTo*100;11)
				End if 
				
			: (iEvaluationMode=Puntos)
				If (($r_BonificacionEsfuerzo#0) & ($r_BonificacionEsfuerzo<=rPointsTo))
					$r_promedio:=$r_promedio+Round:C94($r_BonificacionEsfuerzo/rPointsTo*100;11)
				End if 
				
			: (iEvaluationMode=Porcentaje)
				If (($r_BonificacionEsfuerzo#0) & ($r_BonificacionEsfuerzo<=100))
					$r_promedio:=$r_promedio+$r_BonificacionEsfuerzo
				End if 
		End case 
		
		If ($r_promedio>100)
			$r_promedio:=100
		End if 
		
End case 

$0:=$r_promedio