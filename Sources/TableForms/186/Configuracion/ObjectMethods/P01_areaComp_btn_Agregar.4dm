
$col:=AL_GetColumn (xALP_Competencias)
$lineDimensiones:=AL_GetLine (xALP_Dimensiones)
$lineEjes:=AL_GetLine (xALP_ejes)
$lineArea:=AL_GetLine (xALP_AreasMPA)

atMPA_EtapasArea:=0
Case of 
	: ($lineDimensiones>0)
		GOTO RECORD:C242([MPA_DefinicionDimensiones:188];alEVLG_Dimensiones_RecNums{$lineDimensiones})
		If ($col=0)
			For ($i;1;Size of array:C274(alMPA_NivelDesde))
				If (alMPA_NivelDesde{$i}>=[MPA_DefinicionDimensiones:188]DesdeGrado:6)
					$col:=$i
					$i:=Size of array:C274(alMPA_NivelDesde)
				End if 
			End for 
		End if 
		If ($col=0)
			CD_Dlog (0;__ ("No es posible crear una competencia en esta Dimensión.\r\rLas etapas definidas no corresponden a la configuración de la Dimensión."))
		Else 
			atMPA_EtapasArea:=0
			$l_recNumCompetencia:=MPAcfg_Comp_Agregar (Dimension_Aprendizaje)
		End if 
		
	: ($lineEjes>0)
		If ($col=0)
			GOTO RECORD:C242([MPA_DefinicionEjes:185];alEVLG_Ejes_RecNums{$lineEjes})
			For ($i;1;Size of array:C274(alMPA_NivelDesde))
				If (alMPA_NivelDesde{$i}>=[MPA_DefinicionEjes:185]DesdeGrado:4)
					$col:=$i
					$i:=Size of array:C274(alMPA_NivelDesde)
				End if 
			End for 
		End if 
		
		If ($col=0)
			CD_Dlog (0;__ ("No es posible crear una competencia en este Eje.\r\rLas etapas definidas no corresponden a la configuración del Eje."))
		Else 
			atMPA_EtapasArea:=0
			$l_recNumCompetencia:=MPAcfg_Comp_Agregar (Eje_Aprendizaje)
			
		End if 
		
	: ($lineArea>0)
		atMPA_EtapasArea:=0
		$l_recNumCompetencia:=MPAcfg_Comp_Agregar (0)
		
		
End case 



