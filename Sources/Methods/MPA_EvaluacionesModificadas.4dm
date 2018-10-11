//%attributes = {}
  // MÉTODO: MPA_EvaluacionesModificadas
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 03/01/12, 12:25:44
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_EvaluacionesModificadas()
  // ----------------------------------------------------
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_calificacionesModificadas)
_O_C_INTEGER:C282($i_records)
C_LONGINT:C283($i;$l_FieldNumber_PrimeraEval;$l_FieldNumber_UltimaEval;$l_numeroTabla)
C_POINTER:C301($y_fieldPointer)

If (False:C215)
	C_BOOLEAN:C305(MPA_EvaluacionesModificadas ;$0)
End if 

ARRAY POINTER:C280($ay_Campos;0)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Final_Real:59)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84)
APPEND TO ARRAY:C911($ay_Campos;->[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62)

For ($i;1;Size of array:C274($ay_Campos))
	If ($ay_Campos{$i}->#Old:C35($ay_Campos{$i}->))
		$b_calificacionesModificadas:=True:C214
		$i:=Size of array:C274($ay_Campos)+1
	End if 
End for 


$0:=$b_calificacionesModificadas
