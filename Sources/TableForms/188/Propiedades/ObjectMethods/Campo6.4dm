If ([MPA_DefinicionDimensiones:188]Escala_Minimo:12>[MPA_DefinicionDimensiones:188]Escala_Maximo:13)
	$ignore:=CD_Dlog (0;__ ("El mínimo de la escala no puede ser superior al máximo."))
	[MPA_DefinicionDimensiones:188]Escala_Minimo:12:=Old:C35([MPA_DefinicionDimensiones:188]Escala_Minimo:12)
	GOTO OBJECT:C206([MPA_DefinicionDimensiones:188]Escala_Minimo:12)
End if 
viEVLG_RequeridoDimension:=Round:C94([MPA_DefinicionDimensiones:188]Escala_Maximo:13*[MPA_DefinicionDimensiones:188]PctParaAprobacion:14/100;0)