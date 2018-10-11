//%attributes = {}
  // MPA_CompetenciaAdquirida()
  // Por: Alberto Bachler K.: 06-03-15, 18:35:02
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_competenciaLograda)
C_LONGINT:C283($l_periodo)
C_REAL:C285($r_evaluacion;$r_minimoAprobatorio;$r_Numerico;$r_Real)
C_TEXT:C284($t_indicador;$t_literal;$t_observaciones)

$r_evaluacion:=$1
$l_periodo:=$2
  //MONO - 212957 En algunas instancias no llegamos aquí con el registro de la Definición cargado para obtener el dato de PctParaAprobacion.
Case of 
	: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
		$r_minimoAprobatorio:=KRL_GetNumericFieldData (->[MPA_DefinicionCompetencias:187]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;->[MPA_DefinicionCompetencias:187]PctParaAprobacion:22)
		
	: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
		$r_minimoAprobatorio:=KRL_GetNumericFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;->[MPA_DefinicionDimensiones:188]PctParaAprobacion:14)
		
	: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje)
		$r_minimoAprobatorio:=KRL_GetNumericFieldData (->[MPA_DefinicionEjes:185]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[MPA_DefinicionEjes:185]PctParaAprobacion:16)
		
End case 

If ($r_minimoAprobatorio>0)
	If ($r_evaluacion>=$r_minimoAprobatorio)
		If ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89=!00-00-00!)
			[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=Current date:C33(*)
			
			  //If ([MPA_DefinicionCompetencias]ReportarAdquirida)
			Case of 
				: ($l_periodo=-1)
					  // no hacemos nada, es la calificación final que es aprobada.
					
				: ($l_periodo>=1)  // 20181008 ASM Ticket 217933
					$r_Real:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
					$r_Numerico:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12
					$t_literal:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
					$t_indicador:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
					$t_observaciones:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79
					$t_nivelLogroEnunciado:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_NivelLogroEnunciado:16
					$l_nivelLogroID:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_NivelLogroID:15
					
				: ($l_periodo=2)
					$r_Real:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
					$r_Numerico:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24
					$t_literal:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
					$t_indicador:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
					$t_observaciones:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80
					$t_nivelLogroEnunciado:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_NivelLogroEnunciado:28
					$l_nivelLogroID:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_NivelLogroID:27
					
				: ($l_periodo=3)
					$r_Real:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
					$r_Numerico:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36
					$t_literal:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
					$t_indicador:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
					$t_observaciones:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81
					$t_nivelLogroEnunciado:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_NivelLogroEnunciado:40
					$l_nivelLogroID:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_NivelLogroID:39
					
				: ($l_periodo=4)
					$r_Real:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
					$r_Numerico:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48
					$t_literal:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
					$t_indicador:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
					$t_observaciones:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82
					$t_nivelLogroEnunciado:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_NivelLogroEnunciado:52
					$l_nivelLogroID:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_NivelLogroID:51
					
				: ($l_periodo=5)
					$r_Real:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
					$r_Numerico:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65
					$t_literal:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
					$t_indicador:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
					$t_observaciones:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83
					$t_nivelLogroEnunciado:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_NivelLogroEnunciado:69
					$l_nivelLogroID:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_NivelLogroID:68
			End case 
			
			Case of 
				: ($l_periodo=-1)
					  // no hacemos nada, es la calificación final que es aprobada.
				: ($l_periodo=1)
					If ((([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 2) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0)) & (viSTR_Periodos_NumeroPeriodos>=2) & ($l_periodo=1))
						[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23:=$r_Real
						[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24:=$r_Numerico
						[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25:=$t_literal
						[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=$t_indicador
						[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80:=$t_observaciones
						[Alumnos_EvaluacionAprendizajes:203]Periodo2_fechaRegistro:96:=!00-00-00!
						[Alumnos_EvaluacionAprendizajes:203]Periodo2_NivelLogroEnunciado:28:=$t_nivelLogroEnunciado
						[Alumnos_EvaluacionAprendizajes:203]Periodo2_NivelLogroID:27:=$l_nivelLogroID
						[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 2
					End if 
					
					If ((([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 3) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0)) & (viSTR_Periodos_NumeroPeriodos>=3) & ($l_periodo<=2))
						[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35:=$r_Real
						[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36:=$r_Numerico
						[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37:=$t_literal
						[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=$t_indicador
						[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81:=$t_observaciones
						[Alumnos_EvaluacionAprendizajes:203]Periodo3_fechaRegistro:97:=!00-00-00!
						[Alumnos_EvaluacionAprendizajes:203]Periodo3_NivelLogroEnunciado:40:=$t_nivelLogroEnunciado
						[Alumnos_EvaluacionAprendizajes:203]Periodo3_NivelLogroID:39:=$l_nivelLogroID
						[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 3
					End if 
					
					If ((([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 4) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0)) & (viSTR_Periodos_NumeroPeriodos>=4) & ($l_periodo<=3))
						[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47:=$r_Real
						[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48:=$r_Numerico
						[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49:=$t_literal
						[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=$t_indicador
						[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82:=$t_observaciones
						[Alumnos_EvaluacionAprendizajes:203]Periodo4_fechaRegistro:98:=!00-00-00!
						[Alumnos_EvaluacionAprendizajes:203]Periodo4_NivelLogroEnunciado:52:=$t_nivelLogroEnunciado
						[Alumnos_EvaluacionAprendizajes:203]Periodo4_NivelLogroID:51:=$l_nivelLogroID
						[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 4
					End if 
					
					If ((([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 5) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0)) & (viSTR_Periodos_NumeroPeriodos>=5) & ($l_periodo<=4))
						[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64:=$r_Real
						[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65:=$r_Numerico
						[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66:=$t_literal
						[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=$t_indicador
						[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83:=$t_observaciones
						[Alumnos_EvaluacionAprendizajes:203]Periodo5_fechaRegistro:99:=!00-00-00!
						[Alumnos_EvaluacionAprendizajes:203]Periodo5_NivelLogroEnunciado:69:=$t_nivelLogroEnunciado
						[Alumnos_EvaluacionAprendizajes:203]Periodo5_NivelLogroID:68:=$l_nivelLogroID
						[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 5
					End if 
					
					[Alumnos_EvaluacionAprendizajes:203]Final_Real:59:=$r_Real
					[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60:=$r_Numerico
					[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61:=$t_literal
					[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62:=$t_indicador
					[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84:=$t_observaciones
					[Alumnos_EvaluacionAprendizajes:203]Final_fechaRegistro:100:=!00-00-00!
					[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 0
			End case 
		End if 
	End if 
Else 
	$b_competenciaLograda:=([Alumnos_EvaluacionAprendizajes:203]Final_Real:59>=$r_minimoAprobatorio)
	$b_competenciaLograda:=$b_competenciaLograda | ([Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64>=$r_minimoAprobatorio)
	$b_competenciaLograda:=$b_competenciaLograda | ([Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47>=$r_minimoAprobatorio)
	$b_competenciaLograda:=$b_competenciaLograda | ([Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35>=$r_minimoAprobatorio)
	$b_competenciaLograda:=$b_competenciaLograda | ([Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23>=$r_minimoAprobatorio)
	$b_competenciaLograda:=$b_competenciaLograda | ([Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11>=$r_minimoAprobatorio)
	If (Not:C34($b_competenciaLograda))
		[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=!00-00-00!
	End if 
	  //End if 
End if 