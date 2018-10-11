$line:=AL_GetLine (xALP_Dimensiones)
$l_dimensionEliminada:=MPAcfg_Dim_Eliminar (alEVLG_Dimensiones_RecNums{$line})


If ($l_dimensionEliminada#0)
	MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_RecNumEje;-1;-1)
End if 