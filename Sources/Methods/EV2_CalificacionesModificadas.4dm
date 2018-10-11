//%attributes = {}
  // MÉTODO: EV2_CalificacionesModificadas
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 30/12/11, 17:14:22
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // EV2_CalificacionesModificadas()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL
C_BOOLEAN:C305($0;$b_calificacionesModificadas)
_O_C_INTEGER:C282($i_records)
C_LONGINT:C283($i;$l_FieldNumber_PrimeraEval;$l_FieldNumber_UltimaEval;$l_numeroTabla;$l_periodosEvaluados;$m)

$b_calificacionesModificadas:=False:C215
$l_numeroTabla:=Table:C252(->[Alumnos_Calificaciones:208])
$l_FieldNumber_PrimeraEval:=Field:C253(->[Alumnos_Calificaciones:208]Anual_Real:11)
$l_FieldNumber_UltimaEval:=Field:C253(->[Alumnos_Calificaciones:208]P05_Final_Literal:416)
For ($i;$l_FieldNumber_PrimeraEval;$l_FieldNumber_UltimaEval;1)
	$y_fieldPointer:=Field:C253($l_numeroTabla;$i)
	If ($y_fieldPointer->#Old:C35($y_fieldPointer->))
		$b_calificacionesModificadas:=True:C214
		$i:=$l_FieldNumber_UltimaEval+1
	End if 
End for 


$l_FieldNumber_PrimeraEval:=Field:C253(->[Alumnos_Calificaciones:208]P01_Final_RealNoAproximado:496)
$l_FieldNumber_UltimaEval:=Field:C253(->[Alumnos_Calificaciones:208]EvaluacionFinal_RealNoAprox:502)
For ($i;$l_FieldNumber_PrimeraEval;$l_FieldNumber_UltimaEval;1)
	$y_fieldPointer:=Field:C253($l_numeroTabla;$i)
	If ($y_fieldPointer->#Old:C35($y_fieldPointer->))
		$b_calificacionesModificadas:=True:C214
		$i:=$l_FieldNumber_UltimaEval+1
	End if 
End for 

If ([Alumnos_Calificaciones:208]Reprobada:9#Old:C35([Alumnos_Calificaciones:208]Reprobada:9))
	$b_calificacionesModificadas:=True:C214
End if 

If ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26#Old:C35([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26))
	$b_calificacionesModificadas:=True:C214
End if 


  //MONO: Revisar cambios en Bonificaciones ticket 172760
$l_FieldNumber_PrimeraEval:=Field:C253(->[Alumnos_Calificaciones:208]P01_Bonificacion_Real:510)
$l_FieldNumber_UltimaEval:=Field:C253(->[Alumnos_Calificaciones:208]P05_Bonificacion_Literal:534)
For ($i;$l_FieldNumber_PrimeraEval;$l_FieldNumber_UltimaEval;1)
	$y_fieldPointer:=Field:C253($l_numeroTabla;$i)
	If ($y_fieldPointer->#Old:C35($y_fieldPointer->))
		$b_calificacionesModificadas:=True:C214
		$i:=$l_FieldNumber_UltimaEval+1
	End if 
End for 

$b_calificacionesModificadas:=$b_calificacionesModificadas\
 | ([Alumnos_Calificaciones:208]PTC_Real:535#Old:C35([Alumnos_Calificaciones:208]PTC_Real:535))\
 | ([Alumnos_Calificaciones:208]PTC_Nota:536#Old:C35([Alumnos_Calificaciones:208]PTC_Nota:536))\
 | ([Alumnos_Calificaciones:208]PTC_Puntos:537#Old:C35([Alumnos_Calificaciones:208]PTC_Puntos:537))\
 | ([Alumnos_Calificaciones:208]PTC_Simbolos:538#Old:C35([Alumnos_Calificaciones:208]PTC_Simbolos:538))\
 | ([Alumnos_Calificaciones:208]PTC_Literal:539#Old:C35([Alumnos_Calificaciones:208]PTC_Literal:539))

$0:=$b_calificacionesModificadas | ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492#Old:C35([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492))

