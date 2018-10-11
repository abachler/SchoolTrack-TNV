//%attributes = {}
  // MPA_RecuperaEvalCicloAnterior()
  // Por: Alberto Bachler K.: 06-03-15, 08:03:52
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_BOOLEAN:C305($b_reportar)
C_DATE:C307($d_fechaAdquisicion;$d_fechaRegistro)
C_LONGINT:C283($l_periodosEvaluados;$l_recNumEvaluaciones;$l_idObjeto)
C_REAL:C285($r_minimoAdquisicion;$r_Numerico;$r_Real)
C_TEXT:C284($t_indicador;$t_literal;$t_observaciones)

ARRAY LONGINT:C221($al_RecNums;0)


Case of 
	: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
		$l_idObjeto:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
		$b_reportar:=(KRL_GetNumericFieldData (->[MPA_DefinicionCompetencias:187]ID:1;->$l_idObjeto;->[MPA_DefinicionCompetencias:187]PctParaAprobacion:22)>0)
		
	: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
		$l_idObjeto:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
		$b_reportar:=(KRL_GetNumericFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->$l_idObjeto;->[MPA_DefinicionDimensiones:188]PctParaAprobacion:14)>0)
		$b_reportar:=$b_reportar & ([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=0)
		
	: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje)
		$l_idObjeto:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
		$b_reportar:=(KRL_GetNumericFieldData (->[MPA_DefinicionEjes:185]ID:1;->$l_idObjeto;->[MPA_DefinicionEjes:185]PctParaAprobacion:16)>0)
		$b_reportar:=$b_reportar & ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=0)
End case 


