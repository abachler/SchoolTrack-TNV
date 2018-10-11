//%attributes = {}
  // EV2_PonderaEvaluacion()
  // 
  //
  // creado por: Alberto Bachler Klein: 21-11-16, 08:42:32
  // -----------------------------------------------------------

C_REAL:C285($1)
C_REAL:C285($2)

C_LONGINT:C283($l_decimales)
C_REAL:C285($r_evaluacion;$r_minimo;$r_ponderacion;$tempNum)
C_BOOLEAN:C305($b_forzarMinimo)



If (False:C215)
	C_REAL:C285(EV2_PonderaEvaluacion ;$0)
	C_REAL:C285(EV2_PonderaEvaluacion ;$1)
	C_REAL:C285(EV2_PonderaEvaluacion ;$2)
End if 

$r_evaluacion:=$1
$r_ponderacion:=$2


If (($r_evaluacion>=vrNTA_MinimoEscalaReferencia) & ($r_ponderacion>0))
	$b_forzarMinimo:=False:C215
	$r_minimo:=Round:C94(vrNTA_MinimoEscalaReferencia/100;11)
	$r_evaluacion:=Round:C94($r_evaluacion*$r_ponderacion/100;11)
	
	Case of 
		: (iEvaluationMode=Notas)
			$l_decimales:=iGradesDec+vi_decimalesPonderacion
			If ($l_decimales>11)
				$l_decimales:=11
			End if 
			If (vi_PonderacionTruncada=1)
				$r_evaluacion:=Trunc:C95($r_evaluacion;$l_decimales)
			Else 
				$r_evaluacion:=EV2_Real_a_Nota ($r_evaluacion;0;$l_decimales;$b_forzarMinimo;$r_minimo)
				If ($r_evaluacion>=Round:C94($r_minimo*rGradesTo/100;11))
					$r_evaluacion:=EV2_Nota_a_Real ($r_evaluacion)
				End if 
			End if 
			
			
		: (iEvaluationMode=Puntos)
			$l_decimales:=iPointsDec+vi_decimalesPonderacion
			If ($l_decimales>11)
				$l_decimales:=11
			End if 
			If (vi_PonderacionTruncada=1)
				$r_evaluacion:=Trunc:C95($r_evaluacion;$l_decimales)
			Else 
				$r_evaluacion:=EV2_Real_a_Puntos ($r_evaluacion;0;$l_decimales;$b_forzarMinimo;$r_minimo)
				If ($r_evaluacion>=Round:C94($r_minimo*rPointsTo/100;11))
					$r_evaluacion:=EV2_Puntos_a_Real ($r_evaluacion)
				End if 
			End if 
			
		: (iEvaluationMode=Porcentaje)
			$l_decimales:=1+vi_decimalesPonderacion
			If ($l_decimales>11)
				$l_decimales:=11
			End if 
			If (vi_PonderacionTruncada=1)
				$r_evaluacion:=Trunc:C95($r_evaluacion;$l_decimales)
			Else 
				$r_evaluacion:=Round:C94($r_evaluacion;$l_decimales)
			End if 
		: (iEvaluationMode=Simbolos)
			
	End case 
	$0:=$r_evaluacion
	
Else 
	$0:=-10
	
End if 