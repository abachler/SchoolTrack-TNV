For ($i;1;Size of array:C274(alEVLG_AdvCFG_Ids))
	Case of 
		: (alEVLG_AdvCFG_TipoObjeto{$i}=Eje_Aprendizaje)
			AL_SetRowStyle (xALP_LogrosAsignaturas;$i;1)
		: (alEVLG_AdvCFG_TipoObjeto{$i}=Dimension_Aprendizaje)
			AL_SetRowStyle (xALP_LogrosAsignaturas;$i;2)
		Else 
			AL_SetRowStyle (xALP_LogrosAsignaturas;$i;0)
	End case 
End for 

For ($i;1;Size of array:C274(alEVLG_Ids))
	Case of 
		: (alEVLG_TipoObjeto{$i}=Eje_Aprendizaje)
			AL_SetRowStyle (xALP_Banco;$i;1)
		: (alEVLG_TipoObjeto{$i}=Dimension_Aprendizaje)
			AL_SetRowStyle (xALP_Banco;$i;2)
		Else 
			AL_SetRowStyle (xALP_Banco;$i;0)
	End case 
End for 