$t_enunciado:=OBJECT Get title:C1068(Self:C308->)
$l_filaEje:=Find in array:C230(atEVLG_Ejes_Nombres;$t_enunciado)
If ($l_filaEje>0)
	AL_SetLine (xALP_Ejes;$l_filaEje)
	AL_SetScroll (xALP_Ejes;$l_filaEje;1)
	MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;-1)
End if 