If (($b_reportar) & ((Year of:C25([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89)<<>gYear) | ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89#!00-00-00!)))
	$l_recNumEvaluaciones:=Record number:C243([Alumnos_EvaluacionAprendizajes:203])
	
	$l_idAsignatura:=-[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1
	$l_idAlumno:=-[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
	$l_año:=[Alumnos_EvaluacionAprendizajes:203]Año:77-1
	$l_idEje:=-[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
	$l_idDimension:=-[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6
	$l_idCompetencia:=-[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7
	$t_nombreAsignatura:=[Asignaturas:18]Asignatura:3
	
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;=;$l_idAlumno;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Año:77;=;$l_año;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;=;$l_idEje;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;=;$l_idDimension;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;=;$l_idCompetencia;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89#!00-00-00!)
	Case of 
		: (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])=0)
			
		: (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>=1)
			LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];$al_RecNums;"")
			For ($i_registros;1;Size of array:C274($al_RecNums))
				KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$al_RecNums{$i_registros};False:C215)
				QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]ID_AsignaturaOriginal:30;=;Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1);*)
				QUERY:C277([Asignaturas_Historico:84]; & [Asignaturas_Historico:84]Año:5=[Alumnos_EvaluacionAprendizajes:203]Año:77;*)
				QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas_Historico:84]Asignatura:2;=;$t_nombreAsignatura)
				If (Records in selection:C76([Asignaturas_Historico:84])=1)
					$i_registros:=Size of array:C274($al_RecNums)+1
					REDUCE SELECTION:C351([Alumnos_EvaluacionAprendizajes:203];1)
				End if 
			End for 
	End case 
	
	
	$l_registros:=Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
	
	If ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89#!00-00-00!)
		$l_periodosEvaluados:=MPA_PeriodosEvaluados 
		Case of 
			: (([Alumnos_EvaluacionAprendizajes:203]Final_Real:59>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 0))
				$r_Real:=[Alumnos_EvaluacionAprendizajes:203]Final_Real:59
				$r_Numerico:=[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60
				$t_literal:=[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61
				$t_indicador:=[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62
				$t_observaciones:=[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84
				$d_fechaRegistro:=[Alumnos_EvaluacionAprendizajes:203]Final_fechaRegistro:100
				
			: (([Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 5))
				$r_Real:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
				$r_Numerico:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65
				$t_literal:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
				$t_indicador:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
				$t_observaciones:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83
				$d_fechaRegistro:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_fechaRegistro:99
				
			: (([Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 4))
				$r_Real:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
				$r_Numerico:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48
				$t_literal:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
				$t_indicador:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
				$t_observaciones:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82
				$d_fechaRegistro:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_fechaRegistro:98
				
			: (([Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 3))
				$r_Real:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
				$r_Numerico:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36
				$t_literal:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
				$t_indicador:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
				$t_observaciones:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81
				$d_fechaRegistro:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_fechaRegistro:97
				
			: (([Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 2))
				$r_Real:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
				$r_Numerico:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24
				$t_literal:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
				$t_indicador:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
				$t_observaciones:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80
				$d_fechaRegistro:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_fechaRegistro:96
				
			: (([Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 1))
				$r_Real:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
				$r_Numerico:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12
				$t_literal:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
				$t_indicador:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
				$t_observaciones:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79
				$d_fechaRegistro:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_fechaRegistro:95
				
		End case 
		$d_fechaAdquisicion:=[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89
	End if 
	
	KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$l_recNumEvaluaciones;True:C214)
	If ($d_fechaAdquisicion#!00-00-00!)
		PERIODOS_LoadData ([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91)
		Case of 
			: (Size of array:C274(atSTR_Periodos_Nombre)=5)
				[Alumnos_EvaluacionAprendizajes:203]Final_Real:59:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Final_fechaRegistro:100:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 0
				
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Periodo5_fechaRegistro:99:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 5
				
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_fechaRegistro:98:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 4
				
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_fechaRegistro:97:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 3
				
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_fechaRegistro:96:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 2
				
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_fechaRegistro:95:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 1
				
			: (Size of array:C274(atSTR_Periodos_Nombre)=4)
				[Alumnos_EvaluacionAprendizajes:203]Final_Real:59:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Final_fechaRegistro:100:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 0
				
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Periodo4_fechaRegistro:98:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 4
				
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_fechaRegistro:97:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 3
				
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_fechaRegistro:96:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 2
				
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_fechaRegistro:95:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 1
				
			: (Size of array:C274(atSTR_Periodos_Nombre)=3)
				[Alumnos_EvaluacionAprendizajes:203]Final_Real:59:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Final_fechaRegistro:100:=$d_fechaRegistro
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 0
				
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Periodo3_fechaRegistro:97:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 3
				
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_fechaRegistro:96:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 2
				
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_fechaRegistro:95:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 1
				
			: (Size of array:C274(atSTR_Periodos_Nombre)=2)
				[Alumnos_EvaluacionAprendizajes:203]Final_Real:59:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Final_fechaRegistro:100:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 0
				
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Periodo2_fechaRegistro:96:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 2
				
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_fechaRegistro:95:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 1
				
			: (Size of array:C274(atSTR_Periodos_Nombre)=1)
				[Alumnos_EvaluacionAprendizajes:203]Final_Real:59:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Final_fechaRegistro:100:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 0
				
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11:=$r_Real
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12:=$r_Numerico
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13:=$t_literal
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=$t_indicador
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79:=$t_observaciones
				[Alumnos_EvaluacionAprendizajes:203]Periodo1_fechaRegistro:95:=!00-00-00!
				[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101:=[Alumnos_EvaluacionAprendizajes:203]EsEvaluacionReportada_BitArray:101 ?+ 1
				
		End case 
		[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=$d_fechaAdquisicion
		SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
		
		For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
			MPA_Calculos (Record number:C243([Alumnos_EvaluacionAprendizajes:203]);$i)
			$key:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Año:77)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
			$b_promediosModificados:=MPA_Aprendizajes_a_Notas ([Asignaturas:18]EVAPR_IdMatriz:91;$key)
		End for 
	End if 
End if 


