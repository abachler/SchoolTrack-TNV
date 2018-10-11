//%attributes = {}
  // MÉTODO: MPA_PeriodosEvaluados
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 03/01/12, 12:02:28
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_RegistroHaSidoEvaluado()
  // ----------------------------------------------------
C_LONGINT:C283($0)

_O_C_INTEGER:C282($i_records)
C_LONGINT:C283($i;$l_FieldNumber_PrimeraEval;$l_FieldNumber_UltimaEval;$l_numeroTabla;$l_periodosEvaluados;$m)

If (False:C215)
	C_LONGINT:C283(MPA_PeriodosEvaluados ;$0)
End if 




  // CODIGO PRINCIPAL
$l_periodosEvaluados:=0
$l_numeroTabla:=Table:C252(->[Alumnos_EvaluacionAprendizajes:203])

If (([Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11>-10))
	$l_periodosEvaluados:=$l_periodosEvaluados ?+ 1
End if 
If (([Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23>-10))
	$l_periodosEvaluados:=$l_periodosEvaluados ?+ 2
End if 
If (([Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35>-10))
	$l_periodosEvaluados:=$l_periodosEvaluados ?+ 3
End if 
If (([Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47>-10))
	$l_periodosEvaluados:=$l_periodosEvaluados ?+ 4
End if 
If (([Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64>-10))
	$l_periodosEvaluados:=$l_periodosEvaluados ?+ 5
End if 

If ([Alumnos_EvaluacionAprendizajes:203]Final_Real:59>-10)
	$l_periodosEvaluados:=$l_periodosEvaluados ?+ 0
End if 

$0:=$l_periodosEvaluados

