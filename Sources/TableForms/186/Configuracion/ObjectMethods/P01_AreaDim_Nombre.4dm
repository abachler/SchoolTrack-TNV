$t_enunciado:=OBJECT Get title:C1068(Self:C308->)
$l_filaDimension:=Find in array:C230(atEVLG_Dimensiones_Nombres;$t_enunciado)
If ($l_filaDimension>0)
	AL_SetLine (xALP_Dimensiones;$l_filaDimension)
	AL_SetScroll (xALP_Dimensiones;$l_filaDimension;1)
	MPAcfg_ContenidoAreas 
End if 
