For ($i_filas;1;Size of array:C274(alEVLG_Competencias_RecNums))
	For ($i_columnas;1;Size of array:C274(alEVLG_Competencias_RecNums{1}))
		If (alEVLG_Competencias_RecNums{$i_filas}{$i_columnas}=vlMPA_recNumCompetencia)
			AL_SetCellSel (xALP_Competencias;$i_columnas;$i_filas;$i_columnas;$i_filas)
			  //AL_SetScroll (xALP_Competencias;-2;-2)
			AL_SetScroll (xALP_Competencias;$i_filas;$i_columnas-1)
			AL_SetCellBorder (xALP_Competencias;$i_columnas;$i_filas;1;1;1;1;0;3;187;187;187)
			$l_recNumComptenciaSeleccionada:=alEVLG_Competencias_RecNums{$i_filas}{$i_columnas}
			$i_filas:=Size of array:C274(alEVLG_Competencias_RecNums)
			$i_columnas:=Size of array:C274(alEVLG_Competencias_RecNums{1})
		End if 
	End for 
End for 