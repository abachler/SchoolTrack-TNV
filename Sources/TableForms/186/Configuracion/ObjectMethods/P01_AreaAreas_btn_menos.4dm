C_LONGINT:C283($l_areaEliminada;$l_filaSeleccionada)


$l_filaSeleccionada:=AL_GetLine (xALP_AreasMPA)
$l_areaEliminada:=MPAcfg_Area_Eliminar (alEVLG_Marcos_RecNums{$l_filaSeleccionada})
MPAcfg_Area_Lista 
If (($l_filaSeleccionada>Size of array:C274(alEVLG_Marcos_RecNums)) & (Size of array:C274(alEVLG_Marcos_RecNums)>0))
	alEVLG_Marcos_RecNums:=-1
	$l_filaSeleccionada:=$l_filaSeleccionada-1
	AL_SetLine (xALP_AreasMPA;$l_filaSeleccionada)
	MPAcfg_ContenidoAreas 
End if 


