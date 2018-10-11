If ([MPA_DefinicionDimensiones:188]Escala_Maximo:13<[MPA_DefinicionDimensiones:188]Escala_Minimo:12)
	CD_Dlog (0;__ ("El máximo de la de la escala no puede ser inferior al máximo."))
	[MPA_DefinicionDimensiones:188]Escala_Maximo:13:=Old:C35([MPA_DefinicionDimensiones:188]Escala_Maximo:13)
	GOTO OBJECT:C206([MPA_DefinicionDimensiones:188]Escala_Maximo:13)
End if 
viEVLG_RequeridoDimension:=Round:C94([MPA_DefinicionDimensiones:188]Escala_Maximo:13*[MPA_DefinicionDimensiones:188]PctParaAprobacion:14/100;0)