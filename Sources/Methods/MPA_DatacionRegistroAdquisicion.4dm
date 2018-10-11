//%attributes = {}
  // MPA_DatacionRegistroAdquisicion()
  // Por: Alberto Bachler K.: 04-03-15, 09:37:22
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_REAL:C285($r_minimoAdquisicion)

  // datación del registro de evaluaciones
If ([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13="")
	[Alumnos_EvaluacionAprendizajes:203]Periodo1_fechaRegistro:95:=!00-00-00!
End if 
If ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25="")
	[Alumnos_EvaluacionAprendizajes:203]Periodo2_fechaRegistro:96:=!00-00-00!
End if 
If ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37="")
	[Alumnos_EvaluacionAprendizajes:203]Periodo3_fechaRegistro:97:=!00-00-00!
End if 
If ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49="")
	[Alumnos_EvaluacionAprendizajes:203]Periodo4_fechaRegistro:98:=!00-00-00!
End if 
If ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49="")
	[Alumnos_EvaluacionAprendizajes:203]Periodo5_fechaRegistro:99:=!00-00-00!
End if 
If ([Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61="")
	[Alumnos_EvaluacionAprendizajes:203]Final_fechaRegistro:100:=!00-00-00!
End if 

PERIODOS_LoadData ([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91)

If ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89>=vdSTR_Periodos_InicioEjercicio)
	If ([Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11#Old:C35([Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11))
		[Alumnos_EvaluacionAprendizajes:203]Periodo1_fechaRegistro:95:=Current date:C33
	End if 
	
	If ([Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23#Old:C35([Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23))
		[Alumnos_EvaluacionAprendizajes:203]Periodo2_fechaRegistro:96:=Current date:C33
	End if 
	
	If ([Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35#Old:C35([Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35))
		[Alumnos_EvaluacionAprendizajes:203]Periodo3_fechaRegistro:97:=Current date:C33
	End if 
	
	If ([Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47#Old:C35([Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47))
		[Alumnos_EvaluacionAprendizajes:203]Periodo4_fechaRegistro:98:=Current date:C33
	End if 
	
	If ([Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64#Old:C35([Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64))
		[Alumnos_EvaluacionAprendizajes:203]Periodo5_fechaRegistro:99:=Current date:C33
	End if 
	
	If ([Alumnos_EvaluacionAprendizajes:203]Final_Real:59#Old:C35([Alumnos_EvaluacionAprendizajes:203]Final_Real:59))
		[Alumnos_EvaluacionAprendizajes:203]Final_fechaRegistro:100:=Current date:C33
	End if 
End if 


Case of 
	: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
		READ ONLY:C145([MPA_DefinicionCompetencias:187])
		RELATE ONE:C42([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
		$r_minimoAdquisicion:=[MPA_DefinicionCompetencias:187]PctParaAprobacion:22
		
	: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
		READ ONLY:C145([MPA_DefinicionDimensiones:188])
		RELATE ONE:C42([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
		$r_minimoAdquisicion:=[MPA_DefinicionDimensiones:188]PctParaAprobacion:14
		
	: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje)
		READ ONLY:C145([MPA_DefinicionEjes:185])
		RELATE ONE:C42([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
		$r_minimoAdquisicion:=[MPA_DefinicionEjes:185]PctParaAprobacion:16
		
End case 


  //If ([Alumnos_EvaluacionAprendizajes]Año=<>gYear)
  //$l_periodosEvaluados:=MPA_PeriodosEvaluados 
  //Case of 
  //: (([Alumnos_EvaluacionAprendizajes]Final_Real>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 0))
  //[Alumnos_EvaluacionAprendizajes]FechaAprobacion:=[Alumnos_EvaluacionAprendizajes]Final_fechaRegistro
  //: (([Alumnos_EvaluacionAprendizajes]Periodo5_Real>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 5))
  //[Alumnos_EvaluacionAprendizajes]FechaAprobacion:=[Alumnos_EvaluacionAprendizajes]Periodo5_fechaRegistro
  //: (([Alumnos_EvaluacionAprendizajes]Periodo4_Real>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 4))
  //[Alumnos_EvaluacionAprendizajes]FechaAprobacion:=[Alumnos_EvaluacionAprendizajes]Periodo4_fechaRegistro
  //: (([Alumnos_EvaluacionAprendizajes]Periodo3_Real>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 3))
  //[Alumnos_EvaluacionAprendizajes]FechaAprobacion:=[Alumnos_EvaluacionAprendizajes]Periodo3_fechaRegistro
  //: (([Alumnos_EvaluacionAprendizajes]Periodo2_Real>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 2))
  //[Alumnos_EvaluacionAprendizajes]FechaAprobacion:=[Alumnos_EvaluacionAprendizajes]Periodo2_fechaRegistro
  //: (([Alumnos_EvaluacionAprendizajes]Periodo1_Real>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 1))
  //[Alumnos_EvaluacionAprendizajes]FechaAprobacion:=[Alumnos_EvaluacionAprendizajes]Periodo1_fechaRegistro
  //Else 
  //[Alumnos_EvaluacionAprendizajes]FechaAprobacion:=!00-00-0000!
  //End case 
  //End if 