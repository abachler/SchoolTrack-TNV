//%attributes = {}
  // MÉTODO: MPA_PromediosModificados
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 03/01/12, 12:15:28
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_PromediosModificados()
  // ----------------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_conModificaciones)
C_LONGINT:C283($l_Periodo)

If (False:C215)
	C_BOOLEAN:C305(MPA_PromediosModificados ;$0)
	C_LONGINT:C283(MPA_PromediosModificados ;$1)
End if 



  // CODIGO PRINCIPAL
$l_Periodo:=$1

Case of 
	: ($l_Periodo=0)
		$b_conModificaciones:=KRL_FieldChanges (->[Alumnos_EvaluacionAprendizajes:203]Final_Real:59;->[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61;->[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62;->[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60;->[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62)
		
	: ($l_Periodo=1)
		$b_conModificaciones:=KRL_FieldChanges (->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11;->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13;->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14;->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12;->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14)
		
	: ($l_Periodo=2)
		$b_conModificaciones:=KRL_FieldChanges (->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23;->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25;->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26;->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24;->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26)
		
	: ($l_Periodo=3)
		$b_conModificaciones:=KRL_FieldChanges (->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35;->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37;->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38;->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36;->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38)
		
	: ($l_Periodo=4)
		$b_conModificaciones:=KRL_FieldChanges (->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47;->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49;->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50;->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48;->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50)
		
	: ($l_Periodo=5)
		$b_conModificaciones:=KRL_FieldChanges (->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64;->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66;->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67;->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65;->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67)
		
End case 

$0:=$b_conModificaciones
