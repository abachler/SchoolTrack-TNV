//%attributes = {}
  // MPAcfg_Dim_AlCrear()
  // 
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 25/06/12, 11:53:33
  // ---------------------------------------------





  // CÓDIGO



If (Is new record:C668([MPA_DefinicionDimensiones:188]))
	[MPA_DefinicionDimensiones:188]ID:1:=SQ_SeqNumber (->[MPA_DefinicionDimensiones:188]ID:1)
	[MPA_DefinicionDimensiones:188]ID_Eje:3:=vlEVLG_IDEje
	
	
	READ ONLY:C145([MPA_DefinicionAreas:186])
	READ ONLY:C145([MPA_DefinicionEjes:185])
	RELATE ONE:C42([MPA_DefinicionDimensiones:188]ID_Eje:3)
	[MPA_DefinicionDimensiones:188]ID_Area:2:=[MPA_DefinicionEjes:185]ID_Area:2
	
	
	[MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5:=[MPA_DefinicionEjes:185]Asignado_a_Etapa:19
	[MPA_DefinicionDimensiones:188]DesdeGrado:6:=[MPA_DefinicionEjes:185]DesdeGrado:4
	[MPA_DefinicionDimensiones:188]HastaGrado:7:=[MPA_DefinicionEjes:185]HastaGrado:5
	[MPA_DefinicionDimensiones:188]BitsNiveles:21:=[MPA_DefinicionEjes:185]BitsNiveles:20
	[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20:=Size of array:C274(alEVLG_Dimensiones_RecNums)+1
	
	
	
	  // asignación de tipo y estilo de evaluación
	If ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=0)
		If (vlMPA_TipoEvaluacionDimension=0)
			[MPA_DefinicionDimensiones:188]TipoEvaluacion:15:=[MPA_DefinicionEjes:185]TipoEvaluación:12
			[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11:=[MPA_DefinicionEjes:185]EstiloEvaluación:13
			vlMPA_TipoEvaluacionDimension:=[MPA_DefinicionDimensiones:188]TipoEvaluacion:15
			vlMPA_EstiloEvaluacionDimension:=[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11
		Else 
			If (vlMPA_TipoEvaluacionDimension=0)
				vlMPA_TipoEvaluacionDimension:=1
				If (vlMPA_EstiloEvaluacionDimension=0)
					vlMPA_EstiloEvaluacionDimension:=-5
				End if 
			End if 
			[MPA_DefinicionDimensiones:188]TipoEvaluacion:15:=vlMPA_TipoEvaluacionDimension
			[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11:=vlMPA_EstiloEvaluacionDimension
		End if 
	End if 
	
	[MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16:=__ ("Logrado;No Logrado")
	[MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17:=__ ("L;NL")
End if 
