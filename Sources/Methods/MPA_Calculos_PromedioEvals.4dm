//%attributes = {}
  // MÉTODO: MPA_Calculos_PromedioEvals
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 25/11/11, 13:39:43
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_Calculos_Promedio()
  // ----------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_REAL:C285($3)

C_LONGINT:C283($iEvaluaciones;$l_div;$l_numeroEvaluaciones)
C_POINTER:C301($y_arEvaluaciones;$y_arEvaluacioneses;$y_arPonderacion)
C_REAL:C285($r_minimoEscala;$r_resultado;$r_sum;$r_sum_Ponderaciones;$r_sum_Ponderados)
If (False:C215)
	C_POINTER:C301(MPA_Calculos_PromedioEvals ;$1)
	C_POINTER:C301(MPA_Calculos_PromedioEvals ;$2)
	C_REAL:C285(MPA_Calculos_PromedioEvals ;$3)
End if 




  // CODIGO PRINCIPAL
$y_arEvaluaciones:=$1
$y_arPonderacion:=$2
$r_minimoEscala:=$3

$r_resultado:=-10
$l_numeroEvaluaciones:=0
$r_sum:=0
$l_div:=0

If (AT_GetSumArray ($y_arPonderacion)>0)
	$r_sum_Ponderaciones:=0
	$r_sum_Ponderados:=0
	For ($iEvaluaciones;1;Size of array:C274($y_arEvaluaciones->))
		
		Case of 
			: (($y_arPonderacion->{$iEvaluaciones}>0) & ($y_arEvaluaciones->{$iEvaluaciones}>=$r_minimoEscala))
				$r_sum_Ponderados:=$r_sum_Ponderados+Round:C94($y_arEvaluaciones->{$iEvaluaciones}*$y_arPonderacion->{$iEvaluaciones}/100;11)
				$r_sum_Ponderaciones:=$r_sum_Ponderaciones+$y_arPonderacion->{$iEvaluaciones}
				$l_numeroEvaluaciones:=$l_numeroEvaluaciones+1
				
			: ($y_arEvaluaciones->{$iEvaluaciones}=-2)
				$r_sum_Ponderados:=0
				$r_resultado:=-2
				$l_numeroEvaluaciones:=0
				$iEvaluaciones:=Size of array:C274($y_arEvaluaciones->)
		End case 
	End for 
	
	If ($r_sum_Ponderados>0)
		$r_resultado:=Round:C94($r_sum_Ponderados/$r_sum_Ponderaciones;11)*100
	End if 
	
Else 
	
	For ($iEvaluaciones;1;Size of array:C274($y_arEvaluaciones->))
		Case of 
			: ($y_arEvaluaciones->{$iEvaluaciones}>=$r_minimoEscala)
				$r_sum:=$r_sum+$y_arEvaluaciones->{$iEvaluaciones}
				$l_numeroEvaluaciones:=$l_numeroEvaluaciones+1
				
			: ($y_arEvaluaciones->{$iEvaluaciones}=-2)
				$r_resultado:=-2
				$l_numeroEvaluaciones:=0
				$iEvaluaciones:=Size of array:C274($y_arEvaluaciones->)
				
		End case 
		
	End for 
	If ($l_numeroEvaluaciones>0)
		$r_resultado:=Round:C94($r_sum/$l_numeroEvaluaciones;11)
		
		If ($r_resultado<$r_minimoEscala)
			$r_resultado:=$r_minimoEscala
		End if 
	End if 
End if 

$0:=$r_Resultado