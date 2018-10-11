//%attributes = {}
  // MPAcfg_Comp_AlCrear()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 25/06/12, 07:10:29
  // ---------------------------------------------
C_LONGINT:C283($l_bitNiveles;$iNiveles;$l_celdaVacia)
C_POINTER:C301($y_arregloEtapa)


  // CÓDIGO

If (Is new record:C668([MPA_DefinicionCompetencias:187]))
	PUSH RECORD:C176([MPA_DefinicionCompetencias:187])
	QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11=vlEVLG_IDArea)
	ORDER BY:C49([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;<)
	$l_ultimaPosicionOrdenamiento:=[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25
	POP RECORD:C177([MPA_DefinicionCompetencias:187])
	
	[MPA_DefinicionCompetencias:187]ID:1:=SQ_SeqNumber (->[MPA_DefinicionCompetencias:187]ID:1)
	[MPA_DefinicionCompetencias:187]ID_Dimension:23:=vlEVLG_IDDimension
	[MPA_DefinicionCompetencias:187]ID_Eje:2:=vlEVLG_IDEje
	[MPA_DefinicionCompetencias:187]ID_Area:11:=vlEVLG_IDArea
	[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25:=$l_ultimaPosicionOrdenamiento+1
	  // asignación de etapas o niveles de aplicación y del ordenamiento
	Case of 
		: (atMPA_EtapasArea>0)  // si hay una etapa seleccionada
			[MPA_DefinicionCompetencias:187]DesdeGrado:5:=alMPA_NivelDesde{atMPA_EtapasArea}
			[MPA_DefinicionCompetencias:187]HastaGrado:13:=alMPA_NivelHasta{atMPA_EtapasArea}
			[MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4:=1
			For ($iNiveles;[MPA_DefinicionCompetencias:187]DesdeGrado:5;[MPA_DefinicionCompetencias:187]HastaGrado:13)
				$l_bitToSet:=Find in array:C230(<>aNivNo;$iNiveles)
				[MPA_DefinicionCompetencias:187]BitNiveles:28:=[MPA_DefinicionCompetencias:187]BitNiveles:28 ?+ $l_bitToSet
			End for 
			
		: ([MPA_DefinicionCompetencias:187]ID_Dimension:23>0)
			KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionDimensiones:188]ID:1;->vlEVLG_IDDimension)
			[MPA_DefinicionCompetencias:187]DesdeGrado:5:=[MPA_DefinicionDimensiones:188]DesdeGrado:6
			[MPA_DefinicionCompetencias:187]HastaGrado:13:=[MPA_DefinicionDimensiones:188]HastaGrado:7
			[MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4:=[MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5
			[MPA_DefinicionCompetencias:187]BitNiveles:28:=[MPA_DefinicionDimensiones:188]BitsNiveles:21
			
		: ([MPA_DefinicionCompetencias:187]ID_Eje:2>0)
			KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionDimensiones:188]ID:1;->vlEVLG_IDEje)
			[MPA_DefinicionCompetencias:187]DesdeGrado:5:=[MPA_DefinicionEjes:185]DesdeGrado:4
			[MPA_DefinicionCompetencias:187]HastaGrado:13:=[MPA_DefinicionEjes:185]HastaGrado:5
			[MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4:=[MPA_DefinicionEjes:185]Asignado_a_Etapa:19
			[MPA_DefinicionCompetencias:187]BitNiveles:28:=[MPA_DefinicionEjes:185]BitsNiveles:20
			
		Else 
			[MPA_DefinicionCompetencias:187]DesdeGrado:5:=-100
			[MPA_DefinicionCompetencias:187]HastaGrado:13:=-100
			[MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4:=0
			
			[MPA_DefinicionCompetencias:187]BitNiveles:28:=0
			For ($iEtapas;1;Size of array:C274(alMPA_NivelDesde))
				For ($iNiveles;alMPA_NivelDesde{$iEtapas};alMPA_NivelHasta{$iEtapas})
					$l_bitToSet:=Find in array:C230(<>aNivNo;$iNiveles)
					[MPA_DefinicionCompetencias:187]BitNiveles:28:=[MPA_DefinicionCompetencias:187]BitNiveles:28 ?+ $l_bitToSet
				End for 
			End for 
			
	End case 
	
	ARRAY TEXT:C222(atEVLG_Indicadores_Descripcion;0)
	ARRAY INTEGER:C220(aiEVLG_Indicadores_Valor;0)
	_O_ARRAY STRING:C218(5;atEVLG_Indicadores_Concepto;0)
	BLOB_Variables2Blob (->[MPA_DefinicionCompetencias:187]xIndicadores:14;0;->atEVLG_Indicadores_Descripcion;->aiEVLG_Indicadores_Valor;->atEVLG_Indicadores_Concepto)
	
	vtMessage:=""
	If (vlMPA_TipoEvaluacionComp=0)
		Case of 
			: (vlEVLG_IDDimension#0)
				  // en dimensiones los tipos de evaluación son: 1=Estilos de evaluacion, 2=Binario, 3=Escala Independiente
				  // en competencias los tipos de evaluacion son: 3= Estilos de Evaluacion, 2=Binario, 3=Indicadores de Logros
				RELATE ONE:C42([MPA_DefinicionCompetencias:187]ID_Dimension:23)
				vlMPA_EstiloEvaluacionComp:=[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11
				Case of 
					: ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=1)  //estilos de evaluación
						vlMPA_TipoEvaluacionComp:=3
						[MPA_DefinicionCompetencias:187]TipoEvaluacion:12:=3
						[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7:=vlMPA_EstiloEvaluacionComp
						
					: ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=2)  //binario
						vlMPA_TipoEvaluacionComp:=2
						[MPA_DefinicionCompetencias:187]TipoEvaluacion:12:=2
						
					: ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=3)  //escala independiente
						vlMPA_TipoEvaluacionComp:=1
						[MPA_DefinicionCompetencias:187]TipoEvaluacion:12:=1
						
				End case 
				
			: (vlEVLG_IDEje#0)
				  // en ejes los tipos de evaluación son: 1=Estilos de evaluacion, 2=Binario, 3=Escala Independiente
				  // en competencias los tipos de evaluacion son: 3= Estilos de Evaluacion, 2=Binario, 3=Indicadores de Logros
				RELATE ONE:C42([MPA_DefinicionCompetencias:187]ID_Eje:2)
				vlMPA_EstiloEvaluacionComp:=[MPA_DefinicionEjes:185]EstiloEvaluación:13
				Case of 
					: ([MPA_DefinicionEjes:185]TipoEvaluación:12=1)  //estilos de evaluación
						vlMPA_TipoEvaluacionComp:=3
						[MPA_DefinicionCompetencias:187]TipoEvaluacion:12:=3
						[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7:=vlMPA_EstiloEvaluacionComp
						
					: ([MPA_DefinicionEjes:185]TipoEvaluación:12=2)  //binario
						vlMPA_TipoEvaluacionComp:=2
						[MPA_DefinicionCompetencias:187]TipoEvaluacion:12:=2
						
					: ([MPA_DefinicionEjes:185]TipoEvaluación:12=3)  //escala independiente
						vlMPA_TipoEvaluacionComp:=1
						[MPA_DefinicionCompetencias:187]TipoEvaluacion:12:=1
						
				End case 
				
			: (vlMPA_TipoEvaluacionComp#0)
				[MPA_DefinicionCompetencias:187]TipoEvaluacion:12:=vlMPA_TipoEvaluacionComp
			Else 
				vlMPA_TipoEvaluacionComp:=3
				vlMPA_EstiloEvaluacionComp:=-5
				[MPA_DefinicionCompetencias:187]TipoEvaluacion:12:=vlMPA_TipoEvaluacionComp
				[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7:=-vlMPA_EstiloEvaluacionComp
		End case 
	Else 
		[MPA_DefinicionCompetencias:187]TipoEvaluacion:12:=vlMPA_TipoEvaluacionComp
		[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7:=vlMPA_EstiloEvaluacionComp
	End if 
	
	Case of 
		: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=3)
			[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7:=vlMPA_EstiloEvaluacionComp
		: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=2)
			[MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18:=__ ("Logrado;No Logrado")
			[MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17:=__ ("L;NL")
	End case 
End if 