$l_filaEjes:=AL_GetLine (xALP_Ejes)
If ($l_filaEjes>0)
	$recNumEje:=alEVLG_EJES_RecNums{$l_filaEjes}
	MPAcfg_Eje_Eliminar ($recNumEje)
	MPAcfg_ContenidoAreas (vlMPA_recNumArea;-1;-1;-1)
End if 
