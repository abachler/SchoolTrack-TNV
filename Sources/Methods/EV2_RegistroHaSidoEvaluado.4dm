//%attributes = {}
  // MÉTODO: EV2_RegistroHaSidoEvaluado
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 30/12/11, 17:14:12
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // EV2_RegistroHaSidoEvaluado()
  // ----------------------------------------------------
C_LONGINT:C283($i_records;$l_FieldNumber_PrimeraEval;$l_FieldNumber_UltimaEval;$l_numeroTabla;$l_periodosEvaluados)


  // CODIGO PRINCIPAL

$l_periodosEvaluados:=0
$l_numeroTabla:=Table:C252(->[Alumnos_Calificaciones:208])

$l_FieldNumber_PrimeraEval:=Field:C253(->[Alumnos_Calificaciones:208]P01_Eval01_Real:42)
$l_FieldNumber_UltimaEval:=$l_FieldNumber_PrimeraEval+(15*5)-1

For ($i_records;$l_FieldNumber_PrimeraEval;$l_FieldNumber_UltimaEval;5)
	If (Field:C253($l_numeroTabla;$i_records)->>-10)
		$l_periodosEvaluados:=$l_periodosEvaluados ?+ 1
		$i_records:=$l_FieldNumber_UltimaEval+1
	End if 
End for 

$l_FieldNumber_PrimeraEval:=Field:C253(->[Alumnos_Calificaciones:208]P02_Eval01_Real:117)
$l_FieldNumber_UltimaEval:=$l_FieldNumber_PrimeraEval+(15*5)-1

For ($i_records;$l_FieldNumber_PrimeraEval;$l_FieldNumber_UltimaEval;5)
	If (Field:C253($l_numeroTabla;$i_records)->>-10)
		$l_periodosEvaluados:=$l_periodosEvaluados ?+ 2
		$i_records:=$l_FieldNumber_UltimaEval+1
	End if 
End for 

$l_FieldNumber_PrimeraEval:=Field:C253(->[Alumnos_Calificaciones:208]P03_Eval01_Real:192)
$l_FieldNumber_UltimaEval:=$l_FieldNumber_PrimeraEval+(15*5)-1

For ($i_records;$l_FieldNumber_PrimeraEval;$l_FieldNumber_UltimaEval;5)
	If (Field:C253($l_numeroTabla;$i_records)->>-10)
		$l_periodosEvaluados:=$l_periodosEvaluados ?+ 3
		$i_records:=$l_FieldNumber_UltimaEval+1
	End if 
End for 

$l_FieldNumber_PrimeraEval:=Field:C253(->[Alumnos_Calificaciones:208]P04_Eval01_Real:267)
$l_FieldNumber_UltimaEval:=$l_FieldNumber_PrimeraEval+(15*5)-1

For ($i_records;$l_FieldNumber_PrimeraEval;$l_FieldNumber_UltimaEval;5)
	If (Field:C253($l_numeroTabla;$i_records)->>-10)
		$l_periodosEvaluados:=$l_periodosEvaluados ?+ 4
		$i_records:=$l_FieldNumber_UltimaEval+1
	End if 
End for 

$l_FieldNumber_PrimeraEval:=Field:C253(->[Alumnos_Calificaciones:208]P05_Eval01_Real:342)
$l_FieldNumber_UltimaEval:=$l_FieldNumber_PrimeraEval+(15*5)-1
For ($i_records;$l_FieldNumber_PrimeraEval;$l_FieldNumber_UltimaEval;5)
	If (Field:C253($l_numeroTabla;$i_records)->>-10)
		$l_periodosEvaluados:=$l_periodosEvaluados ?+ 5
		$i_records:=$l_FieldNumber_UltimaEval+1
	End if 
End for 

If (([Alumnos_Calificaciones:208]Anual_Real:11>-10) | ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26>-10))
	$l_periodosEvaluados:=$l_periodosEvaluados ?+ 0
End if 

$0:=$l_periodosEvaluados

