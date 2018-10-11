//%attributes = {}
  // MPA_EliminaReporteAprobacion()
  // Por: Alberto Bachler K.: 05-03-15, 18:27:30
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
$l_borrarDesdePeriodo:=$1

$r_Real:=-10
$r_Numerico:=$r_real
$t_literal:=""
$t_indicador:=""
$t_observaciones:=""
$d_fechaRegistro:=!00-00-00!


If (($l_borrarDesdePeriodo<=1) & ([Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?? 1))
	[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11:=$r_Real
	[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12:=$r_Numerico
	[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13:=$t_literal
	[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=$t_indicador
	[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79:=$t_observaciones
	[Alumnos_EvaluacionAprendizajes:203]Periodo1_fechaRegistro:95:=$d_fechaRegistro
	[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- 1
End if 

If (($l_borrarDesdePeriodo<=2) & ([Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?? 2))
	[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23:=$r_Real
	[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24:=$r_Numerico
	[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25:=$t_literal
	[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=$t_indicador
	[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80:=$t_observaciones
	[Alumnos_EvaluacionAprendizajes:203]Periodo2_fechaRegistro:96:=$d_fechaRegistro
	[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- 2
End if 

If (($l_borrarDesdePeriodo<=3) & ([Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?? 3))
	[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35:=$r_Real
	[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36:=$r_Numerico
	[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37:=$t_literal
	[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=$t_indicador
	[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81:=$t_observaciones
	[Alumnos_EvaluacionAprendizajes:203]Periodo3_fechaRegistro:97:=$d_fechaRegistro
	[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- 3
End if 

If (($l_borrarDesdePeriodo<=4) & ([Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?? 4))
	[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47:=$r_Real
	[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48:=$r_Numerico
	[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49:=$t_literal
	[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=$t_indicador
	[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82:=$t_observaciones
	[Alumnos_EvaluacionAprendizajes:203]Periodo4_fechaRegistro:98:=$d_fechaRegistro
	[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- 4
End if 

If (($l_borrarDesdePeriodo<=5) & ([Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?? 5))
	[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64:=$r_Real
	[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65:=$r_Numerico
	[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66:=$t_literal
	[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=$t_indicador
	[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83:=$t_observaciones
	[Alumnos_EvaluacionAprendizajes:203]Periodo5_fechaRegistro:99:=$d_fechaRegistro
	[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- 5
End if 

If (($l_borrarDesdePeriodo>=1) & ([Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?? 0))
	[Alumnos_EvaluacionAprendizajes:203]Final_Real:59:=$r_Real
	[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60:=$r_Numerico
	[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61:=$t_literal
	[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62:=$t_indicador
	[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84:=$t_observaciones
	[Alumnos_EvaluacionAprendizajes:203]Final_fechaRegistro:100:=$d_fechaRegistro
	[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?- 0
End if 

[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=!00-00-00!

SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])

