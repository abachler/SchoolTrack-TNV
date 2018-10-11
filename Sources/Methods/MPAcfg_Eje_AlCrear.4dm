//%attributes = {}
  // MPAcfg_Eje_AlCrear()
  // 
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/08/12, 17:47:38
  // ---------------------------------------------


  // CÓDIGO
If (Is new record:C668([MPA_DefinicionEjes:185]))
	[MPA_DefinicionEjes:185]ID:1:=SQ_SeqNumber (->[MPA_DefinicionEjes:185]ID:1)
	vlEVLG_IDEje:=[MPA_DefinicionEjes:185]ID:1
	[MPA_DefinicionEjes:185]ID_Area:2:=vlEVLG_IDArea
	
	  // asignación de tipo y estilo de evaluación
	If (vlMPA_TipoEvaluacionEje=0)
		vlMPA_TipoEvaluacionEje:=1
		If (vlMPA_EstiloEvaluacionEje=0)
			vlMPA_EstiloEvaluacionEje:=-5
		End if 
	End if 
	[MPA_DefinicionEjes:185]TipoEvaluación:12:=vlMPA_TipoEvaluacionEje
	[MPA_DefinicionEjes:185]EstiloEvaluación:13:=vlMPA_EstiloEvaluacionEje
	
	
	
	  // asignación de etapas o niveles de aplicación
	[MPA_DefinicionEjes:185]DesdeGrado:4:=-100
	[MPA_DefinicionEjes:185]HastaGrado:5:=-100
	[MPA_DefinicionEjes:185]Asignado_a_Etapa:19:=0
	For ($iEtapas;1;Size of array:C274(alMPA_NivelDesde))
		For ($iNiveles;alMPA_NivelDesde{$iEtapas};alMPA_NivelHasta{$iEtapas})
			$l_bitToSet:=Find in array:C230(<>aNivNo;$iNiveles)
			[MPA_DefinicionEjes:185]BitsNiveles:20:=[MPA_DefinicionEjes:185]BitsNiveles:20 ?+ $l_bitToSet
		End for 
	End for 
	[MPA_DefinicionEjes:185]OrdenamientoNumerico:9:=Size of array:C274(alEVLG_EJES_RecNums)+1
	
	[MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15:=__ ("Logrado;No Logrado")
	[MPA_DefinicionEjes:185]SimbolosBinarios_Simbolos:14:=__ ("L;NL")
	
End if 
